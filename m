Message-ID: <433BEB18.7000703@redhat.com>
Date: Thu, 29 Sep 2005 09:24:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: getseuserbyname patch
References: <43398EB2.1050100@redhat.com> <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------030007000606080301050507"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030007000606080301050507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Updated patch for libselinux.

I have a couple of questions?

Is s0:c1-s0:c2  a valid range?  Is s0:c1-s0:c1,c2 implied or required?

Can this range read/write s0 files in MCS?  MLS?

Dan

-- 



--------------030007000606080301050507
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.27.1/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2005-09-01 11:17:40.000000000 -0400
+++ libselinux-1.27.1/include/selinux/selinux.h	2005-09-28 14:37:04.000000000 -0400
@@ -354,6 +354,25 @@
 extern int selinux_raw_to_trans_context(security_context_t raw, 
 					security_context_t *transp);
 
+
+/* the following functions are used to retrieve the SELinux user and their 
+   security level via the  Linux usernames selinux */
+
+#define SEUSERFILE "/etc/selinux/seusers.conf"
+
+/* Define data structures */
+typedef struct seuser {
+	char* username;
+	char* seusername;
+	char* level;
+} seuser_t;
+
+/* read /etc/selinux/seusers.conf file an return selinux user info */
+
+extern void freeseuser(seuser_t *seuser);
+
+extern int getseuserbyname(const char *name, seuser_t **r_seuser);
+
 #ifdef __cplusplus
 }
 #endif
diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/seuser.h libselinux-1.27.1/include/selinux/seuser.h
--- nsalibselinux/include/selinux/seuser.h	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.1/include/selinux/seuser.h	2005-09-28 14:32:11.000000000 -0400
@@ -0,0 +1,32 @@
+#ifndef _SEUSER_H_
+#define _SEUSER_H_
+
+#include <sys/types.h>
+#include <stdarg.h>
+
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
+#define SEUSERFILE "/etc/selinux/seusers.conf"
+
+/* Define data structures */
+typedef struct seuser {
+	char* username;
+	char* seusername;
+	char* sensitivity;
+	char* categories;
+} seuser_t;
+
+/* read /etc/selinux/seusers.conf file an return selinux user info */
+
+extern void free_seuser(seuser_t *seuser);
+
+extern int getseuserbyname(const char *name, seuser_t **r_seuser);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --exclude-from=exclude -N -u -r nsalibselinux/man/Makefile libselinux-1.27.1/man/Makefile
--- nsalibselinux/man/Makefile	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.27.1/man/Makefile	2005-09-28 14:32:16.000000000 -0400
@@ -8,3 +8,6 @@
 	install -m 644 man3/*.3 $(MAN3DIR)
 	install -m 644 man8/*.8 $(MAN8DIR)
 
+clean:
+	-rm -f *~ \#*
+	-rm -f man8/*~ man8/\#*
diff --exclude-from=exclude -N -u -r nsalibselinux/src/seusers.c libselinux-1.27.1/src/seusers.c
--- nsalibselinux/src/seusers.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.1/src/seusers.c	2005-09-28 14:48:28.000000000 -0400
@@ -0,0 +1,132 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+#include "selinux_internal.h"
+
+void freeseuser(seuser_t *seuser) {
+	if (!seuser) return;
+	if (seuser->username)
+		free(seuser->username);
+	if (seuser->seusername)
+		free(seuser->seusername);
+	if (seuser->level)
+		free(seuser->level);
+	free(seuser);
+	return;
+}
+
+/* Process line from SEUSERSFILE. 
+   Remove white space and set name do data before the "=" and sename to data
+   after it */
+static int process_seusers(const char *buffer, seuser_t **r_user) {
+	seuser_t *user=NULL;
+	char *ptr;
+	int rc=-1;
+	char *tok;
+	char *newbuf=strdup(buffer);
+	if (!newbuf) return -1;
+
+	user=calloc(1, sizeof(seuser_t));
+	if (!user) return -1;
+
+	tok=strtok_r(newbuf,":",&ptr);
+	if (!tok) goto err;
+	if ( tok[0]=='#' ) goto err;
+	user->username=strdup(tok);
+	if (!user->username) {
+		freeseuser(user);
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (!tok) goto err;
+	while (isspace(*tok)) tok++;
+	if(strlen(tok))
+	   user->seusername=strdup(tok);
+	if (!user->seusername) {
+		freeseuser(user);
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (!tok) goto err;
+	while (isspace(*tok)) tok++;
+	if(strlen(tok))
+	   user->level=strdup(tok);
+	if (!user->level) {
+		freeseuser(user);
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (tok) {
+		int len;
+		while (isspace(*tok)) tok++;
+		len=strlen(tok);
+		if(len) {
+			char *ptr=realloc(user->level, strlen(user->level) + len + 2);
+			if (ptr==NULL) {
+				freeseuser(user);
+				rc=-1; 
+				goto err;
+			}
+			user->level=ptr;
+			strcat(user->level,":");
+			strcat(user->level,tok);
+		}
+	}
+
+	*r_user=user;
+	rc=0;
+err:		
+	free(newbuf);
+	return rc;
+}
+
+int getseuserbyname(const char *name, seuser_t **r_seuser) {
+	FILE *cfg=NULL;
+	size_t size=0;
+	char *buffer=NULL;
+
+        static seuser_t *seuser=NULL;
+        static seuser_t *defaultseuser=NULL;
+
+	cfg = fopen(SEUSERFILE,"r");
+	if (!cfg) return -1;
+
+	while (getline(&buffer, &size, cfg) > 0) {
+		if(process_seusers(buffer, &seuser) == 0) {
+			if (strcasecmp(seuser->username, name)==0) 
+			    break;
+
+			if (strcasecmp(seuser->username,"default")==0) {
+				if (defaultseuser) 	freeseuser(defaultseuser);
+				defaultseuser=seuser;
+			} 
+			else 
+				freeseuser(seuser);
+			seuser=NULL;
+		}
+	}
+	if (buffer) free(buffer);
+	fclose(cfg);
+	if (seuser) {
+		freeseuser(defaultseuser);
+		*r_seuser=seuser;
+		return 0;
+	}
+	if (defaultseuser) {
+		*r_seuser=defaultseuser;
+		return 0;
+	}
+		
+	return -1;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getseuser.c libselinux-1.27.1/utils/getseuser.c
--- nsalibselinux/utils/getseuser.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.1/utils/getseuser.c	2005-09-28 14:49:21.000000000 -0400
@@ -0,0 +1,27 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <errno.h>
+#include <string.h>
+#include <selinux/selinux.h>
+
+void usage(const char *progname) 
+{
+	fprintf(stderr, "usage:  %s\n", progname);
+	exit(1);
+}
+int main(int argc, char **argv) {
+	seuser_t *seuser;
+	if ( argc != 2 ) usage(argv[0]);
+	if (getseuserbyname(argv[1], &seuser) == 0 ) {
+		printf("%s\n", seuser->username);
+		printf("%s\n", seuser->seusername);
+		printf("%s", seuser->level);
+		freeseuser(seuser);
+		return 0;
+	} else {
+		printf("%s not found\n", argv[1]);
+		return -1;
+	}
+}

--------------030007000606080301050507--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
