From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov" <jwcart2@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: RE: [PATCH 1/2] libsepol: calloc all the *_to_val_structs
Date: Fri, 19 Aug 2016 15:13:05 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5601285D6F@ORSMSX103.amr.corp.intel.com>
References: <1471553689-14551-1-git-send-email-william.c.roberts@intel.com>
 <a430d903-acb2-e3cc-30b8-701f9b0d4951@tycho.nsa.gov>
In-Reply-To: <a430d903-acb2-e3cc-30b8-701f9b0d4951@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Friday, August 19, 2016 6:06 AM
> To: Roberts, William C <william.c.roberts@intel.com>; selinux@tycho.nsa.gov;
> jwcart2@tycho.nsa.gov; seandroid-list@tycho.nsa.gov
> Subject: Re: [PATCH 1/2] libsepol: calloc all the *_to_val_structs
> 
> On 08/18/2016 04:54 PM, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > The usage patterns between these structures seem similair to
> > role_val_to_struct usages. Calloc these up to prevent any unitialized
> > usages.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libsepol/src/mls.c      | 2 +-
> >  libsepol/src/policydb.c | 6 +++---
> >  libsepol/src/users.c    | 9 ++++++++-
> >  3 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c index
> > 2dc5f2b..8047d91 100644
> > --- a/libsepol/src/mls.c
> > +++ b/libsepol/src/mls.c
> > @@ -312,7 +312,7 @@ int mls_context_isvalid(const policydb_t * p, const
> context_struct_t * c)
> >  	if (!c->user || c->user > p->p_users.nprim)
> >  		return 0;
> >  	usrdatum = p->user_val_to_struct[c->user - 1];
> > -	if (!mls_range_contains(usrdatum->exp_range, c->range))
> > +	if (!usrdatum || !mls_range_contains(usrdatum->exp_range, c->range))
> >  		return 0;	/* user may not be associated with range */
> >
> >  	return 1;
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c index
> > c225ac6..5f888d3 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -1074,7 +1074,7 @@ int policydb_index_others(sepol_handle_t *
> > handle,
> >
> >  	free(p->user_val_to_struct);
> >  	p->user_val_to_struct = (user_datum_t **)
> > -	    malloc(p->p_users.nprim * sizeof(user_datum_t *));
> > +	    calloc(p->p_users.nprim, sizeof(user_datum_t *));
> >  	if (!p->user_val_to_struct)
> >  		return -1;
> >
> > @@ -4006,12 +4006,12 @@ int policydb_reindex_users(policydb_t * p)
> >  		free(p->sym_val_to_name[i]);
> >
> >  	p->user_val_to_struct = (user_datum_t **)
> > -	    malloc(p->p_users.nprim * sizeof(user_datum_t *));
> > +	    calloc(p->p_users.nprim, sizeof(user_datum_t *));
> >  	if (!p->user_val_to_struct)
> >  		return -1;
> >
> >  	p->sym_val_to_name[i] = (char **)
> > -	    malloc(p->symtab[i].nprim * sizeof(char *));
> > +	    calloc(p->symtab[i].nprim, sizeof(char *));
> >  	if (!p->sym_val_to_name[i])
> >  		return -1;
> >
> > diff --git a/libsepol/src/users.c b/libsepol/src/users.c index
> > ce54c2b..3ffb166 100644
> > --- a/libsepol/src/users.c
> > +++ b/libsepol/src/users.c
> > @@ -19,12 +19,17 @@ static int user_to_record(sepol_handle_t * handle,
> >
> >  	const char *name = policydb->p_user_val_to_name[user_idx];
> >  	user_datum_t *usrdatum = policydb->user_val_to_struct[user_idx];
> > -	ebitmap_t *roles = &(usrdatum->roles.roles);
> > +	ebitmap_t *roles;
> >  	ebitmap_node_t *rnode;
> >  	unsigned bit;
> >
> >  	sepol_user_t *tmp_record = NULL;
> >
> > +	if (!usrdatum)
> > +		goto err;
> > +
> > +	roles = &(usrdatum->roles.roles);
> > +
> >  	if (sepol_user_create(handle, &tmp_record) < 0)
> >  		goto err;
> >
> > @@ -234,6 +239,7 @@ int sepol_user_modify(sepol_handle_t * handle,
> >  		if (!tmp_ptr)
> >  			goto omem;
> >  		policydb->user_val_to_struct = tmp_ptr;
> > +		policydb->user_val_to_struct[policydb->p_users.nprim] = NULL;
> >
> >  		tmp_ptr = realloc(policydb->sym_val_to_name[SYM_USERS],
> >  				  (policydb->p_users.nprim +
> > @@ -241,6 +247,7 @@ int sepol_user_modify(sepol_handle_t * handle,
> >  		if (!tmp_ptr)
> >  			goto omem;
> >  		policydb->sym_val_to_name[SYM_USERS] = tmp_ptr;
> > +		policydb->p_user_val_to_name[policydb->p_users.nprim] =
> NULL;
> 
> This one is wrong.
> 
> >
> >  		/* Need to copy the user name */
> >  		name = strdup(cname);
> >

After looking at the email and the patch again, that’s just a context hunk, I see no + or - next it,
And I verified it still exists in my source tree. I never touched that hunk or  am I missing
Some subtle interaction?
