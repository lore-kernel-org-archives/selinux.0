Subject: RE: [PATCH 3/3] mlsxfrm: Various fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vyekkirala@TrustedCS.com
Cc: Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        Paul Moore <paul.moore@hp.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <000701c7036a$7b269010$cc0a010a@tcssec.com>
References: <000701c7036a$7b269010$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 16:57:15 -0500
Message-Id: <1163023035.12241.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-08 at 13:17 -0600, Venkat Yekkirala wrote:
> > > >  Not sure
> > > > though when
> > > > that would apply here,
> > >
> > > It could apply to xfrms if they happen to be using the context
> > > represented by any of the initial SIDs.
> >
> > Which would happen when?
> 
> If one were attempting to use a context pertaining to the unlabeled init
> sid in the SPD and/or the SAD. But would I be correct in assuming that the
> same sid (unlabeled init sid in all likelyhood) would end up being returned
> when the context is turned into a sid, resulting in the SPD and the SAD
> using
> the same init sid, thus making a full-context compare unnecessary?

Yes.

> > What's the harm from just using the SID comparison and
> > allowing for the
> > possibility that there might be a few duplicates in rare
> > circumstances?
> > Does it break any assumptions in the rest of the logic?
> 
> The best I can think of is if the SA's sid doesn't match the
> socket's SID, IKE would come into play, if it's configured.
> 
> I also wanted to conversely ask what harm exists if we did
> a full-context compare in the event the sids didn't match?
> 
> Are we just trying to generally avoid extra code?

More complexity and overhead for no real gain.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
