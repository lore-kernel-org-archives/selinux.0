From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1 3/6] selinux: Consolidate sockcreate_sid logic
Date: Wed, 5 May 2010 11:48:44 -0400
Cc: selinux@tycho.nsa.gov
References: <20100503220455.8177.91177.stgit@flek.lan> <201005041131.20981.paul.moore@hp.com> <1273002270.30175.191.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1273002270.30175.191.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201005051148.44182.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 May 2010 03:44:30 pm Stephen Smalley wrote:
> On Tue, 2010-05-04 at 11:31 -0400, Paul Moore wrote:
> > On Tuesday 04 May 2010 09:52:25 am Stephen Smalley wrote:
> > > On Mon, 2010-05-03 at 18:11 -0400, Paul Moore wrote:
> > > > +static u32 socket_sockcreate_sid(const struct task_security_struct
> > > > *tsec) +{
> > > > +	return tsec->sockcreate_sid ? tsec->sockcreate_sid : tsec->sid;
> > > 
> > > Why is this clearer than just:
> > > 	return tsec->sockcreate_sid ?: tsec->sid;
> > 
> > It is more explicit?
> > 
> > Honestly, it is just a personal preference thing; if you want it the
> > other way just say so and I'll change it back.  The value to me is in
> > the
> > socket_has_perm() and _post_create() cleanup ...
> 
> More opportunity for inconsistency, IMHO.  Nothing wrong with the ?:
> syntax.

Okay, while technically I suppose you are correct on the "more opportunity for 
inconsistency" you have to admit the argument is a bit laughable considering 
the complexity of statement and the function itself for that matter ;)

Regardless, I'll make the change ...

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
