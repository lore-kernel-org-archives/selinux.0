Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n05Mngcp028700
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 17:49:42 -0500
Received: from ladon.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n05MkvR5013138
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 22:47:00 GMT
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org,
        Manoj Srivastava <srivasta@debian.org>
Subject: [libsemanage] Also check for the uppoer bound on user ids in /etc/login.defs
Date: Mon,  5 Jan 2009 16:45:20 -0600
Message-Id: <1231195520-10286-1-git-send-email-manoj.srivastava@stdc.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Manoj Srivastava <srivasta@debian.org>

Some non-Debian packages (like qmail, shudder) create users not below
MIN_UID, but above MAX_UID, in /etc/login.defs (non-system users are
supposed to have uids between MIN_UID and MAX_UID.

genhomedircon.c:gethomedirs() checks pwent.pw_uid against MIN_UID in
/etc/login.defs to exclude system users from generating homedir
contexts. But unfortunately it does not check it against MAX_UID
setting from the same file.

This gets us lines like the following in the
contexts/files/file_contexts.homedirs file:

,----
|  #
|  # Home Context for user user_u
|  #
|  /var/qmail/[^/]*/.+     user_u:object_r:user_home_t:s0
|  /var/qmail/[^/]*/\.ssh(/.*)?    user_u:object_r:user_home_ssh_t:s0
|  /var/qmail/[^/]*/\.gnupg(/.+)?  user_u:object_r:user_gpg_secret_t:s0
|  /var/qmail/[^/]*        -d      user_u:object_r:user_home_dir_t:s0
|  /var/qmail/lost\+found/.*       <<none>>
|  /var/qmail      -d      system_u:object_r:home_root_t:s0
|  /var/qmail/\.journal    <<none>>
|  /var/qmail/lost\+found  -d      system_u:object_r:lost_found_t:s0
|  /tmp/gconfd-.*  -d      user_u:object_r:user_tmp_t:s0
`----

This commit adds checking uid value againt MAX_UID too.

Signed-off-by: Manoj Srivastava <srivasta@debian.org>
---
 src/genhomedircon.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/src/genhomedircon.c b/src/genhomedircon.c
index ce15807..a5306d7 100644
--- a/src/genhomedircon.c
+++ b/src/genhomedircon.c
@@ -219,8 +219,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	char *rbuf = NULL;
 	char *path = NULL;
 	long rbuflen;
-	uid_t temp, minuid = 0;
-	int minuid_set = 0;
+	uid_t temp, minuid = 0, maxuid = 0;
+	int minuid_set = 0, maxuid_set = 0;
 	struct passwd pwstorage, *pwbuf;
 	struct stat buf;
 	int retval;
@@ -270,6 +270,16 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 	}
 	free(path);
 	path = NULL;
+	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
+	if (path && *path) {
+		temp = atoi(path);
+		if (!maxuid_set || temp > maxuid) {
+			maxuid = temp;
+			maxuid_set = 1;
+		}
+	}
+	free(path);
+	path = NULL;
 
 	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
 	if (path && *path) {
@@ -286,6 +296,10 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		minuid = 500;
 		minuid_set = 1;
 	}
+	if (!maxuid_set) {
+		maxuid = 60000;
+		maxuid_set = 1;
+	}
 
 	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
 	if (rbuflen <= 0)
@@ -295,7 +309,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		goto fail;
 	setpwent();
 	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
-		if (pwbuf->pw_uid < minuid)
+		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
 			continue;
@@ -322,7 +336,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 
 			/* NOTE: old genhomedircon printed a warning on match */
 			if (hand.matched) {
-				WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid);
+			  WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or greater than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid, maxuid);
 			} else {
 				if (semanage_list_push(&homedir_list, path))
 					goto fail;
-- 
1.5.6.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
