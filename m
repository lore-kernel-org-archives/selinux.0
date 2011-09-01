Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p810LfUb024542
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:21:41 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p810Lc2P008285
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 00:21:39 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 727D718060
	for <selinux@tycho.nsa.gov>; Thu,  1 Sep 2011 10:21:29 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: policycoreutils man pages patch
Date: Thu, 1 Sep 2011 10:21:32 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MAtXOn3E16oT0Zi"
Message-Id: <201109011021.32754.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_MAtXOn3E16oT0Zi
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

The attached patch documents semanage -i, the -p option for setfiles and 
restorecon, the -0 option for restorecon, and the fact that setfiles and 
restorecon are the same program.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--Boundary-00=_MAtXOn3E16oT0Zi
Content-Type: text/x-patch;
  charset="UTF-8";
  name="policycoreutils-man.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="policycoreutils-man.diff"

--- policycoreutils-2.1.0.orig/semanage/semanage.8
+++ policycoreutils-2.1.0/semanage/semanage.8
@@ -21,6 +21,8 @@
 .br
 .B semanage permissive \-{a|d} type
 .br
+.B semanage -i command-file
+.br
 .B semanage dontaudit [ on | off ]
 .P
 
@@ -99,6 +101,10 @@
 .TP
 .I                \-t, \-\-type       
 SELinux Type for the object
+.TP
+.I                \-i
+Take a set of commands from a specified file and load them in a single
+transaction.
 
 .SH EXAMPLE
 .nf
--- policycoreutils-2.1.0.orig/setfiles/restorecon.8
+++ policycoreutils-2.1.0/setfiles/restorecon.8
@@ -4,10 +4,10 @@
 
 .SH "SYNOPSIS"
 .B restorecon
-.I [\-o outfilename ] [\-R] [\-n] [\-v] [\-e directory ] pathname...
+.I [\-o outfilename ] [\-R] [\-n] [\-v|\-p] [\-e directory ] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-v] [\-F]
+.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-v|\-p] [\-F]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -20,6 +20,10 @@
 It can be run at any time to correct errors, to add support for
 new policy, or with the \-n option it can just check whether the file
 contexts are all as you expect.
+.P
+It is the same executable as
+.BR setfiles
+but operates in a slightly different manner depending on it's argv[0].
 
 .SH "OPTIONS"
 .TP 
@@ -46,10 +50,16 @@
 .TP 
 .B \-vv
 show changes in file labels, if type, role, or user are changing.
+.TP
+.B \-p
+show a progress indication in the form of one dot per 1000 files.
 .TP 
 .B \-F
 Force reset of context to match file_context for customizable files, or the user section, if it has changed. 
 .TP 
+.B \-0
+Input items are terminated by a null character instead of by whitespace,  and the quotes and backslash are not special (every character is taken literally).  Disables the end of file string, which  is  treated  like  any other argument.  Useful when input items might contain white space, quote  marks,  or  backslashes.The  GNU  find  -print0  option produces input suitable for this mode.
+
 .SH "ARGUMENTS"
 .B pathname...
 The pathname for the file(s) to be relabeled. 
--- policycoreutils-2.1.0.orig/setfiles/setfiles.8
+++ policycoreutils-2.1.0/setfiles/setfiles.8
@@ -4,7 +4,7 @@
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-c policy ] [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
+.I [\-c policy ] [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv|\-p] [\-W] [\-F] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -17,6 +17,10 @@
 It can also be run at any time to correct errors, to add support for
 new policy, or with the \-n option it can just check whether the file
 contexts are all as you expect.
+.P
+It is the same executable as 
+.BR setfiles
+but operates in a slightly different manner depending on it's argv[0].
 
 .SH "OPTIONS"
 .TP 
@@ -57,6 +61,9 @@
 .B \-vv
 show changes in file labels, if type, role, or user are changing.
 .TP 
+.B \-p
+show a progress indication in the form of one dot per 1000 files.
+.TP
 .B \-W
 display warnings about entries that had no matching files.
 .TP 

--Boundary-00=_MAtXOn3E16oT0Zi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
