From: Paul Moore <paul.moore@hp.com>
To: vyekkirala@TrustedCS.com
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
Date: Wed, 19 Sep 2007 17:51:24 -0400
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        jmorris@namei.org, "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <method@manicmethod.com>
References: <009401c7fb02$dab3a0a0$cc0a010a@tcssec.com>
In-Reply-To: <009401c7fb02$dab3a0a0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709191751.24892.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, September 19 2007 5:20:05 pm Venkatesh Yekkirala wrote:
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> >
> > Side note:  If we are going to keep using node SIDs in new network
> > controls (vs. just the compat ones), then we will need to a)
> > introduce
> > some kind of node SID cache to avoid the overhead of policy lookup on
> > each packet, and b) extend semanage to manage node contexts.
> > There was
> > work on both in the past but nothing ever made it to completion (see
> > prior postings by Joy Latten and Rodrigo Vivi).
>
> Paul once wondered if it made sense to replace the individual netif
> and node flow lookup/checks with a single interface/network based
> label lookup and check. I initially felt it made sense but I was
> discussing this with Chad and Darrel this afternoon
> and the thinking on this end is that it would be best to leave the
> boundary-defining labels in the policy itself.

Okay, just a thought.

> Also, another idea that has come up here is to make the default message
> sid on netif's useable again and make them fallbacks to the NetLabel
> fallbacks. So the resolution, in order of priority would be:
>
> 1. NetLabel(external/cipso)/Xfrm
> 2. NetLabel Fallback
> 3. netif default context
> 4. Unlabeled

I vote a strong NO on this, multiple fallback peer labels is a bad, confusing 
idea.  However, let's try to stay focused here and stick with flow control 
right now; we can tackle this later.

> > We thought we were eliminating the need for these per-packet
> > per-node/netif checks by way of secmark, but I guess not if we are
> > keeping secmark separate from labeled networking.
>
> At least that's my current understanding of what we were going to do
> (keeping secmark separate).

Yes, SECMARK is separate.  Let's pleeease not go down this road again right 
now.

SECMARK replaced the node/netif lookups when checking the socket against the 
node/netif.  The flow control checks use the node/netif lookups to check the 
peer label against the node/netif.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
