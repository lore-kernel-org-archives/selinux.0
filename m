Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89IR6rT013853
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 14:27:06 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89IR5VJ006988
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 18:27:05 GMT
Date: Thu, 9 Sep 2004 19:38:23 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: at last: info regarding boot problems on multiple partitions
Message-ID: <20040909183823.GJ10046@lkcl.net>
References: <20040908224949.GK7717@lkcl.net> <200409100233.47416.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409100233.47416.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 10, 2004 at 02:33:47AM +1000, Russell Coker wrote:
> On Thu, 9 Sep 2004 08:49, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > FINALLY i got a useable system when i encountered a boot problem
> > [well, i got a console login].
> >
> > the issue is that partitions fail to be mounted.
> >
> > i had noticed over a period of time that programs like pump and dhclient
> > and some others would stop partitions from being unmounted during
> > shutdown.
> >
> > [remember i have /boot, /, /usr, /var and /home]
> >
> > for some reason, this also caused the partitions to fail to MOUNT on
> > startup.
> 
> I've seen a very similar problem, but it was intermittent and didn't occur 
> enough to let me debug it.  I'm not certain that I saw the same problem but 
> the result of file systems not being mounted was similar.
> 
> I would be very interested in any further information you may find on this.

 *urk*!

 i'm sitting here in bewilderment.

 Mounting local filesystems...
 SeLinix: initialized (dev hda1, type ext2) uses xattr
 same for hda6
 same for hda7

 /dev/hda1 on /boot type ext2 (rw)
 /dev/hda6 on /var type ext2 (rw)
 /dev/hda7 on /home type ext2 (rw)


 .... not a sausage about /dev/hda5!!!

 so the /usr partition isn't even mounted!!

 i'm going to re-run later in permissive mode.

 l.

 p.s. i might need to know how to get all "dontaudit" rules listed in
 the log files - anyone know how i can do this?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
