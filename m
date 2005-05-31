Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VB3UgA000694
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 07:03:30 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VAvbC0007312
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 10:57:37 GMT
Date: Tue, 31 May 2005 12:05:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: gentoo/hardened
Message-ID: <20050531110542.GA4131@lkcl.net>
References: <20050530013136.GA28006@lkcl.net> <1117496766.1742.39.camel@chris.pebenito.net> <20050531005739.GH28006@lkcl.net> <1117512454.1742.101.camel@chris.pebenito.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1117512454.1742.101.camel@chris.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 31, 2005 at 12:07:34AM -0400, Chris PeBenito wrote:

> >  okay - how about splitting what you classify as "dead policy"
> >  [wrt gentoo] out into separate files, then submitting
> >  a patch that then makes it easier for gentoo to "exclude"
> >  those files... WITHOUT people like me having to wade through
> >  a diff -ru to work out what you've deleted!
> 
> I think I had a poor choice of words.  Its not dead policy, its unused
> policy.  

 ah - i understood that, i just didn't make it clear that i understood
 it - apologies.

> >  it also means that people have to _explicitly_ install an
> >  selinux policy package in order to allow the service to
> >  actually... er... work!
> 
> No, as I said above, it is pulled in as a dependency.  So if you install
> ntp, selinux-ntp (the ntpd policy package) is installed first.  It does
> not have to be explicitly installed.

 oh, cool.  [hm, i'd done an explicit emerge so hadn't noticed.]

> >  valdis just this week chopped a stack-load of [iirc
> >  correctly: unused? ] macro stuff out and the memory usage
> >  dropped dramatically.
> 
> I am not concerned about the size of the policy.conf, I'm concerned
> about the size of the policy in kernel memory.  

 i understood valdis to be equally so concerned.

> >  ... there _are_ people however whose expertise you could ride with -
> >  stephen, russell, tresys - but forking a separate gentoo/hardened
> >  policy makes their expertise that _extra_ bit more remote.
> 
> I don't see how a little divergence makes their expertise remote.  BTW, I
> also work on policy at Tresys if you didn't realize :)

 :) evidently not :)
 
 thank you for evaporating my concerns.

 ... so am i allowed to ask you, after endeavouring to shoot
 everybody down in flames: any chance you could make your
 latest [experimental?] gentoo policy available?  i do need
 to get a gentoo/hardenened workstation running, asap.

 much appreciated,

 l.
 


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
