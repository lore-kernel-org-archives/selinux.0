Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PBemrT004567
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 07:40:48 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PBe0LV026221
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 11:40:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Date: Wed, 25 Aug 2004 21:40:41 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040823214228.GA13677@lkcl.net> <20040824002244.GA25356@lkcl.net> <20040824091520.GE11911@rom.cip.ifi.lmu.de>
In-Reply-To: <20040824091520.GE11911@rom.cip.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200408252140.41362.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 19:15, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-08-24 03:38]:
> > in amongst this lot are two lines that say /dev/hdc something here
> >
> > we go:
> > > +/.?u?dev/hdc  -b system_u:object_r:tunably_defined_disk_t
> > > +/.?u?dev/[h]d[^/^c]* -b system_u:object_r:fixed_disk_device_t
>
> I don't think this is the right approach. Not all users have their
> CD-Rom on /dev/hdc.
> I've been using a hack to the Makefile which works well on the
> hundred-odd machines we have here:

I agree.  Luke's code makes a tunable for whether /dev/hdc is a cd-rom, not 
whether /dev/hdb, /dev/hdd, etc might be a tunable.

> --- orig/Makefile
> +++ mod/Makefile
> @@ -145,6 +145,7 @@
>         @grep -v "^/root" $@.tmp > $@.root
>         @/usr/sbin/genhomedircon . $@.root  > $@
>         @grep "^/root" $@.tmp >> $@
> +       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i |
> awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}'
> >> $@; done @-rm $@.tmp $@.root

Good work, but there's one minor bug.  If a system has no CD-ROM drives (or 
possibly if the last IDE drive is not a CD) then it returns an error and 
aborts the make.

Appending a "|| true" to the command seems to fix this bug without any 
side-affects.

       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i | awk 
-F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}' >> $@ 
|| true; done @-rm $@.tmp $@.root

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
