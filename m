Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA85cIj3025385
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 00:38:18 -0500
Received: from fed1rmmtai111.cox.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA85cGke020034
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2007 05:38:17 GMT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20071108033951.YKRL8759.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>
          for <selinux@tycho.nsa.gov>; Wed, 7 Nov 2007 22:39:51 -0500
Message-ID: <20071107223951.NOBNW.252783.root@fed1wml01.mgt.cox.net>
Date: Wed, 7 Nov 2007 19:39:51 -0800
From: "Lisa R." <lisaraykow@cox.net>
To: SELinux@tycho.nsa.gov
Subject: Boot Errors
In-Reply-To: <20071107093134.PM3CA.242583.root@fed1wml01.mgt.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


 Hello.
 
I have new to this, have a new system and I have fixed most of the denial errors on boot.  However, I am stuck on three.

Can anyone help?

Nov  6 22:00:27 selinux kernel: audit(1194404427.969:3): avc:  denied  { search } for  pid=2814 comm="dmidecode" name="/\
  " dev=sysfs ino=1 scontext=system_u:system_r:dmidecode_t:s0 tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
Nov  6 22:00:28 selinux kernel: audit(1194404428.085:4): avc:  denied  { read write } for  pid=2816 comm="hal-storage-cle" name=".hal-mtab-lock" dev=hda1 ino=2359302 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file
 Nov  6 22:00:28 selinux kernel: audit(1194404428.089:5): avc:  denied  { lock } for  pid=2816 comm="hal-storage-cle" name=".hal-mtab-lock" dev=hda1 ino=2359302 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:object_r:default_t:s0 tclass=file


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
