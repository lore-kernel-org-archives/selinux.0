Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6ID01gA027283
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 09:00:01 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6ICtBbC007470
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 12:55:12 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j6ICuPSZ004281
	for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2005 08:56:25 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j6ICuPPb004280
	for selinux@tycho.nsa.gov; Mon, 18 Jul 2005 08:56:25 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FIfqgA013591
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 14:41:56 -0400 (EDT)
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FIcErE013208
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 18:38:14 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6FIcF52024734
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 14:38:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6FIcFPD253302
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 14:38:15 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6FIcFLe024865
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 14:38:15 -0400
Received: from localhost (sig-9-65-227-13.mts.ibm.com [9.65.227.13])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j6FIcCSg024743
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 14:38:13 -0400
Date: Fri, 15 Jul 2005 14:38:06 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [RFC][PATCH] polyinstantiation using process namespace
Message-ID: <Pine.WNT.4.63.0507151435390.1188@IBM-AIP3070F3AM>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

Here is a pam patch that adds a new pam module pam_namesapce to
create a private namespace with polyinstantiated directories 
based on the configuration file /etc/security/namespace.conf.
It implements the polyinstatiation scheme proposed by Stephen
Smalley and prototyped by Chad Sellers.

I have unit tested this pam module with login, su, sshd, gdm 
and newrole. Because of lack of pam session management hooks 
in newrole, newrole command itself will be modified as well. 
I will post newrole patch next week. To test this patch, in 
addition to this pam patch, you will need three other (four 
if you are testing newrole) patches. The first two implement 
a new system call unshare, and the 3rd provides a policy patch 
that adds type-member rules used in polyinstantiation. Few 
weeks ago, unshare patches were posted to linux-fsdevel mailing 
list and policy patch (part of Chad Seller's namespace setup 
patch) was posted on this list. However, I will post them again 
on this list to make it easier for you to try this one out. The
README file explains the configuration and use of namespaces. 

Please provide comments and suggestions for improvement. 
Especially on the following issues/questions:

1) Because we didn't have unshare system call, Chad's patch
   modified libselinux, and session establishing programs
   such as login and gdm. Now that there is strong possibility
   of getting the new system call unshare accepted upstream,
   we don't have to modify individual commands. Therefore I
   have moved namespace setup functions from libselinux to
   the new pam module. Is that ok? Do you see any need for
   providing this library routine to other programs that may
   not want to use pam? It won't be very difficult to move
   core functionality from pam module to the selinux library,
   but I thought that it was better to tie namespace setup
   with session setup.

2) Current patch skips malformed or invalid lines in the 
   /etc/security/namespace.conf file. For example, missing
   arguments or lack of absolute pathnames or unknown
   polyinstantiation method. Is it better to exit with an
   error instead of not performing polyinstnation for that
   particular directory?

3) Since security_compute_member() returns proper context
   in permissive mode as well, I am not making any distinction
   for enforcing/permissive mode. Please let me know if that
   is NOT ok.

4) What should be the security context of the reset directory,
   where original contents are available to only authorized
   processes? Right now I am using mode of 000, but I know 
   that is not correct since polyinstantiated directory is 
   mounted on top of that directory. 

5) If newrole or su is executed from inside a polyinstantiated
   directory, undoing bind mount fails since the process has
   the directory open. Currently, I am changing the process
   working directory to the parent of polyinstantiated 
   directory. Please let me know if that is acceptable or if
   there is a better way to handle that. 


Thanks. 

-Janak

Patch Summary:
This patch provides pam_namespace pam module to setup a 
private namespace with polyinstantiated directories.

Patch Justification:
This patch is needed to provide polyinstantiated directories.
Polyinstantiated directories are needed to achieve greater 
information separation for public use directories such 
as /tmp and /var/tmp, and provide users with writeable home 
directories as they transition roles, types or mls level.


Overall Approach:
After unsharing (disassociating from current shared) namespace,
the pam module will cycle through all directories listed in 
configuration file for polyinstantiation, bind mount the original
directory to a "reset" location from where its contents will
be available to authorized processes, create a member directory
based on polyinstantiation method (user, context, or both as
specified in the configuration file) and bind mount this member
directory on top of the directory to polyinstantiate. This 
gives an instance of the directory based on the process context.

Testing:
The patch has been unit tested on uni-processor i386 architecture
based Fedora Core 3 system running 2.6.12 kernel.

Signed-off-by: Janak Desai

