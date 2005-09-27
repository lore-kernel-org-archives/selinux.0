Message-ID: <43398EB2.1050100@redhat.com>
Date: Tue, 27 Sep 2005 14:25:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: getseuserbyname patch
Content-Type: multipart/mixed;
 boundary="------------000804070307080209080703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000804070307080209080703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Currently applied to libsetrans, since we have come to no conclusion on 
where this should go.

Currently takes a file of the format
cat /etc/selinux/seusers.conf
dwalsh:staff_u:s0-s0:c1,c5
pwalsh:user_u::   #This is an error
rwalsh:user_u:s4
root:staff_u:s0-s0-s0:c0,c127
default:user_u:s0

Currently I placed the flat file in /etc/selinux/ directory, but might 
be better off in the policy directory, since s4 or staff_u might not be 
defined for MCS policy.

Eventually this function will call out to LDAP also, so not a good 
candidate for libselinux, unless we want the ls command linking against 
LDAP.

I want to add this function to login programs (Pam, gdm) in order to 
limit MCS users.

Need to figure out what to do if no entries are returned.  (I guess 
allow policy to decide.)  Maybe we should eliminate default entry?

Function returns structure containing

username
seusername
sensitivity (Could be a range)
Categories.(Can be null).

When you call selinux functions you will need to create a level by 
appending Sensitivity + ":" + Categories

Dan

