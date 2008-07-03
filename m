Subject: Re: Trying to get XAce policy straightened out but our tool chain
	is too broken to handle it.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <486CEDB5.2000203@tresys.com>
References: <48480210.60309@redhat.com>
	 <1213625437.15523.71.camel@moss-spartans.epoch.ncsc.mil>
	 <485F863B.1040603@redhat.com> <1214227346.11146.237.camel@gorn>
	 <48628E65.8030701@tycho.nsa.gov>
	 <1214836852.22447.94.camel@moss-spartans.epoch.ncsc.mil>
	 <48693D92.2010307@manicmethod.com>  <486CEDB5.2000203@tresys.com>
Content-Type: text/plain
Date: Thu, 03 Jul 2008 12:12:57 -0400
Message-Id: <1215101577.22447.457.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-07-03 at 11:18 -0400, Joshua Brindle wrote:
> Joshua Brindle wrote:
> > Stephen Smalley wrote:
> >> On Wed, 2008-06-25 at 14:28 -0400, Eamon Walsh wrote:
> >>> Christopher J. PeBenito wrote:
> >>>> On Mon, 2008-06-23 at 07:17 -0400, Daniel J Walsh wrote:
> >>>>   
> >>>>> Stephen Smalley wrote:
> >>>>>     
> >>>>>> On Thu, 2008-06-05 at 11:11 -0400, Daniel J Walsh wrote:
> >>>>>>       
> >>>>   
> >>>>>>> The problem I have is the compiler is too stupid to understand the
> >>>>>>> differences between a gen_requires block defining the required types and
> >>>>>>> the actual type definition.
> >>>>>>>
> >>>>>>> So I end up in a catch 22 where the compiler tells me I need to require
> >>>>>>> $1_rootwindow_t, but if I gen_require type $1_rootwindow_t, it tells me
> >>>>>>> I have a duplicate definition.
> >>>>>>>
> >>>>>>> So if you have a derived type in a gen_requires block the compiler can
> >>>>>>> not handle it.
> >>>>>>>         
> >>>>>> I'm a little unclear as to why this is required (why do you need to
> >>>>>> require and declare the same symbol again?).  However, is there some
> >>>>>> reason we can't just automatically promote a require to a declaration
> >>>>>> upon encountering the latter?  Seems like we've talked about this
> >>>>>> before.  Not sure whether that should happen within libsepol
> >>>>>> symtab_insert() or in the callers, e.g. declare_type().
> >>>>>>
> >>>>>>       
> >>>>> I don't know,  All I know is the compiler complains if it is there and
> >>>>> if it is not there.  Catch 22.  I end up going to great lengths to hack
> >>>>> around compiler errors...
> >>>>>     
> >>>> We add requires to templates, so that if they're used outside xserver,
> >>>> the caller gets the appropriate require.  But then we also use the
> >>>> template inside xserver for code reuse, which is where the problem
> >>>> creeps up.  There are a couple other examples of this in refpolicy, but
> >>>> I was able to work around them by reordering statements.  It sounds like
> >>>> Dan's situation may not be something that can be easily worked around
> >>>> without some restructuring
> >>> I opened a ticket in the refpolicy Trac for this:   
> >>> http://oss.tresys.com/projects/refpolicy/ticket/43
> >> Ok - although I was thinking that this would be fixed by changing
> >> checkpolicy/libsepol to promote requires to decls upon encountering a
> >> decl.  Joshua?
> >>
> > 
> > I believe this fixes it but I'm still testing for corner cases and such. The require and declare still have to be in the same scope, eg:
> > 
> > optional {
> > 	require {
> > 		type foo;
> > 	}
> > 	type bar;
> > }
> > 
> > require {
> > 	type bar;
> > }
> > 
> > does not work but the standard use case of:
> > 
> > require {
> > 	type foo;
> > }
> > 
> > type foo;
> > 
> > does work.
> > 
> 
> I've done some more testing and think this patch is correct, if noone
> has objections I'll merge it in later today.

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> 
> > -------
> > 
> > Index: libsepol/src/policydb.c
> > ===================================================================
> > --- libsepol/src/policydb.c	(revision 2916)
> > +++ libsepol/src/policydb.c	(working copy)
> > @@ -1215,21 +1215,13 @@
> >  	/* FIX ME - the failures after the hashtab_insert will leave
> >  	 * the policy in a inconsistent state. */
> >  	rc = hashtab_insert(pol->symtab[sym].table, key, datum);
> > -	if (rc == 0) {
> > +	if (rc == SEPOL_OK) {
> >  		/* if no value is passed in the symbol is not primary
> >  		 * (i.e. aliases) */
> >  		if (value)
> >  			*value = ++pol->symtab[sym].nprim;
> > -	} else if (rc == SEPOL_EEXIST && scope == SCOPE_REQ) {
> > +	} else if (rc == SEPOL_EEXIST) {
> >  		retval = 1;	/* symbol not added -- need to free() later */
> > -	} else if (rc == SEPOL_EEXIST && scope == SCOPE_DECL) {
> > -		if (sym == SYM_ROLES || sym == SYM_USERS) {
> > -			/* allow multiple declarations for these two */
> > -			retval = 1;
> > -		} else {
> > -			/* duplicate declarations not allowed for all else */
> > -			return -2;
> > -		}
> >  	} else {
> >  		return rc;
> >  	}
> > @@ -1256,21 +1248,15 @@
> >  			free(scope_datum);
> >  			return rc;
> >  		}
> > -	} else if (scope_datum->scope == SCOPE_DECL) {
> > +	} else if (scope_datum->scope == SCOPE_DECL && scope == SCOPE_DECL) {
> >  		/* disallow multiple declarations for non-roles/users */
> >  		if (sym != SYM_ROLES && sym != SYM_USERS) {
> >  			return -2;
> >  		}
> >  	} else if (scope_datum->scope == SCOPE_REQ && scope == SCOPE_DECL) {
> > -		/* appending to required symbol only allowed for roles/users */
> > -		if (sym == SYM_ROLES || sym == SYM_USERS) {
> > -			scope_datum->scope = SCOPE_DECL;
> > -		} else {
> > -			return -2;
> > -		}
> > -
> > +		scope_datum->scope = SCOPE_DECL;
> >  	} else if (scope_datum->scope != scope) {
> > -		/* scope does not match */
> > +		/* This only happens in DECL then REQUIRE case, which is handled by caller */
> >  		return -2;
> >  	}
> >  
> > 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
