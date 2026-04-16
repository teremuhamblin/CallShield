# Composants UI – Pseudo-code

## Button (React Native)

component Button({ label, variant = 'primary', onPress, disabled }) {
  const style = variant === 'primary'
    ? styles.primary
    : styles.secondary

  return (
    <TouchableOpacity
      style={[style.base, disabled && style.disabled]}
      onPress={onPress}
      disabled={disabled}
    >
      <Text style={style.text}>{label}</Text>
    </TouchableOpacity>
  )
}

## StatusCard (React Native)

component StatusCard({ status }) {
  const isActive = status === 'active'

  return (
    <View style={styles.card}>
      <Text style={styles.title}>
        {isActive ? 'Protection active' : 'Protection inactive'}
      </Text>
      <Button
        label={isActive ? 'Désactiver' : 'Activer'}
        variant="primary"
      />
    </View>
  )
}

## CallItem (Flutter)

class CallItem extends StatelessWidget {
  final String number;
  final String date;
  final CallStatus status;

  CallItem({required this.number, required this.date, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_iconForStatus(status)),
      title: Text(number),
      subtitle: Text(date),
      trailing: _badgeForStatus(status),
    );
  }
}

## AlertBanner (SwiftUI)

struct AlertBanner: View {
    let type: AlertType
    let message: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
            Text(message)
                .font(.subheadline)
        }
        .padding()
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(8)
    }

    private var iconName: String { ... }
    private var backgroundColor: Color { ... }
}
