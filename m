Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7820rhK031612
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 22:00:53 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7820fri004296
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 02:00:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dennis Wronka <linuxweb@gmx.net>
Subject: Re: Problem with MLS because /dev is labeled tmpfs_t
Date: Fri, 8 Aug 2008 12:00:39 +1000
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
References: <20080804123456.679565839@hardeman.nu> <1218116958.5345.20.camel@gorn.columbia.tresys.com> <200808072211.00709.linuxweb@gmx.net>
In-Reply-To: <200808072211.00709.linuxweb@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808081200.41418.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 August 2008 00:10, Dennis Wronka <linuxweb@gmx.net> wrote:
> Does anybody know where this problem is? Is it udev? I already compiled it
> with SELinux-support, but /dev is always tmpfs_t.
> As said, I suspect udev here, but of course I might be wrong.

Your udev script which mounts the tmpfs (which might be /etc/init.d/udev or a 
script called by it) needs to call restorecon.

See the scripts in Debian and Fedora for examples of how it's done.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
