Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA09401
	for <selinux@tycho.nsa.gov>; Sun, 9 Mar 2003 05:12:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA12487
	for <selinux@tycho.nsa.gov>; Sun, 9 Mar 2003 10:12:55 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id KAA12483 for <selinux@tycho.nsa.gov>; Sun, 9 Mar 2003 10:12:52 GMT
Date: Sun, 9 Mar 2003 21:12:26 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE-Linux debian-installer
Message-ID: <20030309101226.GA4550@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Some people are still after my debian-installer disk, even though it is
very old, and never worked...

I don't have time to update it myself, especially since it would require
me to download all the packages over my relatively slow Internet link.

Instead, I will just describe what is needed to create one yourself.
This is untested, errors might exist. Still it should give you the
general idea.

If you just want a SE-Linux system, and you want it now, you are advised
to take another approach.

1. Install CVS.

2. CVS_RSH=ssh cvs -d :ext:bam@cvs.debian.org:/cvs/debian-boot co debian-installer
(I think that is correct, not absolutely certain). You should get
directories under debian-installer: CVS/    anna/   doc/
main-menu/  rootskel/  tools/ README  build/  libdebian-installer/
retriever/  scripts/   utils/

3. cd debian-installer/build

4. Install dependancies listed in debian/control, if they are not
in Debian, you will need to build the source in the CVS you just
downloaded. In fact, if udebs are required that aren't yet available in
Debian, you might have to build them here, too (hopefully everything is
in Debian now though). "dpkg-buildpackage -rfakeroot" where required.

5. Copy sources.list to sources.list.local and modify as appropriate.
Do not modify sources.list. Possibly you will want to get this to use
my SE-Linux udeb kernel image (note: only 2.4.19 is available at the
moment) as the first priority.

6. fakeroot make TYPE=net

Theoritically you should be left with a disk image in the dest
directory.

In practise, you are likely to get errors. Fix them, and continue ;-).

>From memory, my kernel was too big, so I had to download the beta
version of UPX, compile it, in order to compress it so it would fit on a
floppy image.

(sorry, I can't predict what other errors you might get).

7. Write a patch for selinux-small, Debian package, that will build a
selinux*.udeb, with appropriate menus, etc. Submit patch to Russell.

All right, I don't expect many people to get up to step 7...
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
