Received: from sender-of-o53.zoho.eu (sender11.zoho.eu [31.186.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4084FCD
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=31.186.226.224
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072155; cv=pass; b=KspY+Pwr062FT5qX0oPlQlyjf8WXYLDXLvNSl5FI76Y361SJfDbXnsAF56Q044MfXgRxcJ4sgjHNC82FXsnxxxiVRycLB02Ycn0h8DApqdlDdBylk8CB3stzj6wvwwrulqlr0chrY/NYfC6nkGz88m2Zae5aJlu0ONd6MSqb7N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072155; c=relaxed/simple;
	bh=8iM784Dj0vJtfEwPvRSGadd4GzL4p+S4jPNDEnj9Ofw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlcLiShk/yh486Ya6Qqgr+xXuTz1N94z8x8CCVheICHrDaTvi/zyCqGwARaL/OwznkOBiRZHeiw2zW73fPBxSrSlp2rjxxHyw3wcnRBwkHWVTrLT41Cqa9ugNjSi2lON/uu7uW8rx0cW2d9JFL1FLeGL9kgmpv0Y4lbGFZULjbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jurajmarcin.com; spf=pass smtp.mailfrom=jurajmarcin.com; dkim=pass (1024-bit key) header.d=jurajmarcin.com header.i=juraj@jurajmarcin.com header.b=hIN6iR3u; arc=pass smtp.client-ip=31.186.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jurajmarcin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jurajmarcin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jurajmarcin.com header.i=juraj@jurajmarcin.com header.b="hIN6iR3u"
ARC-Seal: i=1; a=rsa-sha256; t=1712072131; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=B2Wehbj7HahN5QGZLRP2o+AhNqPrpjdrbiPhcOIX4FrPF+LaFol8+Op09WT4EXjNIVTUw1cli9vs+wmJJmQ+Mu7u1SeRSEwaNn4cZhxEfflO9QrsR2lO70f2JWJM3DramgltKk2fEjPxUNIQhLEnF7/NFjR0EnzC9pmpIuUAqdk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1712072131; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P9beB2iPZi+ab27BCBwzCUHlu0gu/x4NMQk+U9Rp3YM=; 
	b=YZ0PSJ5w8OynQbY21olsXkm50w5VEz+tLL6v4h5+O/SloIW1K6MY2QvnrgIN/xoNiKFQQo+jW8wcuNlBRxMc5S/Fa9sRmlM7/90/AurAKBUBEXN8vwWC0P+TKzmj0MfFONBYtLhDbj9L95NsOVH/mxno08M3BGOYmgzslCbz7vU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=jurajmarcin.com;
	spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
	dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1712072131;
	s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=P9beB2iPZi+ab27BCBwzCUHlu0gu/x4NMQk+U9Rp3YM=;
	b=hIN6iR3ub7eX+ocztAHkUkVTuKDaBL/tc/N+6ipISHSjt6Bjz1Ug1Cr7MwuUnS/z
	OYz1UTOqISbpQDLGpKMiXX/o+InAW1VyF+ttG/tdZ2mA7awuQpyS/cAZfNk+0jA8b8/
	CTIZ8KM3T2xsTH6ss+fBkb9jrjCCFYb5I+6/TTz4=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
	with SMTPS id 171207212925562.21991893441361; Tue, 2 Apr 2024 17:35:29 +0200 (CEST)
Received: from jmarcin-t14s-01 (unknown [213.175.37.12])
	by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 2587F207C097;
	Tue,  2 Apr 2024 15:35:28 +0000 (UTC)
Date: Tue, 2 Apr 2024 17:35:26 +0200
From: Juraj Marcin <juraj@jurajmarcin.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v5] selinux: add prefix/suffix matching to filename type
 transitions
Message-ID: <20240402153526.ua7jdw7xtgda6qo2@jmarcin-t14s-01>
References: <20240305170501.2185811-1-juraj@jurajmarcin.com>
 <486c37d889583bb7351dba9793a2e709@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486c37d889583bb7351dba9793a2e709@paul-moore.com>

Hi Paul

Thank you for your feedback!

On 2024-03-27 21:22, Paul Moore wrote:
> On Mar  5, 2024 Juraj Marcin <juraj@jurajmarcin.com> wrote:
> > 

<snip>

> > 
> > Performance tests:
> > 
> > 1: Reference kernel (a1fc79343abbd), Fedora policy (format v33)
> > 2: This patch, Fedora policy (format v33)
> > 3: This patch, Fedora policy without prefix/suffix rules (format v34)
> > 4: This patch, Fedora policy with prefix rules (format v35)
> 
> I think #4 also uses policy format v34, right?

Yes, it's just a typo, I will fix it.

> 
> >    | Mem   | Binary | Policy  | Create    | osbench [2]
> >    | Usage | policy | load    | tty [1]   | create
> >    |       | size   | time    |           | files
> >    | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
> > ---+-------+--------+---------+-----------+-----------
> >  1 |   430 |   3682 |  46.930 |    2.4569 |   43.4431
> >    | sd= 8 |        | sd=0.25 |  sd=0.043 |  sd=0.434
> >  2 |   410 |   3682 |  46.829 |    2.4623 |   43.4112
> >    | sd=20 |        | sd=0.27 |  sd=0.053 |  sd=0.442
> >  3 |   419 |   3682 |  46.823 |    2.4257 |   43.0575
> >    | sd=14 |        | sd=0.18 |  sd=0.057 |  sd=0.416
> >  4 |   420 |   2585 |  42.044 |    2.5028 |   43.7907
> >    | sd=10 |        | sd=0.19 |  sd=0.067 |  sd=0.382
> 
> Thanks for the updated patchset :)
> 
> I like the improvements in #2 and #3, with only one test being slightly
> worse than #1, I think we're okay there.  However, it looks like there
> has been a regression in #4 in terms of runtime performance ... hmmm.

