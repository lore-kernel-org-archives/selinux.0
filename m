Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8GFsfLa020538
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 11:54:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8GFsemw008203
	for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 15:54:40 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8GFsd9d008200 for <selinux@tycho.nsa.gov>; Tue, 16 Sep 2003 15:54:39 GMT
Date: Tue, 16 Sep 2003 16:54:39 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Trivial debian bootscript for selinuxfs on 2.6
Message-ID: <20030916155439.GN8988@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In case anyone might find it useful, or if it saves Colin
five minutes on his next release, here is the bootscript
I wrote to handle getting selinuxfs mounted on /.

I was undecided as to whether to actually have the
reload/restart or not, or even whether it made sense
to have a stop that dismounts selinuxfs. I'm agnostic
on it.

It should be linked into rcS.d as S0Selinux -> ../init.d/Selinux

So FWIW...

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=20030916-etc_initd_Selinux

#! /bin/sh
#
# Selinux	Mount the selinux fs.
#		Written by Dale Amon <amon@islandone.org>.
#
# Version:	@(#)Selinux  1.0.0  15-Sep-2003  amon@vnl.com
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin
NAME=Selinux

set -e

case "$1" in
  start)
	echo -n "Mounting selinuxfs"
	mount -t selinuxfs none /selinux
	echo "."
	;;
  stop)
	echo -n "Unmounting selinuxfs"
	umount -t selinuxfs
	echo "."
	;;
  reload|restart|force-reload)
	echo -n "Restarting $DESC: $NAME"
	umount -t selinuxfs
	mount -t selinuxfs none /selinux
	echo "."
	;;
  *)
	N=/etc/init.d/$NAME
	# echo "Usage: $N {start|stop|restart|reload|force-reload}" >&2
	echo "Usage: $N {start|stop|restart|force-reload}" >&2
	exit 1
	;;
esac

exit 0




--PNTmBPCT7hxwcZjr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
