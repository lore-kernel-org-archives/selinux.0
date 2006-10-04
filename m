Message-ID: <36282A1733C57546BE392885C0618592015CF940@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, eparis@redhat.com,
        sds@tycho.nsa.gov, Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: RE: [PATCH 0/2] [PATCH 0/2] Updated NetLabel/secid-reconciliation
	 bits and a bugfix
Date: Wed, 4 Oct 2006 15:11:04 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > As for the rest of the network labeling, please work 
> together with Venkat 
> > and the SELinux developers on a final patchset which meets 
> all of the 
> > design goals and has been tested, with policy which has been merged 
> > upstream and is available via Fedora devel.  Please keep 
> the discussion 
> > going, but ensure that the final patchset for review and merge 
> > consideration is a complete set against the current git 
> kernel coming from 
> > one person.
> 
> I'm trying :)  When I posted the NetLabel secid support patch 
> last week
> I asked Venkat if he could merge it with the main secid 
> patchset (due to
> size and dependencies that seemed like the most reasonable course of
> action).  For reasons I'm not aware of he chose not to.

FYI- I am no NetLabel expert, and the pathset I sent out that day included
the peersid changes. And since you were going to have to post a patch for
that
again, I thought it best you ported and reposted the entire patch again.

>  As a result I
> keep posting updated patches backed against Venkat's latest and
> incorporating the latest feedback.

And let's keep this going like this on the selinux list. When all the
testing is done and selinux ok's the patchsets, I will combine them
and send them onto netdev. How does that sound?

> 
> Venkat, can you please merge the latest my latest NetLabel 
> secid support
> patch in with your next release?

I would, but it currently is premature. As James says, let's
get policy done, the design proven, and tested and then we will
go to netdev with one patchset.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
