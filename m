Subject: Re: [PATCH 2/3 v2] semantic MLS representation for
	range_trans_rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Christopher PeBenito <cpebenito@tresys.com>
In-Reply-To: <1157141546.26621.232.camel@moss-spartans.epoch.ncsc.mil>
References: <44F3192B.2000408@trustedcs.com>
	 <44F6E74B.3030904@trustedcs.com>
	 <1157141546.26621.232.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 16:26:35 -0400
Message-Id: <1157142395.26621.237.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 16:12 -0400, Stephen Smalley wrote:
> On Thu, 2006-08-31 at 08:42 -0500, Darrel Goeddel wrote:
> > Here is a second take on the previous patch.  The changes are:
> > - create functions to initialize and destroy mls_semantic_cat structs
> > - move the definitions of the semantic_cat related functions to mls.c and just
> >   declare the functions in mls_types.h
> > - fix a problem with compiling non-MLS policies (do not attempt expansion of
> >   mls_semantic_cat structs because the MLS symbols will not be available)
> > 
> > ---
> > 
> > Introduce a semantic representation for MLS levels and ranges to be used in
> > modular policy formats.  This will allow expansion of levels such as "s0:c1.c5"
> > to happen at module expansion time.  The range_trans_rules were updated to use
> > this new semantic format.
> > 
> > All range_transitions are now represented as range_trans_rules when in a modular
> > format (old range_trans structs are converted when the policy is read).  The
> > semantic rules are expanded along with other rules when the module is expanded.
> > 
> > The ebitmap used for classes in the range_trans_rules has also been fixed to use
> > the standard "value - 1" indexing.
> > 
> > 
> > Signed-off-by:  Darrel Goeddel <dgoeddel@trustedcs.com>
> 
> > diff --exclude=.svn -ruNp selinux-list/libsepol/src/write.c selinux-rangetrans-2/libsepol/src/write.c
> > --- selinux-list/libsepol/src/write.c	2006-08-25 06:16:43.000000000 -0500
> > +++ selinux-rangetrans-2/libsepol/src/write.c	2006-08-30 11:11:18.000000000 -0500
> > @@ -308,6 +308,55 @@ static int avtab_write(struct policydb *
> >  }
> >  
> >  /*
> > + * Write a semantic MLS level structure to a policydb binary 
> > + * representation file.
> > + */
> > +static int mls_write_semantic_level_helper(mls_semantic_level_t * l,
> > +					   struct policy_file *fp)
> > +{
> > +	uint32_t buf[2], ncat = 0;
> > +	size_t items;
> > +	mls_semantic_cat_t *cat;
> > +
> > +	for (cat = l->cat; cat; cat = cat->next)
> > +		ncat++;
> > +
> > +	buf[0] = l->sens;
> > +	buf[1] = ncat;
> 
> Needs cpu_to_le32() conversion.
> 
> > +	items = put_entry(buf, sizeof(uint32_t), 2, fp);
> > +	if (items != 2)
> > +		return POLICYDB_ERROR;
> > +
> > +	for (cat = l->cat; cat; cat = cat->next) {
> > +		buf[0] = cat->low;
> > +		buf[1] = cat->high;
> 
> Ditto.
> 
> > +		items = put_entry(buf, sizeof(uint32_t), 2, fp);
> > +		if (items != 2)
> > +			return POLICYDB_ERROR;
> > +	}
> > +
> > +	return POLICYDB_SUCCESS;
> > +}
> > +

Otherwise, looks fine.  With the above two items fixed,

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