--------------000804070307080209080703
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff -r -uN libsetrans-0.1.7/include/Makefile libsetrans-0.1.8/include/Makefile
--- libsetrans-0.1.7/include/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ libsetrans-0.1.8/include/Makefile	2005-09-27 12:22:56.000000000 -0400
@@ -0,0 +1,12 @@
+# Installation directories.
+PREFIX ?= $(DESTDIR)/usr
+INCDIR ?= $(PREFIX)/include/selinux
+
+install:
+	test -d $(INCDIR) || install -m 755 -d $(INCDIR)
+	install -m 644 $(wildcard selinux/*.h) $(INCDIR)
+
+clean: 
+	-rm -f *~ \#*
+	-rm -f selinux/*~ selinux/\#*
+
diff -r -uN libsetrans-0.1.7/include/selinux/seuser.h libsetrans-0.1.8/include/selinux/seuser.h
--- libsetrans-0.1.7/include/selinux/seuser.h	1969-12-31 19:00:00.000000000 -0500
+++ libsetrans-0.1.8/include/selinux/seuser.h	2005-09-27 11:42:31.000000000 -0400
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
diff -r -uN libsetrans-0.1.7/Makefile libsetrans-0.1.8/Makefile
--- libsetrans-0.1.7/Makefile	2005-09-20 21:48:42.000000000 -0400
+++ libsetrans-0.1.8/Makefile	2005-09-27 12:21:21.000000000 -0400
@@ -3,6 +3,7 @@
 	$(MAKE) -C utils
 
 install: 
+	$(MAKE) -C include install
 	$(MAKE) -C src install
 	$(MAKE) -C utils install
 	$(MAKE) -C man install
@@ -10,6 +11,10 @@
 
 clean:
 	rm -f *~ \#*
+	$(MAKE) -C include clean
 	$(MAKE) -C src clean
 	$(MAKE) -C utils clean
+	$(MAKE) -C man clean
+	$(MAKE) -C scripts clean
+
 
diff -r -uN libsetrans-0.1.7/man/Makefile libsetrans-0.1.8/man/Makefile
--- libsetrans-0.1.7/man/Makefile	2005-09-08 09:36:19.000000000 -0400
+++ libsetrans-0.1.8/man/Makefile	2005-09-27 12:24:28.000000000 -0400
@@ -5,3 +5,6 @@
 	mkdir -p $(MAN8DIR)
 	install -m 644 man8/*.8 $(MAN8DIR)
 
+clean:
+	-rm -f *~ \#*
+	-rm -f man8/*~ man8/\#*
diff -r -uN libsetrans-0.1.7/scripts/Makefile libsetrans-0.1.8/scripts/Makefile
--- libsetrans-0.1.7/scripts/Makefile	2005-09-20 21:47:34.000000000 -0400
+++ libsetrans-0.1.8/scripts/Makefile	2005-09-27 12:23:50.000000000 -0400
@@ -13,5 +13,5 @@
 	install -m 644 chcat.8 $(MANDIR)/man8/
 
 clean:
-	rm -f *~
+	-rm -f *~ \#*
 
diff -r -uN libsetrans-0.1.7/src/dso.h libsetrans-0.1.8/src/dso.h
--- libsetrans-0.1.7/src/dso.h	1969-12-31 19:00:00.000000000 -0500
+++ libsetrans-0.1.8/src/dso.h	2005-09-27 14:15:22.000000000 -0400
@@ -0,0 +1,23 @@
+#ifndef _SEUSER_DSO_H
+#define _SEUSER_DSO_H	1
+
+#ifdef SHARED
+# define hidden __attribute__ ((visibility ("hidden")))
+# define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
+# define __hidden_proto(fct, internal)	\
+     extern __typeof (fct) internal;	\
+     extern __typeof (fct) fct __asm (#internal) hidden;
+# if defined(__alpha__) || defined(__mips__)
+#  define hidden_def(fct) \
+     asm (".globl " #fct "\n" #fct " = " #fct "_internal");
+# else
+#  define hidden_def(fct) \
+     asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");
+#endif
+#else
+# define hidden
+# define hidden_proto(fct)
+# define hidden_def(fct)
+#endif
+
+#endif
diff -r -uN libsetrans-0.1.7/src/setrans.c libsetrans-0.1.8/src/setrans.c
--- libsetrans-0.1.7/src/setrans.c	2005-09-19 13:30:27.000000000 -0400
+++ libsetrans-0.1.8/src/setrans.c	2005-09-27 13:44:58.000000000 -0400
@@ -6,6 +6,7 @@
 #include <ctype.h>
 #include <selinux/selinux.h>
 #include <selinux/context.h>
+#include "dso.h"
 
 #define CATEGORYFILE "/etc/mcs.conf"
 
@@ -24,7 +25,7 @@
 static cat_t *catlist=NULL;
 
 /* Remove excess white space */
-static char *strtrim(char *dest, char *source, int size) {
+char * strtrim(char *dest, char *source, int size) {
 	int i=0;
 	char *ptr=source;
 	i=0;
@@ -40,6 +41,7 @@
 	return dest;
 }
 
+hidden_proto(strtrim)
 void finish_context_translations(void) {
 	cat_t *ptr=NULL;
 	cat_t *current=NULL;
diff -r -uN libsetrans-0.1.7/src/seusers.c libsetrans-0.1.8/src/seusers.c
--- libsetrans-0.1.7/src/seusers.c	1969-12-31 19:00:00.000000000 -0500
+++ libsetrans-0.1.8/src/seusers.c	2005-09-27 14:16:58.000000000 -0400
@@ -0,0 +1,140 @@
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+#include <selinux/seuser.h>
+#include "dso.h"
+
+extern char* hidden strtrim(char *dest, char *source, int size);
+void free_seuser(seuser_t *seuser) {
+	if (!seuser) return;
+	if (seuser->username)
+		free(seuser->username);
+	if (seuser->seusername)
+		free(seuser->seusername);
+	if (seuser->sensitivity)
+		free(seuser->sensitivity);
+	if (seuser->categories)
+		free(seuser->categories);
+	free(seuser);
+	return;
+}
+
+/* Process line from SEUSERSFILE. 
+   Remove white space and set name do data before the "=" and sename to data
+   after it */
+static int process_seusers(const char *buffer, seuser_t **r_user) {
+	char name[BUFSIZ];
+	char name1[BUFSIZ];
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
+	strncpy(name1,tok, sizeof(name1)-1);
+	strtrim(name,name1,sizeof(name)-1);
+	if ( name[0]=='#' ) goto err;
+	user->username=strdup(name);
+	if (!user->username) {
+		free_seuser(user);
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (!tok) goto err;
+	while (isspace(*tok)) tok++;
+	strncpy(name1,tok, sizeof(name1)-1);
+	strtrim(name,name1,sizeof(name)-1);
+	if(strlen(name))
+	   user->seusername=strdup(name);
+	if (!user->seusername) {
+		free_seuser(user);
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (!tok) goto err;
+	while (isspace(*tok)) tok++;
+	strncpy(name1,tok, sizeof(name1)-1);
+	strtrim(name,name1,sizeof(name)-1);
+	if(strlen(name))
+	   user->sensitivity=strdup(name);
+	if (!user->sensitivity) {
+		free_seuser(user);
+		rc=-1; 
+		goto err;
+	}
+
+	tok=strtok_r(NULL,":",&ptr);
+	if (tok) {
+		while (isspace(*tok)) tok++;
+		strncpy(name1,tok, sizeof(name1)-1);
+		strtrim(name,name1,sizeof(name)-1);
+		if(strlen(name))
+		   user->categories=strdup(name);
+		if (!user->categories) {
+			free_seuser(user);
+			rc=-1; 
+			goto err;
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
+				if (defaultseuser) 	free_seuser(defaultseuser);
+				defaultseuser=seuser;
+			} 
+			else 
+				free_seuser(seuser);
+			seuser=NULL;
+		}
+	}
+	if (buffer) free(buffer);
+	fclose(cfg);
+	if (seuser) {
+		free_seuser(defaultseuser);
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
diff -r -uN libsetrans-0.1.7/utils/getseuser.c libsetrans-0.1.8/utils/getseuser.c
--- libsetrans-0.1.7/utils/getseuser.c	1969-12-31 19:00:00.000000000 -0500
+++ libsetrans-0.1.8/utils/getseuser.c	2005-09-27 11:49:09.000000000 -0400
@@ -0,0 +1,31 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <errno.h>
+#include <string.h>
+#include <selinux/seuser.h>
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
+		printf("%s", seuser->sensitivity);
+		if (seuser->categories) 
+			printf(":%s\n", seuser->categories);
+		else
+			printf("\n");
+		free_seuser(seuser);
+		return 0;
+	} else {
+		printf("%s not found\n", argv[1]);
+		return -1;
+	}
+}

--------------000804070307080209080703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
