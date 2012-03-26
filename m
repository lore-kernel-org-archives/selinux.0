Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QDwmxr031684
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 09:58:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 204C61A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:58:47 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FeOFvKs-namY for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 15:58:45 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id A7B981A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:58:45 +0200 (CEST)
Date: Mon, 26 Mar 2012 15:58:43 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/4] libsemanage -- max-uid
Message-ID: <20120326155843.4c834941@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Again no rational and not original author

--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -283,8 +283,8 @@
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
@@ -334,6 +334,16 @@
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
@@ -350,6 +360,10 @@
 		minuid = 500;
 		minuid_set = 1;
 	}
+	if (!maxuid_set) {
+		maxuid = 60000;
+		maxuid_set = 1;
+	}
 
 	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
 	if (rbuflen <= 0)
@@ -359,7 +373,7 @@
 		goto fail;
 	setpwent();
 	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
-		if (pwbuf->pw_uid < minuid)
+		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
 			continue;
@@ -392,7 +406,7 @@
 
 			/* NOTE: old genhomedircon printed a warning on match */
 			if (hand.matched) {
-				WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid);
+				WARN(s->h_semanage, "%s homedir %s or its parent directory conflicts with a file context already specified in the policy.  This usually indicates an incorrectly defined system account.  If it is a system account please make sure its uid is less than %u or greater than %u or its login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid, maxuid);
 			} else {
 				if (semanage_list_push(&homedir_list, path))
 					goto fail;
@@ -743,7 +757,7 @@
 	semanage_seuser_t **seuser_list = NULL;
 	unsigned int nseusers = 0;
 	semanage_user_key_t *key = NULL;
-	semanage_user_t *u = NULL;
+	semanage_user_t *the_user = NULL;
 	const char *name = NULL;
 	const char *seuname = NULL;
 	const char *prefix = NULL;
@@ -769,22 +783,22 @@
 				errors = STATUS_ERR;
 				break;
 			}
-			if (semanage_user_query(s->h_semanage, key, &u) < 0)
+			if (semanage_user_query(s->h_semanage, key, &the_user) < 0)
 			{
 				prefix = name;
 				level = "s0";
 			}
 			else
 			{
-				prefix = semanage_user_get_prefix(u);
-				level = semanage_user_get_mlslevel(u);
+				prefix = semanage_user_get_prefix(the_user);
+				level = semanage_user_get_mlslevel(the_user);
 			}
 
 			if (set_fallback_user(s, seuname, prefix, level) != 0)
 				errors = STATUS_ERR;
 			semanage_user_key_free(key);
-			if (u)
-				semanage_user_free(u);
+			if (the_user)
+				semanage_user_free(the_user);
 			break;
 		}
 	}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
