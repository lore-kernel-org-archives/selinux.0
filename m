Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8MIt9pK003859
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 14:55:09 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8MIt50N020354
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 18:55:10 GMT
Message-ID: <48D7EA05.8060608@manicmethod.com>
Date: Mon, 22 Sep 2008 14:55:01 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest flask definitions for libselinux.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:


diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/flask.h libselinux-2.0.71/include/selinux/flask.h
--- nsalibselinux/include/selinux/flask.h	2008-08-28 09:34:24.000000000 -0400
+++ libselinux-2.0.71/include/selinux/flask.h	2008-09-22 13:28:05.000000000 -0400
@@ -35,18 +35,18 @@
 #define SECCLASS_SHM                                     28
 #define SECCLASS_IPC                                     29
 #define SECCLASS_PASSWD                                  30
-#define SECCLASS_DRAWABLE                                31
-#define SECCLASS_WINDOW                                  32
-#define SECCLASS_GC                                      33
-#define SECCLASS_FONT                                    34
-#define SECCLASS_COLORMAP                                35
-#define SECCLASS_PROPERTY                                36
-#define SECCLASS_CURSOR                                  37
-#define SECCLASS_XCLIENT                                 38
-#define SECCLASS_XINPUT                                  39
-#define SECCLASS_XSERVER                                 40
-#define SECCLASS_XEXTENSION                              41
-#define SECCLASS_PAX                                     42
+#define SECCLASS_X_DRAWABLE                              31
+#define SECCLASS_X_SCREEN                                32
+#define SECCLASS_X_GC                                    33
+#define SECCLASS_X_FONT                                  34
+#define SECCLASS_X_COLORMAP                              35
+#define SECCLASS_X_PROPERTY                              36
+#define SECCLASS_X_SELECTION                             37
+#define SECCLASS_X_CURSOR                                38
+#define SECCLASS_X_CLIENT                                39
+#define SECCLASS_X_DEVICE                                40
+#define SECCLASS_X_SERVER                                41
+#define SECCLASS_X_EXTENSION                             42
 #define SECCLASS_NETLINK_ROUTE_SOCKET                    43
 #define SECCLASS_NETLINK_FIREWALL_SOCKET                 44
 #define SECCLASS_NETLINK_TCPDIAG_SOCKET                  45


These are renumbered, why are you doing that?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
