Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z5XWsr0+"
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9D1AA
	for <selinux@vger.kernel.org>; Tue,  5 Dec 2023 19:18:23 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-423c944352fso2292331cf.3
        for <selinux@vger.kernel.org>; Tue, 05 Dec 2023 19:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701832702; x=1702437502; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jnz02e0X+PBibjp6H+6xUHly6pcgiPdeRrdsZOlPAC8=;
        b=Z5XWsr0+AiTYUSUnHmhAn3SyNeLLrBv9ORYmtxySciF66holmBs5DgXK+l3dQVjBuk
         XXdRCFH5pO4zloVGjjdR2fqZ29SuE7dzZ42lHMicgN0PCqBQ4hs+hVmCJXQC2LbDb8Hw
         W2sAp7u8jgvrg3e+aXgAZbYIYnzqLCufrO0/ZlxXp+xH69uWrblm+ilbHcVxWqurdnk4
         +4hPrQ1FYzRzjypQCfxWb2TqL6/QC/9tp8Ppih1rGcPMKf4wkwpg9Bi5RV6xT8gdZd+g
         ST4l77DqiOB8bB8Up4r793X+FdH90tM47rQhFopJkLS0UNf9AB22CNmlZGar/v8hYGLi
         B7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701832702; x=1702437502;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jnz02e0X+PBibjp6H+6xUHly6pcgiPdeRrdsZOlPAC8=;
        b=Vxzr9SSWsSBhg8AATzab5ryshPg21ouSPCD/ejP6K73ZSq7kyIbBYqE+P1RowrpsTx
         eLBxO/m7oqGPLbKLeAWuZbWKRjDnALithbuCHxMy6pXeb6G6735HfMNy8s/M6WzoXhIs
         WWWgZATA5CDJpMmvo8W4xzvpasgrLY6wdIWz6cmk2HKPTqD/EoGi9tKzbZXvV984QqnK
         Ob120u8YIQxaXFOtIiYqAmK8c1gkjS/lawhOWjTW4WH+9zdvYRMx4oEmzxQZkhCRfl7T
         b3a1bR4P0z6PTaBhq5y9xN3rSskHBdBQZRgXBMSoRtJUGWPw6fYfamnxAppA7GwkPZNm
         gBEA==
X-Gm-Message-State: AOJu0Yz2pgCujw8vD7CN5YBHW77K5Xnv/OUQJdO/Gju6BtMu7VN5co+2
	jv4YW+AZ9zYsb/D6W7Wg/boi
X-Google-Smtp-Source: AGHT+IFZx3AEztUachc8hNISpHTOXHhcJNo6zsM747X+Yg+m6gXoDZY0x30+rb5mhcf50ekBNQGhlw==
X-Received: by 2002:a05:622a:1902:b0:425:4043:29d6 with SMTP id w2-20020a05622a190200b00425404329d6mr338614qtc.81.1701832702351;
        Tue, 05 Dec 2023 19:18:22 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id b6-20020ac844c6000000b00423e9316931sm5636785qto.83.2023.12.05.19.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:18:21 -0800 (PST)
Date: Tue, 05 Dec 2023 22:18:20 -0500
Message-ID: <e5095e3efcf18b1ab85e98d421185309@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Juraj Marcin <juraj@jurajmarcin.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v4] selinux: add prefix/suffix matching to filename type  transitions
References: <20231121122719.2332137-1-juraj@jurajmarcin.com>
In-Reply-To: <20231121122719.2332137-1-juraj@jurajmarcin.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>

