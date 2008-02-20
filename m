Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KFfoxV026404
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 10:41:50 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KFfkDb000149
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 15:41:47 GMT
Date: Wed, 20 Feb 2008 16:41:40 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for Debian backup cron daily jobs
Message-ID: <20080220154140.GA9839@bobek.pm.i.cz>
References: <20080219122951.GA23700@bobek.pm.i.cz> <1203430571.13618.88.camel@gorn> <200802202224.48452.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <200802202224.48452.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 20, 2008 at 10:24:45PM +1100, Russell Coker wrote:
> On Wednesday 20 February 2008 01:16, "Christopher J. PeBenito" 
> <cpebenito@tresys.com> wrote:
> > Merged.  I moved the file context change into a distro_debian block,
> > though I suspect the backup policy is fairly Debian-specific.
> 
> What do people who don't use Debian do for their backup then?
> 
> I wrote the policy for backup_t as a domain for anything the sys-admin might 
> run at the command-line for the purpose of backing things up.  For me it's 
> LVM snapshots that are copied (via dd or gzip) to a USB device.  Nothing 
> Debian specific there, and I've run it on a few Fedora machines too.

This was really Debian-specific - cron jobs doing a local backup into
/var/backup...
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
