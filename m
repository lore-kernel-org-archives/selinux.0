Subject: Re: [RFC PATCH v1 3/6] selinux: Consolidate sockcreate_sid logic
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <201005041131.20981.paul.moore@hp.com>
References: <20100503220455.8177.91177.stgit@flek.lan>
	 <20100503221134.8177.57403.stgit@flek.lan>
	 <1272981145.30175.43.camel@moss-pluto.epoch.ncsc.mil>
	 <201005041131.20981.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 04 May 2010 15:44:30 -0400
Message-Id: <1273002270.30175.191.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-04 at 11:31 -0400, Paul Moore wrote:
> On Tuesday 04 May 2010 09:52:25 am Stephen Smalley wrote:
> > On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> > > Consolidate the basic sockcreate_sid logic into a single helper function
> > > which allows us to do some cleanups in the related code.
> > > 
> > > Signed-off-by: XXX
> > > ---
> > > 
> > >  security/selinux/hooks.c |   32 ++++++++++++--------------------
> > >  1 files changed, 12 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 09973e2..4034a3a 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -3730,6 +3730,12 @@ static int selinux_skb_peerlbl_sid(struct sk_buff
> > > *skb, u16 family, u32 *sid)
> > > 
> > >  }
> > >  
> > >  /* socket security operations */
> > > 
> > > +
> > > +static u32 socket_sockcreate_sid(const struct task_security_struct
> > > *tsec) +{
> > > +	return tsec->sockcreate_sid ? tsec->sockcreate_sid : tsec->sid;
> > 
> > Why is this clearer than just:
> > 	return tsec->sockcreate_sid ?: tsec->sid;
> 
> It is more explicit?
> 
> Honestly, it is just a personal preference thing; if you want it the other way 
> just say so and I'll change it back.  The value to me is in the 
> socket_has_perm() and _post_create() cleanup ...

More opportunity for inconsistency, IMHO.  Nothing wrong with the ?:
syntax.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
