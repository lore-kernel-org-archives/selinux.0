Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QAOUrT026850
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 06:24:30 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QAOThU003492
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 10:24:30 GMT
Date: Sun, 26 Sep 2004 11:35:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Remove unrestricted_admin
Message-ID: <20040926103533.GA26338@lkcl.net>
References: <200409211526.37810.russell@coker.com.au> <200409252039.01196.russell@coker.com.au> <1096119005.11665.21.camel@gorn.pebenito.net> <200409260121.10665.russell@coker.com.au> <20040925220708.GB15912@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040925220708.GB15912@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 25, 2004 at 11:07:08PM +0100, Dale Amon wrote:
> On Sun, Sep 26, 2004 at 01:21:10AM +1000, Russell Coker wrote:
> > Corner cases that happen to be a regular part of any sys-admin's job.
> 
> I massively agree. Lots of people do 'ghosting'; lots
> of people back up entire disk images before doing
> something dangerous. Now I've got ways around a lot
> of the problems anyway because I've a root boot floppy
> I use. Boot a machine off an nfs root; mount a Real Big
> Disk over nfs, and then dd the whole frigging host
> system disk to the destination system where it
> can be worked on. 

 i'm doing something similar using rsync to do backups and restores
 (i did use dd but had to save space).

 it's a boot cd, and on a restore it runs in "permissive" mode,
 sets up the partitions on /target/, /target/boot, /target/var etc.
 chroots to /target and then does a make -C /etc/selinux/src relabel.

 that seems to "do the job".

 i am certain that lots of people can come up with alternative schemes,
 all of which will work "offline" where you have physical access to the
 machine.

 what i believe russell to be concerned about is that there _are_ so
 many "alternative" schemes that people use [during live operation]
 e.g. _yes_ people really do do "dd backups" usually at 3am on a cron
 job to a spare disk.

 therefore, making a decision about, how do we say "which
 one(s)" - if at all - should go into the "strict" policy is
 of some concern.

 ...if this was microsoft, you'd write your own backup program and then
 lock the OS to that.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
