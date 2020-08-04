package com.yourcompany.yourSDK

import android.content.Context
import android.graphics.drawable.Drawable
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.usebutton.sdk.Button


private const val TAG = "YourSDK"

/**
 * Your SDK that makes use of the Button Publisher SDK.
 * A Partner App will interface with Your SDK, and not the Button SDK.
 */
object YourSDK {

    private val configuration = Configuration()

    fun start(context: Context) {
        // You can use some internal configuration to control whether Button is enabled or not
        configuration.isButtonEnabled = true

        if (configuration.isButtonEnabled) {
            Button.debug().isLoggingEnabled = true
            Button.configure(context, BuildConfig.BUTTON_APP_ID) {
                it?.let {
                    Log.e(TAG, "Button failed to initialize", it)
                }
            }
        }
    }

    /**
     * Fetch available offers
     */
    fun fetchOffers(completion: (List<Offer>) -> Unit) {
        val offers = listOf(Offer("https://www.ikea.com/"))

        Handler(Looper.getMainLooper()).postDelayed({
            completion.invoke(offers)
        }, 1000)
    }

    /**
     * Claim a specific offer
     */
    fun claimOffer(offer: Offer, completion: ((Throwable?) -> Unit)? = null) {
        Button.openURL(offer.url) {
            Handler(Looper.getMainLooper()).post { completion?.invoke(it) }
            it?.let {
                Log.e(TAG, "Error opening link via Button SDK", it)
            }
        }
    }

    /**
     * A configuration object returned from a service indicating features to enable/disable.
     */
    data class Configuration(
        var isButtonEnabled: Boolean = false
    )

    /**
     * Represents an offer available via YourSDK to be displayed in PartnerApp.
     */
    data class Offer(
        val url: String,
        val image: Drawable? = null,
        val brand: String? = null,
        val value: String? = null,
        val offerDescription: String? = null
    )
}