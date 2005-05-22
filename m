Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NENOgA008422
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 10:23:25 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NEIpMj022356
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 14:18:51 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j4NEJiFG018224
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 10:19:44 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j4NEJiTO018223
	for selinux@tycho.nsa.gov; Mon, 23 May 2005 10:19:44 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4MKLSgA003912
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 16:21:28 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4MKGivS024747
	for <selinux@tycho.nsa.gov>; Sun, 22 May 2005 20:16:45 GMT
Date: Sun, 22 May 2005 21:25:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Kurt Wall <kwall@kurtwerks.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: depinit
Message-ID: <20050522202555.GR10156@lkcl.net>
References: <20050522174200.GP10156@lkcl.net> <200505221403.26383.kwall@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505221403.26383.kwall@kurtwerks.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[advance notice for busy people: contents of this message mostly off-topic]

On Sun, May 22, 2005 at 02:03:26PM -0400, Kurt Wall wrote:
> On Sunday 22 May 2005 13:42, Luke Kenneth Casson Leighton enlightened us 
> thusly:
> > hiya people,
> >
> > i have come across someone who unbelievably is completely
> > disconnected from the free software community, despite the fact that
> > he has come up with an absolutely invaluable core piece of software.
> >
> > richard lightman, is the author of depinit, and by complete
> > coincidence i happen to be working at the same tiny company in
> > farnham, uk, that he is working for.
> 
> I've heard of this. I think IBM came up with something similar
> that used make to compute dependencies.

 i've seen a research paper by sun microsystems, too.

 also there's always NT's MSRPC-controlled "svcctl", the format of
 which also allows you to specify service interdependencies.

 ... and yet linux is still, despite the best efforts of the
 linux standards base, still living with something cobbled together
 from nearly 30 years ago.

 at least redhat and suse (and probably others i don't know much about)
 service startup scripts are making an effort to be LSB compliant.

 my debian-based laptop takes TWO MINUTES to get to a console
 login because of the services it runs.  that's a _joke_.

 anyway - all of this is off-topic.

 i may have a requirement for utilising depinit instead of debian
 /etc/init.d and /sbin/init - because i believe it to be much more
 capable of doing fast boot-times.

 one of the other requirements is selinux.

 one plus one equals a whole boat-load more work.

 if anyone _else_ is interested to see depinit be selinux'd,
 such that i would end up with testers and potential
 contributors, i'd be more inclined to bother.



> > despite depinit being a core critical component of linux from
> > scratch, and thence, for some time, in gentoo, he has received
> > XXXX-ALL feedback on depinit - despite it being the only real
> > significant advance in unix system service maintenance since sysinit!
> 
> Please translate "XXXX-ALL" for me.
 
 ... not on-list :)
 
 pick any bad word you like in the language of your choice -
 it'll do *cackle*

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
