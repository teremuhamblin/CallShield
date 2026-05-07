#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# CallShield Script Generator (TUI)
# ============================================================

APP_NAME="CallShield Script Generator"
VERSION="1.0.0"
BASE_DIR="$(pwd)"
SCRIPTS_DIR="${BASE_DIR}/scripts"
PLUGINS_DIR="${SCRIPTS_DIR}/plugins"
REQUIREMENTS_FILE="${SCRIPTS_DIR}/requirements.txt"
SELF_PATH="${0}"

# ------------- Utils -------------------------------------------------

log() {
    printf "[%s] %s\n" "${APP_NAME}" "$*"
}

err() {
    printf "[%s][ERROR] %s\n" "${APP_NAME}" "$*" >&2
}

pause() {
    read -r -p "Appuyer sur Entrée pour continuer..." _
}

ensure_dirs() {
    mkdir -p "${SCRIPTS_DIR}" "${PLUGINS_DIR}"
    touch "${REQUIREMENTS_FILE}"
}

has_whiptail() {
    command -v whiptail >/dev/null 2>&1
}

tui_menu() {
    local title="$1"
    local prompt="$2"
    shift 2
    local options=("$@")

    if has_whiptail; then
        whiptail --title "${title}" --menu "${prompt}" 20 78 10 "${options[@]}" 3>&1 1>&2 2>&3
    else
        echo "== ${title} =="
        echo "${prompt}"
        local i=1
        for ((idx=0; idx<${#options[@]}; idx+=2)); do
            echo "  ${options[idx]}) ${options[idx+1]}"
            i=$((i+1))
        done
        echo -n "Choix: "
        read -r choice
        echo "${choice}"
    fi
}

tui_input() {
    local title="$1"
    local prompt="$2"
    local default="${3:-}"

    if has_whiptail; then
        whiptail --title "${title}" --inputbox "${prompt}" 10 78 "${default}" 3>&1 1>&2 2>&3
    else
        echo "== ${title} =="
        echo -n "${prompt} [${default}]: "
        read -r value
        if [ -z "${value}" ]; then
            value="${default}"
        fi
        echo "${value}"
    fi
}

tui_yesno() {
    local title="$1"
    local prompt="$2"

    if has_whiptail; then
        if whiptail --title "${title}" --yesno "${prompt}" 10 78; then
            echo "yes"
        else
            echo "no"
        fi
    else
        echo "== ${title} =="
        echo -n "${prompt} (y/N): "
        read -r ans
        case "${ans}" in
            y|Y|yes|YES) echo "yes" ;;
            *) echo "no" ;;
        esac
    fi
}

append_requirement() {
    local dep="$1"
    if ! grep -qx "${dep}" "${REQUIREMENTS_FILE}"; then
        echo "${dep}" >> "${REQUIREMENTS_FILE}"
        log "Dépendance ajoutée à requirements.txt : ${dep}"
    fi
}

# ------------- Script templates --------------------------------------

generate_script_content() {
    local name="$1"
    local command="$2"
    local with_colors="$3"
    local with_strict="$4"
    local with_logs="$5"

    local shebang="#!/usr/bin/env bash"
    local strict="set -euo pipefail"
    local color_defs=""
    local log_func=""

    if [ "${with_colors}" = "yes" ]; then
        color_defs='
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"
'
    fi

    if [ "${with_logs}" = "yes" ]; then
        log_func='
log() {
    printf "[%s] %s\n" "'"${name}"'" "$*"
}
'
    fi

    cat <<EOF
${shebang}
${with_strict:+${strict}}

${color_defs}
${log_func}
main() {
    ${with_logs:+log "Exécution du script ${name}..."}
    ${command}
    ${with_logs:+log "Terminé."}
}

main "\$@"
EOF
}

create_script_file() {
    local filename="$1"
    local content="$2"

    ensure_dirs
    local path="${SCRIPTS_DIR}/${filename}"
    printf "%s\n" "${content}" > "${path}"
    chmod +x "${path}"
    log "Script créé : ${path}"
}

# ------------- Plugin system -----------------------------------------

list_plugins() {
    ensure_dirs
    find "${PLUGINS_DIR}" -maxdepth 1 -type f -name "*.sh" -printf "%f\n" 2>/dev/null || true
}

run_plugin() {
    local plugin="$1"
    local path="${PLUGINS_DIR}/${plugin}"
    if [ -x "${path}" ]; then
        log "Exécution du plugin : ${plugin}"
        "${path}"
    else
        err "Plugin introuvable ou non exécutable : ${plugin}"
    fi
}

# ------------- Built-in script presets -------------------------------

preset_menu() {
    tui_menu "Types de scripts" "Choisir un type de script à générer :" \
        1 "build.sh (build du projet)" \
        2 "serve.sh (serveur local)" \
        3 "deploy.sh (déploiement)" \
        4 "lint.sh (analyse)" \
        5 "format.sh (formatage)" \
        6 "test.sh (tests)" \
        7 "clean.sh (nettoyage)" \
        8 "watch.sh (surveillance)" \
        9 "custom.sh (personnalisé)"
}

preset_to_filename_and_command() {
    local choice="$1"
    case "${choice}" in
        1) echo "build.sh;npm run build" ;;
        2) echo "serve.sh;npm run dev" ;;
        3) echo "deploy.sh;npm run deploy" ;;
        4) echo "lint.sh;npm run lint" ;;
        5) echo "format.sh;npm run format" ;;
        6) echo "test.sh;npm test" ;;
        7) echo "clean.sh;rm -rf dist .cache node_modules/.cache" ;;
        8) echo "watch.sh;npm run watch" ;;
        9) echo "custom.sh;echo \"Custom script CallShield\"" ;;
        *) echo "custom.sh;echo \"Custom script CallShield\"" ;;
    esac
}

