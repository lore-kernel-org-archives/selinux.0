Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PDvErT005627
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 09:57:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PDvBuQ009133
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 13:57:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Date: Wed, 25 Aug 2004 23:57:08 +1000
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040823214228.GA13677@lkcl.net> <200408252140.41362.russell@coker.com.au> <20040825135316.GF4241@lkcl.net>
In-Reply-To: <20040825135316.GF4241@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408252357.08855.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 25 Aug 2004 23:53, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > --- orig/Makefile
> > > +++ mod/Makefile
> > > @@ -145,6 +145,7 @@
> > >         @grep -v "^/root" $@.tmp > $@.root
> > >         @/usr/sbin/genhomedircon . $@.root  > $@
> > >         @grep "^/root" $@.tmp >> $@
> > > +       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i
> > > | awk -F / '{ print
> > > "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}'
> > >
> > > >> $@; done @-rm $@.tmp $@.root
> >
> > Good work, but there's one minor bug.
>
>  would it work with udev, too?

udev uses the same file_contexts file, so it should work.  The only possible 
problem I can think of is that if you have a machine which boots without IDE 
disk access and which has no IDE modules loaded at the time that it has the 
file_contexts file generated then this would not work (think of servers that 
have IDE CD-ROM or DVD drives but hardware RAID or SCSI for main storage).

Of course this is not necessarily a problem, Fedora kernels have the IDE 
drivers statically linked into the kernel, and there were some issues last 
time I tried building a Debian kernel with IDE as a module so the number of 
people who might get hit by this is very small.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
