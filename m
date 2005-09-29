Message-ID: <433C3C5A.4000104@redhat.com>
Date: Thu, 29 Sep 2005 15:11:22 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Karl MacMillan <kmacmillan@tresys.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: getseuserbyname patch
References: <43398EB2.1050100@redhat.com>	 <1127925593.25945.130.camel@moss-spartans.epoch.ncsc.mil>	 <433BEB18.7000703@redhat.com> <1128006623.27495.70.camel@moss-spartans.epoch.ncsc.mil> <433C06F0.3020804@redhat.com>
In-Reply-To: <433C06F0.3020804@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070107020002030209070206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070107020002030209070206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok lets try again.

getseuserbyname(const char *username, char **seuser, char **level);


-- 



--------------070107020002030209070206
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.27.1/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2005-09-01 11:17:40.000000000 -0400
+++ libselinux-1.27.1/include/selinux/selinux.h	2005-09-29 14:46:48.000000000 -0400
@@ -323,6 +323,7 @@
 extern const char *selinux_booleans_path(void);
 extern const char *selinux_customizable_types_path(void);
 extern const char *selinux_users_path(void);
+extern const char *selinux_usersconf_path(void);
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
@@ -354,6 +355,12 @@
 extern int selinux_raw_to_trans_context(security_context_t raw, 
 					security_context_t *transp);
 
+
+/* the following functions are used to retrieve the SELinux user and their 
+   security level via the  Linux usernames selinux */
+
+extern int getseuserbyname(const char *name, char **seuser, char **level);
+
 #ifdef __cplusplus
 }
 #endif