# ------------- Update system -----------------------------------------

self_update() {
    local repo_url
    repo_url="$(tui_input "Mise à jour" "URL du dépôt git contenant ce script (origin)" "origin")"

    if [ "${repo_url}" = "origin" ]; then
        if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
            log "Mise à jour via git pull..."
            git pull
            log "Mise à jour terminée."
        else
            err "Pas de dépôt git détecté. Mise à jour impossible."
        fi
    else
        log "Clonage/mise à jour depuis ${repo_url} (non implémenté finement ici)."
        err "Pour une mise à jour avancée, gère le dépôt git manuellement."
    fi
}

# ------------- Main TUI flows ----------------------------------------

flow_generate_script() {
    local preset choice meta filename command
    choice="$(preset_menu)"
    meta="$(preset_to_filename_and_command "${choice}")"
    filename="${meta%%;*}"
    command="${meta#*;}"

    filename="$(tui_input "Nom du script" "Nom du fichier script (dans scripts/)" "${filename}")"
    command="$(tui_input "Commande principale" "Commande à exécuter dans le script" "${command}")"

    local with_colors with_strict with_logs
    with_colors="$(tui_yesno "Couleurs" "Activer les couleurs dans le script ?")"
    with_strict="$(tui_yesno "Strict mode" "Activer 'set -euo pipefail' ?")"
    with_logs="$(tui_yesno "Logs" "Activer une fonction de log ?")"

    local deps
    deps="$(tui_input "Dépendances" "Lister les dépendances (séparées par des espaces, ex: node npm jq)" "")"

    if [ -n "${deps}" ]; then
        for d in ${deps}; do
            append_requirement "${d}"
        done
    fi

    local content
    content="$(generate_script_content "${filename}" "${command}" "${with_colors}" "${with_strict}" "${with_logs}")"
    create_script_file "${filename}" "${content}"

    log "Script généré avec succès."
    pause
}

flow_plugins() {
    while true; do
        local choice
        choice="$(tui_menu "Plugins" "Gestion des plugins scripts/plugins/" \
            1 "Lister les plugins" \
            2 "Exécuter un plugin" \
            3 "Quitter le menu plugins")"

        case "${choice}" in
            1)
                log "Plugins disponibles :"
                list_plugins || true
                pause
                ;;
            2)
                local plugin
                plugin="$(tui_input "Plugin" "Nom du plugin (fichier .sh dans scripts/plugins/)" "")"
                run_plugin "${plugin}"
                pause
                ;;
            3|*) break ;;
        esac
    done
}

flow_requirements() {
    ensure_dirs
    log "Fichier requirements.txt : ${REQUIREMENTS_FILE}"
    echo "Contenu actuel :"
    cat "${REQUIREMENTS_FILE}" || true
    pause
}

flow_main_menu() {
    while true; do
        local choice
        choice="$(tui_menu "${APP_NAME} v${VERSION}" "Choisir une action :" \
            1 "Générer un script" \
            2 "Gérer les plugins" \
            3 "Voir requirements.txt" \
            4 "Mettre à jour le générateur" \
            5 "Quitter")"

        case "${choice}" in
            1) flow_generate_script ;;
            2) flow_plugins ;;
            3) flow_requirements ;;
            4) self_update ;;
            5|*) break ;;
        esac
    done
}

# ------------- Entry point -------------------------------------------

main() {
    ensure_dirs
    flow_main_menu
}

main "$@"
