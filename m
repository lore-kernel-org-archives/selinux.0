Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAKMZqIi028254
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 17:35:52 -0500 (EST)
Received: from smtp-bedford.mitre.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAKMYOLS028131
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 22:34:24 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with SMTP id iAKMZub06216
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 17:35:56 -0500
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (Postfix) with ESMTP id 1302DBF7C
	for <selinux@tycho.nsa.gov>; Sat, 20 Nov 2004 17:35:56 -0500 (EST)
Subject: SELinux enhanced strace patch
To: selinux@tycho.nsa.gov
References: <20041118191131.87032.qmail@web50601.mail.yahoo.com>
	<ogtsm76lwjh.fsf@divan.mitre.org>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 20 Nov 2004 17:35:55 -0500
In-Reply-To: <ogtsm76lwjh.fsf@divan.mitre.org>
Message-ID: <ogt1xeojghg.fsf_-_@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I finally tracked down and resolved all the issues with the SELinux
enhancement patch for strace 4.5.8, and placed an updated patch here:

http://simp.mitre.org/selinux

The new patch updates the strace(1) manual page so that it describes
the -X option, the one that requests that security contexts be printed
whenever possible.

The copyright issue has also been resolved.  It turns out that in the
strace project's CVS repository on SourceForge, the strace module has
no COPYING file in its root directory.  It does, however, have a file
named COPYRIGHT.  This file contains what appears to me to be a BSD
license, although it's not identical to the BSD license on
http://opensource.org.

So why does a standard strace distribution include a copy of the GPL
in a file named COPYING?  I suspect the answer is this.

When checked out, strace module does not have several files that must
be included in a distribution.  These files are created with:

  $ autoreconf -i

The -i option installs missing auxiliary files.  If no file exists
called COPYING, it will install a version of that file that contains
the GPL.  As a result, a distribution contains two incompatible
licenses!  As near as I can tell, someone receiving the distribution
has no way of knowing the conditions of using the software.  The file
COPYRIGHT should be renamed to COPYING.

There is one more odd thing about what is in the strace module.  It
contains the files config.guess, config.sub, and install-sh.  The
files are also installed by autoreconf when missing.  It's a good idea
to let it install these files so that distributions get the latest
versions of them.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
