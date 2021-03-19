const { GoogleSpreadsheet } = require('google-spreadsheet');
const clientSecret = require('./client_secret.json');

const googleSheetId = '1c1-z6CRxLL1LZUT_JGOldN-Vw1HdHZsPxuPMB2o4rok';
const spreadsheet = new GoogleSpreadsheet(googleSheetId);
const moment = require('moment-timezone');

const appendNewEntry = async function (event) {
    try {
        await spreadsheet.useServiceAccountAuth(clientSecret);
        await spreadsheet.loadInfo();
        const sheet = await spreadsheet.sheetsByIndex[0];

        let currentDate = new Date();
        let submittedDate = moment(currentDate.getTime()).tz("America/New_York").format("DD-MM-YYYY");
        let submittedDate = currentDate.toLocaleDateString("en-US", {timeZone: "America/New_York"});
        
        const row = await sheet.addRow({
            firstname: event.firstname,
            lastname: event.lastname,
            temp: event.temp,
            q1: event.q1,
            q2: event.q2,
            exposure: event.exposure,
            q3: event.q3
        })
    } catch (err) {
        console.log(err);
        return false;
    }
}

exports.handler = async (event) => {
    console.log("Post request: " + JSON.stringify(event))
    const data = await appendNewEntry(event);

    let response = {
        "statusCode": 200,
        "body": "Good to go",
        "isBase64Encoded": false
    };
    
    if(!data) {
        response = {
            "statusCode": 400,
            "body": "Something went wrong",
            "isBase64Encoded": false
        }
    }
    
    return response;
}