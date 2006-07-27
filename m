MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH RETRY 2/3] Optionally expand neverallows
Date: Thu, 27 Jul 2006 15:43:00 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832A937@exchange.columbia.tresys.com>
In-Reply-To: <44C915F5.8010502@mentalrootkit.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> Joshua Brindle wrote:
> > Stephen Smalley wrote:
> >>
> Did you mean to include the rename for expand_avrule_decls?

Yes, forgot to add that to the description

> >
> > Index: trunk/libsepol/include/sepol/policydb/policydb.h
> > ===================================================================
> > --- trunk/libsepol/include/sepol/policydb/policydb.h    
> (revision 951)
> > +++ trunk/libsepol/include/sepol/policydb/policydb.h    
> (working copy)
> > @@ -366,6 +366,7 @@
> >     uint32_t policy_type;
> >     char *name;
> >     char *version;
> > +    int invalid;
> >
> 
> Expanding the avrules doesn't really make the policydb 
> invalid, right? 
> It just makes it non-standard (tainted :) )
> 

Putting neverallows in the avtab is invalid (the reader will bail if it
tries to read one)

> >
> >     }
> > @@ -2156,7 +2159,7 @@
> >         goto cleanup;
> >     hashtab_map_remove_on_error(state.out->p_types.table,
> >                     type_attr_remove, type_destroy, state.out);
> > -    if (check) {
> > +    if (check && !(out->invalid)) {
> >         if (hierarchy_check_constraints(handle, state.out))
> >             goto cleanup;
> >
> 
> Why disallow hierarchy checking?

It disables all checking for invalid policies, there is no reason to do
checking if you've marked a policy invalid since it can't be written
anyway (invalid will probably mean other things in the future, such as a
policy with disabled rules expanded out and conflicting type transitions
in the avtab for access control checking).

> 
> > Index: trunk/libsepol/src/write.c
> > ===================================================================
> > --- trunk/libsepol/src/write.c    (revision 951)
> > +++ trunk/libsepol/src/write.c    (working copy)
> > @@ -1411,6 +1411,9 @@
> >     struct policy_data pd;
> >     char *policydb_str;
> >
> > +    if (p->invalid)
> > +        return -1;
> > +
> 
> A separate return code is needed so that the caller can 
> distinguish between general, likely fatal errors and a 
> policydb that can't be written because the format doesn't support it.
> 

-2? ;)

-1 is currently used if, for example, policy->policyvers is invalid,
same deal.. These are programming errors not user errors. I'd be fine
with it being an assert() personally.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
