Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PG9PrT006581
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 12:09:26 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PG9OuQ014574
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 16:09:25 GMT
Date: Wed, 25 Aug 2004 17:20:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040825162035.GA7260@lkcl.net>
References: <20040823214228.GA13677@lkcl.net> <200408252140.41362.russell@coker.com.au> <20040825135316.GF4241@lkcl.net> <200408252357.08855.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408252357.08855.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 25, 2004 at 11:57:08PM +1000, Russell Coker wrote:
> On Wed, 25 Aug 2004 23:53, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > > --- orig/Makefile
> > > > +++ mod/Makefile
> > > > @@ -145,6 +145,7 @@
> > > >         @grep -v "^/root" $@.tmp > $@.root
> > > >         @/usr/sbin/genhomedircon . $@.root  > $@
> > > >         @grep "^/root" $@.tmp >> $@
> > > > +       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i
> > > > | awk -F / '{ print
> > > > "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}'
> > > >
> > > > >> $@; done @-rm $@.tmp $@.root
> > >
> > > Good work, but there's one minor bug.
> >
> >  would it work with udev, too?
> 
> udev uses the same file_contexts file, so it should work.  The only possible 
> problem I can think of is that if you have a machine which boots without IDE 
> disk access and which has no IDE modules loaded at the time that it has the 
> file_contexts file generated then this would not work (think of servers that 
> have IDE CD-ROM or DVD drives but hardware RAID or SCSI for main storage).
> 
> Of course this is not necessarily a problem, Fedora kernels have the IDE 
> drivers statically linked into the kernel, and there were some issues last 
> time I tried building a Debian kernel with IDE as a module so the number of 
> people who might get hit by this is very small.
 
 ... initrd.  initial ramdisk.  contains all ide drivers, 'n'stuff.

 i always always start from herbert's standard debian config files,
 add the selinux configs, then run make-kpkg --initrd kernel-image.

 then do a dpkg -i on the resultant .deb.

 that way i stand a good chance of minimising any potential problems
 with kernel/thingy inconsistencies.

 l.
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
