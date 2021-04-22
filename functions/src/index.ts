import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendToDevice = functions.firestore.document("ratings/{ratingId}").onCreate(async snapshot =>{

    const rating  = snapshot.data();
    const querySnapshot = await db.collection("rating").doc(rating.uid).collection("tokens").get();

    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New Order!",
          body: "you sold a ${rating.stars} for ${rating.order}",
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        }
      };
      return fcm.sendToDevice(tokens, payload);
});

