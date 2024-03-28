Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523F22325
	for <selinux@vger.kernel.org>; Thu, 28 Mar 2024 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711588925; cv=none; b=StkNDYtauElm2drbjQIxmGrg3UqLBtUlKU8sL/6z2fa7AVtrBLKJImlmhYqnXJJo6kMV+BX1hz20HEIy51a4kjg44KvlH59kEHYA91xz8q3Xs7GLvn2UWC8VnsrelYCs4s6VubPm0WK8jezQj3pnXfCeb5hNiSBh84WCK6Y+bPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711588925; c=relaxed/simple;
	bh=MtU1+RbFgq0DyWrii14zQqg0Ii0+5tWestgoPoRf8nw=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=ODdda7Qzz/J08kqtzRHFtkl6Wj4qAOJrwAmyWlApNFtKwf6Xm6c1iBd5OXfHa9J9dMgT2OJFKAnxw7Te7R+9Gart5YLF3b3lCyctYx3vmoPD2QTKqJdhk/rOsO1bXmpnNBQAaD07L22MVctxuGkBOSbsCUJI84AJ31nJl3O58As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qh7wcVyO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qh7wcVyO"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-690c1747c3cso3753446d6.0
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711588922; x=1712193722; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mjTHxNuXN2Qgwi/K5OC7O1PfrYfKl8JL9UVZKmDpHXU=;
        b=Qh7wcVyOWE8RbwL1tyQjyg2n2JKB4ZFGhhSjT21G96EuY9RLFmxD+qJqR0sdIKFfNz
         YG2gAEsAp0yOjKD1ASwhS3/3FP678JUrL/FKVVMFzb6ma0VZ8JA2FGKTG0XiAON5lexC
         8r86bD1iOJnqxfAr1RACuqM0C/HlKrkXHsV7EShqh/SZbW0AKD6eJMydsRqBTH83R3yk
         HUmK5Apqu6Oflm3clk66z2dCe88ZP7fZS0LYJOpEqZE86N46EfKCParxFKXd86HI2vJK
         xiuT3Aym5mF3LyVJESbKESn8XwOi3O/NcJMtosX+b2Rd6sGBMZaDk4d0Dr7sj15krslN
         P6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711588922; x=1712193722;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjTHxNuXN2Qgwi/K5OC7O1PfrYfKl8JL9UVZKmDpHXU=;
        b=hKVxONlg7pl6jktsdq47cKtnD6xHvKOA/yGlDNubu553QENyKR5XiISYmFARx2Fp5U
         /KKlvsYT13HJ4/K5OLDhwRkX01ParQYpGnZ+MkwIITORBUpu4VSaAq+bbjKNrChRy3Ms
         bYb7SjAow/8Nv3tUWlIoRtvlrxfyDku5arjDF8v1PmCzjx5E8K/ChHCKSb01pv80ufeG
         V03gui4pEnEIGvbBlGAqEcRz6ARA76jegdOhFAmlxzavf+gaTZKEzdN77A/1RZzGV8Kq
         OErSS+KGtgm9Z0eM+LRHWR6D8UCzQHRiM9g8c70Wa9wJLx22VsC81ZYxyZJFHLqPFX0Y
         WzVw==
X-Forwarded-Encrypted: i=1; AJvYcCVl204b5q1c4cCaX6KS8z5Z100QfxqKxgNiVImcS35jTzEeqhb20H8dSwc+dttHlRalc5/HpLaYiQ/tntmjspj2nmzm3FC4gQ==
X-Gm-Message-State: AOJu0YzH7s4Qqir3XSwoWwQtvQhExKs6N+6sDAV3C8vz7m6vthbhLL+m
	5tsm8Jg346FL5m3PT7EKFa8A0k4NkC+KZT5xZWWaKkQm1NWp5NqyuXpUAx0xzQ==
X-Google-Smtp-Source: AGHT+IEXlYQre8fpIUr1V/wLZcY7lL27qOHeG7gT1nSx5RUBs8ZBZ4TBHKRzmG9AG4/TWBAFzUY/TQ==
X-Received: by 2002:a0c:e3cc:0:b0:696:8191:9b17 with SMTP id e12-20020a0ce3cc000000b0069681919b17mr1328709qvl.26.1711588922036;
        Wed, 27 Mar 2024 18:22:02 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 4-20020a0562140d0400b00690bfb6aac7sm166397qvh.51.2024.03.27.18.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:22:01 -0700 (PDT)
