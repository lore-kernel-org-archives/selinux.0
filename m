Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7O9FLrT024636
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 05:15:21 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7O9EZMZ023401
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 09:14:35 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 4684C43572
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 11:15:20 +0200 (CEST)
Date: Tue, 24 Aug 2004 11:15:20 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
Message-ID: <20040824091520.GE11911@rom.cip.ifi.lmu.de>
References: <20040823214228.GA13677@lkcl.net> <20040824002244.GA25356@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20040824002244.GA25356@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-08-24 03:38]:
> in amongst this lot are two lines that say /dev/hdc something here
> we go:
> 
> > +/.?u?dev/hdc		-b	system_u:object_r:tunably_defined_disk_t
> > +/.?u?dev/[h]d[^/^c]*	-b	system_u:object_r:fixed_disk_device_t

I don't think this is the right approach. Not all users have their
CD-Rom on /dev/hdc.
I've been using a hack to the Makefile which works well on the
hundred-odd machines we have here:

--- orig/Makefile
+++ mod/Makefile
@@ -145,6 +145,7 @@
        @grep -v "^/root" $@.tmp > $@.root
        @/usr/sbin/genhomedircon . $@.root  > $@
        @grep "^/root" $@.tmp >> $@
+       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i | awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}' >> $@; done
        @-rm $@.tmp $@.root

 clean:

This inserts a special line into the file_contexts file for every cdrom
found on the system (according to proc).
I am however not sure how a proper solution would look like; do we want
to make policy that system dependant?
Maybe we need a tool like genhomedircon for devices.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
