Subject: Re: [PATCH] libsepol: support for permissive types
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, tmiller@tresys.com, jbrindle@tresys.com
In-Reply-To: <1205260096.23866.168.camel@moss-spartans.epoch.ncsc.mil>
References: <1205243961.5297.79.camel@localhost.localdomain>
	 <1205260096.23866.168.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 14:35:43 -0400
Message-Id: <1205260543.5297.113.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 14:28 -0400, Stephen Smalley wrote:
> On Tue, 2008-03-11 at 09:59 -0400, Eric Paris wrote:
> > This patch adds support for permissive types.
> > 
> > In the kernel policy format the permissive types are in a bitmap
> > referenced by the type value.
> > 
> > In the module policy format a new field in the type_datum_t called
> > 'flags' was added.  The only currently defined flag is
> > TYPE_FLAGS_PERMISSIVE.
> > 
> > Checkpolicy can set the permissive flag on the type_datum_t in question
> > and that flag will persist on disk.  It will be OR'd at link time
> > against the type in the base policy.  At expand time we build the bit
> > array the kernel uses.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> > ---
> 
> <snip>
> > @@ -112,6 +113,9 @@ static int type_copy_callback(hashtab_ke
> >  		return -1;
> >  	}
> >  
> > +	if (new_type->flags & TYPE_FLAGS_PERMISSIVE)
> > +		ebitmap_set_bit(&state->out->permissive_map, new_type->s.value, 1);
> 
> ebitmap_set_bit() can fail due to memory allocation failure, so you need
> to check for it.

sure.

> 
> Somewhere we also need to clearly document that the permissive map is
> _not_ using zero-based indexing for the types, unlike other ebitmaps in
> policy.

any idea where to document?  Would you prefer I just move all of this to
type-1 to keep consistancy?  Probably some way to use max_type_number+1
for global if I/we ever do it....

> 
> > @@ -492,6 +498,10 @@ static int alias_copy_callback(hashtab_k
> >  	}
> >  
> >  	state->typemap[alias->s.value - 1] = new_alias->s.value;
> > +
> > +	if (new_alias->flags & TYPE_FLAGS_PERMISSIVE)
> > +		ebitmap_set_bit(&state->out->permissive_map, new_alias->s.value, 1);
> 
> Ditto.
> 
> Have you tested the handling of aliases, e.g. declare a type alias to a
> type in one module, then mark that type alias as permissive in another
> module, and confirm proper propagation of the permissive flag?

I tested declare a type in base and then in a module require that base
type, alias to that base type, and then permissive the alias.  Is there
a different between that and actually declaring the type in another
module?


> > diff -Naupr libsepol-2.0.23/src/write.c libsepol-2.0.23.new/src/write.c
> > --- libsepol-2.0.23/src/write.c	2008-03-06 13:31:08.000000000 -0500
> > +++ libsepol-2.0.23.new/src/write.c	2008-03-06 10:08:37.000000000 -0500
> > @@ -959,6 +959,8 @@ static int type_write(hashtab_key_t key,
> >  	buf[items++] = cpu_to_le32(typdatum->primary);
> >  	if (p->policy_type != POLICY_KERN) {
> >  		buf[items++] = cpu_to_le32(typdatum->flavor);
> > +		if (p->policyvers >= MOD_POLICYDB_VERSION_PERMISSIVE)
> > +			buf[items++] = cpu_to_le32(typdatum->flags);
> >  	}
> >  	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
> >  	if (items != items2)
> > @@ -1618,6 +1620,12 @@ int policydb_write(policydb_t * p, struc
> >  			return POLICYDB_ERROR;
> >  	}
> >  
> > +	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
> > +	    p->policy_type == POLICY_KERN) {
> > +		if (ebitmap_write(&p->permissive_map, fp) == -1)
> > +			return POLICYDB_ERROR;
> > +	}
> > +
> >  	num_syms = info->sym_num;
> >  	for (i = 0; i < num_syms; i++) {
> >  		buf[0] = cpu_to_le32(p->symtab[i].nprim);
> 
> So in the case of automatic policy downgrade by libselinux load policy
> logic, we will silently shed any permissive maps.  Likely need a warning
> if the permissive map has any bits set at all to warn the user that he
> isn't going to get what he expected.

So just some print statements?  I'll look for examples....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