diff --exclude-from=exclude -N -u -r nsalibselinux/man/Makefile libselinux-1.27.1/man/Makefile
--- nsalibselinux/man/Makefile	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.27.1/man/Makefile	2005-09-28 14:32:16.000000000 -0400
@@ -8,3 +8,6 @@
 	install -m 644 man3/*.3 $(MAN3DIR)
 	install -m 644 man8/*.8 $(MAN8DIR)
 
+clean:
+	-rm -f *~ \#*
+	-rm -f man8/*~ man8/\#*
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getseuserbyname.3 libselinux-1.27.1/man/man3/getseuserbyname.3
--- nsalibselinux/man/man3/getseuserbyname.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.1/man/man3/getseuserbyname.3	2005-09-29 15:09:57.000000000 -0400
@@ -0,0 +1,21 @@
+.TH "getseuserbyname" "3" "29 September 2005" "dwalsh@redhat.com" "SE Linux API documentation"
+.SH "NAME"
+getseuserbyname \- get SELinux user and level via Linux username
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int getseuserbyname(const char *" username ", char **" selinuxuser ", char **" level ");
+.SH "DESCRIPTION"
+.B getseuserbyname
+retrieves the SELinux Username and security level associated with username.
+
+.br
+
+The returned SELinux username and level should be free with free if non-NULL.  
+.SH "RETURN VALUE"
+On success, 0 is returned indicating.
+On failure, \-1 is returned and errno is set appropriately.
+
+The errors documented for the stat(2) system call are also applicable
+here.
+
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.27.1/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2005-03-17 14:56:21.000000000 -0500
+++ libselinux-1.27.1/src/selinux_config.c	2005-09-29 11:28:55.000000000 -0400
@@ -11,6 +11,7 @@
 
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
+#define SELINUXUSERS SELINUXDIR "seusers.conf"
 #define SELINUXDEFAULT "targeted"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
@@ -252,5 +253,9 @@
 const char *selinux_users_path() {
   return get_path(USERS_DIR);
 }
+const char *selinux_usersconf_path() {
+  return SELINUXUSERS;
+}
+
 hidden_def(selinux_users_path)
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-1.27.1/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2005-08-25 16:18:01.000000000 -0400
+++ libselinux-1.27.1/src/selinux_internal.h	2005-09-29 14:49:43.000000000 -0400
@@ -49,6 +49,7 @@
 hidden_proto(selinux_check_passwd_access)
 hidden_proto(matchpathcon_init)
 hidden_proto(selinux_users_path)
+hidden_proto(selinux_usersconf_path);
 
 extern int context_translations hidden;
 extern int hidden trans_to_raw_context(char *trans, char **rawp);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/seusers.c libselinux-1.27.1/src/seusers.c
--- nsalibselinux/src/seusers.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.1/src/seusers.c	2005-09-29 14:51:47.000000000 -0400
@@ -0,0 +1,138 @@
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
+/* Process line from seusers.conf. 
+   Remove white space and set name do data before the "=" and sename to data
+   after it */
+static int process_seusers(const char *buffer, char **r_username, char **r_seuser, char **r_level) {
+	char *username=NULL;
+	char *seuser=NULL;
+	char *level=NULL;
+	char *ptr;
+	int rc=-1;
+	char *tok;
+	char *newbuf=strdup(buffer);
+	if (!newbuf) return -1;
+
+	tok=strtok_r(newbuf,":",&ptr);
+	if (!tok) goto err;
+	if ( tok[0]=='#' ) goto err;
+	username=strdup(tok);
+	if (!username) {
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (!tok) goto err;
+	while (isspace(*tok)) tok++;
+	if(strlen(tok))
+	   seuser=strdup(tok);
+	if (!seuser) {
+		free(username);
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (!tok) goto err;
+	while (isspace(*tok)) tok++;
+	if(strlen(tok))
+		level=strdup(tok);
+	if (!level) {
+		free(username);
+		free(seuser);
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
+			char *ptr=realloc(level, strlen(level) + len + 2);
+			if (ptr==NULL) {
+				free(username);
+				free(seuser);
+				free(level);
+				rc=-1; 
+				goto err;
+			}
+			level=ptr;
+			strcat(level,":");
+			strcat(level,tok);
+		}
+	}
+
+	*r_username=username;
+	*r_seuser=seuser;
+	*r_level=level;
+	rc=0;
+err:		
+	free(newbuf);
+	return rc;
+}
+
+int getseuserbyname(const char *name, char **r_seuser, char **r_level) {
+	FILE *cfg=NULL;
+	size_t size=0;
+	char *buffer=NULL;
+
+	char *username=NULL;
+        char *seuser=NULL;
+        char *level=NULL;
+        char *defaultseuser=NULL;
+        char *defaultlevel=NULL;
+
+	cfg = fopen(selinux_usersconf_path(),"r");
+	if (!cfg) return -1;
+
+	while (getline(&buffer, &size, cfg) > 0) {
+		if(process_seusers(buffer, &username, &seuser, &level) == 0) {
+			if (strcmp(username, name)==0) 
+			    break;
+
+			if (strcmp(username,"default")==0) {
+				free(username);
+				if (defaultseuser) 
+					free(defaultseuser);
+				if (defaultlevel) 
+					free(defaultlevel);
+				defaultseuser=seuser;
+				defaultlevel=level;
+			} 
+			else {
+				free(username);
+				free(seuser);
+				free(level);
+			}
+			seuser=NULL;
+		}
+	}
+	if (buffer) free(buffer);
+	fclose(cfg);
+	if (seuser) {
+		free(username);
+		free(defaultseuser);
+		free(defaultlevel);
+		*r_seuser=seuser;
+		*r_level=level;
+		return 0;
+	}
+	if (defaultseuser) {
+		*r_seuser=defaultseuser;
+		*r_level=defaultlevel;
+		return 0;
+	}
+		
+	return -1;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getseuser.c libselinux-1.27.1/utils/getseuser.c
--- nsalibselinux/utils/getseuser.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.1/utils/getseuser.c	2005-09-29 14:46:06.000000000 -0400
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
+	char *seuser;
+	char *level;
+	if ( argc != 2 ) usage(argv[0]);
+	if (getseuserbyname(argv[1], &seuser, &level) == 0 ) {
+		printf("%s\n", argv[1]);
+		printf("%s\n", seuser);
+		printf("%s", level);
+		return 0;
+	} else {
+		printf("%s not found\n", argv[1]);
+		return -1;
+	}
+}

--------------070107020002030209070206--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
