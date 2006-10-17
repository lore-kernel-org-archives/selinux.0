Message-ID: <4535245A.4010307@us.ibm.com>
Date: Tue, 17 Oct 2006 13:43:38 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 4/4] newrole suid functionality (take 2)
References: <45351FC9.2080204@us.ibm.com>
In-Reply-To: <45351FC9.2080204@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060907040500040702030406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060907040500040702030406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael C Thompson wrote:
> This is the intro to a set of four patches.
> 
> These patches are an attempt to make newrole be an acceptably secure 
> suid root program, to provide it with the capabilities to generate audit 
> records (existing) and handle polyinstatiation (new).
> 
> The 4 patches are as follows:
> 1) New functions introduced to newrole.c, new and existing functionality
> 2) Changes to existing functions in newrole.c
> 3) Updates to main in newrole.c to use the aforementioned changes
> 4) Changes to the Makefile to allow building of newrole with the
>    changes and introduction of newrole-lspp.pamd

This is the 4th of 4 patches.
This patch applies against policycoreutils-1.30.30-1.

Changes:
  * Makefile now has AUDIT_LOG_PRIV and NAMESPACE_PRIV, as well as
    LSPP_PRIV (causes both previous to be on)
  * Adds newrole-lspp.pamd

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------060907040500040702030406
Content-Type: text/x-diff;
 name="04-update_Makefile_add_lspp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-update_Makefile_add_lspp.patch"

diff -Naur policycoreutils-1.30.30.orig/newrole/Makefile policycoreutils-1.30.30.suid/newrole/Makefile
--- policycoreutils-1.30.30.orig/newrole/Makefile	2006-09-29 10:50:27.000000000 -0500
+++ policycoreutils-1.30.30.suid/newrole/Makefile	2006-10-17 12:58:01.000000000 -0500
@@ -6,10 +6,18 @@
 LOCALEDIR = /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
-# If LOG_AUDIT_PRIV is y, then newrole will be made into setuid root program.
-# This is so that we have the CAP_AUDIT_WRITE capability. newrole will
-# shed all privileges and change to the user's uid.
-LOG_AUDIT_PRIV ?= n
+# Enable capabilities to permit newrole to generate audit records.
+# This will make newrole a setuid root program.
+# The capabilities used are: CAP_AUDIT_WRITE.
+AUDIT_LOG_PRIV ?= n
+# Enable capabilities to permit newrole to utilitize the pam_namespace module.
+# This will make newrole a setuid root program.
+# The capabilities used are: CAP_SYS_ADMIN, CAP_CHOWN, CAP_FOWNER and
+# CAP_DAC_OVERRIDE. 
+NAMESPACE_PRIV ?= n
+# If LSPP_PRIV is y, then newrole will be made into setuid root program.
+# Enabling this option will force AUDIT_LOG_PRIV and NAMESPACE_PRIV to be y.
+LSPP_PRIV ?= y
 VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
@@ -26,10 +34,21 @@
 	override CFLAGS += -DUSE_AUDIT
 	LDLIBS += -laudit
 endif
-ifeq (${LOG_AUDIT_PRIV},y)
-	override CFLAGS += -DLOG_AUDIT_PRIV
-	LDLIBS += -lcap
+ifeq (${LSPP_PRIV},y)
+	override AUDIT_LOG_PRIV=y
+	override NAMESPACE_PRIV=y
+endif
+ifeq (${AUDIT_LOG_PRIV},y)
+	override CFLAGS += -DAUDIT_LOG_PRIV
+	IS_SUID=y
+endif
+ifeq (${NAMESPACE_PRIV},y)
+	override CFLAGS += -DNAMESPACE_PRIV
+	IS_SUID=y
+endif
+ifeq (${IS_SUID},y)
 	MODE := 4555
+	LDLIBS += -lcap
 else
 	MODE := 555
 endif
@@ -46,8 +65,12 @@
 	install -m 644 newrole.1 $(MANDIR)/man1/
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	test -d $(ETCDIR)/pam.d || install -m 755 -d $(ETCDIR)/pam.d
+ifeq (${LSPP_PRIV},y)
+	install -m 644 newrole-lspp.pamd $(ETCDIR)/pam.d/newrole
+else
 	install -m 644 newrole.pamd $(ETCDIR)/pam.d/newrole
 endif
+endif
 
 clean:
 	rm -f $(TARGETS) *.o 
diff -Naur policycoreutils-1.30.30.orig/newrole/newrole-lspp.pamd policycoreutils-1.30.30.suid/newrole/newrole-lspp.pamd
--- policycoreutils-1.30.30.orig/newrole/newrole-lspp.pamd	1969-12-31 18:00:00.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole-lspp.pamd	2006-10-17 12:58:01.000000000 -0500
@@ -0,0 +1,5 @@
+#%PAM-1.0
+auth       include	system-auth
+account    include	system-auth
+password   include	system-auth
+session    required	pam_namespace.so unmnt_remnt no_unmount_on_close

--------------060907040500040702030406--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
