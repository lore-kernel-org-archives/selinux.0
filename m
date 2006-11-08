Subject: RE: [PATCH 3/3] mlsxfrm: Various fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vyekkirala@TrustedCS.com
Cc: Paul Moore <paul.moore@hp.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <000601c70343$02fa9fe0$cc0a010a@tcssec.com>
References: <000601c70343$02fa9fe0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 12:34:08 -0500
Message-Id: <1163007248.12241.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-08 at 08:34 -0600, Venkat Yekkirala wrote:
> > Such duplication can occur among the initial SIDs.
> 
> For some reason I thought that could happen between an initial SID
> and a non-initial SID.

I think only in the case where a non-initial SID has been invalidated by
policy reload that renders its context illegal and is thus remapped to
the unlabeled SID.  

> >  Not sure 
> > though when
> > that would apply here,
> 
> It could apply to xfrms if they happen to be using the context
> represented by any of the initial SIDs.

Which would happen when?  

> > and it would only apply if both SIDs 
> > were initial
> > SIDs.
> 
> OK. Will narrow the full context comparison to just this case.

What's the harm from just using the SID comparison and allowing for the
possibility that there might be a few duplicates in rare circumstances?
Does it break any assumptions in the rest of the logic?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
