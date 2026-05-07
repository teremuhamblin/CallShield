#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# CallShield‑OS Script Generator v2
# Root-level TUI + Plugins + Presets + Profiles + Export
# ============================================================

APP="CallShield Script Generator"
VERSION="2.0.0"

ROOT_DIR="$(pwd)"
SCRIPTS_DIR="${ROOT_DIR}/scripts"
PLUGINS_DIR="${SCRIPTS_DIR}/plugins"
REQUIREMENTS_FILE="${ROOT_DIR}/requirements.txt"
PROFILES_DIR="${ROOT_DIR}/.script-profiles"

# ------------------------------------------------------------
# UTILS
# ------------------------------------------------------------

log() { printf "[%s] %s\n" "$APP" "$*"; }
err() { printf "[%s][ERROR] %s\n" "$APP" "$*" >&2; }
pause() { read -r -p "Appuyer sur Entrée..." _; }

ensure_dirs() {
    mkdir -p "$SCRIPTS_DIR" "$PLUGINS_DIR" "$PROFILES_DIR"
    touch "$REQUIREMENTS_FILE"
}

has_whiptail() { command -v whiptail >/dev/null 2>&1; }

menu() {
    local title="$1" prompt="$2"; shift 2
    local opts=("$@")

    if has_whiptail; then
        whiptail --title "$title" --menu "$prompt" 20 78 12 "${opts[@]}" 3>&1 1>&2 2>&3
    else
        echo "== $title =="
        echo "$prompt"
        for ((i=0; i<${#opts[@]}; i+=2)); do
            echo "  ${opts[i]}) ${opts[i+1]}"
        done
        echo -n "> "
        read -r choice
        echo "$choice"
    fi
}

input() {
    local title="$1" prompt="$2" default="${3:-}"
    if has_whiptail; then
        whiptail --title "$title" --inputbox "$prompt" 10 78 "$default" 3>&1 1>&2 2>&3
    else
        echo "== $title =="
        echo -n "$prompt [$default]: "
        read -r val
        echo "${val:-$default}"
    fi
}

yesno() {
    local title="$1" prompt="$2"
    if has_whiptail; then
        whiptail --title "$title" --yesno "$prompt" 10 78 && echo yes || echo no
    else
        echo "== $title =="
        echo -n "$prompt (y/N): "
        read -r ans
        [[ "$ans" =~ ^[Yy]$ ]] && echo yes || echo no
    fi
}

append_dep() {
    local dep="$1"
    if ! grep -qx "$dep" "$REQUIREMENTS_FILE"; then
        echo "$dep" >> "$REQUIREMENTS_FILE"
        log "Dépendance ajoutée : $dep"
    fi
}

# ------------------------------------------------------------
# SCRIPT TEMPLATE
# ------------------------------------------------------------

generate_script() {
    local name="$1" cmd="$2" colors="$3" strict="$4" logs="$5"

    local shebang="#!/usr/bin/env bash"
    local strict_mode="set -euo pipefail"
    local color_defs=""
    local log_func=""

    [[ "$colors" == yes ]] && color_defs='
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"
'

    [[ "$logs" == yes ]] && log_func='
log() { printf "[%s] %s\n" "'"$name"'" "$*"; }
'

    cat <<EOF
${shebang}
${strict:+${strict_mode}}

${color_defs}
${log_func}

main() {
    ${logs:+log "Exécution du script $name..."}
    ${cmd}
    ${logs:+log "Terminé."}
}

main "\$@"
EOF
}

create_script() {
    local file="$1" content="$2"
    ensure_dirs
    printf "%s\n" "$content" > "${SCRIPTS_DIR}/${file}"
    chmod +x "${SCRIPTS_DIR}/${file}"
    log "Script créé : scripts/${file}"
}

# ------------------------------------------------------------
# PRESETS CALLSHIELD‑OS
# ------------------------------------------------------------

preset() {
    case "$1" in
        1) echo "build.sh;npm run build" ;;
        2) echo "serve.sh;npm run dev" ;;
        3) echo "deploy.sh;npm run deploy" ;;
        4) echo "lint.sh;npm run lint" ;;
        5) echo "format.sh;npm run format" ;;
        6) echo "test.sh;npm test" ;;
        7) echo "clean.sh;rm -rf dist .cache node_modules/.cache" ;;
        8) echo "watch.sh;npm run watch" ;;
        9) echo "monitoring.sh;echo 'Monitoring CallShield'" ;;
        10) echo "api.sh;echo 'API CallShield'" ;;
        11) echo "custom.sh;echo 'Custom script'" ;;
        *) echo "custom.sh;echo 'Custom script'" ;;
    esac
}