On Nov 21, 2023 Juraj Marcin <juraj@jurajmarcin.com> wrote:
> 
> Currently, filename transitions are stored separately from other type
> enforcement rules and only support exact name matching. However, in
> practice, the names contain variable parts. This leads to many
> duplicated rules in the policy that differ only in the part of the name,
> or it is even impossible to cover all possible combinations.
> 
> This patch changes the filename transition table in the policydb
> structure into an array of three tables, where the index determines the
> match type for the rules contained (extract, prefix, and suffix match).
> Then the patch extends the functions that access the table through the
> policydb structure to accompany this change while reusing the majority
> of the old filename transitions code.
> 
> This patch also updates the code responsible for finding the right
> filename transition based on the context and the name. The rules have
> the following order of prioriy, if no matching rule is found, the code
> moves on to the next category:
> - exact filename transitions,
> - prefix filename transitions in the order of the longest prefix match,
> - suffix filename transitions in the order of the longest suffix match.
> This ensures the compatibility with older policies.
> 
> Without prefix/suffix rules in the policy, this patch has no impact on
> performance or policy loading times. Moreover, with prefix/suffix rules,
> the overall number of filename transitions can be reduced, which results
> in smaller binary policy size and therefore also slightly lower load
> time and memory usage.
> 
> Performance tests:
> 
> 1: Reference kernel (f5bbdeda34c63), Fedora policy (format v33)
> 2: This patch, Fedora policy (format v33)
> 3: This patch, Fedora policy without prefix/suffix rules (format v34)
> 4: This patch, Fefora policy with prefix rules (format v35)
> 
>    | Mem    | Binary | Policy  | Create tty [1]       | osbench [2]
>    | Usage  | policy | load    |                      | create
>    |        | size   | time    | (ms/file)            | files
>    | (MiB)  | (KiB)  | (ms)    | real     | kernel    | (us/file)
> ---+--------+--------+---------+----------+-----------+-----------
>  1 |  298.7 |   3682 |  58.626 |   1.0228 |    0.6793 |    8.4916
>    | sd=4.1 |        | sd=0.47 | sd=0.058 | sd=0.0497 |  sd=0.131
>  2 |  296.3 |   3682 |  58.915 |   1.0209 |    0.6752 |    8.5728
>    | sd=3.9 |        | sd=0.28 | sd=0.021 | sd=0.0244 |  sd=0.156
>  3 |  295.7 |   3682 |  56.374 |   1.0160 |    0.6616 |    8.7467
>    | sd=2.6 |        | sd=0.44 | sd=0.008 | sd=0.0141 |  sd=0.126
>  4 |  296.2 |   2585 |  51.434 |   1.0116 |    0.6699 |    8.7467
>    | sd=4.1 |        | sd=0.39 | sd=0.012 | sd=0.0115 |  sd=0.126
>
> [1] Create test_tty benchmark:
> 
>     mknod /dev/test_tty c 4 1
>     time for i in `seq 1 10000`; do
>         mknod /dev/test_tty$i c 4 1
>     done
> 
> This benchmark should simulate the worst case scenario as many filename
> transitions affect files created in the /dev directory.
> 
> [2] https://github.com/mbitsnbites/osbench

Hi Juraj, first I want to thank you for your continued persistence on
this patch, I know this has likely been a lot of work.  However, I am
a little concerned about the osbench test results.  The policy size
and load time improvements are really nice to see but I worry that
those wins might be overshadowed by the runtime performance impacts.

I did see some things which I think might improve that slightly, more
on that below ...

> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v4:
> - rebased to the latest pcmoore/selinux/next
> - fixed non-atomic allocation in atomic section
> ---
> v3:
> - reworked the solution from scratch, this time only adding the
>   prefix/suffix matching feature without moving filename transition
>   rules to the avtab
> ---
>  security/selinux/include/security.h |  3 +-
>  security/selinux/ss/policydb.c      | 96 ++++++++++++++++++++++-------
>  security/selinux/ss/policydb.h      | 12 +++-
>  security/selinux/ss/services.c      | 57 ++++++++++++++---
>  4 files changed, 134 insertions(+), 34 deletions(-)

