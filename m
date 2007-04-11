Message-ID: <461D2A3D.5040908@redhat.com>
Date: Wed, 11 Apr 2007 14:34:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fixes for checkmodule man page.
Content-Type: multipart/mixed;
 boundary="------------070007070604080501070405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070007070604080501070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070007070604080501070405
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

--- checkpolicy-2.0.1/checkmodule.8~	2007-02-20 09:20:51.000000000 -0500
+++ checkpolicy-2.0.1/checkmodule.8	2007-04-11 14:32:40.000000000 -0400
@@ -3,7 +3,7 @@
 checkmodule \- SELinux policy module compiler
 .SH SYNOPSIS
 .B checkmodule
-.I "[-b] [-d] [-m] [-M] [-o output_file] [input_file]"
+.I "[-b] [-m] [-M] [-V] [-o output_file] [input_file]"
 .SH "DESCRIPTION"
 This manual page describes the
 .BR checkmodule
@@ -25,16 +25,15 @@
 Read an existing binary policy module file rather than a source policy
 module file.  This option is a development/debugging aid.
 .TP
-.B \-d
-Enter debug mode after loading the policy.  This option is a 
-development/debugging aid.
-.TP
 .B \-m
 Generate a non-base policy module.
 .TP
 .B \-M
 Enable the MLS/MCS support when checking and compiling the policy module.
 .TP
+.B \-V
+ Show policy versions created by this program
+.TP
 .B \-o filename
 Write a binary policy module file to the specified filename.
 Otherwise, checkmodule will only check the syntax of the module source file

--------------070007070604080501070405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