Date: Wed, 27 Mar 2024 21:22:00 -0400
Message-ID: <486c37d889583bb7351dba9793a2e709@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Juraj Marcin <juraj@jurajmarcin.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v5] selinux: add prefix/suffix matching to filename type  transitions
References: <20240305170501.2185811-1-juraj@jurajmarcin.com>
In-Reply-To: <20240305170501.2185811-1-juraj@jurajmarcin.com>

On Mar  5, 2024 Juraj Marcin <juraj@jurajmarcin.com> wrote:
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
> the following order of priority, if no matching rule is found, the code
> moves on to the next category:
> - exact filename transitions,
> - prefix filename transitions in the order of the longest prefix match,
> - suffix filename transitions in the order of the longest suffix match.
> This ensures the compatibility with older policies.
> 
> Lastly, this patch adds an attribute containing the explicit length of
> the name string in the filename transition key to allow using only
> prefix of a constant string as key.
> 
> Without prefix/suffix rules in the policy, this patch has no impact on
> performance or policy loading times. Moreover, with prefix/suffix rules,
> the overall number of filename transitions can be reduced, which results
> in smaller binary policy size and therefore also slightly lower load
> time and memory usage.
> 
> Performance tests:
> 
> 1: Reference kernel (a1fc79343abbd), Fedora policy (format v33)
> 2: This patch, Fedora policy (format v33)
> 3: This patch, Fedora policy without prefix/suffix rules (format v34)
> 4: This patch, Fedora policy with prefix rules (format v35)

I think #4 also uses policy format v34, right?

>    | Mem   | Binary | Policy  | Create    | osbench [2]
>    | Usage | policy | load    | tty [1]   | create
>    |       | size   | time    |           | files
>    | (MiB) | (KiB)  | (ms)    | (ms/file) | (us/file)
> ---+-------+--------+---------+-----------+-----------
>  1 |   430 |   3682 |  46.930 |    2.4569 |   43.4431
>    | sd= 8 |        | sd=0.25 |  sd=0.043 |  sd=0.434
>  2 |   410 |   3682 |  46.829 |    2.4623 |   43.4112
>    | sd=20 |        | sd=0.27 |  sd=0.053 |  sd=0.442
>  3 |   419 |   3682 |  46.823 |    2.4257 |   43.0575
>    | sd=14 |        | sd=0.18 |  sd=0.057 |  sd=0.416
>  4 |   420 |   2585 |  42.044 |    2.5028 |   43.7907
>    | sd=10 |        | sd=0.19 |  sd=0.067 |  sd=0.382

Thanks for the updated patchset :)

I like the improvements in #2 and #3, with only one test being slightly
worse than #1, I think we're okay there.  However, it looks like there
has been a regression in #4 in terms of runtime performance ... hmmm.

> [1] Create test_tty benchmark:
> 
>     mknod /dev/test_tty c 4 1
>     time for i in `seq 1 10000`; do
>        	mknod /dev/test_tty$i c 4 1
>     done
> 
> This benchmark should simulate the worst case scenario as many filename
> transitions affect files created in the /dev directory.
> 
> [2] https://github.com/mbitsnbites/osbench
> 
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

Unless Ondrej has specifically reviewed v5, I think we need to drop
his Reviewed-by tag as there have been some significant changes since
he reviewed it last.

> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
> ---
> v5:
> - rebased to the latest pcmoore/selinux/next
> - applied suggestions from Paul Moore
> - added limit optimization suggested by Paul Moore
> - removed string duplication by using explicit string length in
>   filename trasition key
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
>  security/selinux/include/security.h |   4 +-
>  security/selinux/ss/policydb.c      | 132 ++++++++++++++++++++++------
>  security/selinux/ss/policydb.h      |  14 ++-
>  security/selinux/ss/services.c      |  72 ++++++++++++---
>  4 files changed, 178 insertions(+), 44 deletions(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 289bf9233f714..49a043633173c 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -46,10 +46,12 @@
>  #define POLICYDB_VERSION_INFINIBAND	     31
>  #define POLICYDB_VERSION_GLBLUB		     32
>  #define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
> +#define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */

I think one #define should be enough ;)

> +#define POLICYDB_VERSION_PREFIX_SUFFIX	     34 /* prefix/suffix filename transitions */
>  
>  /* Range of policy versions we understand*/
>  #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
> -#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COMP_FTRANS
> +#define POLICYDB_VERSION_MAX POLICYDB_VERSION_PREFIX_SUFFIX
>  
>  /* Mask for just the mount related flags */
>  #define SE_MNTMASK 0x0f
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 3d22d5baa829b..5de22ba840673 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -429,7 +434,11 @@ static int filenametr_cmp(const void *k1, const void *k2)
>  	if (v)
>  		return v;
>  
> -	return strcmp(ft1->name, ft2->name);
> +	v = strncmp(ft1->name, ft2->name, min(ft1->name_len, ft2->name_len));
> +	if (ft1->name_len == ft2->name_len || v)
> +		return v;
> +	/* if one name is prefix of the other, the longer is greater */
> +	return (int)ft1->name_len - (int)ft2->name_len;
>  }

