import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendToDeviceChat = functions.firestore
    .document("messagePile/{messagePileId}")
    .onCreate(async (snapshot) => {
      const message = snapshot.data();
      const querySnapshot = await db
          .collection("tokens")
          .doc(message.toUID)
          .get();
      const tok = querySnapshot.get("token");
      const tokens = [tok];

      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "New message from " + message.fromName,
          body: message.content,
        },
        data: {
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      return fcm.sendToDevice(tokens, payload);
    });

export const sendToDevicePost = functions.firestore
    .document("postsAnswered/{postsAnsweredId}")
    .onCreate(async (snapshot) => {
      const post = snapshot.data();
      const querySnapshot = await db
          .collection("tokens")
          .doc(post.uidAuthor)
          .get();
      const tok = querySnapshot.get("token");
      const tokens = [tok];

      const payload: admin.messaging.MessagingPayload = {
        notification: {
          title: "Help offered form: " + post.nameAnswered,
          body: post.content,
        },
        data: {
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
      };
      return fcm.sendToDevice(tokens, payload);
    });

