Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PDg5rT005460
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 09:42:05 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PDg4uQ008618
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 13:42:04 GMT
Date: Wed, 25 Aug 2004 14:53:17 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040825135316.GF4241@lkcl.net>
References: <20040823214228.GA13677@lkcl.net> <20040824002244.GA25356@lkcl.net> <20040824091520.GE11911@rom.cip.ifi.lmu.de> <200408252140.41362.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408252140.41362.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 25, 2004 at 09:40:41PM +1000, Russell Coker wrote:
> On Tue, 24 Aug 2004 19:15, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> wrote:
> > * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-08-24 03:38]:
> > > in amongst this lot are two lines that say /dev/hdc something here
> > >
> > > we go:
> > > > +/.?u?dev/hdc  -b system_u:object_r:tunably_defined_disk_t
> > > > +/.?u?dev/[h]d[^/^c]* -b system_u:object_r:fixed_disk_device_t
> >
> > I don't think this is the right approach. Not all users have their
> > CD-Rom on /dev/hdc.
> > I've been using a hack to the Makefile which works well on the
> > hundred-odd machines we have here:
> 
> I agree.  Luke's code makes a tunable for whether /dev/hdc is a cd-rom, not 
> whether /dev/hdb, /dev/hdd, etc might be a tunable.
> 
> > --- orig/Makefile
> > +++ mod/Makefile
> > @@ -145,6 +145,7 @@
> >         @grep -v "^/root" $@.tmp > $@.root
> >         @/usr/sbin/genhomedircon . $@.root  > $@
> >         @grep "^/root" $@.tmp >> $@
> > +       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i |
> > awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}'
> > >> $@; done @-rm $@.tmp $@.root
> 
> Good work, but there's one minor bug.  

 would it work with udev, too?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
