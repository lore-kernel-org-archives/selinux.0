Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mABEpXlj015506
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 09:51:33 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id mABEpWFP010149
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 14:51:33 GMT
Subject: [PATCH] homedir_template generation skips USER lines
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 11 Nov 2008 09:49:00 -0500
Message-Id: <1226414940.24358.15.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current libsemanage code does not correctly add lines which include
USER in them into the homedir_template, for example:

/tmp/gconfd-USER -d	system_u:object_r:ROLE_tmp_t

This line was included in the past since it has ROLE.  However, with the
switch to UBAC separations, the line has changed to:

/tmp/gconfd-USER -d	system_u:object_r:user_tmp_t

and is no longer included.  The follwing patch fixes.

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index ab79c28..9f197ed 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -983,7 +983,8 @@ int semanage_split_fc(semanage_handle_t * sh)
 
 	while (fgets_unlocked(buf, PATH_MAX, file_con)) {
 		if (!strncmp(buf, "HOME_DIR", 8) ||
-		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE")) {
+		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE") ||
+		    strstr(buf, "USER")) {
 			/* This contains one of the template variables, write it to homedir.template */
 			if (write(hd, buf, strlen(buf)) < 0) {
 				ERR(sh, "Write to %s failed.",



-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