It might look like a regression but there is some variance between runs,
even though I ran single benchmark many times and cases right after the
previous one. There is a similar difference but in the other direction
between #2 and #3 even though they both run with the same kernel and
basically the same policy (the only difference being explicit zero
counts of prefix and suffix rules in the policy file for #3).

I ran the whole benchmark suite again 2 times with the same reference
and patched kernels and got the following results:

   | Mem   | Binary | Policy  | Create    | osbench [2]
   | Usage | policy | load    | tty [1]   | create
   |       | size   | time    |           | files
   | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
---+-------+--------+---------+-----------+-----------
 1 |   436 |   3682 |  48.955 |    2.5037 |   43.7484
   | sd=20 |        | sd=0.25 |  sd=0.048 |  sd=0.445
 2 |   434 |   3682 |  48.331 |    2.4314 |   43.6714
   | sd=16 |        | sd=0.25 |  sd=0.044 |  sd=0.422
 3 |   421 |   3682 |  47.592 |    2.4633 |   43.5746
   | sd=19 |        | sd=0.28 |  sd=0.056 |  sd=0.375
 4 |   413 |   2585 |  41.895 |    2.4608 |   43.7485
   | sd=13 |        | sd=0.19 |  sd=0.063 |  sd=0.378

   | Mem   | Binary | Policy  | Create    | osbench [2]
   | Usage | policy | load    | tty [1]   | create
   |       | size   | time    |           | files
   | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
---+-------+--------+---------+-----------+-----------
 1 |   442 |   3682 |  48.639 |    2.4741 |   43.4764
   | sd=23 |        | sd=0.21 |  sd=0.059 |  sd=0.487
 2 |   422 |   3682 |  48.305 |    2.4191 |   43.6313
   | sd=10 |        | sd=0.21 |  sd=0.064 |  sd=0.460
 3 |   427 |   3682 |  47.524 |    2.4798 |   43.7239
   | sd=21 |        | sd=0.17 |  sd=0.055 |  sd=0.590
 4 |   416 |   2585 |  41.764 |    2.4272 |   43.6712
   | sd= 8 |        | sd=0.20 |  sd=0.052 |  sd=0.376

As can be seen, sometimes one case is the fastest one for the given test
by a few tenths of a millisecond/microsecond, sometimes it is the other
way around. Regression in one test case would result in it being slower
consistently between runs.

> 
> > [1] Create test_tty benchmark:
> > 
> >     mknod /dev/test_tty c 4 1
> >     time for i in `seq 1 10000`; do
> >        	mknod /dev/test_tty$i c 4 1
> >     done
> > 
> > This benchmark should simulate the worst case scenario as many filename
> > transitions affect files created in the /dev directory.
> > 
> > [2] https://github.com/mbitsnbites/osbench
> > 
> > Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> Unless Ondrej has specifically reviewed v5, I think we need to drop
> his Reviewed-by tag as there have been some significant changes since
> he reviewed it last.
> 
> > Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> > ---
> > v5:
> > - rebased to the latest pcmoore/selinux/next
> > - applied suggestions from Paul Moore
> > - added limit optimization suggested by Paul Moore
> > - removed string duplication by using explicit string length in
> >   filename trasition key
> > ---
> > v4:
> > - rebased to the latest pcmoore/selinux/next
> > - fixed non-atomic allocation in atomic section
> > ---
> > v3:
> > - reworked the solution from scratch, this time only adding the
> >   prefix/suffix matching feature without moving filename transition
> >   rules to the avtab
> > ---
> >  security/selinux/include/security.h |   4 +-
> >  security/selinux/ss/policydb.c      | 132 ++++++++++++++++++++++------
> >  security/selinux/ss/policydb.h      |  14 ++-
> >  security/selinux/ss/services.c      |  72 ++++++++++++---
> >  4 files changed, 178 insertions(+), 44 deletions(-)
> > 
> > diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> > index 289bf9233f714..49a043633173c 100644
> > --- a/security/selinux/include/security.h
> > +++ b/security/selinux/include/security.h
> > @@ -46,10 +46,12 @@
> >  #define POLICYDB_VERSION_INFINIBAND	     31
> >  #define POLICYDB_VERSION_GLBLUB		     32
> >  #define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
> > +#define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
> 
> I think one #define should be enough ;)
> 
> > +#define POLICYDB_VERSION_PREFIX_SUFFIX	     34 /* prefix/suffix filename transitions */
> >  
> >  /* Range of policy versions we understand*/
> >  #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
> > -#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COMP_FTRANS
> > +#define POLICYDB_VERSION_MAX POLICYDB_VERSION_PREFIX_SUFFIX
> >  
> >  /* Mask for just the mount related flags */
> >  #define SE_MNTMASK 0x0f
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 3d22d5baa829b..5de22ba840673 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -429,7 +434,11 @@ static int filenametr_cmp(const void *k1, const void *k2)
> >  	if (v)
> >  		return v;
> >  
> > -	return strcmp(ft1->name, ft2->name);
> > +	v = strncmp(ft1->name, ft2->name, min(ft1->name_len, ft2->name_len));
> > +	if (ft1->name_len == ft2->name_len || v)
> > +		return v;
> > +	/* if one name is prefix of the other, the longer is greater */
> > +	return (int)ft1->name_len - (int)ft2->name_len;
> >  }
> 
> I'm probably missing some subtlety in the code above, but I think we
> might be able to optimize this a bit more:
> 
>   if (ft1->name_len != ft2->name_len)
>     return (int)ft1->name_len - (int)ft2->name_len;
>   return strcmp(ft1->name, ft2->name);
> 
> I expect being able to avoid a string comparison in some cases should
> result in a small performance bump.

