Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SN9erT014932
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 19:09:41 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6SN9AVb025433
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 23:09:10 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp808.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 23:09:39 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bpx3y-0000sW-Bb
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 22:38:18 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bpxj1-00054p-Vp
	for selinux@tycho.nsa.gov; Thu, 29 Jul 2004 00:20:43 +0100
Date: Thu, 29 Jul 2004 00:20:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: temporary hack to use udev in selinux
Message-ID: <20040728232043.GF18711@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i have a requirement (use of usb-mount, see
http://users.actrix.co.nz/michael/usbmount.html) that forces the use
of udev on an selinux system.

fighting with it for a day, and after seeing some clues in the
file contexts (/(u)dev/....) i decided to try editing
/etc/udev/udev.conf to set it to use /udev instead of /dev.

other than a warning about udev not starting up, well, everything
seems to work hunky-dory.

somehow i do _get_ a udevd running, i could not tell you how it got
there.

i notice the following message 

	http://www.redhat.com/archives/fedora-devel-list/2004-March/msg00888.html

in which steven (hi steven :) says that support for udev "fake"
attributes for ramfs and tmpfs, just like for devpts.

is that literally as simple as cut/paste the devpts code...
the xattr stuff?

cos if so, i _like_ cut/paste :)

l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