I'm probably missing some subtlety in the code above, but I think we
might be able to optimize this a bit more:

  if (ft1->name_len != ft2->name_len)
    return (int)ft1->name_len - (int)ft2->name_len;
  return strcmp(ft1->name, ft2->name);

I expect being able to avoid a string comparison in some cases should
result in a small performance bump.

> @@ -437,10 +446,34 @@ static const struct hashtab_key_params filenametr_key_params = {
>  	.cmp = filenametr_cmp,
>  };
>  
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
> + *         of the list, based on the stype value
> + */
>  struct filename_trans_datum *
> -policydb_filenametr_search(struct policydb *p, struct filename_trans_key *key)
> +policydb_filenametr_search(struct policydb *p, unsigned int match_type,
> +			   struct filename_trans_key *key, u32 stype)
>  {
> -	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
> +	struct filename_trans_datum *datum = hashtab_search(
> +		&p->filename_trans[match_type], key, filenametr_key_params);
> +	if (!datum || !stype)
> +		return datum;
> +
> +	while (datum) {
> +		if (ebitmap_get_bit(&datum->stypes, stype - 1))
> +			return datum;
> +
> +		datum = datum->next;

Nitpicky, but you can probably remove the vertical whitespace above.

> +	}
> +	return datum;

This could be 'return NULL', right?

> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 4bba386264a3d..78abb959e7205 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -232,6 +233,11 @@ struct genfs {
>  #define OCON_IBENDPORT 8 /* Infiniband end ports */
>  #define OCON_NUM       9
>  
> +#define FILENAME_TRANS_MATCH_EXACT 0
> +#define FILENAME_TRANS_MATCH_PREFIX 1
> +#define FILENAME_TRANS_MATCH_SUFFIX 2
> +#define FILENAME_TRANS_MATCH_NUM 3

I think we should probably tweak things to help indicate that the last
macro/define above is not a usable value, how about this renaming it to
FILENAME_TRANS_MATCH_MAX?  I'm open to other suggestions too ...

>  /* The policy database */
>  struct policydb {
>  	int mls_enabled;
> @@ -266,9 +272,12 @@ struct policydb {
>  	/* quickly exclude lookups when parent ttype has no rules */
>  	struct ebitmap filename_trans_ttypes;
>  	/* actual set of filename_trans rules */
> -	struct hashtab filename_trans;
> +	struct hashtab filename_trans[FILENAME_TRANS_MATCH_NUM];
>  	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
>  	u32 compat_filename_trans_count;
> +	/* lenghts of prefix/suffix rules to optimze for long filenames */

"lengths" and "optimize"

> +	u32 filename_trans_name_max[FILENAME_TRANS_MATCH_NUM];
> +	u32 filename_trans_name_min[FILENAME_TRANS_MATCH_NUM];
>  
>  	/* bools indexed by (value - 1) */
>  	struct cond_bool_datum **bool_val_to_struct;

...

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e88b1b6c4adbb..e142c6bdfe2ed 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1672,13 +1672,20 @@ static int compute_sid_handle_invalid_context(
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
> +	size_t prefix_len;
> +	size_t suffix_len;
> +	size_t prefix_max;
> +	size_t suffix_max;
> +	size_t prefix_min;
> +	size_t suffix_min;

With the filename length variables being u32 elsewhere in this patch,
you can probably make these u32 and save some space (perf?).

> +	size_t objname_len = strlen(objname);

Same here, although you'll likely need a cast to keep the compiler
quiet.

>  	/*
>  	 * Most filename trans rules are going to live in specific directories

--
paul-moore.com
