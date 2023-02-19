const puppeteer = require('puppeteer');

const functions = require('firebase-functions');

const fs = require('fs')

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    databaseURL: 'https://hackathon23.firebaseio.com'
});


async function scrape() {
    const itemsObject = {}; //Object containing data of all menus

    const browser = await puppeteer.launch({
        headless: false
    });
    const page = await browser.newPage();
    await page.goto('https://dineoncampus.com/seattleu/whats-on-the-menu');

    const currDate = new Date();

    // Find the dropdown button element
    await page.waitForSelector("#dropdown-grouped__BV_toggle_");

    const dropdownButton = await page.$("#dropdown-grouped__BV_toggle_");

    // Click the dropdown button to open the dropdown menu
    await dropdownButton.click();

    //Thrive
    await page.waitForSelector("#building_612ff923a9f13a04a36619ab > li:nth-child(4) > button");

    const thrive = await page.$('#building_612ff923a9f13a04a36619ab > li:nth-child(4) > button');

    thrive.click();

    await page.waitForTimeout(5000);

    const thriveItemsLunch = await page.$$eval('strong', anchors => { return anchors.map(anchor => anchor.textContent).slice(0, 10) })


    let currIndex = thriveItemsLunch.length;

    for(let i = 0; i < thriveItemsLunch.length; i++) {
        let menuItemObject = {
            title: thriveItemsLunch[i],
            siteServed: 'Thrive',
            timeServed: 'Lunch',
            dateServed: currDate
        }

        itemsObject[`mI${i+1}`] = menuItemObject;
    }

    await page.waitForTimeout(5000);

    const dinnerTab = await page.waitForXPath('//a[text()="Dinner"]');

    dinnerTab.click();

    await page.waitForTimeout(5000);

    const thriveItemsDinner= await page.$$eval('strong', anchors => { return anchors.map(anchor => anchor.textContent).slice(0, 10) })


    for(let i = 0; i < thriveItemsDinner.length; i++) {
        let menuItemObject = {
            title: thriveItemsDinner[i],
            siteServed: 'Thrive',
            timeServed: 'Dinner',
            dateServed: currDate
        }
        itemsObject[`mI${i+currIndex+1}`] = menuItemObject;
    }

    console.log(itemsObject);    
    var jsonContent = JSON.stringify(itemsObject);
    fs.writeFile("output.json", jsonContent, 'utf8', function (err) {
        if (err) {
            console.log("An error occured while writing JSON Object to File.");
            return console.log(err);
        }

        console.log("JSON file has been saved.");
    });

}

// Function to add a JSON object to a Firestore collection
async function addJsonToFirestore(collectionName, json) {
    const collectionRef = admin.firestore().collection(collectionName);
    await collectionRef.add(json);
}

const myCollectionName = 'menuItems';

//call functionality
scrape();

//TODO: add to firestore
/*
addJsonToFirestore(myCollectionName, itemsObject)
    .then(() => console.log('JSON object added to Firestore collection'))
    .catch(error => console.error('Error adding JSON object to Firestore:', error));
*/
