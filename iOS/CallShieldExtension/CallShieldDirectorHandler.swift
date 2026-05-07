import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {

    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.removeAllBlockingEntries()
        context.removeAllIdentificationEntries()

        addBlockedNumbers(to: context)
        addIdentifiedNumbers(to: context)

        context.completeRequest()
    }

    private func addBlockedNumbers(to context: CXCallDirectoryExtensionContext) {
        let blockedNumbers: [Int64] = [
            33970000000,
            33800000000
        ]

        for number in blockedNumbers {
            context.addBlockingEntry(withNextSequentialPhoneNumber: number)
        }
    }

    private fun addIdentifiedNumbers(to context: CXCallDirectoryExtensionContext) {
        let spamNumbers: [(Int64, String)] = [
            (33970000000, "Spam détecté"),
            (33800000000, "Numéro suspect")
        ]

        for (number, label) in spamNumbers {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: number, label: label)
        }
    }
}
