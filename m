Message-Id: <20070927200752.528616244@tresys.com>
References: <20070927200712.950671948@tresys.com>
Date: Thu, 27 Sep 2007 16:07:14 -0400
From: "Todd C. Miller" <tmiller@tresys.com>
To: sds@tycho.nsa.gov, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, tmiller@tresys.com
Subject: [patch 2/4] libsemanage: fix getpw*_r usage
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

getpwnam_r() returns 0 when a user doesn't exist and just zeroes the
struct passwd pointer.  However, getpwent_r() returns ENOENT when there
are no more users.  This diff deals with both possible behaviors so that
if the two functions are brought in line nothing will break.  We can
also remove the errno check and use the return value directly.

Index: trunk/libsemanage/src/genhomedircon.c
===================================================================
--- trunk.orig/libsemanage/src/genhomedircon.c
+++ trunk/libsemanage/src/genhomedircon.c
@@ -158,6 +158,7 @@ static semanage_list_t *get_home_dirs(ge
 	size_t temp;
 	struct passwd pwstorage, *pwbuf;
 	struct stat buf;
+	int retval;
 
 	shells = get_shell_list();
 	assert(shells);
@@ -229,7 +230,7 @@ static semanage_list_t *get_home_dirs(ge
 	if (rbuf == NULL)
 		goto fail;
 	setpwent();
-	for (errno = 0; getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf) == 0; errno = 0) {
+	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) {
 		if (pwbuf->pw_uid < minuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
@@ -252,7 +253,7 @@ static semanage_list_t *get_home_dirs(ge
 		free(path);
 	}
 
-	if (errno) {
+	if (retval && retval != ENOENT) {
 		WARN(s->h_semanage, "Error while fetching users.  "
 		     "Returning list so far.");
 	}
@@ -614,12 +615,13 @@ static genhomedircon_user_entry_t *get_u
 			prefix = name;
 		}
 
-		errno = 0;
-		if (getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent) != 0) {
-			if (errno != 0) {
+		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
+		if (retval != 0 || pwent == NULL) {
+			if (retval != 0 && retval != ENOENT) {
 				*errors = STATUS_ERR;
 				goto cleanup;
 			}
+
 			WARN(s->h_semanage,
 			     "user %s not in password file", name);
 			continue;

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
