Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PH6rrT007061
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 13:06:56 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PH6ruQ016544
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 17:06:53 GMT
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by monk.area614.net (Postfix) with ESMTP id D1E0841081A
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 13:07:01 -0400 (EDT)
Subject: Re: policy patch for tunable "/dev/hdc is removable drive"
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <200408252140.41362.russell@coker.com.au>
References: <20040823214228.GA13677@lkcl.net>
	 <20040824002244.GA25356@lkcl.net>
	 <20040824091520.GE11911@rom.cip.ifi.lmu.de>
	 <200408252140.41362.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 25 Aug 2004 13:07:43 -0400
Message-Id: <1093453663.5092.84.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-08-25 at 21:40 +1000, Russell Coker wrote:
> On Tue, 24 Aug 2004 19:15, Thomas Bleher <bleher@informatik.uni-muenchen.de> 

> > --- orig/Makefile
> > +++ mod/Makefile
> > @@ -145,6 +145,7 @@
> >         @grep -v "^/root" $@.tmp > $@.root
> >         @/usr/sbin/genhomedircon . $@.root  > $@
> >         @grep "^/root" $@.tmp >> $@
> > +       @for i in /proc/ide/hd*/media; do grep -q cdrom $$i && echo $$i |
> > awk -F / '{ print "/dev/"$$4"\t-b\tsystem_u:object_r:removable_device_t"}'
> > >> $@; done @-rm $@.tmp $@.root

I guess genhomedircon is a precendent here, but: I don't think this
makes sense, because then the policy is dependent on the machine where
you build the policy, which may be different from the machine to which
the policy is ultimately installed.

This kind of calculation should probably be done in the policy post-
installation step.

In the larger picture, I don't think we should use one-off hacks like
this.  Instead, we really need a tool to analyze your whole system and
suggest policy changes, or vice versa.  If we start embedding things
like this in policy, system administrators are going to actually expect
it to work, and I don't think it will, reliably.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
