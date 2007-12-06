MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Man page fix for matchpatchcon
Date: Thu, 6 Dec 2007 16:16:02 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801456164@exchange.columbia.tresys.com>
In-Reply-To: <47583B35.9060002@redhat.com>
References: <47583B35.9060002@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Comments inline, hopefully the mail client won't munge things too much.

 - todd

diff --exclude-from=exclude -N -u -r
nsalibselinux/man/man8/matchpathcon.8
libselinux-2.0.45/man/man8/matchpathcon.8
--- nsalibselinux/man/man8/matchpathcon.8	2007-08-03
16:02:56.000000000 -0400
+++ libselinux-2.0.45/man/man8/matchpathcon.8	2007-12-06
11:22:40.000000000 -0500
@@ -6,7 +6,12 @@
 .B matchpathcon [-V] [-N] [-n] [-f file_contexts_file ] [-p prefix ]
filepath...
 .SH "DESCRIPTION"
 .B matchpathcon
-Prints the file path and the default security context associated with
it.
+Queries the system and prints the default security context associated
with the filepath.

This should be a lower case 'q' since it is not the start of the
sentence.

+
+Note: Identical paths can have different security contexts, depending
on the file type. (regular file, directory, link file, char file ...)
+
+matchpathcon will check the system default context using the file type
if the file exists.  If 
the file does not exist, it will get the context of a regular file.

Should probably use ".B matchpathcon" here.

+
 .SH OPTIONS
 .B \-n
 Do not display path.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
