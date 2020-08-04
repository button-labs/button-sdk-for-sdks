package com.partnercompany.app

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.yourcompany.yourSDK.YourSDK

class MainActivity : AppCompatActivity() {

    private lateinit var offerButton: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        offerButton = findViewById<Button>(R.id.btn_link)

        // Calling the methods from your SDK
        YourSDK.start(this)

        offerButton.setOnClickListener {
            offerButton.text = "Fetching best offer..."

            YourSDK.fetchOffers { offers ->
                val bestOffer = offers[0]
                YourSDK.claimOffer(bestOffer) {
                    offerButton.text = "Fetch next best offer"
                }
            }
        }
    }
}