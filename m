Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HGudxF001532
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 12:56:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8HGsrLY006360
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 16:54:53 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id h8HGsqsG006357
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 16:54:52 GMT
Date: Wed, 17 Sep 2003 17:56:20 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Trivial debian bootscript for selinuxfs on 2.6
Message-ID: <20030917165620.GB22480@vnl.com>
References: <20030916155439.GN8988@vnl.com> <200309172036.48566.russell@coker.com.au> <20030917111027.GA8988@vnl.com> <200309172243.31840.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <200309172243.31840.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Okay, here's a second pass with most of what Russ asked for.
I didn't consider the pivot_root yet. That would also have
to worked out with Colin, and since set up the whole of the
selinux mkinitrd and policy infrastructure packages, he's
the one to think about how this all fits.

Here's the second cut. Note the questions I have on the
timing of this at halt/reboot.




--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=Selinux

#! /bin/sh
#
# Selinux	Mount the selinux fs.
#		Written by Dale Amon <amon@islandone.org>.
#
# Version:	@(#)Selinux  1.0.0  15-Sep-2003  amon@vnl.com
#               @(#)Selinux  1.0.1  17-Sep-2003  amon@vnl.com
#
# Recommended levels:
#		update-rc.d Selinux start 00 S . stop 99 0 6 .
#
# Note: It should run before anything else at boot time; it
#       should be the very last thing down at halt or reboot.
#
#       One could have a rc0.d/K99XXXXX that executed after it.
#       Also, all of the rc0.d/S* scripts run after it and we
#       have no way to make a kill script be the last thing 
#       after Starts, short of a serious kludge I can think of
#       by using a second script, S99XXXXXX that calls 
#       Selinux stop.
#       Could this cause any problems, security or otherwise?
#

PATH=/sbin:/bin:/usr/sbin:/usr/bin
NAME=Selinux
SELF=/etc/init.d/$NAME
POLICY=/etc/security/selinux/policy.15
LOADPOLICY=/usr/sbin/load_policy

set -e

function can_load_policy () {
    if [ ! -x $LOADPOLICY ]; then
	return 0
    fi
    if [ ! -f $POLICY ]; then
       echo "Failed."
       echo -n "...Cannot find $POLICY, try: make -C /etc/selinux install"
       return 0
    fi
    return 1
}

function do_load_policy () {
   echo -n "Reloading policy"
   if can_load_policy; then
        $LOADPOLICY $POLICY || (echo -n "...Policy load failed")
   fi
   echo "."
}

case "$1" in
  start)
	echo "Mounting selinuxfs."
	mount -t selinuxfs none /selinux
	do_load_policy;
	;;

  stop)
	echo -n "Unmounting selinuxfs."
	umount -t selinuxfs /selinux
	echo "."
	;;

  reload|force-reload)
	do_load_policy;
	;;

  restart)
	echo "Remounting selinuxfs."
	umount -t selinuxfs /selinux
	mount  -t selinuxfs none /selinux
	do_load_policy;
	;;

  *)
	echo "Usage: $SELF {start|stop|restart|reload|force-reload}" >&2
	exit 1
	;;
esac

exit 0



--0OAP2g/MAC+5xKAE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