As a quick side note, it's a good idea to get in the habit of running
the checkpatch.pl script on your patches before submitting as it can
catch a lot of silly things.

 % ./scripts/checkpatch.pl -g HEAD

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index a9de89af8fdc..943dfe7ede83 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -46,10 +46,11 @@
>  #define POLICYDB_VERSION_INFINIBAND		31
>  #define POLICYDB_VERSION_GLBLUB		32
>  #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitions */
> +#define POLICYDB_VERSION_PREFIX_SUFFIX	34 /* prefix/suffix filename transitions */
>  
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
> +#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_PREFIX_SUFFIX
>  
>  /* Mask for just the mount related flags */
>  #define SE_MNTMASK	0x0f
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index bd1e7f26d951..562eaa70fb12 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -157,6 +157,11 @@ static const struct policydb_compat_info policydb_compat[] = {
>  		.sym_num	= SYM_NUM,
>  		.ocon_num	= OCON_NUM,
>  	},
> +	{
> +		.version	= POLICYDB_VERSION_PREFIX_SUFFIX,
> +		.sym_num	= SYM_NUM,
> +		.ocon_num	= OCON_NUM,
> +	},
>  };
>  
>  static const struct policydb_compat_info *policydb_lookup_compat(unsigned int version)
> @@ -437,10 +442,33 @@ static const struct hashtab_key_params filenametr_key_params = {
>  	.cmp = filenametr_cmp,
>  };
>  
> -struct filename_trans_datum *policydb_filenametr_search(
> -	struct policydb *p, struct filename_trans_key *key)
> +/**
> + * policydb_filenametr_search() - Search for filename transition in policy
> + * @p: policydb structure to search in
> + * @match_type: filename transition match type to search for
> + * @key: key to search for
> + * @stype: source type to search for, when stype is zero, the function will
> + *         return head of the linked list with matching key, otherwise it will
> + *         traverse the linked list to find the item with matching stype
> + *
> + * Return: head of the linked list of filename transition datums or single item
> + * 	   of the list, based on the stype value
> + */
> +struct filename_trans_datum *policydb_filenametr_search(struct policydb *p,
> +	unsigned int match_type, struct filename_trans_key *key, u32 stype)
>  {
> -	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
> +	struct filename_trans_datum *datum = hashtab_search(
> +		&p->filename_trans[match_type], key, filenametr_key_params);
> +
> +	if (stype) {
> +		while (datum) {
> +			if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
> +				return datum;
> +			}
> +			datum = datum->next;
> +		}
> +	}
> +	return datum;

I'd be curious if this actually changes any of the compiled code, but
you could tweak the above to return an error quicker (and it tends to
fit kernel coding patterns a bit better):

  policydb_filenametr_search(...)
  {
    datum = hashtab_search(...);
    if (!datum || !stype)
      return datum;
    while (datum) {
      /* stuff */
    }
    return datum;
  }	

>  }
>  
>  static u32 rangetr_hash(const void *k)
> @@ -833,8 +861,10 @@ void policydb_destroy(struct policydb *p)
>  	}
>  	kfree(lra);
>  
> -	hashtab_map(&p->filename_trans, filenametr_destroy, NULL);
> -	hashtab_destroy(&p->filename_trans);
> +	for (unsigned int i = 0; i < FILENAME_TRANS_MATCH_NUM; i++) {
> +		hashtab_map(&p->filename_trans[i], filenametr_destroy, NULL);
> +		hashtab_destroy(&p->filename_trans[i]);
> +	}
>  
>  	hashtab_map(&p->range_tr, range_tr_destroy, NULL);
>  	hashtab_destroy(&p->range_tr);
> @@ -1909,7 +1939,9 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
>  	otype = le32_to_cpu(buf[3]);
>  
>  	last = NULL;
> -	datum = policydb_filenametr_search(p, &key);
> +	// this version does not support other than exact match

Please only use C-style comments (/* ... */).

