From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC PATCH 0/2] Series short description
Date: Wed, 26 Sep 2007 12:54:56 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net> <200709261200.09547.paul.moore@hp.com> <46FA8C30.2020303@manicmethod.com>
In-Reply-To: <46FA8C30.2020303@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261254.56733.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 September 2007 12:43:28 pm Joshua Brindle wrote:
> Paul Moore wrote:
> > Okay, it looks like its probably at least worth investigating the bitmap
> > concept with some RFC patches.
> >
> > Josh, since you brought up the idea and you have a better grasp of the
> > toolchain, can I talk/bribe/make-you-an-offer-you-can't-refuse into
> > working up some patches for the toolchain if I come up with the matching
> > kernel piece?
>
> I knew I should have kept my mouth shut :)

Think of it as "taking one for the team" ;)

> I'll try to get around to the toolchain patches this week. Some things
> need to be settled, this will require a policy version bump to 22, and
> we can either ignore all the capabilities we have now and start with
> secid reconciliation or actually factor in all the capabilities we have
> now into it. It will be easier short term to do the former, but possibly
> better in the long term to do the latter.

I'm not familiar enough with that code to have a strong opinion either way, 
although I would think that if you are going to introduce a new policy 
version to support this you might as well go all the way and put all the 
features into the bitmap.

Also, don't worry too much about getting them done right away, there is plenty 
of work still left to do with the network bits before this issue becomes a 
roadblock.  Where would you put the capability bitmap in the policy?  After 
the version/config/table-sizes (where I put the ill-fated version number)?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
