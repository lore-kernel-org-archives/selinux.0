Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA07388
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 16:48:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBDLmUI02741
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 21:48:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBDLmSf02737 for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 21:48:29 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1A953924C8
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 08:48:16 +1100 (EST)
Date: Fri, 13 Dec 2002 22:48:04 +0100
To: selinux@tycho.nsa.gov
Subject: new kernel patch
Message-ID: <20021213214804.GA1781@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: russell@coker.com.au (Russell Coker)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The new version seems to have a bug related to file labelling that affects
devfs.

If I type "ls -l /dev/floppy/0" on a devfs system and the floppy.o module is
not loaded then the kernel will signal the devfsd daemon (through
/dev/.devfsd) that this has been attempted.  In a default configuration the
devfsd will then run "modprobe /dev/floppy/0" and as the modutils config has
an alias for /dev/floppy/0 to "floppy" the floppy.o device driver is loaded.

With this new kernel it appears that the labelling takes place at a different
stage such that the devfsd gets to access a device that is not fully
labelled.

You can see the log entry below, it does not log the action, and it claims
that there is a file named /dev/floppy which is bogus.  There can be
no file under /dev on a devfs system so any reference to tclass=file and
dev=00:06 means a kernel bug.  Without reading the kernel code in question
I guess that file is the default tclass (defined to 0?).

But interestingly after logging >20 of the following messages the kernel
then proceeds to assign the right type to the device nodes that have been
created and then everything goes fine.  Of course I expect this to fail
catastrophically in the case of device nodes that need my devfs shared
object to label them, but I haven't got around to testing this yet.

avc:  denied  { } for  pid=65 exe=/sbin/devfsd path=/floppy dev=00:06 ino=527 scontext=system_u:system_r:devfsd_t tcontext=system_u:object_r:unlabeled_t tclass=file



PS  The reason my system is unable to run my usual email program is due
to a conflict between unofficial Debian KDE packages that I've been using
and the new official Debian package og QT.  Just in case you were
wondering. ;)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
