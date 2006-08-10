Subject: RE: [RFC 3/3] expander support for hooks
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AF52@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832AF52@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:13:18 -0400
Message-Id: <1155226398.8018.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-09 at 18:56 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > On Tue, 2006-08-01 at 07:52 -0400, Josh Brindle wrote:
> > >  /* User attributes */
> > > @@ -148,6 +151,7 @@ typedef struct user_datum {
> > >  	mls_range_t range;	/* MLS range (min. - max.) for user */
> > >  	mls_level_t dfltlevel;	/* default login MLS level for user */
> > >  	ebitmap_t cache;	/* This is an expanded set used 
> > for context validation during parsing */
> > > +	role_set_t all_roles;	/* used during policy access 
> > control check */
> > >  } user_datum_t;
> > >  
> > 
> > These changes are what I am most concerned about and I don't 
> > think that they are necessary. For the "other" policy expand 
> > all can simply expand into the existing fields (e.g., 
> > role_datum->types can hold all of the authorized types even 
> > those for disabled optionals).
> > 
> 
> This is merely for efficiency. The "other" policy *does* expand into
> role_datum->types, the role_datum->all_types is used for the new policy
> so that disabled 'aggregate' rules don't pollute the real policy and can
> be easily discarded.
> 

Avoiding the semantic checks will reduce algorithmic complexity far more
simply because the number of rules far outweighs symbol manipulations
(like typeattribute).

I don't think that this is a good space/time tradeoff but I don't have
any real evidence.

> 
> That's fine, I believe this approach is sound (though it has quite a bit
> of complexity added)

I agree - we are mainly trying to balance code efficiency / algorithmic
complexity against meta-policy simplicity. I believe that most
meta-policies are going to be coarse-grained and short anyway, so I am
pushing the balance towards code simplicity. Ultimately I'm fine with
either.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