# ------------------------------------------------------------
# PROFILES
# ------------------------------------------------------------

save_profile() {
    local name="$1"
    local file="${PROFILES_DIR}/${name}.profile"
    printf "%s;%s;%s;%s;%s\n" "$2" "$3" "$4" "$5" "$6" > "$file"
    log "Profil enregistré : $name"
}

load_profile() {
    local name="$1"
    local file="${PROFILES_DIR}/${name}.profile"
    [[ -f "$file" ]] && cat "$file"
}

list_profiles() {
    ls "$PROFILES_DIR" | sed 's/.profile//g'
}

# ------------------------------------------------------------
# EXPORT JSON/YAML
# ------------------------------------------------------------

export_script() {
    local name="$1" cmd="$2"
    printf '{ "script": "%s", "command": "%s" }\n' "$name" "$cmd" > "${name}.json"
    printf 'script: "%s"\ncommand: "%s"\n' "$name" "$cmd" > "${name}.yaml"
    log "Exports générés : ${name}.json, ${name}.yaml"
}

# ------------------------------------------------------------
# MAIN FLOW
# ------------------------------------------------------------

flow_generate() {
    local choice meta file cmd
    choice="$(menu "Génération" "Choisir un preset CallShield‑OS :" \
        1 "build" 2 "serve" 3 "deploy" 4 "lint" 5 "format" \
        6 "test" 7 "clean" 8 "watch" 9 "monitoring" 10 "api" 11 "custom")"

    meta="$(preset "$choice")"
    file="${meta%%;*}"
    cmd="${meta#*;}"

    file="$(input "Nom du script" "Nom du fichier" "$file")"
    cmd="$(input "Commande" "Commande principale" "$cmd")"

    local colors strict logs
    colors="$(yesno "Couleurs" "Activer les couleurs ?")"
    strict="$(yesno "Strict mode" "Activer set -euo pipefail ?")"
    logs="$(yesno "Logs" "Activer les logs ?")"

    local deps
    deps="$(input "Dépendances" "Liste des dépendances (ex: node jq)" "")"
    for d in $deps; do append_dep "$d"; done

    local content
    content="$(generate_script "$file" "$cmd" "$colors" "$strict" "$logs")"
    create_script "$file" "$content"

    if [[ "$(yesno "Export" "Exporter en JSON/YAML ?")" == yes ]]; then
        export_script "$file" "$cmd"
    fi
}

flow_profiles() {
    local choice
    choice="$(menu "Profils" "Gestion des profils" \
        1 "Lister" 2 "Charger" 3 "Créer" 4 "Retour")"

    case "$choice" in
        1) list_profiles; pause ;;
        2)
            local p; p="$(input "Charger" "Nom du profil")"
            load_profile "$p"
            pause
            ;;
        3)
            local p file cmd colors strict logs
            p="$(input "Profil" "Nom du profil")"
            file="$(input "Nom script" "Nom du fichier")"
            cmd="$(input "Commande" "Commande principale")"
            colors="$(yesno "Couleurs" "Activer couleurs ?")"
            strict="$(yesno "Strict" "Activer strict mode ?")"
            logs="$(yesno "Logs" "Activer logs ?")"
            save_profile "$p" "$file" "$cmd" "$colors" "$strict" "$logs"
            ;;
    esac
}

flow_main() {
    ensure_dirs

    while true; do
        local choice
        choice="$(menu "$APP v$VERSION" "Choisir une action" \
            1 "Générer un script" \
            2 "Profils" \
            3 "Voir requirements.txt" \
            4 "Quitter")"

        case "$choice" in
            1) flow_generate ;;
            2) flow_profiles ;;
            3) cat "$REQUIREMENTS_FILE"; pause ;;
            4) exit 0 ;;
        esac
    done
}

flow_main
