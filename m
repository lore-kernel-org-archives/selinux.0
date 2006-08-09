Subject: RE: [PATCH 2/2 take 2] userland support for new range_transition
	statements
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AE65@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832AE65@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 09:09:16 -0400
Message-Id: <1155128956.942.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-08 at 18:25 -0400, Joshua Brindle wrote:
> > From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
> > 
> 
> Sorry it took so long to reply to this.
> 
> > 
> >  for module policy versions up to 6, there are no 
> > range_transitions  for base policy versions 6 and up, an 
> 
> This is only per the grammar right? You are writing range_trans_rule_t's
> in every avrule block so version 6 does support them, just not the
> grammar yet.
> 
> 
> >  #if 0
> > @@ -307,6 +326,32 @@
> >  	}
> >  }
> >  
> > +void range_trans_rule_init(range_trans_rule_t *x) {
> > +	type_set_init(&x->stypes);
> > +	type_set_init(&x->ttypes);
> > +	ebitmap_init(&x->tclasses);
> > +	mls_range_init(&x->trange);
> > +}
> 
> x->next = NULL? 
> 
> 
> That's all I have, looks good sans the semantic range representation. 
> 

I vote we punt on this - it is only needed for modules and this work
won't get us module support without another format change anyway (to
support mls requirements). If this is going to make fc6 it needs to be
done soon and I would rather be close and in fc6 than perfect and not.

Karl

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
