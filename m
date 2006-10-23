Subject: Re: [PATCH 4/4] newrole suid functionality (take 2)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4535245A.4010307@us.ibm.com>
References: <45351FC9.2080204@us.ibm.com>  <4535245A.4010307@us.ibm.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 15:09:08 -0400
Message-Id: <1161630549.3316.130.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-17 at 13:43 -0500, Michael C Thompson wrote:
> Michael C Thompson wrote:
> > This is the intro to a set of four patches.
> > 
> > These patches are an attempt to make newrole be an acceptably secure 
> > suid root program, to provide it with the capabilities to generate audit 
> > records (existing) and handle polyinstatiation (new).
> > 
> > The 4 patches are as follows:
> > 1) New functions introduced to newrole.c, new and existing functionality
> > 2) Changes to existing functions in newrole.c
> > 3) Updates to main in newrole.c to use the aforementioned changes
> > 4) Changes to the Makefile to allow building of newrole with the
> >    changes and introduction of newrole-lspp.pamd
> 
> This is the 4th of 4 patches.
> This patch applies against policycoreutils-1.30.30-1.
> 
> Changes:
>   * Makefile now has AUDIT_LOG_PRIV and NAMESPACE_PRIV, as well as
>     LSPP_PRIV (causes both previous to be on)
>   * Adds newrole-lspp.pamd
> 
> Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>

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

The plan would be to make LSPP_PRIV = n by default in the upstream
Makefile, then Red Hat can build with make LSPP_PRIV=y in their .spec
file.  That ensures it is always an explicit choice to enable this.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
