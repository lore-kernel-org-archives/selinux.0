Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0GG9VcD030803
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 11:09:31 -0500
Received: from g5t0006.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0GG6eIT024325
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2009 16:06:41 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Justin Mattock" <justinmattock@gmail.com>
Subject: Re: netlabel: UNLABELED ath9k not denying unlabeled traffic
Date: Fri, 16 Jan 2009 11:09:27 -0500
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        "SE-Linux" <selinux@tycho.nsa.gov>
References: <496D759A.7010401@gmail.com> <200901151752.06622.paul.moore@hp.com> <dd18b0c30901151644q4578f7d6k3023cad6f05325dd@mail.gmail.com>
In-Reply-To: <dd18b0c30901151644q4578f7d6k3023cad6f05325dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901161109.27222.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 15 January 2009 7:44:15 pm Justin Mattock wrote:
> On Thu, Jan 15, 2009 at 2:52 PM, Paul Moore <paul.moore@hp.com> wrote:
> > Well, it is possible that /bin/sh points to a non-bash shell but
> > maybe not (I'm pretty sure the make command executes the scripts
> > with /bin/sh).  Either way, I checked in the fix to the SVN tree
> > earlier today so newer releases will have the fix; if needed I can
> > release a 0.19.1 or similar but I want to wait and see how
> > widespread the problem is ...
> >
> > --
> > paul moore
> > linux @ hp
>
> Cool, If I see anybody
> struggling, I point them to the
> fix you posted.

Great.  Also let me know, if this looks like it will be widespread 
problem I'll make a new release; I'd hate for people to have to patch 
the Makefile to get it to build ...

> I also might be missing something, i.g.
> one of the boxes that gave this error I built
> with debootstrap, but then the other that gave this as well
> was built with nubuntu which seems more complete
> than debootstrap.
> but then maybe both are missing a package.
> (or it's a debian thing)

It could also be my rather poor understanding of bash and makefiles :)  
If anyone out there wants to take a look and offer an explanation or a 
better patch I'm more than happy to accept it.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
