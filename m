Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p49KX068008251
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 16:33:00 -0400
Received: from fep05-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p49KWxCN016822
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 20:32:59 GMT
Subject: [PATCH 2/2 v2]: improve the manual page for setfiles
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Lawrence <slawrence@tresys.com>
Date: Mon, 09 May 2011 22:32:55 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1304973177.2521.71.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RE-SUBMISSION (originally submitted on Sun, 20 Feb 2011 09:56:52 +0100)

Improvements to the manual page documentation for setfiles
(policycoreutils):

- specify that "-c" option takes an argument;
- document "-f" option (list of files from a text file);
- document "-p" option (progress meter);
- improve formatting in SYNOPSIS section by remove trailing spaces from
bracketed options that expect an argument;
- use American spelling in DESCRIPTION section (instead of British
spelling for word "initialize");
- improve formatting for the "-0" option (added space at the end of
sentence);
- minor formatting improvements (e.g. remove double spaces, terminate
all sentences with a dot).

diff -pruN selinux/policycoreutils/setfiles/setfiles.8 selinux-policycoreutils-setfiles-man-page/policycoreutils/setfiles/setfiles.8
--- selinux/policycoreutils/setfiles/setfiles.8	2011-05-09 01:04:17.079842517 +0200
+++ selinux-policycoreutils-setfiles-man-page/policycoreutils/setfiles/setfiles.8	2011-05-09 21:59:02.513259804 +0200
@@ -4,14 +4,14 @@ setfiles \- set file SELinux security co
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-c policy ] [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
+.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-q] [\-f filename] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
 program.
 .P
-This program is primarily used to initialise the security context
-database (extended attributes) on one or more filesystems.  This
+This program is primarily used to initialize the security context
+database (extended attributes) on one or more filesystems. This
 program is initially run as part of the SE Linux installation process.
 .P
 It can also be run at any time to correct errors, to add support for
@@ -20,7 +20,7 @@ contexts are all as you expect.
 
 .SH "OPTIONS"
 .TP 
-.B \-c
+.B \-c policy
 check the validity of the contexts against the specified binary policy.
 .TP
 .B \-d
@@ -36,32 +36,40 @@ don't change any file labels.
 suppress non-error output.
 .TP 
 .B \-r rootpath
-use an alternate root path
+use an alternate root path.
 .TP 
 .B \-e directory
-directory to exclude (repeat option for more than one directory.)
+directory to exclude (repeat option for more than one directory).
 .TP 
 .B \-F
-Force reset of context to match file_context for customizable files
+Force reset of context to match file_context for customizable files.
 .TP 
 .B \-o filename
 save list of files with incorrect context in filename.
+.TP
+.B \-f filename
+take a list of files from a specific text file.
 .TP 
 .B \-s
 take a list of files from standard input instead of using a pathname on the
-command line.
+command line (as in -f).
+.TP
+.B \-p
+display progress meter (mutually exclusive with \-v or \-vv).
 .TP
 .B \-v
-show changes in file labels, if type or role are changing.
+show changes in file labels, if type or role are changing (mutually
+exclusive with \-p).
 .TP 
 .B \-vv
-show changes in file labels, if type, role, or user are changing.
+show changes in file labels, if type, role, or user are changing (mutually
+exclusive with \-p).
 .TP 
 .B \-W
 display warnings about entries that had no matching files.
 .TP 
 .B \-0
-Input items are terminated by a null character instead of by whitespace,  and the quotes and backslash are not special (every character is taken literally).  Disables the end of file string, which  is  treated  like  any other argument.  Useful when input items might contain white space, quote  marks,  or  backslashes.The  GNU  find  -print0  option produces input suitable for this mode.
+Input items are terminated by a null character instead of by whitespace, and the quotes and backslash are not special (every character is taken literally). Disables the end of file string, which is treated like any other argument. Useful when input items might contain white space, quote marks, or backslashes. The GNU find -print0 option produces input suitable for this mode.
 
 .SH "ARGUMENTS"
 .B spec_file
@@ -69,11 +77,11 @@ The specification file which contains li
 .br
 .B regexp [ \-type ] ( context | <<none>> )
 .br
-The regular expression is anchored at both ends.  The optional type field 
+The regular expression is anchored at both ends. The optional type field 
 specifies the file type as shown in the mode field by the
 .B ls(1)
 program, e.g. \-\- to match only regular files or \-d to match only
-directories.  The context can be an ordinary security context or the
+directories. The context can be an ordinary security context or the
 string <<none>> to specify that the file is not to have its context
 changed.
 .br
@@ -87,11 +95,13 @@ specification other than <<none>>.
 The pathname for the root directory of each file system to be relabeled. 
 Not used if the
 .B \-s
+or the
+.B \-f
 option is used.
 
 .SH "AUTHOR"
 This man page was written by Russell Coker <russell@coker.com.au>.
-The program was written by Stephen Smalley <sds@epoch.ncsc.mil>
+The program was written by Stephen Smalley <sds@epoch.ncsc.mil>.
 
 .SH "SEE ALSO"
 .BR load_policy (8),


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