-----------------------------------------------------------------
diff -Naurp Linux-PAM-0.79/modules/pam_namespace/Makefile Linux-PAM-0.79+pam_namespace/modules/pam_namespace/Makefile
--- Linux-PAM-0.79/modules/pam_namespace/Makefile	1970-01-01 00:00:00.000000000 +0000
+++ Linux-PAM-0.79+pam_namespace/modules/pam_namespace/Makefile	2005-07-15 15:57:45.000000000 +0000
@@ -0,0 +1,44 @@
+#
+# $Id: Makefile,v 1.4 2004/09/28 13:48:47 kukuk Exp $
+#
+# This Makefile controls a build process of $(TITLE) module for
+# Linux-PAM. You should not modify this Makefile (unless you know
+# what you are doing!).
+#
+
+include ../../Make.Rules
+
+TITLE=pam_namespace
+
+ifeq ($(OS),linux)
+
+LOCAL_CONFILE=./namespace.skel
+INSTALLED_CONFILE=$(SCONFIGD)/namespace.conf
+
+DEFS=-DDEFAULT_CONF_FILE=\"$(INSTALLED_CONFILE)\"
+CFLAGS += $(DEFS) -DWITH_SELINUX
+
+MODULE_SIMPLE_INSTALL=bash -f ../install_conf "$(FAKEROOT)" "$(SCONFIGD)" "$(INSTALLED_CONFILE)" "$(TITLE)" "$(LOCAL_CONFILE)"
+MODULE_SIMPLE_REMOVE=rm -f $(FAKEROOT)$(INSTALLED_CONFILE)
+MODULE_SIMPLE_CLEAN=rm -f ./.ignore_age
+
+MODULE_SIMPLE_EXTRALIBS = -ldl
+
+ifeq ($(HAVE_LIBCAP),yes)
+MODULE_SIMPLE_EXTRALIBS += -lcap
+endif
+
+ifeq ($(HAVE_LIBSELINUX),yes)
+MODULE_SIMPLE_EXTRALIBS += -lselinux
+endif
+
+include ../Simple.Rules
+
+#else
+#include ../dont_makefile
+#endif
+else
+
+include ../dont_makefile
+
+endif
diff -Naurp Linux-PAM-0.79/modules/pam_namespace/README Linux-PAM-0.79+pam_namespace/modules/pam_namespace/README
--- Linux-PAM-0.79/modules/pam_namespace/README	1970-01-01 00:00:00.000000000 +0000
+++ Linux-PAM-0.79+pam_namespace/modules/pam_namespace/README	2005-07-15 15:57:49.000000000 +0000
@@ -0,0 +1,85 @@
+
+pam_namespace module:
+Setup a private namespace with polyinstantiated directories.
+
+THEORY OF OPERATION:
+The pam namespace module consults /etc/security/namespace.conf
+configuration file and sets up a private namespace with polyinstantiated
+directories for a session managed by PAM. A skeleton namespace.conf
+installed by default provides example for polyinstantiating /tmp
+and users' home directory.
+
+Each line describes a limit for a user in the form:
+
+<polydir>   <member_path>   <reset_path>   <method>   <list_of_uids>
+
+Where:
+<polydir> - is the absolute pathname of the directory to polyinstantiate
+        Special entry $HOME is supported to designate user's home directory.
+        This field cannot be blank.
+
+<member_path> - is the absolute pathname of the parent directory where an
+	instantiation of <polydir> is to be created. This instance is bind
+	mounted on the <polydir> to provide an instance of <polydir> based
+	on the <method> column. Two special entries $HOME and $HOME_PARENT
+	are supported to designate user's home directory and parent of
+	user's home directory. This field cannot be blank.
+
+<reset_path> - is the absolute pathname of the parent directory where the
+        "reset" version of the <polydir> is to be available. "reset" version
+        of <polydir> provides original content of <polydir> to authorized
+        programs. Special entry $HOME_PARENT is supported to designate
+	parent of user's home directory. This field cannot be blank and
+        this directory cannot be a subdirectory of <polydir>.
+
+<method> - is the method used for polyinstantiation. It can take 3 different
+	values; "user" for polyinstantiation based on user name, "context"
+	for polyinstantiation based on process security context, and "both"
+	for polyinstantiation based on both user name and security context.
+	Methods "context" and "both" are only available with SELinux. This
+        field cannot be blank.
+
+<list_of_uids> - is a comma separated list of user names for whom the
+        poyinstantiation is not performed. If left blank, polyinstantiation
+	will be performed for all users.
+
+EXAMPLE /etc/security/namespace.conf configuration file:
+=======================================================
+# comments
+#
+# Following line will polyinstantiate /tmp directory and user's home
+# directory. /tmp will be polyinstantiated based on both security context
+# as well as user name, where as home directory will be polyinstantiated
+# based on security context only. Polyinstantion will not be performed
+# for user root and adm for directory /tmp, where as home directories
+# are polyinstantiated for all users.
+/tmp	/		/		both		root,adm
+$HOME	$HOME_PARENT	$HOME_PARENT	context
+
+
+ARGUMENTS RECOGNIZED:
+    debug		verbose logging by syslog
+
+    unmnt_first		For programs such as su and newrole, the login
+			session has already setup a polyinstantiated
+			namespace. For these programs, polyinstantiation
+			is performed based on new user id or security
+			context, however the command first needs to
+			undo the polyinstantiation performed by login.
+			This argument is provide in the command's pam
+			configuration file to instruct the command to
+			first undo previous polyinstantiation before
+			proceeding with new polyinstantiation based on
+			new id/context.
+
+MODULE SERVICES PROVIDED:
+	session            _open_session and _close_session (blank)
+
+USAGE:
+	For the <command>s you need polyinstnatition (login for example) put
+	the following line in /etc/pam.d/<command> as the last line for
+	session service:
+
+	session  required  /lib/security/pam_namespace.so [unmnt_first] [debug]
+
+	Replace "/lib/security" path with your real modules path.
diff -Naurp Linux-PAM-0.79/modules/pam_namespace/namespace.skel Linux-PAM-0.79+pam_namespace/modules/pam_namespace/namespace.skel
--- Linux-PAM-0.79/modules/pam_namespace/namespace.skel	1970-01-01 00:00:00.000000000 +0000
+++ Linux-PAM-0.79+pam_namespace/modules/pam_namespace/namespace.skel	2005-07-15 15:57:46.000000000 +0000
@@ -0,0 +1,51 @@
+# /etc/security/namespace.conf
+#
+# Each line describes a limit for a user in the form:
+#
+# <polydir>   <member_path>   <reset_path>   <method>   <list_of_uids>
+#
+# Where:
+# <polydir> - is the absolute pathname of the directory to polyinstantiate
+#         Special entry $HOME is supported to designate user's home directory.
+#         This field cannot be blank.
+#
+# <member_path> - is the absolute pathname of the parent directory where an
+# 	instantiation of <polydir> is to be created. This instance is bind
+# 	mounted on the <polydir> to provide an instance of <polydir> based
+# 	on the <method> column. Two special entries $HOME and $HOME_PARENT
+# 	are supported to designate user's home directory and parent of
+# 	user's home directory. This field cannot be blank.
+#
+# <reset_path> - is the absolute pathname of the parent directory where the
+#         "reset" version of the <polydir> is to be available. "reset" version
+#         of <polydir> provides original content of <polydir> to authorized
+#         programs. Special entry $HOME_PARENT is supported to designate
+# 	parent of user's home directory. This field cannot be blank and
+#         this directory cannot be a subdirectory of <polydir>.
+#
+# <method> - is the method used for polyinstantiation. It can take 3 different
+# 	values; "user" for polyinstantiation based on user name, "context"
+# 	for polyinstantiation based on process security context, and "both"
+# 	for polyinstantiation based on both user name and security context.
+# 	Methods "context" and "both" are only available with SELinux. This
+#         field cannot be blank.
+#
+# <list_of_uids> - is a comma separated list of user names for whom the
+#         poyinstantiation is not performed. If left blank, polyinstantiation
+# 	will be performed for all users.
+#
+# EXAMPLE /etc/security/namespace.conf configuration file:
+# =======================================================
+# comments
+#
+# Following two lines will polyinstantiate /tmp directory and user's home
+# directory. /tmp will be polyinstantiated based on both security context
+# as well as user name, where as home directory will be polyinstantiated
+# based on security context only. Polyinstantion will not be performed
+# for user root and adm for directory /tmp, where as home directories
+# are polyinstantiated for all users.
+#
+# /tmp	/		/		both		root,adm
+#
+# $HOME	$HOME_PARENT	$HOME_PARENT	context
+#
diff -Naurp Linux-PAM-0.79/modules/pam_namespace/pam_namespace.c Linux-PAM-0.79+pam_namespace/modules/pam_namespace/pam_namespace.c
--- Linux-PAM-0.79/modules/pam_namespace/pam_namespace.c	1970-01-01 00:00:00.000000000 +0000
+++ Linux-PAM-0.79+pam_namespace/modules/pam_namespace/pam_namespace.c	2005-07-15 15:57:47.000000000 +0000
@@ -0,0 +1,1381 @@
+/******************************************************************************
+ * A module for Linux-PAM that will set the default namespace after establising
+ * a session via PAM.
+ *
+ * (C) Copyright IBM Corporation 2005
+ * All Rights Reserved.
+ *
+ * Written by: Janak Desai <janak@us.ibm.com>
+ * Derived from a namespace setup patch by Chad Sellers <cdselle@tycho.nsa.gov>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * on the rights to use, copy, modify, merge, publish, distribute, sub
+ * license, and/or sell copies of the Software, and to permit persons to whom
+ * the Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.  IN NO EVENT SHALL
+ * IBM AND/OR THEIR SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#if !(defined(linux))
+#error THIS CODE IS KNOWN TO WORK ONLY ON LINUX !!!
+#endif
+
+#define PAM_SM_SESSION
+
+#include <security/_pam_aconf.h>
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <ctype.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <syslog.h>
+#include <dlfcn.h>
+#include <stdarg.h>
+#include <linux/limits.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/resource.h>
+#include <sys/mount.h>
+
+#include <security/pam_modules.h>
+#include <security/_pam_macros.h>
+#include <security/_pam_modutil.h>
+
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
+
+#define CLONE_NEWNS 0x00020000 /* Flag to create new namespace */
+
+/*
+ * Does the kernel know about unshare system call?
+ */
+#include <linux/unistd.h>
+#define __NR_unshare 289
+static inline _syscall1 (int, unshare, int, flags)
+
+/*
+ * Module defines
+ */
+#define MODULE "pam_namespace"
+#define CONF_FILE "/etc/security/namespace.conf"
+#define PROC_MNTS "/proc/mounts"
+#define MD5_DIGEST_LENGTH 16
+
+/*
+ * Polyinstantiation method options, based on user, security context
+ * or both
+ */
+enum polymethod {
+    USER,
+    CONTEXT,
+    BOTH,
+};
+
+/*
+ * Structure that holds information about a directory to polyinstantiate
+ */
+struct polydir_s {
+    char dir[PATH_MAX];    	       	/* directory to polyinstantiate */
+    char member_path[PATH_MAX]; 	/* member dir parent path */
+    char reset_path[PATH_MAX];  	/* original dir available at */
+    enum polymethod method;		/* method used to polyinstantiate */
+    int num_uids;			/* number of override uids */
+    int *uid;				/* list of override uids */
+    struct polydir_s *next;		/* pointer to the next polydir entry */
+};
+
+/*
+ * Adds an entry for a polyinstantiated directory to the linked list of
+ * polyinstantiated directories. It is called from process_line() while
+ * parsing the namespace configuration file.
+ */
+static void add_polydir_entry(struct polydir_s **polydirs_ptr, struct polydir_s *ent, int debug)
+{
+    struct polydir_s *pent, *tail;
+    int i, *pptr, *eptr;
+
+    /*
+     * Allocate an entry to hold information about a directory to
+     * polyinstantiate, populate it with information from 2nd argument
+     * and add the entry to the linked list of polyinstantiated
+     * directories.
+     */
+    pent = (struct polydir_s *) malloc(sizeof(struct polydir_s));
+    if (pent) {
+        strcpy(pent->dir, ent->dir);
+        strcpy(pent->member_path, ent->member_path);
+        strcpy(pent->reset_path, ent->reset_path);
+        pent->method = ent->method;
+        if (ent->num_uids) {
+            pent->num_uids = ent->num_uids;
+            pent->uid = (int *) malloc(ent->num_uids * sizeof(int));
+            if (!(pent->uid)) {
+                syslog(LOG_ERR, MODULE": Unable to allocate space");
+                *polydirs_ptr = NULL;
+                if (pent)
+                    free(pent);
+                return;
+            }
+            for (i = 0, pptr = pent->uid, eptr = ent->uid; i < ent->num_uids;
+                 i++, eptr++, pptr++)
+                 *pptr = *eptr;
+        } else {
+            pent->num_uids = 0;
+            pent->uid = NULL;
+        }
+        pent->next = NULL;
+        if (*polydirs_ptr == NULL)
+            *polydirs_ptr = pent;
+        else {
+            tail = *polydirs_ptr;
+            while (tail->next)
+                tail = tail->next;
+            tail->next = pent;
+        }
+    } else {
+        syslog(LOG_ERR, MODULE": Unable to allocate space");
+        *polydirs_ptr = NULL;
+    }
+
+    if (debug && *polydirs_ptr) {
+        struct polydir_s *dptr = *polydirs_ptr;
+        int *iptr;
+
+        syslog(LOG_NOTICE, MODULE "Poly dirs so far");
+        while (dptr) {
+            syslog(LOG_NOTICE, MODULE ": %s %s %s %d", dptr->dir,
+                   dptr->member_path, dptr->reset_path, dptr->method);
+            for (i = 0, iptr = dptr->uid; i < dptr->num_uids; i++, iptr++)
+                syslog(LOG_NOTICE, MODULE ": override user %d ", *iptr);
+            dptr = dptr->next;
+        }
+    }
+    return;
+}
+
+
+/*
+ * Called from parse_config_file, this function processes a single line
+ * of the namespace configuration file. It skips over comments and incomplete
+ * of malformed lines. It process a valid line with information on
+ * polyinstantiating a directory by populating appropriate fields of a
+ * polyinstatiated directory structure and then calling add_polydir_entry to
+ * add that entry to the linked list of polyinstantited directories.
+ */
+static int process_line(char *line, char *home, struct polydir_s **polydirs_ptr, int debug)
+{
+    char dir[PATH_MAX], member_path[PATH_MAX], reset_path[PATH_MAX];
+    char dir_tslash[PATH_MAX], reset_path_tslash[PATH_MAX];
+    char method[PATH_MAX], uids[PATH_MAX];
+    int i, count, *uidptr, retval = 0;
+    char *tptr, *ustr, *sstr, *cptr, *fptr;
+    struct passwd *pwd;
+    struct polydir_s poly;
+
+    tptr = line;
+
+    /*
+     * skip the leading white space
+     */
+    while (*tptr && isspace(*tptr))
+        tptr++;
+    strncpy(line, tptr, strlen(line)-1);
+    line[strlen(line)-1] = '\0';
+
+    /*
+     * Rip off the comments
+     */
+    tptr = strchr(line,'#');
+    if (tptr)
+        *tptr = '\0';
+
+    /*
+     * Rip off the newline char
+     */
+    tptr = strchr(line,'\n');
+    if (tptr)
+        *tptr = '\0';
+
+    /*
+     * Anything left ?
+     */
+    if (!strlen(line)) {
+        memset(line, 0, strlen(line));
+        retval = 0;
+        goto skipping;
+    }
+
+    /*
+     * Initialize and scan the five strings from the line from the
+     * namespace configuration file.
+     */
+    memset(dir, 0, sizeof(dir));
+    memset(member_path, 0, sizeof(member_path));
+    memset(reset_path, 0, sizeof(reset_path));
+    memset(method, 0, sizeof(method));
+    memset(uids, 0, sizeof(uids));
+
+    i = sscanf(line, "%s%s%s%s%s", dir, member_path, reset_path, method, uids);
+
+    /*
+     * If there are less than 4 entries, the line is incomplete so we
+     * will skip it.
+     */
+    if (i < 4) {
+        retval = 0;
+        syslog(LOG_NOTICE, MODULE": Invalid line -- skipping");
+    } else {
+        /*
+         * Only the uids field is allowed to be blank, to indicate no
+         * override users for polyinstantiation of that directory. If
+         * any of the other fields are blank, the line is incomplete so
+         * skip it.
+         */
+        if ((dir[0] == '\0') || (member_path[0] == '\0') ||
+            (reset_path[0] == '\0') || (method[0] == '\0')) {
+            retval = 0;
+            goto skipping;
+        }
+
+        /*
+         * If the directory being polyinstantiated is the home directory
+         * of the user who is establishing a session, we have to swap
+         * the "$HOME" string with the user's home directory that is
+         * passed in as an argument.
+         */
+        if (strcmp(dir, "$HOME") == 0) {
+            if (home == NULL) {
+                retval = 0;
+                goto skipping;
+    	    } else {
+    	        strcpy(dir, home);
+                /*
+                 * For $HOME_PARENT, use the passed in home directory
+                 * to obtain the parent of home directory.
+                 */
+    	        if (strcmp(member_path, "$HOME_PARENT") == 0) {
+    	            strcpy(member_path, home);
+    	            fptr = strchr(member_path, '/');
+    	            cptr = strrchr(member_path, '/');
+    	            if (fptr && cptr && (fptr == cptr))
+    		        strcpy(member_path, "/");
+    	            else if (cptr)
+    		        *cptr = '\0';
+    	        } else if (strcmp(member_path, "$HOME") == 0)
+    	            strcpy(member_path, home);
+
+    	        if (strcmp(reset_path, "$HOME_PARENT") == 0) {
+    		    strcpy(reset_path, home);
+    		    fptr = strchr(reset_path, '/');
+    		    cptr = strrchr(reset_path, '/');
+    		    if (fptr && cptr && (fptr == cptr))
+    		        strcpy(reset_path, "/");
+    		    else if (cptr)
+    		        *cptr = '\0';
+    	        } else if (strcmp(reset_path, "$HOME") == 0)
+    		    strcpy(reset_path, home);
+    	    }
+        }
+
+        /*
+         * Ensure that all pathnames are absolute path names.
+         */
+        if ((dir[0] != '/') || (member_path[0] != '/') ||
+            (reset_path[0] != '/')) {
+            if (debug)
+       	        syslog(LOG_NOTICE, MODULE ": Pathnames must start with '/'");
+            retval = 0;
+            goto skipping;
+        }
+
+        /*
+         * Ensure that reset pathname is not a subdirectory of the
+         * directory being polyinstantiated. Since we may have a case
+         * similar to /abcdef and /abc, we add a "/" to both reset and
+         * directory being polyinstantiated before comparing them.
+         */
+        sprintf(dir_tslash, "%s/", dir);
+        sprintf(reset_path_tslash, "%s/", reset_path);
+	if (strncmp(reset_path_tslash, dir_tslash, strlen(dir_tslash)) == 0) {
+            if (debug)
+       	        syslog(LOG_NOTICE, MODULE
+                ": Reset path %s cannot be inside the poly dir %s",
+                reset_path_tslash, dir_tslash);
+            retval = 0;
+            goto skipping;
+        }
+
+        /*
+         * Populate polyinstantiated directory structure with appropriate
+         * pathnames and the method with which to polyinstantiate.
+         */
+        memset(&poly, 0, sizeof(poly));
+        strcpy(poly.dir, dir);
+        strcpy(poly.member_path, member_path);
+        strcpy(poly.reset_path, reset_path);
+        if (strcmp(method, "user") == 0)
+            poly.method = USER;
+#ifdef WITH_SELINUX
+        else if (strcmp(method, "context") == 0)
+            poly.method = CONTEXT;
+        else if (strcmp(method, "both") == 0)
+            poly.method = BOTH;
+#endif
+        else {
+            syslog(LOG_NOTICE, MODULE": Illegal method - skipping");
+            retval = 0;
+            goto skipping;
+        }
+
+        /*
+         * If the line in namespace.conf for a directory to polyinstantiate
+         * contains a list of override users (users for whom polyinstantiation
+         * is not performed), read the user ids, convert names into uids, and
+         * add to polyinstantiated directory structure.
+         */
+        if (i == 5) {
+            for (count = 0, ustr = sstr = uids; sstr; ustr = sstr + 1, count++)
+               sstr = strchr(ustr, ',');
+            poly.num_uids = count;
+            poly.uid = (int *) malloc(count * sizeof (int));
+            uidptr = poly.uid;
+
+            ustr = uids;
+            for (i = 0; i < count; i++) {
+                tptr = strchr(ustr, ',');
+                if (tptr)
+                    *tptr = '\0';
+                pwd = getpwnam(ustr);
+                *uidptr = pwd->pw_uid;
+                if (i < count - 1) {
+                    ustr = tptr + 1;
+                    uidptr++;
+                }
+            }
+        } else {
+            poly.num_uids = 0;
+            poly.uid = NULL;
+        }
+
+	/*
+         * Add polyinstantiated directory structure to the linked list
+         * of all polyinstantiated directory structures.
+         */
+        add_polydir_entry(polydirs_ptr, &poly, debug);
+     	if (*polydirs_ptr == NULL) {
+            syslog(LOG_ERR, MODULE": Allocation Error");
+            retval = PAM_SERVICE_ERR;
+        }
+    }
+skipping:
+    return retval;
+}
+
+
+/*
+ * Parses /etc/security/namespace.conf file to build a linked list of
+ * polyinstantiated directory structures of type polydir_s. Each entry
+ * in the linked list contains information needed to polyinstantiate
+ * one directory.
+ */
+static int parse_config_file(pam_handle_t *pamh, struct polydir_s **polydirs_ptr, int debug)
+{
+    FILE *fil;
+    char *line, *user_name, *home;
+    struct passwd *cpwd;
+    int retval = 0;
+
+    if (debug)
+        syslog(LOG_NOTICE, MODULE": Parsing config file %s", CONF_FILE);
+
+    /*
+     * Obtain user name from PAM so we can extract the user's home
+     * directory. Home directory is needed to resolve $HOME entries
+     * in the namespace configuration file.
+     */
+    retval = pam_get_item(pamh, PAM_USER, (void*) &user_name );
+    if ( user_name == NULL || retval != PAM_SUCCESS ) {
+        syslog(LOG_ERR, MODULE "open_session - error recovering username");
+        return PAM_SESSION_ERR;
+    }
+    cpwd = getpwnam(user_name);
+    if (!cpwd) {
+        syslog(LOG_ERR,
+               MODULE "open_session user '%s' does not exist", user_name);
+        return PAM_SESSION_ERR;
+    }
+    home = (char *) malloc(PATH_MAX);
+    if (!home) {
+        syslog(LOG_ERR,
+               MODULE "Error allocating home directory space");
+        return PAM_SESSION_ERR;
+    }
+    memset(home, 0, strlen(home));
+    strcpy(home, cpwd->pw_dir);
+
+    line = (char *) malloc(PATH_MAX * 5);
+    if (!line) {
+        syslog(LOG_ERR,
+               MODULE "Error allocating buffer to hold a line from conf file");
+        if (home)
+            free(home);
+        return PAM_SESSION_ERR;
+    }
+    memset(line, 0, strlen(line));
+
+    /*
+     * Open configuration file, read one line at a time and call
+     * process_line to process each line.
+     */
+    fil = fopen(CONF_FILE, "r");
+    if (fil == NULL) {
+        syslog(LOG_ERR, MODULE": Error opening config file");
+        if (home)
+            free(home);
+        if (line)
+            free(line);
+        return PAM_SERVICE_ERR;
+    }
+
+    while (fgets(line, PATH_MAX*5, fil) != NULL) {
+        retval = process_line(line, home, polydirs_ptr, debug);
+        if (retval < 0) {
+            syslog(LOG_ERR, MODULE": Error processing conf file line %s", line);
+            if (home)
+                free(home);
+            if (line)
+                free(line);
+            fclose(fil);
+            return PAM_SERVICE_ERR;
+        }
+    }
+    fclose(fil);
+    if (home)
+        free(home);
+    if (line)
+        free(line);
+
+    return PAM_SUCCESS;
+}
+
+
+/*
+ * This funtion returns true if a given uid is present in the polyinstantiated
+ * directory's list of override uids. If the uid is one of the override
+ * uids for the polyinstantiated directory, polyinstantiation is not
+ * performed for that user for that directory.
+ */
+static int ns_override(struct polydir_s *polyptr, int uid, int debug)
+{
+    int i, retval = 0;
+
+    if (debug)
+    	syslog(LOG_NOTICE,
+		MODULE ": Checking for ns override for dir %s for uid %d",
+		polyptr->dir, uid);
+
+    for (i = 0; i < polyptr->num_uids; i++) {
+        if (uid == polyptr->uid[i]) {
+            retval = 1;
+    	    break;
+        }
+    }
+
+    return retval;
+}
+
+
+/*
+ * polymem_name returns the name of the polyinstnatiated member directory
+ * based on the method used for polyinstnatiation (user, context or both)
+ * In addition, the function also returns the security contexts of the
+ * original directory to polyinstantiate and the polyinstantiated member
+ * directory.
+ */
+#ifdef WITH_SELINUX
+static int polymem_name(struct polydir_s *polyptr, char *user_name, char *m_name, security_context_t *m_context, security_context_t *origcon, int debug)
+#else
+static int polymem_name(struct polydir_s *polyptr, char *user_name, char *m_name, int debug)
+#endif
+{
+    char *dir;
+#ifdef WITH_SELINUX
+    security_context_t scon = NULL;
+    security_class_t tclass;
+#endif
+
+    /*
+     * Get the last component of the pathname to polyinstantiate.
+     */
+    dir = strrchr(polyptr->dir, '/');
+    if (dir && strlen(dir) > 1)
+        dir++;
+    else
+        dir = polyptr->dir;
+
+#ifdef WITH_SELINUX
+    /*
+     * Get the security context of the directory to polyinstantiate.
+     */
+    getfilecon(polyptr->dir, origcon);
+    if (*origcon == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error getting poly dir context");
+        return PAM_SESSION_ERR;
+    }
+
+    /*
+     * If polyinstantiating based on security context, get current
+     * process security context, get security class for directories,
+     * and ask the policy to provide security context of the
+     * polyinstantiated member directory.
+     */
+    if ((polyptr->method == CONTEXT) || (polyptr->method == BOTH)) {
+        getexeccon(&scon);
+	if (scon == NULL) {
+    	    if (debug)
+    	        syslog(LOG_ERR, MODULE ": Error getting exec context");
+    	    return PAM_SESSION_ERR;
+	}
+        tclass = string_to_security_class("dir");
+
+        if (security_compute_member(scon, *origcon, tclass, m_context) < 0) {
+    	    if (debug)
+    	        syslog(LOG_ERR,
+                       MODULE ": Error computing poly dir member context");
+    	    return PAM_SESSION_ERR;
+        } else if (debug)
+    	    syslog(LOG_NOTICE, MODULE ": member context returned by policy %s",
+                    *m_context);
+    }
+#endif
+
+    /*
+     * Set the name of the polyinstantiated member based on the
+     * polyinstantiation method.
+     */
+    switch (polyptr->method) {
+        case USER:
+    	    sprintf(m_name, "%s/.%s%s", polyptr->member_path, user_name, dir);
+    	    break;
+
+#ifdef WITH_SELINUX
+        case CONTEXT:
+    	    sprintf(m_name, "%s/.%s%s", polyptr->member_path, *m_context, dir);
+    	    break;
+
+    	case BOTH:
+    	    sprintf(m_name, "%s/.%s%s%s", polyptr->member_path, *m_context,
+                    user_name, dir);
+    	    break;
+#endif /* WITH_SELINUX */
+
+    	default:
+    	    if (debug)
+    	        syslog(LOG_ERR, MODULE ": Unknown method");
+    	    return PAM_SESSION_ERR;
+    }
+
+    if (debug)
+        syslog(LOG_NOTICE, MODULE ": polymem_name %s", m_name);
+
+    return PAM_SUCCESS;
+}
+
+
+/*
+ * Create polyinstantiated member directory and reset directory, where
+ * the original "un-polyinstantiated" contents would be available to
+ * authorized processes.
+ */
+#ifdef WITH_SELINUX
+static int create_dirs(struct polydir_s *polyptr, char *rpath, char *mpath,
+                       security_context_t mcontext, security_context_t ocontext,
+                       int debug)
+#else
+static int create_dirs(struct polydir_s *polyptr, char *rpath, char *mpath,
+                       int debug)
+#endif
+{
+    struct stat statbuf;
+
+    /*
+     * stat the directory to polyinstantiate, so its owner-group-mode
+     * can be propagated to reset and member directories
+     */
+    if (stat(polyptr->dir, &statbuf) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error stating %s", polyptr->dir);
+        return PAM_SESSION_ERR;
+    }
+
+    /*
+     * Create reset directory, set its security context, mode and
+     * ownership attributes to match that of the original directory
+     * that is being polyinstantiated.
+     */
+    if (mkdir(rpath, statbuf.st_mode) < 0) {
+        if (errno != EEXIST) {
+            if (debug)
+                syslog(LOG_ERR, MODULE ": Error creating %s", rpath);
+            return PAM_SESSION_ERR;
+        }
+    }
+#ifdef WITH_SELINUX
+    if (setfilecon(rpath, ocontext) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error setting context of %s to %s",
+                   rpath, ocontext);
+        return PAM_SESSION_ERR;
+    }
+#endif
+    if (chmod(rpath, 0) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error changing mode for %s", rpath);
+        return PAM_SESSION_ERR;
+    }
+    if (chown(rpath, statbuf.st_uid, statbuf.st_gid) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error changing owner for %s", rpath);
+        return PAM_SESSION_ERR;
+    }
+
+    /*
+     * Create member directory and set its security context to the context
+     * returned by the security policy. Set its mode and ownership
+     * attributes to match that of the original directory that is being
+     * polyinstantiated.
+     */
+    if (mkdir(mpath, statbuf.st_mode) < 0) {
+        if (errno != EEXIST) {
+            if (debug)
+                syslog(LOG_ERR, MODULE ": Error creating %s", mpath);
+            return PAM_SESSION_ERR;
+        }
+    }
+#ifdef WITH_SELINUX
+    if (mcontext) {
+        if (setfilecon(mpath, mcontext) < 0) {
+            if (debug)
+                syslog(LOG_ERR, MODULE ": Error setting context of %s to %s",
+                       mpath, mcontext);
+            return PAM_SESSION_ERR;
+        }
+    } else {
+        if (setfilecon(mpath, ocontext) < 0) {
+            if (debug)
+                syslog(LOG_ERR, MODULE ": Error setting context of %s to %s",
+                       mpath, ocontext);
+            return PAM_SESSION_ERR;
+        }
+    }
+#endif
+    if (chmod(mpath, statbuf.st_mode) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error changing mode for %s", mpath);
+        return PAM_SESSION_ERR;
+    }
+    if (chown(mpath, statbuf.st_uid, statbuf.st_gid) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error changing owner for %s", mpath);
+        return PAM_SESSION_ERR;
+    }
+
+    return PAM_SUCCESS;
+}
+
+
+/*
+ * This function performs the namespace setup for a perticular directory
+ * that is being polyinstantiated. It creates MD5 hashes of reset and
+ * member directories, calls create_dirs to create them with appropriate
+ * security attributes, and performs bind mounts to setup the process
+ * namespace.
+ */
+static int ns_setup(struct polydir_s *polyptr, char *user_name, int debug)
+{
+    int i, retval = 0;
+    char resetname[PATH_MAX], *res_path, *mem_path;
+    char *c, *to, *md5res, *md5mem, *error, *memname, *dir, *lastchr;
+#ifdef WITH_SELINUX
+    security_context_t memcontext = NULL, origcontext = NULL;
+#endif
+    void *handle;
+    unsigned char mem_digest[MD5_DIGEST_LENGTH], res_digest[MD5_DIGEST_LENGTH];
+    unsigned char* (*MD5) (const unsigned char *, unsigned long,
+                           unsigned char *);
+
+    if (debug)
+        syslog(LOG_NOTICE,
+               MODULE ": Set namespace for directory %s", polyptr->dir);
+
+    dir = strrchr(polyptr->dir, '/');
+
+    if (dir && strlen(dir) > 1)
+        dir++;
+
+    sprintf(resetname, "%s/.%s-poly-orig", polyptr->reset_path, dir);
+    if (debug)
+        syslog(LOG_NOTICE, MODULE ": resetname %s", resetname);
+
+    if ((memname = (char *) malloc(PATH_MAX)) == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Unable to allocate space for mem name");
+        goto no_memname;
+    }
+    if ((res_path = (char *) malloc(PATH_MAX)) == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Unable to allocate space for res name");
+        goto no_respath;
+    }
+    if ((mem_path = (char *) malloc(PATH_MAX)) == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Unable to allocate space for mem path");
+        goto no_mempath;
+    }
+
+    /*
+     * Obtain names of reset and member pathnames based on the
+     * polyinstantiation method and member context returned by
+     * security policy.
+     */
+#ifdef WITH_SELINUX
+    retval = polymem_name(polyptr, user_name, memname, &memcontext,
+                          &origcontext, debug);
+#else
+    retval = polymem_name(polyptr, user_name, memname, debug);
+#endif
+
+    if (retval) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error getting member name");
+        goto no_polyname;
+    } else {
+#ifdef WITH_SELINUX
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Member context %s Orig context %s",
+                   memcontext, origcontext);
+#endif
+    }
+
+    /*
+     * Create MD5 hashes for member and reset pathnames.
+     */
+    handle = dlopen("libssl.so", RTLD_LAZY);
+    if (!handle) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error opening ssl library");
+        goto no_polyname;
+    }
+    *(void **) (&MD5) = dlsym(handle, "MD5");
+    if ((error = dlerror()) != NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error in ssl library %s", error);
+        goto no_polyname;
+    }
+    (*MD5)((unsigned char*)resetname,strlen((char*)resetname),res_digest);
+    (*MD5)((unsigned char*)memname,strlen((char*)memname),mem_digest);
+    dlclose(handle);
+
+    if ((c = (char *) malloc(3)) == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Unable to allocate space for mem name");
+        goto no_polyname;
+    }
+    if ((md5res = (char *) malloc(MD5_DIGEST_LENGTH * 2 + 1)) == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Unable to allocate space for mem name");
+        goto no_md5res;
+    }
+    if ((md5mem = (char *) malloc(MD5_DIGEST_LENGTH * 2 + 1)) == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Unable to allocate space for mem name");
+        goto no_md5mem;
+    }
+
+    to = md5res;
+    for (i = 0; i < MD5_DIGEST_LENGTH; i++) {
+        snprintf(c, 3, "%02x", (unsigned int)res_digest[i]);
+        to = stpcpy(to, c);
+    }
+
+    /*
+     * In the case where reset or member path is just / or has a trailing
+     * /, we should not include an extra / in the snprintfs below. It messes
+     * up when we are trying to unmount the filesystem based on
+     * /proc/mounts
+     */
+    lastchr = polyptr->reset_path + strlen(polyptr->reset_path) - 1;
+    if (*lastchr == '/')
+        snprintf(res_path, PATH_MAX,"%s.poly-%s", polyptr->reset_path, md5res);
+    else
+        snprintf(res_path, PATH_MAX,"%s/.poly-%s", polyptr->reset_path, md5res);
+
+    to = md5mem;
+    for (i = 0; i < MD5_DIGEST_LENGTH; i++) {
+        snprintf(c, 3, "%02x", (unsigned int)mem_digest[i]);
+        to = stpcpy(to, c);
+    }
+
+    lastchr = polyptr->member_path + strlen(polyptr->member_path) - 1;
+    if (*lastchr == '/')
+        snprintf(mem_path, PATH_MAX,"%s.mem-%s", polyptr->member_path, md5mem);
+    else
+        snprintf(mem_path, PATH_MAX,"%s/.mem-%s", polyptr->member_path, md5mem);
+
+    if (debug) {
+        syslog(LOG_NOTICE, MODULE ": reset %s", res_path);
+        syslog(LOG_NOTICE, MODULE ": member %s", mem_path);
+    }
+
+
+    /*
+     * Create reset and member directories with appropriate security
+     * contexts, owner, group and mode bits.
+     */
+#ifdef WITH_SELINUX
+    retval = create_dirs(polyptr, res_path, mem_path, memcontext,
+                         origcontext, debug);
+#else
+    retval = create_dirs(polyptr, res_path, mem_path, debug);
+#endif
+
+    if (retval < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error creating member/reset dirs");
+        goto error_out;
+    }
+
+    /*
+     * Bind mount polyinstantiated directory on reset path so it can
+     * be available from that alternate location to authorized trusted
+     * programs.
+     */
+    if (mount(polyptr->dir, res_path, NULL, MS_BIND, NULL) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error mounting %s on %s - error %d",
+                   polyptr->dir, res_path, errno);
+        goto error_out;
+    }
+
+    /*
+     * Bind mount member directory on top of the polyinstantiated
+     * directory to provide an instance of polyinstantiated directory
+     * based on polyinstantiated method.
+     */
+    if (mount(mem_path, polyptr->dir, NULL, MS_BIND, NULL) < 0) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Error mounting %s on %s - error %d",
+                   mem_path, polyptr->dir, errno);
+        goto error_out;
+    }
+
+    if (md5mem)
+        free(md5mem);
+    if (md5res)
+        free(md5res);
+    if (c)
+        free(c);
+    if (mem_path)
+        free(mem_path);
+    if (res_path)
+        free(res_path);
+    if (memname)
+        free(memname);
+
+    return retval;
+
+    /*
+     * various error exit points. Free allocated memory and set return
+     * value to indicate a pam session error.
+     */
+error_out:
+    if (md5mem)
+        free(md5mem);
+no_md5mem:
+    if (md5res)
+        free(md5res);
+no_md5res:
+    if (c)
+        free(c);
+no_polyname:
+    if (mem_path)
+        free(mem_path);
+no_mempath:
+    if (res_path)
+        free(res_path);
+no_respath:
+    if (memname)
+        free(memname);
+no_memname:
+    retval = PAM_SESSION_ERR;
+
+    return retval;
+}
+
+
+/*
+ * This function checks to see if the current working directory is
+ * inside the directory passed in as the first argument.
+ */
+static int cwd_in(char *dir, int debug)
+{
+    int retval = 0;
+    char *cwd = NULL, curr_dir[PATH_MAX], dir_tslash[PATH_MAX];
+
+    if ((cwd = getcwd(cwd, PATH_MAX)) == NULL) {
+        if (debug)
+            syslog(LOG_ERR, MODULE ": Can't get current dir - errno %d", errno);
+        return -1;
+    }
+    sprintf(curr_dir, "%s/", cwd);
+    sprintf(dir_tslash, "%s/", dir);
+
+    if (strncmp(curr_dir, dir_tslash, strlen(dir_tslash)) == 0) {
+        if (debug)
+            syslog(LOG_NOTICE, MODULE ": cwd is inside %s", dir);
+        retval = 1;
+    } else {
+        if (debug)
+            syslog(LOG_NOTICE, MODULE ": cwd is outside %s", dir);
+        retval = 0;
+    }
+
+    /*
+     * getcwd mallocs the string, so we have to free it
+     */
+    if (cwd)
+        free(cwd);
+    return retval;
+}
+
+
+/*
+ * This function reads /proc/mounts file to obtain names of mount points
+ * of all "reset" directories, where original contents of polyinstantiated
+ * directories are available to trusted programs. Once the names are read
+ * from /proc/mounts, umount system call is invoked for each of these
+ * reset directories.
+ */
+static int unmount_reset_dirs(int debug)
+{
+    int i, retval = 0, changing_dir = 0;
+    FILE *procmounts;
+    char line[PATH_MAX*3], mntdir[PATH_MAX];
+    char *mntpt, *mntpt_name, *mntpt_parent, *fptr, *cptr;
+
+    if (debug)
+        syslog(LOG_NOTICE, MODULE ": Attempting unmount of all reset dirs");
+
+    /*
+     * Open /proc/mounts file, read one line at a time, isolate
+     * mount point name (2nd string), and if starts with ".poly-"
+     * try and unmount it.
+     */
+    procmounts = fopen(PROC_MNTS, "r");
+    if (procmounts == NULL) {
+        syslog(LOG_ERR, MODULE ": Error opening %s file", PROC_MNTS);
+        goto bad_file;
+    }
+
+    if ((mntpt = (char *) malloc(PATH_MAX)) == NULL) {
+        syslog(LOG_ERR, MODULE ": Error allocating buffer to hold pathname");
+        goto bad_alloc_mnt;
+    }
+    if ((mntpt_parent = (char *) malloc(PATH_MAX)) == NULL) {
+        syslog(LOG_ERR, MODULE ": Error allocating buffer to hold pathname");
+        goto bad_alloc_mntparent;
+    }
+
+    while (fgets(line, PATH_MAX*3, procmounts) != NULL) {
+        if ((i = sscanf(line, "%s%s", mntdir, mntpt)) != 2) {
+            syslog(LOG_ERR, MODULE": Error parsing %s file", PROC_MNTS);
+            goto bad_umnt;
+	}
+        if ((mntpt_name = strrchr(mntpt, '/')) != NULL) {
+            strcpy(mntpt_parent, mntpt);
+            if (strncmp(mntpt_name, "/.poly-", 7) == 0) {
+                /*
+                 * Check to see if process current directory is in the
+                 * bind mounted reset directory that we are trying to
+                 * umount
+                 */
+                if ((changing_dir = cwd_in(mntpt, debug)) < 0) {
+                    syslog(LOG_ERR, MODULE": Error checking current dir");
+                    goto bad_umnt;
+                } else if (changing_dir) {
+                    if (debug)
+                        syslog(LOG_NOTICE, MODULE ": changing cwd");
+
+                    /*
+                     * Change current working directory to the parent of
+                     * the mount point, that is parent of the reset
+                     * directory where original contents of the polydir
+                     * are available from
+                     */
+                    strcpy(mntpt_parent, mntpt);
+    	            fptr = strchr(mntpt_parent, '/');
+    	            cptr = strrchr(mntpt_parent, '/');
+    	            if (fptr && cptr && (fptr == cptr))
+    		        strcpy(mntpt_parent, "/");
+    	            else if (cptr)
+    		        *cptr = '\0';
+                    if (chdir(mntpt_parent) < 0) {
+                        syslog(LOG_ERR, MODULE "unable to chdir to %s error %d",
+                               mntpt_parent, errno);
+                    goto bad_umnt;
+                    }
+                }
+
+                /*
+                 * Now try and umount
+                 */
+                if (umount(mntpt) < 0) {
+                    syslog(LOG_ERR, MODULE "Umount failed for %s error %d",
+                           mntpt, errno);
+                    goto bad_umnt;
+                } else {
+                    if (debug)
+                        syslog(LOG_NOTICE, MODULE ": umounted reset dir %s",
+                               mntpt);
+                }
+            }
+        }
+    }
+    fclose(procmounts);
+    return PAM_SUCCESS;
+
+bad_umnt:
+    if (mntpt_parent)
+        free(mntpt_parent);
+bad_alloc_mntparent:
+    if (mntpt)
+        free(mntpt);
+bad_alloc_mnt:
+    fclose(procmounts);
+bad_file:
+    retval = PAM_SERVICE_ERR;
+    return retval;
+}
+
+
+/*
+ * This function checks to see if polyinstantiation is needed for any
+ * of the directories listed in the configuration file; if needed,
+ * cycles through all polyinstantiated directory entries and calls
+ * ns_setup to setup polyinstantiation for each one of them.
+ */
+static int setup_namespace(pam_handle_t *pamh, struct polydir_s *polydirs, int unmnt_first, int debug)
+{
+    int retval = 0, need_poly = 0, changing_dir = 0;
+    char *user_name, *cptr, *fptr, poly_parent[PATH_MAX];
+    struct passwd *pwd;
+    struct polydir_s *pptr;
+
+    if (debug)
+        syslog(LOG_NOTICE, MODULE ": Set up namespace %d", getpid());
+
+    retval = pam_get_item(pamh, PAM_USER, (void*) &user_name );
+    if ( user_name == NULL || retval != PAM_SUCCESS ) {
+        syslog(LOG_ERR, MODULE "open_session - error recovering username");
+        return PAM_SESSION_ERR;
+    }
+    pwd = getpwnam(user_name);
+    if (!pwd) {
+        syslog(LOG_ERR, MODULE "open_session - no user '%s'", user_name);
+        return PAM_SESSION_ERR;
+    }
+
+    /*
+     * Cycle through all polyinstantiated directory entries to see if
+     * polyinstantiation is needed at all.
+     */
+    for (pptr = polydirs; pptr; pptr = pptr->next) {
+        if (ns_override(pptr, pwd->pw_uid, debug)) {
+            if (debug)
+                syslog(LOG_NOTICE, "Overriding poly for user %d for dir %s",
+                       pwd->pw_uid, pptr->dir);
+            continue;
+        } else {
+            if (debug)
+                syslog(LOG_NOTICE, "Need poly ns for user %d for dir %s",
+                       pwd->pw_uid, pptr->dir);
+            need_poly = 1;
+            break;
+        }
+    }
+
+    /*
+     * If polyinstnatiation is needed, call the unshare system call to
+     * disassociate from the parent namespace.
+     */
+    if (need_poly) {
+        if (unshare(CLONE_NEWNS) < 0) {
+            syslog(LOG_ERR, MODULE "Unable to unshare from parent namespace");
+            return PAM_SESSION_ERR;
+        } else
+            syslog(LOG_ERR, MODULE "Unshare successful for %d", getpid());
+    } else
+        return PAM_SUCCESS;
+
+    /*
+     * If need to unmount previously bind mounted polyinstantiated
+     * directories, call unmount_reset_dirs to unmount polyinstantiated
+     * directories from their alternate location where they were available
+     * to trusted programs.
+     */
+    if (unmnt_first) {
+        if ((retval = unmount_reset_dirs(debug)) < 0) {
+            syslog(LOG_ERR, MODULE "Unmount of reset directories failed");
+            return PAM_SESSION_ERR;
+        } else if (debug)
+            syslog(LOG_NOTICE, MODULE "Unmount of reset directories succeeded");
+    }
+
+    /*
+     * Again cycle through all polyinstantiated directories, this time,
+     * call ns_setup to setup polyinstantiation for a perticular entry.
+     */
+    for (pptr = polydirs; pptr; pptr = pptr->next) {
+        if (ns_override(pptr, pwd->pw_uid, debug))
+            continue;
+        else {
+            if (debug)
+                syslog(LOG_NOTICE, "Setting poly ns for user %d for dir %s",
+                       pwd->pw_uid, pptr->dir);
+
+            if (unmnt_first) {
+                /*
+                 * Check to see if process current directory is in the
+                 * bind mounted member directory that we are trying to
+                 * umount
+                 */
+                if ((changing_dir = cwd_in(pptr->dir, debug)) < 0) {
+                    syslog(LOG_ERR, MODULE": Error checking current dir");
+                    return PAM_SESSION_ERR;
+                } else if (changing_dir) {
+                    if (debug)
+                        syslog(LOG_NOTICE, MODULE ": changing cwd");
+
+                    /*
+                     * Change current working directory to the parent of
+                     * the mount point, that is parent of the reset
+                     * directory where original contents of the polydir
+                     * are available from
+                     */
+                    strcpy(poly_parent, pptr->dir);
+    	            fptr = strchr(poly_parent, '/');
+        	    cptr = strrchr(poly_parent, '/');
+        	    if (fptr && cptr && (fptr == cptr))
+        	        strcpy(poly_parent, "/");
+        	    else if (cptr)
+        	        *cptr = '\0';
+                    if (chdir(poly_parent) < 0) {
+                        syslog(LOG_ERR, MODULE "Can't chdir to %s error %d",
+                               poly_parent, errno);
+                    }
+                }
+
+                if (umount(pptr->dir) < 0) {
+                    syslog(LOG_ERR, MODULE "Unmount of %s failed, error %d",
+                           pptr->dir, errno);
+                    return PAM_SESSION_ERR;
+                } else if (debug)
+                    syslog(LOG_ERR, MODULE "Umount succeeded %s", pptr->dir);
+            }
+
+            retval = ns_setup(pptr, user_name, debug);
+            if (retval != PAM_SUCCESS) {
+                syslog(LOG_ERR, "Couldn't set poly ns for user %d for dir %s",
+                       pwd->pw_uid, pptr->dir);
+                break;
+            }
+        }
+    }
+
+    return retval;
+}
+
+
+/*
+ * Reset namespace. This function is called from when clossing a pam
+ * session. If authorized, it unmounts member directory and reset
+ * directory (where original directory was bind mounted).
+ */
+static int reset_namespace(pam_handle_t *pamh, struct polydir_s *polydirs, int debug)
+{
+    int retval = 0;
+    char *user_name;
+    struct passwd *pwd;
+    struct polydir_s *pptr;
+
+    if (debug)
+        syslog(LOG_NOTICE, MODULE ": reset namespace %d", getpid());
+
+    retval = pam_get_item(pamh, PAM_USER, (void*) &user_name );
+    if ( user_name == NULL || retval != PAM_SUCCESS ) {
+        syslog(LOG_ERR, MODULE "close_session - error recovering username");
+        return PAM_SESSION_ERR;
+    }
+
+    pwd = getpwnam(user_name);
+    if (!pwd) {
+        syslog(LOG_ERR, MODULE "close_session - no user '%s'", user_name);
+        return PAM_SESSION_ERR;
+    }
+
+    /*
+     * Cycle through all polyinstantiated directories from the namespace
+     * configuration file to see if polyinstantiation was performed for
+     * this user for each of the entry. If it was, try and unmount
+     * appropriate polyinstantiated member directories.
+     */
+    for (pptr = polydirs; pptr; pptr = pptr->next) {
+        if (ns_override(pptr, pwd->pw_uid, debug))
+            continue;
+        else {
+            if (debug)
+                syslog(LOG_NOTICE, "Unmounting member dir for user %d & dir %s",
+                       pwd->pw_uid, pptr->dir);
+
+            if (umount(pptr->dir) < 0) {
+                syslog(LOG_ERR, MODULE "Unmount of %s failed, error %d",
+                       pptr->dir, errno);
+                return PAM_SESSION_ERR;
+            } else if (debug)
+                syslog(LOG_ERR, MODULE "Unmount of %s succeeded", pptr->dir);
+        }
+    }
+
+    /*
+     * Call unmount_reset_dirs to unmount polyinstantiated directories
+     * from their alternate location where they were available to trusted
+     * programs.
+     */
+    if ((retval = unmount_reset_dirs(debug)) < 0)
+        syslog(LOG_ERR, MODULE "Unmount of reset directories failed");
+    else if (debug)
+        syslog(LOG_NOTICE, MODULE "Unmount of reset directories succeeded");
+
+    return retval;
+}
+
+
+/*
+ * Entry point from pam_open_session call.
+ */
+PAM_EXTERN int pam_sm_open_session(pam_handle_t *pamh, int flags,
+                                   int argc, const char **argv)
+{
+    int i, debug = 0, unmnt_first = 0, retval = 0;
+    struct polydir_s *polydirs = NULL;
+
+    /* Parse arguments. */
+    for (i = 0; i < argc; i++) {
+        if (strcmp(argv[i], "debug") == 0)
+            debug = 1;
+        if (strcmp(argv[i], "unmnt_first") == 0)
+            unmnt_first = 1;
+    }
+
+    /*
+     * Parse namespace configuration file which lists directories to
+     * polyinstantiate, directory where member subdirectories are to
+     * be created and the method used for polyinstantiation.
+     */
+    retval = parse_config_file(pamh, &polydirs, debug);
+    if (retval != PAM_SUCCESS) {
+        syslog(LOG_ERR, MODULE "open_session - error parsing config file");
+        return PAM_SESSION_ERR;
+    }
+
+    if (polydirs) {
+        if (debug)
+            syslog(LOG_NOTICE, MODULE ": Creating namespace %d", getpid());
+
+        retval = setup_namespace(pamh, polydirs, unmnt_first, debug);
+        if (retval) {
+            if (debug)
+                syslog(LOG_NOTICE, MODULE ": namespace setup failed");
+        } else {
+            if (debug)
+                syslog(LOG_NOTICE, MODULE ": namespace set for %d", getpid());
+        }
+    } else if (debug)
+        syslog(LOG_NOTICE, MODULE ": Nothing to polyinstantiate");
+
+    return retval;
+}
+
+
+/*
+ * Entry point from pam_close_session call.
+ */
+PAM_EXTERN int pam_sm_close_session(pam_handle_t *pamh, int flags,
+                                    int argc, const char **argv)
+{
+    int i, debug = 0, retval = 0;
+    struct polydir_s *polydirs = NULL;
+
+    /* Parse arguments. */
+    for (i = 0; i < argc; i++) {
+        if (strcmp(argv[i], "debug") == 0) {
+            debug = 1;
+        }
+    }
+
+    /*
+     * Parse namespace configuration file which lists directories that
+     * are polyinstantiated, directories where member subdirectories are
+     * created and the method used for polyinstantiation.
+     */
+    retval = parse_config_file(pamh, &polydirs, debug);
+    if ((retval != PAM_SUCCESS) || !polydirs) {
+        syslog(LOG_ERR, MODULE "close_session - error parsing config file");
+        return PAM_SESSION_ERR;
+    }
+
+    if (debug)
+        syslog(LOG_NOTICE, MODULE ": Resetting namespace %d", getpid());
+
+    retval = reset_namespace(pamh, polydirs, debug);
+
+    if (retval) {
+        if (debug)
+            syslog(LOG_NOTICE, MODULE ": reset namespace failed %d", getpid());
+    } else {
+        if (debug)
+            syslog(LOG_NOTICE, MODULE ": reset namespace ok %d", getpid());
+    }
+    return PAM_SUCCESS;
+}
+
+#ifdef PAM_STATIC
+
+/* static module data */
+
+struct pam_module _pam_namespace_modstruct = {
+     "pam_namespace",
+     NULL,
+     NULL,
+     NULL,
+     pam_sm_open_session,
+     pam_sm_close_session,
+     NULL
+};
+#endif

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
