Subject: Re: [PATCH 1/3] SELinux: fix selinux to safely handle any bugs
 even when not CONFIG_BUG
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <alpine.LRH.1.10.0902110151340.6605@tundra.namei.org>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
	 <1234274420.4642.22.camel@localhost.localdomain>
	 <1234276789.3724.30.camel@localhost.localdomain>
	 <alpine.LRH.1.10.0902110151340.6605@tundra.namei.org>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 10:05:18 -0500
Message-Id: <1234278318.4642.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-11 at 01:52 +1100, James Morris wrote:
> On Tue, 10 Feb 2009, Eric Paris wrote:
> 
> > > > +++ b/security/selinux/ss/services.c
> > > > @@ -120,16 +120,25 @@ static int constraint_expr_eval(struct context *scontext,
> > > >  	for (e = cexpr; e; e = e->next) {
> > > >  		switch (e->expr_type) {
> > > >  		case CEXPR_NOT:
> > > > -			BUG_ON(sp < 0);
> > > > +			if (unlikely(sp < 0)) {
> > > > +				BUG();
> > > > +				return 0;
> > > > +			}
> > > 
> > > General question:  Should we in fact be panic'ing in these cases where
> > > we cannot return a value that will in fact abort the computation and
> > > guarantee that the operation will not proceed?  Same applies to the
> > > ebitmap code.  Just returning 0 (false) doesn't necessarily mean that we
> > > won't grant a permission, as the result may get negated.
> > 
> > James?
> 
> Perhaps panic() in enforcing mode, otherwise print a warning.

Yuck.

These are cases where we were already fine with an undefined opcode from
BUG() happening in the usual CONFIG_BUG=y case, so I'd think they could
be made unconditional panic() calls.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
