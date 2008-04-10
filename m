Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3B0dkUR013211
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 20:39:46 -0400
Received: from g4t0017.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3B0djCJ020525
	for <selinux@tycho.nsa.gov>; Fri, 11 Apr 2008 00:39:45 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v2 0/2] Labeled networking patches for 2.6.26
Date: Thu, 10 Apr 2008 18:12:36 -0400
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <20080409204936.26774.55254.stgit@flek.lan> <200804101725.59604.paul.moore@hp.com> <Xine.LNX.4.64.0804110802140.1313@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0804110802140.1313@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804101812.36542.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 10 April 2008 6:04:32 pm James Morris wrote:
> On Thu, 10 Apr 2008, Paul Moore wrote:
> > Just a quick follow-up on testing, I've run this for a few hours on
> > two Fedora systems with both labeled and unlabeled IPsec in use
> > with SAs rekeying every 5 minutes and didn't notice anything evil.
> >
> > At this point I'd strip the "RFC" from the patchset and ask that
> > they be considered for inclusion in 2.6.26 assuming there are no
> > objections.
>
> I suggest pushing them via DaveM's tree, unless they depend on
> anything in my tree.

Okay.  It sounds like DaveM is working through a backlog right now, if I 
don't see them in his tree by next week I'll resubmit them.

Thanks.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