That optimization would lead to a different ordering than before with
the plain `strcmp()` - it would sort the strings by length first and
only then alphabetically. In fact, the `name_len` comparison could be
removed from the condition entirely without changing the ordering. This
could make it more clear.

However, this change in ordering might not matter as it is only a key
comparator function for the hash table and items from the policy are
inserted one by one. I will also ask Ondrej about this.

> 
> > @@ -437,10 +446,34 @@ static const struct hashtab_key_params filenametr_key_params = {
> >  	.cmp = filenametr_cmp,
> >  };
> >  
> > +/**
> > + * policydb_filenametr_search() - Search for filename transition in policy
> > + * @p: policydb structure to search in
> > + * @match_type: filename transition match type to search for
> > + * @key: key to search for
> > + * @stype: source type to search for, when stype is zero, the function will
> > + *         return head of the linked list with matching key, otherwise it will
> > + *         traverse the linked list to find the item with matching stype
> > + *
> > + * Return: head of the linked list of filename transition datums or single item
> > + *         of the list, based on the stype value
> > + */
> >  struct filename_trans_datum *
> > -policydb_filenametr_search(struct policydb *p, struct filename_trans_key *key)
> > +policydb_filenametr_search(struct policydb *p, unsigned int match_type,
> > +			   struct filename_trans_key *key, u32 stype)
> >  {
> > -	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
> > +	struct filename_trans_datum *datum = hashtab_search(
> > +		&p->filename_trans[match_type], key, filenametr_key_params);
> > +	if (!datum || !stype)
> > +		return datum;
> > +
> > +	while (datum) {
> > +		if (ebitmap_get_bit(&datum->stypes, stype - 1))
> > +			return datum;
> > +
> > +		datum = datum->next;
> 
> Nitpicky, but you can probably remove the vertical whitespace above.
> 
> > +	}
> > +	return datum;
> 
> This could be 'return NULL', right?

Yes, I will change it.

> 
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> > index 4bba386264a3d..78abb959e7205 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -232,6 +233,11 @@ struct genfs {
> >  #define OCON_IBENDPORT 8 /* Infiniband end ports */
> >  #define OCON_NUM       9
> >  
> > +#define FILENAME_TRANS_MATCH_EXACT 0
> > +#define FILENAME_TRANS_MATCH_PREFIX 1
> > +#define FILENAME_TRANS_MATCH_SUFFIX 2
> > +#define FILENAME_TRANS_MATCH_NUM 3
> 
> I think we should probably tweak things to help indicate that the last
> macro/define above is not a usable value, how about this renaming it to
> FILENAME_TRANS_MATCH_MAX?  I'm open to other suggestions too ...

I thought being consistent with other array indices (`SYM_*`, `OCON_*`)
would be better, but I am also open to change the suffix to `_MAX` if
there are no objections.

Then possibly update also `SYM_NUM` and `OCON_NUM` defines in another
patch.

> 
> >  /* The policy database */
> >  struct policydb {
> >  	int mls_enabled;
> > @@ -266,9 +272,12 @@ struct policydb {
> >  	/* quickly exclude lookups when parent ttype has no rules */
> >  	struct ebitmap filename_trans_ttypes;
> >  	/* actual set of filename_trans rules */
> > -	struct hashtab filename_trans;
> > +	struct hashtab filename_trans[FILENAME_TRANS_MATCH_NUM];
> >  	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
> >  	u32 compat_filename_trans_count;
> > +	/* lenghts of prefix/suffix rules to optimze for long filenames */
> 
> "lengths" and "optimize"
> 
> > +	u32 filename_trans_name_max[FILENAME_TRANS_MATCH_NUM];
> > +	u32 filename_trans_name_min[FILENAME_TRANS_MATCH_NUM];
> >  
> >  	/* bools indexed by (value - 1) */
> >  	struct cond_bool_datum **bool_val_to_struct;
> 
> ...
> 
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index e88b1b6c4adbb..e142c6bdfe2ed 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1672,13 +1672,20 @@ static int compute_sid_handle_invalid_context(
> >  	return -EACCES;
> >  }
> >  
> > -static void filename_compute_type(struct policydb *policydb,
> > +static int filename_compute_type(struct policydb *policydb,
> >  				  struct context *newcontext,
> >  				  u32 stype, u32 ttype, u16 tclass,
> >  				  const char *objname)
> >  {
> >  	struct filename_trans_key ft;
> >  	struct filename_trans_datum *datum;
> > +	size_t prefix_len;
> > +	size_t suffix_len;
> > +	size_t prefix_max;
> > +	size_t suffix_max;
> > +	size_t prefix_min;
> > +	size_t suffix_min;
> 
> With the filename length variables being u32 elsewhere in this patch,
> you can probably make these u32 and save some space (perf?).
> 
> > +	size_t objname_len = strlen(objname);
> 
> Same here, although you'll likely need a cast to keep the compiler
> quiet.
> 
> >  	/*
> >  	 * Most filename trans rules are going to live in specific directories
> 
> --
> paul-moore.com

Best regards

Juraj Marcin
