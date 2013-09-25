Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8PFqUjX011894
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 11:52:31 -0400
Received: by mail-wi0-f175.google.com with SMTP id ez12so5660132wid.14
        for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2013 08:52:29 -0700 (PDT)
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/5] Mount sys before trying to mount selinuxfs
Date: Wed, 25 Sep 2013 17:51:58 +0200
Message-Id: <1380124322-32745-2-git-send-email-sven.vermeulen@siphos.be>
In-Reply-To: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
References: <1380124322-32745-1-git-send-email-sven.vermeulen@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If /sys is not present, the attempt to mount selinuxfs will of course
fail. So we try to mount /sys first (and only if that fails fall back to
the /selinux mount point) and then try to mount selinuxfs.

Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 libselinux/src/load_policy.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 10e29b9..e419f1a 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -370,8 +370,16 @@ int selinux_init_load_policy(int *enforce)
 	 * mount it if present for use in the calls below.  
 	 */
 	const char *mntpoint = NULL;
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
1.8.1.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
