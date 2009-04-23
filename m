Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3NGXxGl006870
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 12:33:59 -0400
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3NGXwRp016140
	for <selinux@tycho.nsa.gov>; Thu, 23 Apr 2009 16:33:58 GMT
From: Paul Moore <paul.moore@hp.com>
To: Mark Webb <elihusmails@gmail.com>
Subject: Re: labeled network aware kernel
Date: Thu, 23 Apr 2009 12:33:32 -0400
Cc: selinux@tycho.nsa.gov
References: <9f066ee90904220426g563d2ebpa708ef8b6e1a4378@mail.gmail.com> <200904221816.34596.paul.moore@hp.com> <9f066ee90904222005n1070763j1a71f8c9b075e998@mail.gmail.com>
In-Reply-To: <9f066ee90904222005n1070763j1a71f8c9b075e998@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200904231233.32705.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 22 April 2009 11:05:20 pm Mark Webb wrote:
> Paul,
>
> Thanks for the response.  As of right now, I am just trying to
> understand and learn the options available to me.  I am most
> interested in the Labeled IPSec.  I would like to study this at both
> the kernel level and the network packet level.

Okay, fair enough.  Good luck and if you have any questions let us know.

> On Wed, Apr 22, 2009 at 6:16 PM, Paul Moore <paul.moore@hp.com> wrote:
> > On Wednesday 22 April 2009 07:26:45 am Mark Webb wrote:
> >> I am interested in experimenting with the labeled networking that SE
> >> Linux offers.  I am reading through Josh Brindle's blog
> >>
> >> http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinu
> >>x/
> >>
> >> My question is, how do I know if my kernel is capable of supporting
> >> this?  I am currently running Fedora 10 with all the latest updates
> >> but not sure how to check.
> >
> > The Fedora kernels are built with all of the labeled networking bits so
> > you should be all set from a kernel point of view, but as Xavier/Ted
> > pointed out you may need additional userspace packages to configure
> > everything.
> >
> >> Also if I compile a kernel from source, is there anything that needs
> >> to be done in the configuring of the kernel build to enable the
> >> labeled networking?
> >
> > At this point I have to ask "what kind of labeled networking?"  Labeled
> > networking is a fairly generic term with three different mechanisms
> > available on Linux: labeled IPsec (likely what you are reading about on
> > Josh's blog), Secmark (search James Morris' blog,
> > http://james-morris.livejournal.com), and NetLabel (search my blog,
> > http://paulmoore.livejournal.com).
> >
> > Which are you interested in?  Or perhaps more to the point, what are you
> > trying to do?
> >
> > --
> > paul moore
> > linux @ hp

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
