MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC 1/3] hook callbacks
Date: Wed, 9 Aug 2006 18:53:13 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832AF51@exchange.columbia.tresys.com>
In-Reply-To: <1155160182.942.109.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: <selinux@tycho.nsa.gov>, <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Tue, 2006-08-01 at 07:51 -0400, Josh Brindle wrote:
> 
> <snip>
> 
> > +
> > +typedef struct sepol_security_internal sepol_security_internal_t;
> > +
> > +typedef struct sepol_security_ops {
> > +	int (*symbol_add) (int sym_type, char *type);
> > +	int (*symbol_remove) (int sym_type, char *type);
> > +
> > +	/* type hooks */
> > +	int (*type_add_attrib) (char *attrib, char *type);
> > +
> 
> It seems more natural for this to be the reverse 
> (attrib_add_type) though I understand that it doesn't really matter.
> 

>From the point of view of the library we are adding a type to an
attribute, however in the policy server callback permission checks would
be done where the type is the object being added to and also the
attribute is being added to. The callbacks here do not necessarilly
represent 1 access check.

> > +	/* role hooks */
> > +	int (*role_allow_add) (char *role, char *new_role);
> > +	int (*role_trans_add) (char *role, char *type, char *new_role);
> > +	int (*role_add_type) (char *role, char *type);
> > +
> > +	/* user hooks */
> > +	int (*user_add_role) (char *user, char *role);
> > +
> > +	int (*avrule_add) (int type, char *src, char *tgt, char 
> *class, char 
> > +**perms, int num_perms);
> > +
> 
> Type rules aren't handled at all? Neverallow (to prevent 
> those DOS attacks on policy add).
> 

Like I said, this is an incomplete rfc, type_ rules would certainly be
handled, not sure about neverallows.

> For the syntactic checking that I am suggesting you will need 
> to add checks for the use of each symbol in each rule variant.
> 

Yes, the actual callback in the policy server would check if src could
be used in a "type" rule, tgt can be used, object class can be used and
so on. The callbacks may end up being several permission checks on the
backend.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
