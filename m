Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EAcnMd025289
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 06:38:50 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EAci4s022864
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 10:38:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "david carvalho" <david@di.ubi.pt>
Subject: Re: selinux backups
Date: Thu, 14 Jun 2007 19:08:59 +1000
Cc: selinux@tycho.nsa.gov
References: <049d01c7ade0$d28ca260$fd01000a@ubi.pt>
In-Reply-To: <049d01c7ade0$d28ca260$fd01000a@ubi.pt>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706141909.00957.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 14 June 2007 03:32, "david carvalho" <david@di.ubi.pt> wrote:
> Good afternoon.
> Wich is the best way to make a backup of a system running lvm and selinux ?
> It seems that with lvm systems, the best way is to take a snapshot (wich
> seems a waste of space in a Volume Group). But with Selinux ?  tar-1.15
> doesn't apply the right permissions when extracting (at least of what I
> tested).

Create a file that contains zeros using most of the free space on the 
filesystem in question (EG dd from /dev/zero) and then unlink it.  Then gzip 
compress the filesystem, the zero blocks will compress well.

For my laptop I use cryptsetup to encrypt the LVM volumes so I can't usefully 
compress them (encrypted data is almost uncompressable), but this does give 
me encrypted backups which I consider useful.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
