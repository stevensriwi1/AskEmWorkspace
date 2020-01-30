"use strict";



var admin = require("firebase");

var serviceAccount = require("../askem-flutter-firebase-adminsdk-ckzgy-7e32cf7574.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://askem-flutter.firebaseio.com"
});
const db =admin.firestore();
getQuote().then(result => {
	console.log(result.body);
	const obj = JSON.parse(result.body);
	const quoteData = {
		quote: obj.quote,
		author: obj.author
	};
	return db.collection('sampleData').doc('inspiration')
	.set(quoteData).then(() => {
		console.log('new quote has been added');
	});
})

function getQuote()
{

}

module.exports = {
	name: "greeter",

	/**
	 * Service settings
	 */
	settings: {

	},

	/**
	 * Service dependencies
	 */
	dependencies: [],	

	/**
	 * Actions
	 */
	actions: {

		/**
		 * Say a 'Hello'
		 *
		 * @returns
		 */
		hello() {
			return "Hello Moleculer";
		},

		/**
		 * Welcome a username
		 *
		 * @param {String} name - User name
		 */
		welcome: {
			params: {
				name: "string"
			},
			handler(ctx) {
				return `Welcome, ${ctx.params.name}`;
			}
		}
	},

	/**
	 * Events
	 */
	events: {

	},

	/**
	 * Methods
	 */
	methods: {

	},

	/**
	 * Service created lifecycle event handler
	 */
	created() {

	},

	/**
	 * Service started lifecycle event handler
	 */
	started() {

	},

	/**
	 * Service stopped lifecycle event handler
	 */
	stopped() {

	}
};