Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OEAqrT026642
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 10:10:52 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OEA6MZ007896
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 14:10:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id CF3E8BF2D
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:10:50 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 05723-05-3 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 15:10:43 +0100 (BST)
Received: from lkcl.net (th-pm02-58.ndirect.co.uk [195.7.225.250])
	by open.hands.com (Postfix) with ESMTP id 5EFE7BF28
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 15:10:42 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzcBV-0001i4-Cv
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 15:22:01 +0100
Date: Tue, 24 Aug 2004 15:22:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040824142201.GB4698@lkcl.net>
References: <20040823214228.GA13677@lkcl.net> <20040824002244.GA25356@lkcl.net> <20040824091520.GE11911@rom.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040824091520.GE11911@rom.cip.ifi.lmu.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 24, 2004 at 11:15:20AM +0200, Thomas Bleher wrote:
> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-08-24 03:38]:
> > in amongst this lot are two lines that say /dev/hdc something here
> > we go:
> > 
> > > +/.?u?dev/hdc		-b	system_u:object_r:tunably_defined_disk_t
> > > +/.?u?dev/[h]d[^/^c]*	-b	system_u:object_r:fixed_disk_device_t
> 
> I don't think this is the right approach. Not all users have their
> CD-Rom on /dev/hdc.

 no, i know: that's why i set it to a tunable called
 "tunably_defined_disk_t" :)

> I've been using a hack to the Makefile which works well on the
> hundred-odd machines we have here:
> 
> --- orig/Makefile
> +++ mod/Makefile
> @@ -145,6 +145,7 @@
>         @grep -v "^/root" $@.tmp > $@.root
>         @/usr/sbin/genhomedircon . $@.root  > $@
>         @grep "^/root" $@.tmp >> $@
> +       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i | awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}' >> $@; done
>         @-rm $@.tmp $@.root

 okay... that's fine on a system that doesn't use udev :) :)

> This inserts a special line into the file_contexts file for every cdrom
> found on the system (according to proc).
> I am however not sure how a proper solution would look like; do we want
> to make policy that system dependant?
> Maybe we need a tool like genhomedircon for devices.
 
  perhaps udev could communicate to run-time tunables to "switch"
  certain device types (like the example tunably_defined_disk_t)
  from their aliases fixed_disk_device_t to removable_disk_device_t?

  of course, it would be necessary to do "prep" things with a
  tunably_defined_hda_t, tunably_defined_hdb_t, tunably_defined you
  get the idea.

  l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
