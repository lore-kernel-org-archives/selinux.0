Message-ID: <36282A1733C57546BE392885C0618592015CF969@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov, eparis@redhat.com,
        sds@tycho.nsa.gov
Subject: RE: [PATCH 0/2] [PATCH 0/2] Updated NetLabel/secid-reconciliation
	 bits and a bugfix
Date: Wed, 4 Oct 2006 15:48:59 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ EXCLUDING netdev ]
> There was a secid patchset posted on Thursday (9/28) night, I 
> posted the
> a patch on Friday (9/29) to provide NetLabel support.
> 
> There was a secid patchset posted on Sunday (10/1) night, I respun the
> NetLabel support patch on Monday (10/2) - "v2".
> 
> I respun the NetLabel support patch to take into account Stephen
> Smalley's comments on Monday (10/2) - "v3".
> 
> There was a small update to the secid patches yesterday (10/3) so I
> respun the NetLabel support patch (10/4) - "v4".

You are making my head spin :)

> 
> >> As a result I
> >>keep posting updated patches backed against Venkat's latest and
> >>incorporating the latest feedback.
> >  
> > And let's keep this going like this on the selinux list. 
> When all the
> > testing is done and selinux ok's the patchsets, I will combine them
> > and send them onto netdev. How does that sound?
> 
> Yes, the discussion is a good one I don't want to disrupt that.
> 
> I would prefer if all of the patches were in one patchset, 
> pushed out by
> one person as that would save me from having to respin my 
> patch if all I
> need to do is update it for the latest secid patches.  I 
> think that has
> value so people can review/test/etc all of the parts as one coherent
> patchset.  However, it's ultimately up to you as you are the 
> one working
> on the main secid patchset.
> 
> >>Venkat, can you please merge the latest my latest NetLabel 
> >>secid support
> >>patch in with your next release?
> >  
> > I would, but it currently is premature. As James says, let's
> > get policy done, the design proven, and tested and then we will
> > go to netdev with one patchset.
> 
> I think it's easier to decide on policy, review the design, 
> and test it
> all if there is one place/patchset with all of the latest 
> bits/patches.
>  Right not it's not that easy with different patches scattered around.

I believe Eric Paris is already keeping track of this and I believe
people are testing HIS kernel.

Actually since your patches need to be modified based on mine, it seems
to make sense for either you or Eric take on the responsibility of tracking
the patches and forwarding them on finally.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