> +	datum = policydb_filenametr_search(p, FILENAME_TRANS_MATCH_EXACT, &key,
> +					   0);
>  	while (datum) {
>  		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
>  			/* conflicting/duplicate rules are ignored */
> @@ -1939,8 +1971,9 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
>  			if (!ft)
>  				goto out;
>  
> -			rc = hashtab_insert(&p->filename_trans, ft, datum,
> -					    filenametr_key_params);
> +			rc = hashtab_insert(
> +				&p->filename_trans[FILENAME_TRANS_MATCH_EXACT],
> +				ft, datum, filenametr_key_params);
>  			if (rc)
>  				goto out;
>  			name = NULL;
> @@ -1961,7 +1994,8 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
>  	return rc;
>  }
>  
> -static int filename_trans_read_helper(struct policydb *p, void *fp)
> +static int filename_trans_read_helper(struct policydb *p, void *fp,
> +				      unsigned int match_type)
>  {
>  	struct filename_trans_key *ft = NULL;
>  	struct filename_trans_datum **dst, *datum, *first = NULL;
> @@ -2028,7 +2062,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
>  	ft->tclass = tclass;
>  	ft->name = name;
>  
> -	rc = hashtab_insert(&p->filename_trans, ft, first,
> +	rc = hashtab_insert(&p->filename_trans[match_type], ft, first,
>  			    filenametr_key_params);
>  	if (rc == -EEXIST)
>  		pr_err("SELinux:  Duplicate filename transition key\n");
> @@ -2050,7 +2084,8 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
>  	return rc;
>  }
>  
> -static int filename_trans_read(struct policydb *p, void *fp)
> +static int filename_trans_read(struct policydb *p, void *fp,
> +			       unsigned int match_type)
>  {
>  	u32 nel, i;
>  	__le32 buf[1];
> @@ -2067,27 +2102,28 @@ static int filename_trans_read(struct policydb *p, void *fp)
>  	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
>  		p->compat_filename_trans_count = nel;
>  
> -		rc = hashtab_init(&p->filename_trans, (1 << 11));
> +		rc = hashtab_init(&p->filename_trans[match_type], (1 << 11));
>  		if (rc)
>  			return rc;
>  
>  		for (i = 0; i < nel; i++) {
> +			// this version does not support other than exact match

See my previous comment on comments :)

>  			rc = filename_trans_read_helper_compat(p, fp);
>  			if (rc)
>  				return rc;
>  		}
>  	} else {
> -		rc = hashtab_init(&p->filename_trans, nel);
> +		rc = hashtab_init(&p->filename_trans[match_type], nel);
>  		if (rc)
>  			return rc;
>  
>  		for (i = 0; i < nel; i++) {
> -			rc = filename_trans_read_helper(p, fp);
> +			rc = filename_trans_read_helper(p, fp, match_type);
>  			if (rc)
>  				return rc;
>  		}
>  	}
> -	hash_eval(&p->filename_trans, "filenametr");
> +	hash_eval(&p->filename_trans[match_type], "filenametr");
>  	return 0;
>  }
>  
> @@ -2636,9 +2672,17 @@ int policydb_read(struct policydb *p, void *fp)
>  		lra = ra;
>  	}
>  
> -	rc = filename_trans_read(p, fp);
> +	rc = filename_trans_read(p, fp, FILENAME_TRANS_MATCH_EXACT);
>  	if (rc)
>  		goto bad;
> +	if (p->policyvers >= POLICYDB_VERSION_PREFIX_SUFFIX) {
> +		rc = filename_trans_read(p, fp, FILENAME_TRANS_MATCH_PREFIX);
> +		if (rc)
> +			goto bad;
> +		rc = filename_trans_read(p, fp, FILENAME_TRANS_MATCH_SUFFIX);
> +		if (rc)
> +			goto bad;
> +	}
>  
>  	rc = policydb_index(p);
>  	if (rc)
> @@ -3569,7 +3613,8 @@ static int filename_write_helper(void *key, void *data, void *ptr)
>  	return 0;
>  }
>  
> -static int filename_trans_write(struct policydb *p, void *fp)
> +static int filename_trans_write(struct policydb *p, void *fp,
> +				unsigned int match_type)
>  {
>  	__le32 buf[1];
>  	int rc;
> @@ -3583,15 +3628,16 @@ static int filename_trans_write(struct policydb *p, void *fp)
>  		if (rc)
>  			return rc;
>  
> -		rc = hashtab_map(&p->filename_trans,
> +		rc = hashtab_map(&p->filename_trans[match_type],
>  				 filename_write_helper_compat, fp);
>  	} else {
> -		buf[0] = cpu_to_le32(p->filename_trans.nel);
> +		buf[0] = cpu_to_le32(p->filename_trans[match_type].nel);
>  		rc = put_entry(buf, sizeof(u32), 1, fp);
>  		if (rc)
>  			return rc;
>  
> -		rc = hashtab_map(&p->filename_trans, filename_write_helper, fp);
> +		rc = hashtab_map(&p->filename_trans[match_type],
> +				 filename_write_helper, fp);
>  	}
>  	return rc;
>  }
> @@ -3706,9 +3752,17 @@ int policydb_write(struct policydb *p, void *fp)
>  	if (rc)
>  		return rc;
>  
> -	rc = filename_trans_write(p, fp);
> +	rc = filename_trans_write(p, fp, FILENAME_TRANS_MATCH_EXACT);
>  	if (rc)
>  		return rc;
> +	if (p->policyvers >= POLICYDB_VERSION_PREFIX_SUFFIX) {
> +		rc = filename_trans_write(p, fp, FILENAME_TRANS_MATCH_PREFIX);
> +		if (rc)
> +			return rc;
> +		rc = filename_trans_write(p, fp, FILENAME_TRANS_MATCH_SUFFIX);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	rc = ocontext_write(p, info, fp);
>  	if (rc)
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index b97cda489753..7bd0ecb8ed69 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -235,6 +235,13 @@ struct genfs {
>  #define OCON_IBENDPORT	8 /* Infiniband end ports */
>  #define OCON_NUM	9
>  
> +enum {
> +	FILENAME_TRANS_MATCH_EXACT,
> +	FILENAME_TRANS_MATCH_PREFIX,
> +	FILENAME_TRANS_MATCH_SUFFIX,
> +	FILENAME_TRANS_MATCH_NUM,
> +};

Since we are using the enums above as array indices it might be a
good idea to assign them values explicitly, or just use pre-processor
macros instead of enums.  The latter might be preferable here.

>  /* The policy database */
>  struct policydb {
>  	int mls_enabled;
> @@ -269,7 +276,7 @@ struct policydb {
>  	/* quickly exclude lookups when parent ttype has no rules */
>  	struct ebitmap filename_trans_ttypes;
>  	/* actual set of filename_trans rules */
> -	struct hashtab filename_trans;
> +	struct hashtab filename_trans[FILENAME_TRANS_MATCH_NUM];
>  	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
>  	u32 compat_filename_trans_count;
>  
> @@ -325,7 +332,8 @@ extern int policydb_read(struct policydb *p, void *fp);
>  extern int policydb_write(struct policydb *p, void *fp);
>  
>  extern struct filename_trans_datum *policydb_filenametr_search(
> -	struct policydb *p, struct filename_trans_key *key);
> +	struct policydb *p, unsigned int match_type,
> +	struct filename_trans_key *key, u32 stype);
>  
>  extern struct mls_range *policydb_rangetr_search(
>  	struct policydb *p, struct range_trans *key);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 1eeffc66ea7d..99200a9490a3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1661,13 +1661,16 @@ static int compute_sid_handle_invalid_context(
>  	return -EACCES;
>  }
>  
> -static void filename_compute_type(struct policydb *policydb,
> +static int filename_compute_type(struct policydb *policydb,
>  				  struct context *newcontext,
>  				  u32 stype, u32 ttype, u16 tclass,
>  				  const char *objname)
>  {
>  	struct filename_trans_key ft;
>  	struct filename_trans_datum *datum;
> +	size_t name_len = strlen(objname);

Since the @name_len variable isn't used by the MATCH_EXACT search you
should move it below that policydb_filenametr_search() call so we
don't do unnecessary strlen() computations.

> +	size_t i;
> +	char *name_copy;
>  
>  	/*
>  	 * Most filename trans rules are going to live in specific directories
> @@ -1675,20 +1678,50 @@ static void filename_compute_type(struct policydb *policydb,
>  	 * if the ttype does not contain any rules.
>  	 */
>  	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
> -		return;
> +		return 0;
>  
>  	ft.ttype = ttype;
>  	ft.tclass = tclass;
> +
> +	/* Search for exact rules */
>  	ft.name = objname;
> +	datum = policydb_filenametr_search(policydb, FILENAME_TRANS_MATCH_EXACT,
> +					   &ft, stype);
> +	if (datum) {
> +		newcontext->type = datum->otype;
> +		return 0;
> +	}
>  
> -	datum = policydb_filenametr_search(policydb, &ft);
> -	while (datum) {
> -		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
> +	/* Search for prefix rules */
> +	name_copy = kstrdup(objname, GFP_ATOMIC);
> +	if (!name_copy)
> +		return -ENOMEM;

I'd set @name_len here.

> +	ft.name = name_copy;
> +	for (i = name_len; i > 0; i--) {

I'm not sure if this intentional or not, but the minimum prefix size
here is two characters '(i == 1)' is that intended?  Or am I tired and
simply reading the code wrong ;)

Please note that if you adjust this to go down to a single character
you will likely need to switch @i to a 'ssize_t', and 'int', or
something signed.

I'm also wondering if there is some clever way to limit the number of
times we go through this loop.  If we tracked and saved the smallest
prefix size when we are loading the policy, I imagine we could use
that to limit the number of loop iterations as there is no sense in
searching below the length of the smallest prefix, right?  Thinking
about it some more, the same logic could be applied to the longest
prefix as well.  I'm not sure what the test policy looks like with the
prefix and suffic matches, but hopefully that should improve
performance slightly, especially on long filenames.

> +		name_copy[i] = '\0';
> +		datum = policydb_filenametr_search(policydb,
> +						   FILENAME_TRANS_MATCH_PREFIX,
> +						   &ft, stype);
> +		if (datum) {
>  			newcontext->type = datum->otype;
> -			return;
> +			kfree(name_copy);
> +			return 0;

If you initialize @name_copy to NULL and reset it below, you could
simplify things very slightly by making a 'found' jump target at the
end of the function:

  found:
    kfree(name_copy);
    newcontext->type = datum->otype;
    return 0;

>  		}
> -		datum = datum->next;
>  	}
> +	kfree(name_copy);
> +
> +	/* Search for suffix rules */
> +	for (i = 0; i < name_len; i++) {

I believe you should be able to bound the loop iterations here too.

> +		ft.name = &objname[i];
> +		datum = policydb_filenametr_search(policydb,
> +						   FILENAME_TRANS_MATCH_SUFFIX,
> +						   &ft, stype);
> +		if (datum) {
> +			newcontext->type = datum->otype;
> +			return 0;
> +		}
> +	}
> +	return 0;
>  }
>  
>  static int security_compute_sid(u32 ssid,
> @@ -1833,9 +1866,13 @@ static int security_compute_sid(u32 ssid,
>  	}
>  
>  	/* if we have a objname this is a file trans check so check those rules */
> -	if (objname)
> -		filename_compute_type(policydb, &newcontext, scontext->type,
> -				      tcontext->type, tclass, objname);
> +	if (objname) {
> +		rc = filename_compute_type(policydb, &newcontext,
> +					   scontext->type, tcontext->type,
> +					   tclass, objname);
> +		if (rc)
> +			goto out_unlock;
> +	}
>  
>  	/* Check for class-specific changes. */
>  	if (specified & AVTAB_TRANSITION) {
> -- 
> 2.42.0

--
paul-moore.com
