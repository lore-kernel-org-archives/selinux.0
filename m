Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5RIq5rT008902
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 14:52:05 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5RIpp5h017008
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 18:51:51 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 27 Jun 2004 18:50:48 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bee9g-0004Cx-Lz
	for selinux@tycho.nsa.gov; Sun, 27 Jun 2004 18:13:28 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Beegg-0004hk-Ip
	for selinux@tycho.nsa.gov; Sun, 27 Jun 2004 18:47:34 +0000
Date: Sun, 27 Jun 2004 18:47:34 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: whoops!  apt-get dist-upgrade fun and games
Message-ID: <20040627184734.GJ13575@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hey, anyone come across _this_ before? it's really cool [uhn..] - 
mount can't recognise the type of the root partition!

	/dev/hda2 on / type unknown (rw,errors=remount-ro)
	proc on /proc type proc (rw)
	sysfs on /sys type sysfs (rw)
	devpts on /dev/pts type devpts (rw,gid=5,mode=620)
	usbfs on /proc/bus/usb type usbfs (rw)
	/dev/hda1 on /boot type ext2 (rw)
	/dev/hda5 on /usr type ext3 (rw)
	/dev/hda6 on /var type ext3 (rw)
	/dev/hda7 on /home type ext3 (rw)

consequently, make relabel doesn't bother to do the root partition...

whoopsie...

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
