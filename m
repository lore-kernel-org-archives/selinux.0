MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC 3/3] expander support for hooks
Date: Wed, 9 Aug 2006 18:56:48 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832AF52@exchange.columbia.tresys.com>
In-Reply-To: <1155160749.942.117.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Tue, 2006-08-01 at 07:52 -0400, Josh Brindle wrote:
> >  /* User attributes */
> > @@ -148,6 +151,7 @@ typedef struct user_datum {
> >  	mls_range_t range;	/* MLS range (min. - max.) for user */
> >  	mls_level_t dfltlevel;	/* default login MLS level for user */
> >  	ebitmap_t cache;	/* This is an expanded set used 
> for context validation during parsing */
> > +	role_set_t all_roles;	/* used during policy access 
> control check */
> >  } user_datum_t;
> >  
> 
> These changes are what I am most concerned about and I don't 
> think that they are necessary. For the "other" policy expand 
> all can simply expand into the existing fields (e.g., 
> role_datum->types can hold all of the authorized types even 
> those for disabled optionals).
> 

This is merely for efficiency. The "other" policy *does* expand into
role_datum->types, the role_datum->all_types is used for the new policy
so that disabled 'aggregate' rules don't pollute the real policy and can
be easily discarded.

> For the current policy, you can make the expander walk all of 
> the optional blocks calling the hooks but _not_ storing the 
> results for the non-active options.
> 

That's what we do.

> The downside is that some hooks will be called multiple 
> times, but I think that the reduction in changes is worth it.
> 
> Any reason this won't work?
> 
> >  /* Sensitivity attributes */
> > @@ -374,6 +378,12 @@ typedef struct policydb {
> >  	/* Whether this policydb is mls, should always be set */
> >  	int mls;
> >  
> > +	/* Whether this is an invalid policy, currently set 
> when EXPAND_ALL
> > +	 * is passed to the expander to prevent this policy 
> from being written
> > +	 * to disk. 
> > +	 */
> > +	int invalid;
> > +
> 
> No comment :)
> 

Yea, yea, I didn't change this per the previous converstation.

> I'll leave any more specific comments until I hear back about 
> my general comments.
> 

That's fine, I believe this approach is sound (though it has quite a bit
of complexity added)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
