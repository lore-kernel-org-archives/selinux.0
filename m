Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1RGun8N020227
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 11:56:49 -0500
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1RGujgc020554
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2008 16:56:46 GMT
From: Paul Moore <paul.moore@hp.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Speaking of networking...
Date: Wed, 27 Feb 2008 11:13:29 -0500
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
References: <Xine.LNX.4.64.0802280057060.14155@us.intercode.com.au> <200802270951.55462.paul.moore@hp.com> <47C5879A.2060108@redhat.com>
In-Reply-To: <47C5879A.2060108@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802271113.29423.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 February 2008 10:54:02 am Daniel J Walsh wrote:
> Paul Moore wrote:
> > On Wednesday 27 February 2008 9:01:31 am James Morris wrote:
> >> Any further thoughts on how to push the secmark integration
> >> forward?
> >>
> >> The secmark table patch should allow MAC rules to be administered
> >> independently, and I know there has been some demand for the new
> >> (well, now not so new) networking controls.
> >
> > When I asked this question previously the one thing that came up
> > was semanage integration/compatibility.  However, there didn't
> > appear to be a consensus as to if that was a good idea because
> > semanage has a rather simplistic view of local network controls due
> > to the limitations of the legacy netif/node controls.
> >
> > I'm with you in that I'd really like to see all of the
> > distributions shift over to using secmark.  Beyond the normal
> > performance improvement of moving to secmark, starting with 2.6.25
> > having both secmark and the new network_peer_controls capability
> > enabled should result in a nice performance boost* over the legacy
> > network controls.
> >
> > * No, I don't have any numbers yet, but looking at the code should
> > explain why.
>
> I have no problem with switching to this, as long as we do NO harm. 
> IE Everything just works.
> Nothing breaks when the user shuts down iptables.
>
> It needs to be exactly compatible with what we have now.
>
> Permissive mode has got to work.
>
> And it has to be before Beta 1 March 4.
>
> It has to be easy for a user to customize.
>
> Most users will never use it, so it better not be a headache.

I'd like to think that at some point we can evolve the mechanisms/tools 
so that normal users can/will take advantage of these controls ... then 
again, I'm more than a little bit biased (what do you mean it's hard to 
use?!) and a tinge starry-eyed.

Back to the real world, in 2.6.25 _all_ of the "new" networking controls 
(including secmark, NetLabel, and labeled IPsec) are dynamic.  This 
means that by default there are no permission checks applied, not even 
unlabeled_t checks; you have to configure something (i.e. load the gun 
and point it at your own foot) for the controls to become active.  In a 
sense, the new additions _should_* actually make life easier for you.

* Really, I mean it this time :)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
