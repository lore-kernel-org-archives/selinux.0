From: "Frank Mayer" <mayerf@tresys.com>
To: "'SELinux'" <SELinux@tycho.nsa.gov>
Cc: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: setools, version 0.8
Date: Thu, 10 Apr 2003 12:52:28 -0400
Message-ID: <004901c2ff81$959a32d0$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We just released version 0.8 of our setools packages.  The version of
setools included in the latest NSA distribution (under
selinux/tools/setools) was version 0.7, which we released in February of
this year.  You can download the complete tar file for versions 0.8 at
www.tresys.com/selinux.  I will separately send a (rather large) patch
file to Steve to update the versions in the selinux sourceforge CVS
tree.

You can view the change log file on our web site to get a sense of the
changes in this version.  The primary enhancements are in seuser and
apol.  We've completely rewritten both the command line and GUI
interfaces for seuser (user manager), to provide a single interface to
manage both system user (ala the passwd file) and policy user i.e.,
role) attributes.  We also included three scripts (seuseradd, seusermod,
and seuserdel) that provides a single set of commands to do both from
command line.

In our policy analysis tool (apol), we added the first high-level
analysis capability: a domain transition analysis.  You can now view an
entire domain transition "call tree", including all the rules and types
allowing the transitions. 

Many other minor changes and updated were made.  As always we welcome
bug reports, complaints, and feedback at selinux@tresys.com.  All tools
are distributed in source code form.

Regards, Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
