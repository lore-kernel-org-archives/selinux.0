Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QAn2rT011996
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 06:49:02 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QAn00g008127
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 10:49:00 GMT
Date: Thu, 26 Aug 2004 12:00:11 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040826110011.GB6382@lkcl.net>
References: <20040823214228.GA13677@lkcl.net> <200408252357.08855.russell@coker.com.au> <20040825162035.GA7260@lkcl.net> <200408260951.48939.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408260951.48939.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 26, 2004 at 09:51:48AM +1000, Russell Coker wrote:
> On Thu, 26 Aug 2004 02:20, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > udev uses the same file_contexts file, so it should work.  The only
> > > possible problem I can think of is that if you have a machine which boots
> > > without IDE disk access and which has no IDE modules loaded at the time
> > > that it has the file_contexts file generated then this would not work
> > > (think of servers that have IDE CD-ROM or DVD drives but hardware RAID or
> > > SCSI for main storage).
> > >
> > > Of course this is not necessarily a problem, Fedora kernels have the IDE
> > > drivers statically linked into the kernel, and there were some issues
> > > last time I tried building a Debian kernel with IDE as a module so the
> > > number of people who might get hit by this is very small.
> >
> >  ... initrd.  initial ramdisk.  contains all ide drivers, 'n'stuff.
> 
> Last time I was doing this there were some kernel bugs related to IDE drivers.  
> One of which was having two drivers which need symbols that the other exports 
> (so it was impossible to load them).  At the time almost no testing was being 
> done on this and it didn't seem that the problem was going to be fixed in a 
> reasonable amount of time.
> 
> I gave up using an initrd in Debian at about the same time.  The problem was 
> that the Debian mkinitrd program tried to work out too many things about the 
> system by itself.  This made it difficult if it's guesses were wrong, or if 
> you wanted to prepare an initrd for a different configuration (either for a 
> significant configuration change or making an initrd for use on another 
> machine).
 
 there was indeed a wobbly period a few months ago where you couldn't
 even _use_ make-kpkg if you had some particular version of
 module-init-tools but didn't back-pedal to some earlier version of
 some package.

 i had to do the make-kpkg with one version the package, wait for the
 error and the exit, install the latest version and then carry on.

 but the dust appears to have settled now.

 i get around the problems you describe by having the same kernel on my
 build machine as on my target.

 i can then add scripts to /etc/mkinitrd/files to do "weird" things like
 mount a cd, mount a tmpfs, unpack a .tgz from the CD into the tmpfs and
 then chroot to the tmpfs, with impunity.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
