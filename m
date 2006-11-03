Message-ID: <454A9527.2010909@us.ibm.com>
Date: Thu, 02 Nov 2006 19:02:31 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------050203000001040203010508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050203000001040203010508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael C Thompson wrote:
> The 8 patches are as follows:
> 1) Modifications to Makefile to support future patch needs
>    Add newrole-lspp.pamd

This is the 1st of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This patch adds the new lspp pam.d support file for namespaces,
and includes new compile-time options to the Makefile.

Changes:
  * Makefile now has AUDIT_LOG_PRIV and NAMESPACE_PRIV, as well as
    LSPP_PRIV (causes both previous to be on)
  * Adds newrole-lspp.pamd

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------050203000001040203010508
Content-Type: text/x-diff;
 name="01-prep_non_source.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-prep_non_source.patch"

diff -Naur policycoreutils-1.30.30/newrole/Makefile policycoreutils-1.30.30.suid/newrole/Makefile
--- policycoreutils-1.30.30/newrole/Makefile	2006-09-29 10:50:27.000000000 -0500
+++ policycoreutils-1.30.30.suid/newrole/Makefile	2006-11-02 12:13:15.000000000 -0600
@@ -10,6 +10,19 @@
 # This is so that we have the CAP_AUDIT_WRITE capability. newrole will
 # shed all privileges and change to the user's uid.
 LOG_AUDIT_PRIV ?= n
+
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
+LSPP_PRIV ?= n
 VERSION = $(shell cat ../VERSION)
 
 CFLAGS ?= -Werror -Wall -W
@@ -26,6 +39,26 @@
 	override CFLAGS += -DUSE_AUDIT
 	LDLIBS += -laudit
 endif
+
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
+	MODE := 4555
+	LDLIBS += -lcap
+else
+	MODE := 0555
+endif
+
 ifeq (${LOG_AUDIT_PRIV},y)
 	override CFLAGS += -DLOG_AUDIT_PRIV
 	LDLIBS += -lcap
@@ -46,8 +79,12 @@
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
diff -Naur policycoreutils-1.30.30/newrole/newrole-lspp.pamd policycoreutils-1.30.30.suid/newrole/newrole-lspp.pamd
--- policycoreutils-1.30.30/newrole/newrole-lspp.pamd	1969-12-31 18:00:00.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole-lspp.pamd	2006-11-02 12:11:19.000000000 -0600
@@ -0,0 +1,5 @@
+#%PAM-1.0
+auth       include	system-auth
+account    include	system-auth
+password   include	system-auth
+session    required	pam_namespace.so unmnt_remnt no_unmount_on_close

--------------050203000001040203010508--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
