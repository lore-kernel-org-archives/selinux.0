Date: Wed, 11 Feb 2009 01:52:54 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/3] SELinux: fix selinux to safely handle any bugs even
 when not CONFIG_BUG
In-Reply-To: <1234276789.3724.30.camel@localhost.localdomain>
Message-ID: <alpine.LRH.1.10.0902110151340.6605@tundra.namei.org>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>  <1234274420.4642.22.camel@localhost.localdomain> <1234276789.3724.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 10 Feb 2009, Eric Paris wrote:

> > > +++ b/security/selinux/ss/services.c
> > > @@ -120,16 +120,25 @@ static int constraint_expr_eval(struct context *scontext,
> > >  	for (e = cexpr; e; e = e->next) {
> > >  		switch (e->expr_type) {
> > >  		case CEXPR_NOT:
> > > -			BUG_ON(sp < 0);
> > > +			if (unlikely(sp < 0)) {
> > > +				BUG();
> > > +				return 0;
> > > +			}
> > 
> > General question:  Should we in fact be panic'ing in these cases where
> > we cannot return a value that will in fact abort the computation and
> > guarantee that the operation will not proceed?  Same applies to the
> > ebitmap code.  Just returning 0 (false) doesn't necessarily mean that we
> > won't grant a permission, as the result may get negated.
> 
> James?

Perhaps panic() in enforcing mode, otherwise print a warning.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
