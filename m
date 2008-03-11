Subject: RE: [PATCH] checkpolicy: support for permissive types
From: Eric Paris <eparis@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, Todd Miller <tmiller@tresys.com>,
        sds@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801AD2238@exchange.columbia.tresys.com>
References: <1205245845.5297.90.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B0158801AD2238@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 10:44:31 -0400
Message-Id: <1205246671.5297.93.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 10:36 -0400, Joshua Brindle wrote:
> Eric Paris wrote:
> > This patch adds support for permissive types.
> > 
> > A very simple module to make httpd_t a permissive domain would be:
> > 
> > policy_module(permissiveapache, 1.0)
> > gen_require(`
> > 	type httpd_t;
> > ')
> > permissive httpd_t;
> > 
> > Obviously this syntax can be used in both the base policy and
> > in a policy module.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> 
> Comments below, otherwise looks fine.

> > +static int define_permissive(void)
> > +{
> > +	char *type = NULL;
> > +	struct type_datum *t;
> > +
> > +	if (pass == 2) {
> > +		type = queue_remove(id_queue);
> > +		free(type);
> > +		return 0;
> > +	}
> > +
> 
> I think this should be pass == 1. It doesn't need to be on pass 1 since
> it won't be adding symbols needed for pass 2 and it makes it a little
> more resilient to ordering issues.

Makes sense.

> > diff -up checkpolicy-2.0.10/policy_scan.l.pre.permissive
> > checkpolicy-2.0.10/policy_scan.l
> > --- checkpolicy-2.0.10/policy_scan.l.pre.permissive
> > 2008-03-11 10:18:31.000000000 -0400
> > +++ checkpolicy-2.0.10/policy_scan.l	2008-03-11
> > 10:19:00.000000000 -0400
> > @@ -202,7 +202,9 @@ H1				{ return(H1); }
> >  h2 |
> >  H2				{ return(H2); }
> >  policycap |
> > -POLICYCAP			{ return(POLICYCAP);}
> > +POLICYCAP			{ return(POLICYCAP); }
> 
> Whitespace?

Yup, turns out I like consistency   :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
