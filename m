Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KBP2ZO025456
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 06:25:02 -0500
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KBOsd5008445
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 11:25:00 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: refpolicy: patch for Debian backup cron daily jobs
Date: Wed, 20 Feb 2008 22:24:45 +1100
Cc: =?iso-8859-1?q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
References: <20080219122951.GA23700@bobek.pm.i.cz> <1203430571.13618.88.camel@gorn>
In-Reply-To: <1203430571.13618.88.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802202224.48452.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 20 February 2008 01:16, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> Merged.  I moved the file context change into a distro_debian block,
> though I suspect the backup policy is fairly Debian-specific.

What do people who don't use Debian do for their backup then?

I wrote the policy for backup_t as a domain for anything the sys-admin might 
run at the command-line for the purpose of backing things up.  For me it's 
LVM snapshots that are copied (via dd or gzip) to a USB device.  Nothing 
Debian specific there, and I've run it on a few Fedora machines too.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
