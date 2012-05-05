Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q459gm3N021473
	for <selinux@tycho.nsa.gov>; Sat, 5 May 2012 05:42:48 -0400
Received: by eaa1 with SMTP id 1so1099578eaa.12
        for <selinux@tycho.nsa.gov>; Sat, 05 May 2012 02:42:48 -0700 (PDT)
Date: Sat, 5 May 2012 11:42:12 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Mounting /sys within libselinux?
Message-ID: <20120505094212.GA7904@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.ncsc.mil
List-Id: selinux@tycho.nsa.gov

Hi guys,

Since selinux_init_load_policy tries to mount the selinuxfs on
/sys/fs/selinux, it of course fails when /sys is not available yet. It
currently falls back to /selinux then, but what about just mounting /sys
there?

Something akin to the following?

Wkr,
	Sven Vermeulen


diff -ur libselinux-2.1.9.orig/src/load_policy.c libselinux-2.1.9/src/load_policy.c
--- libselinux-2.1.9.orig/src/load_policy.c	2012-05-05 10:33:06.130719282 +0200
+++ libselinux-2.1.9/src/load_policy.c	2012-05-05 10:43:45.024720646 +0200
@@ -370,8 +370,16 @@
 	 * mount it if present for use in the calls below.  
 	 */
 	char *mntpoint = NULL;
-	if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
-		mntpoint = SELINUXMNT;
+	/* First make sure /sys is mounted */
+	if (mount("sysfs", "/sys", "sysfs", 0, 0) == 0 || errno == EBUSY) {
+		if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
+			mntpoint = SELINUXMNT;
+		} else {
+			/* check old mountpoint */
+			if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {
+				mntpoint = OLDSELINUXMNT;
+			}
+		}
 	} else {
 		/* check old mountpoint */
 		if (mount(SELINUXFS, OLDSELINUXMNT, SELINUXFS, 0, 0) == 0 || errno == EBUSY) {

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
