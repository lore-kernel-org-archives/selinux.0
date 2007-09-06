Date: Thu, 6 Sep 2007 15:16:24 -0400 (EDT)
Message-Id: <200709061916.l86JGO5O028440@tex.courtesan.com>
From: "Todd C. Miller" <tmiller@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: [patch 0/4] libsemanage: genhomedircon replacement
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> BTW, the C code shouldn't be using getpwnam or getpwent - it should be
> using the _r versions of those functions since it is a library.

Below is a diff to use the _r versions.  I sent this out some time ago
but apparently it didn't make it to the list.

 - todd

 genhomedircon.c |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

Index: libsemanage/src/genhomedircon.c
===================================================================
--- libsemanage/src/genhomedircon.c	(revision 2549)
+++ libsemanage/src/genhomedircon.c	(working copy)
@@ -41,6 +41,7 @@
 #include <fcntl.h>
 #include <pwd.h>
 #include <errno.h>
+#include <unistd.h>
 
 /* paths used in get_home_dirs() */
 #define PATH_ETC_USERADD "/etc/default/useradd"
@@ -145,11 +146,13 @@
 {
 	semanage_list_t *homedir_list = NULL;
 	semanage_list_t *shells = NULL;
+	char *rbuf = NULL;
 	char *path = NULL;
+	long rbuflen;
 	size_t minuid = 0;
 	size_t minuid_set = 0;
 	size_t temp;
-	struct passwd *pwbuf;
+	struct passwd pwstorage, *pwbuf;
 	struct stat buf;
 
 	shells = get_shell_list();
@@ -215,8 +218,14 @@
 		minuid_set = 1;
 	}
 
+	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (rbuflen <= 0)
+		goto fail;
+	rbuf = malloc(rbuflen);
+	if (rbuf == NULL)
+		goto fail;
 	setpwent();
-	for (errno = 0; (pwbuf = getpwent()); errno = 0) {
+	for (errno = 0; getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf) == 0; errno = 0) {
 		if (pwbuf->pw_uid < minuid)
 			continue;
 		if (!semanage_list_find(shells, pwbuf->pw_shell))
@@ -244,6 +253,7 @@
 		     "Returning list so far.");
 	}
 	endpwent();
+	free(rbuf);
 	semanage_list_destroy(&shells);
 	if (semanage_list_sort(&homedir_list))
 		goto fail;
@@ -251,6 +261,8 @@
 	return homedir_list;
 
       fail:
+	endpwent();
+	free(rbuf);
 	semanage_list_destroy(&homedir_list);
 	semanage_list_destroy(&shells);
 	return NULL;
@@ -496,8 +508,10 @@
 	const char *name = NULL;
 	const char *seuname = NULL;
 	const char *prefix = NULL;
-	struct passwd *pwent = NULL;
+	struct passwd pwstorage, *pwent = NULL;
 	unsigned int i;
+	long rbuflen;
+	char *rbuf = NULL;
 	int retval;
 
 	*errors = 0;
@@ -514,6 +528,14 @@
 	qsort(user_list, nusers, sizeof(semanage_user_t *),
 	      (int (*)(const void *, const void *))&user_sort_func);
 
+	/* Allocate space for the getpwnam_r buffer */
+	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
+	if (rbuflen <= 0)
+		goto cleanup;
+	rbuf = malloc(rbuflen);
+	if (rbuf == NULL)
+		goto cleanup;
+
 	for (i = 0; i < nseusers; i++) {
 		name = semanage_seuser_get_name(seuser_list[i]);
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
@@ -536,8 +558,7 @@
 		}
 
 		errno = 0;
-		pwent = getpwnam(name);
-		if (!pwent) {
+		if (getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent) != 0) {
 			if (errno != 0) {
 				*errors = STATUS_ERR;
 				goto cleanup;
@@ -561,6 +582,7 @@
 	}
 
       cleanup:
+	free(rbuf);
 	if (*errors) {
 		for (; head; pop_user_entry(&head)) {
 			/* the pop function takes care of all the cleanup

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
