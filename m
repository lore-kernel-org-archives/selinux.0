Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFNMU4010739
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:23:22 -0500
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNKYP012669
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:23:21 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865859nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:23:19 -0800 (PST)
Message-ID: <cadfc0e40711260723r48205ccesa1643320865d67b0@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:23:19 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 2/10] PAM Namespace: expand $HOME
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch expands $HOME when it is used in the directory portion of a
namespace.conf configuration line to specify subdirectories of the
home directory for example $HOME/.mozilla.

--- Linux-PAM-0.99.8.1/modules/pam_namespace/pam_namespace.c	2007-11-14
08:30:46.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_namespace/pam_namespace.c	2007-11-14
08:33:13.000000000 -0600
@@ -207,8 +207,10 @@
      * the "$HOME" string with the user's home directory that is
      * passed in as an argument.
      */
-    if (strcmp(dir, "$HOME") == 0) {
-	dir = home;
+    if (strncmp(dir, "$HOME", 5) == 0) {
+            char *expanded = alloca(strlen(home) + strlen(dir) - 5 + 1);
+            sprintf(expanded, "%s%s", home, dir + 5);
+            dir = expanded;
     }

     /*

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
