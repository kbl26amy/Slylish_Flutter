package com.example.flutter_application_1

import android.app.Dialog
import android.widget.Button
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import tech.cherri.tpdirect.api.TPDCard
import tech.cherri.tpdirect.api.TPDForm
import tech.cherri.tpdirect.api.TPDServerType
import tech.cherri.tpdirect.api.TPDSetup

class MainActivity: FlutterActivity() {

    private val flutterChannel = "flutterChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, flutterChannel)
            .setMethodCallHandler { call: MethodCall, result ->

                when (call.method) {
                    "startTapPaySetting" -> {
                        try {
                            // for implementing flutter card input
                            val cardNumber = call.argument<String>("carNumber") ?: ""
                            val dueMonth = call.argument<String>("dueMonth") ?: ""
                            val dueYear = call.argument<String>("dueYear") ?: ""
                            val cvv = call.argument<String>("cvv") ?: ""

                            startTapPay(useAndroidDialog = true, result = result)

                        } catch (e: Exception) {
                            result.error("9999", e.message, e.stackTrace)
                            println(e)
                        }
                    }
                }
            }
    }

    private fun startTapPay(
        cardNumber: String = "",
        dueMonth: String = "",
        dueYear: String = "",
        cvv: String = "",
        useAndroidDialog: Boolean = true,
        result: MethodChannel.Result
    ) {

        if (useAndroidDialog) {

            TPDSetup.initInstance(
                applicationContext,
                12348,
                "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF",
                TPDServerType.Sandbox
            )

            val dialog = Dialog(this, R.style.CardDialog)
            dialog.setContentView(R.layout.dialog_card)
            val tpdForm = dialog.findViewById<TPDForm>(R.id.tpdForm)
            tpdForm.setOnFormUpdateListener { status ->

                val canGetPrime = status.isCanGetPrime
                val button = dialog.findViewById<Button>(R.id.btn_confirm)

                button.isEnabled = canGetPrime
                button.setBackgroundColor(getColor(if (canGetPrime) R.color.black else R.color.grey))
                button.text = if (canGetPrime) getString(R.string.confirm) else getString(R.string.please_input_number)
            }
            val card = TPDCard.setup(tpdForm)
                .onSuccessCallback { prime, _ ,_ ,_ ->
                    result.success(prime)
                    dialog.dismiss()
                }
                .onFailureCallback { code, message ->
                    result.success("error: $code - $message")
                    dialog.dismiss()
                }
            dialog.findViewById<Button>(R.id.btn_confirm).setOnClickListener {
                card.getPrime()
            }
            dialog.show()

        } else {

            // for implementing flutter card input
            val card = TPDCard(
                applicationContext,
                StringBuffer(cardNumber),
                StringBuffer(dueMonth),
                StringBuffer(dueYear),
                StringBuffer(cvv)
            )
            card.onSuccessCallback { prime, _, _, _ ->
                result.success(prime)
            }.onFailureCallback { code, message ->
                result.error(code.toString(), message, getString(R.string.error_message))
            }
            card.createToken("UNKNOWN")
        }
    }
}
