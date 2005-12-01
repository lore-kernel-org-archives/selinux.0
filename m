Message-ID: <438F579E.6070506@redhat.com>
Date: Thu, 01 Dec 2005 15:05:50 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
   "selinux >> SE Linux" <selinux@tycho.nsa.gov>
Subject: Checkmodule man page
Content-Type: multipart/mixed;
 boundary="------------040009000105010206090109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040009000105010206090109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



-- 



--------------040009000105010206090109
Content-Type: text/x-patch;
 name="checkpolicy-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="checkpolicy-rhat.patch"

diff --exclude-from=exclude -N -u -r nsacheckpolicy/checkmodule.8 checkpolicy-1.27.19/checkmodule.8
--- nsacheckpolicy/checkmodule.8	1969-12-31 19:00:00.000000000 -0500
+++ checkpolicy-1.27.19/checkmodule.8	2005-12-01 15:00:22.000000000 -0500
@@ -0,0 +1,45 @@
+.TH CHECKMODULE 8
+.SH NAME
+checkmodule \- SELinux policy module compiler
+.SH SYNOPSIS
+.B checkmodule
+.I "[-b] [-d] [-M] [-c policyvers] [-o output_file] [input_file]"
+ .br
+.SH "DESCRIPTION"
+This manual page describes the
+.BR checkmodule
+command.
+.PP
+.B checkmodule
+is a program that checks and compiles a SELinux security policy module
+into a binary representation.  Use semodule_package to combine this module with
+its optional file context to create a policy package that can be loaded into the kernel.  
+
+.SH OPTIONS
+.TP
+.B \-b
+Read an existing binary policy file rather than a source policy.conf file.
+.TP
+.B \-d
+Enter debug mode after loading the policy.
+.TP
+.B \-M
+Enable the MLS policy when checking and compiling the policy.
+.TP
+.B \-o filename
+Write a binary policy file to the specified filename.
+.TP
+.B \-c policyvers
+Specify the policy version, defaults to the latest.
+
+.SH "SEE ALSO"
+.B load_policy(8), semodule(8), semodule_package(8), semodule_expand(8), semodule_link(8)
+SELinux documentation at http://www.nsa.gov/selinux/docs.html,
+especially "Configuring the SELinux Policy".
+
+
+.SH AUTHOR
+This manual page was copied from the checkpolicy man page 
+written by Arpad Magosanyi <mag@bunuel.tii.matav.hu>, 
+and edited by Dan Walsh <dwalsh@redhat.com>.
+The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
diff --exclude-from=exclude -N -u -r nsacheckpolicy/Makefile checkpolicy-1.27.19/Makefile
--- nsacheckpolicy/Makefile	2005-09-12 16:30:34.000000000 -0400
+++ checkpolicy-1.27.19/Makefile	2005-12-01 15:00:34.000000000 -0500
@@ -45,6 +45,7 @@
 	-mkdir -p $(MANDIR)/man8
 	install -m 755 $(TARGETS) $(BINDIR)	
 	install -m 644 checkpolicy.8 $(MANDIR)/man8
+	install -m 644 checkmodule.8 $(MANDIR)/man8
 
 relabel: install
 	/sbin/restorecon $(BINDIR)/checkpolicy

--------------040009000105010206090109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
