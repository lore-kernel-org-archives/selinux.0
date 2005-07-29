Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6T8oMgA028412
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 04:50:24 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6T8iRC2010450
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 08:44:27 GMT
Date: Fri, 29 Jul 2005 09:44:19 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Sriram, Kannan" <ksriram@ti.com>
Cc: Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: SELinux for embedded devices...
Message-ID: <20050729084419.GD11752@lkcl.net>
References: <45F366B1BC4F7C4A895F0F34C41E61A55113E1@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45F366B1BC4F7C4A895F0F34C41E61A55113E1@dbde01.ent.ti.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 29, 2005 at 10:17:18AM +0530, Sriram, Kannan wrote:
> Does SELinux require a writeable filesystem always? 

 no, it doesn't.

 however, nobody with the skills to add xattrs to any of
 the read-only filesystems has yet gone ahead and done it /
 had a requirement strong enough to justify adding xattrs.
 [i added xattrs to tmpfs because i really needed it and there
 were enough simple examples to copy].

 i too would like to use selinux-enabled squashfs or other
 read-only filesystem, because that's a _fantastic_ way of
 getting a secure OS.  someone's root-kitted the machine?
 oh dearie me: reboot it and you _know_ that the squashfs-based
 live boot CD will get you back up-and-running.

 yep.

 throw some money my way and i'll do it for you.

 l.
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
