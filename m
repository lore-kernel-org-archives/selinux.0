Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA08722
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 20:46:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA11802
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 01:45:58 GMT
Received: from smtpproxy1.mitre.org (mb-20-100.mitre.org [129.83.20.100])
	by jazzband.ncsc.mil  with ESMTP id BAA11797
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 01:45:57 GMT
Date: Thu, 29 Mar 2001 20:45:27 -0500 (EST)
From: bede@mitre.org (Bede McCall)
Message-Id: <200103300145.UAA27928@idiot-savant.mitre.org>
To: BSimonin@nmda-bubba.nmsu.edu
CC: selinux@tycho.nsa.gov
In-reply-to: <B7F6E4A39BE7D111BF2500A0C989BA4795071B@NMDA-BUBBA> (BSimonin@nmda-bubba.nmsu.edu)
Subject: RE: Can I compile NSA Linux 2.4.2 kernel the same way I do a the norm
	al 2.4.2 kernel?
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

   From: "Simonin, Bradley" <BSimonin@nmda-bubba.nmsu.edu>
   Date: Thu, 29 Mar 2001 15:53:39 -0700

   [ . . . ]

   When I reboot I am getting a kernel panic.  The message says:
   Security:  Starting up (compiled Mar 29, 2001)
   Security:  loaded policy configuration from /ss_policy
   Security:  unable to open /ss_policy

   [ . . . ]

When the kernel boots, it looks for the file /ss_policy and panics if
it can't read it (see kernel/security/init.c).

Take a look at /etc/lilo.conf.  The problem is caused by having the
wrong "root" partition listed in /etc/lilo.conf.  It's not always
/dev/hda0.

Assuming your root partition is on /dev/hda8, for example, here's what
your /etc/lilo.conf might look like:

	boot=/dev/hda
	map=/boot/map
	install=/boot/boot.b
	prompt
	timeout=50
	default=flask
	image=/boot/vmlinuz-2.2.12-FLASK
	        label=flask
	        root=/dev/hda8
	        read-only
	image=/boot/vmlinuz-2.2.12-20
	        label=linux
	        initrd=/boot/initrd-2.2.12-20.img
	        read-only
	        root=/dev/hda8

-- 
  Bede McCall   <bede@mitre.org>
  MITRE Corporation                        Tel: (781) 271-2839
  202 Burlington Road                      FAX: (781) 271-2423
  Bedford, Massachusetts  01730-1420

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
