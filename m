Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79HfarT026581
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 13:41:36 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i79Hexnn008165
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 17:40:59 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 9 Aug 2004 17:41:24 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BuDh9-0000KR-50
	for selinux@tycho.nsa.gov; Mon, 09 Aug 2004 17:12:23 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BuEKE-0003Ap-Ll
	for selinux@tycho.nsa.gov; Mon, 09 Aug 2004 18:52:46 +0100
Date: Mon, 9 Aug 2004 18:52:46 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: lots of allow xxx_device_t device_t:filesystem { associate }
Message-ID: <20040809175246.GK3868@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

i'm getting an awful lot of the above due to udev creating
inodes in /dev which i decided to associate with device_t.

should i have instead picked a different fscontext (bearing
in mind that this is with the modified 2.6.8 kernel that
doesn't mind associating an xattr-enabled tmpfs with a mount
point)

i have added mount -o fscontext=system_u:object_r:device_t to
/etc/init.d/udev for mounting /dev on a tmpfs.

now i have had to add about 15 or 20 lines so far each for pretty
much every xxx_device_t under the sun, and am concerned that i
am taking the wrong approach.

anyone got any ideas about what i should try next?

ta,

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
