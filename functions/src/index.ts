import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendToDevice = functions.firestore
    .document("messagePile/{messagePileId}")
    .onCreate(async (snapshot) => {
      const message = snapshot.data();
      const querySnapshot = await db
          .collection("mesagePile")
          .doc(message.toUID)
          .collection("tokens")
          .get();

      const tokens = querySnapshot.docs.map((snap) => snap.id);

      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New Message From ${message.nameFrom}",
          body: "${message.content}",
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      console.log(message);
      console.log(querySnapshot);
      console.log(tokens);
      return fcm.sendToDevice(tokens, payload);
    });

