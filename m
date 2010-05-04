From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1 3/6] selinux: Consolidate sockcreate_sid logic
Date: Tue, 4 May 2010 11:31:20 -0400
Cc: selinux@tycho.nsa.gov
References: <20100503220455.8177.91177.stgit@flek.lan> <20100503221134.8177.57403.stgit@flek.lan> <1272981145.30175.43.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1272981145.30175.43.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201005041131.20981.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 May 2010 09:52:25 am Stephen Smalley wrote:
> On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> > Consolidate the basic sockcreate_sid logic into a single helper function
> > which allows us to do some cleanups in the related code.
> > 
> > Signed-off-by: XXX
> > ---
> > 
> >  security/selinux/hooks.c |   32 ++++++++++++--------------------
> >  1 files changed, 12 insertions(+), 20 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 09973e2..4034a3a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3730,6 +3730,12 @@ static int selinux_skb_peerlbl_sid(struct sk_buff
> > *skb, u16 family, u32 *sid)
> > 
> >  }
> >  
> >  /* socket security operations */
> > 
> > +
> > +static u32 socket_sockcreate_sid(const struct task_security_struct
> > *tsec) +{
> > +	return tsec->sockcreate_sid ? tsec->sockcreate_sid : tsec->sid;
> 
> Why is this clearer than just:
> 	return tsec->sockcreate_sid ?: tsec->sid;

It is more explicit?

Honestly, it is just a personal preference thing; if you want it the other way 
just say so and I'll change it back.  The value to me is in the 
socket_has_perm() and _post_create() cleanup ...

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
