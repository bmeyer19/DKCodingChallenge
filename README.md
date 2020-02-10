# Diamond Kinetics Coding Challenge - Ben Meyer

**Overview**

I thought it would be fun to create an iOS app as a part of the Coding Challenge, 
so here is a simple interface that will let you run tests for the Coding Challenge operations and show you the outputs.

Hope you enjoy it!

**Getting Started**

1. Clone this repository
2. Open DKCodingChallenge.xcworkspace in Xcode
3. Set your test device in **Product > Destination** - I recommend connecting a personal device or using an iPhone 11 Simulator
4. Set your development team in **Signing & Capabilities > Signing > Team** - Depending on your development team setup, it is possible that you will need to change more settings at this step
5. Run the app by pressing **Product > Run**

**Coding Challenge**

The app interface will allow you to test the operations on the different columns of the provided dataset. 
However, to see the code for these operations, you can find the CodingChallenge.swift file at:

If you would like to run these on your own data, you can add your .csv file to the app and change the variable *filename* in 

**Bonus Question**

Looking through the provided dataset, my guess would be that the impact occurs at index 874 (timestamp 1091349). 
This is because I see a ton of variation in the values between 874 and 880. 
Since 874 is the first of these indices, I'm assuming that this is the inital impact.

