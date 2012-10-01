Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWva1017398
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id C4F2F1AAEF
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:28 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 51Oti-TfWp0o for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:26 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id CC07F1AAED
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:25 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 07/15] libsemanage: Also check for the uppoer bound on user ids in login.defs
Date: Mon,  1 Oct 2012 18:31:49 +0200
Message-Id: <1349109117-593-8-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Manoj Srivastava <srivasta@debian.org>

Some non-Debian packages (like qmail, shudder) create
users not below MIN_UID, but above MAX_UID, in /etc/login.defs
(non-system users are supposed to have uids between MIN_UID and
MAX_UID.

genhomedircon.c:gethomedirs() checks pwent.pw_uid against MIN_UID in
/etc/login.defs to exclude system users from generating homedir
contexts. But unfortunately it does not check it against MAX_UID
setting from the same file. This gets us lines like the following in
the contexts/files/file_contexts.homedirs file:
,----
| #
| # Home Context for user user_u
| #
| /var/qmail/[^/]*/.+ user_u:object_r:user_home_t:s0
| /var/qmail/[^/]*/\.ssh(/.*)? user_u:object_r:user_home_ssh_t:s0
| /var/qmail/[^/]*/\.gnupg(/.+)? user_u:object_r:user_gpg_secret_t:s0
| /var/qmail/[^/]* -d user_u:object_r:user_home_dir_t:s0
| /var/qmail/lost\+found/.* <<none>>
| /var/qmail -d system_u:object_r:home_root_t:s0
| /var/qmail/\.journal <<none>>
| /var/qmail/lost\+found -d system_u:object_r:lost_found_t:s0
| /tmp/gconfd-.* -d user_u:object_r:user_tmp_t:s0
`----
This commit adds checking uid value againt MAX_UID too.
---
 libsemanage/src/genhomedircon.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 15bca6c..728ed72 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -283,8 +283,8 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
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
@@ -335,6 +335,17 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
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
+
 	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
 	if (path && *path) {
 		temp = atoi(path);
@@ -350,6 +361,10 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		minuid = 500;
 		minuid_set = 1;
 	}
+	if (!maxuid_set) {
+		maxuid = 60000;
+		maxuid_set = 1;
+	}
 
 	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
 	if (rbuflen <= 0)
@@ -359,7 +374,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		goto fail;
 	setpwent();
 	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
-		if (pwbuf->pw_uid < minuid)
+		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
 			continue;
@@ -392,7 +407,7 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 
 			/* NOTE: old genhomedircon printed a warning on match */
 			if (hand.matched) {
-				WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid);
+				WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or greater than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid, maxuid);
 			} else {
 				if (semanage_list_push(&homedir_list, path))
 					goto fail;
-- 
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
