Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5352054FF;
	Mon, 16 Dec 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359811; cv=none; b=tnmBZfeAOqbxD78S9ATo20Iai+P8uO5u+AH57qiLjkNeN6imnz9foYRTYD/LpFmaMrizlt68aQ66NdnX5/iwQpIA7p8zgkw5TldCAYiOTX7atftotu+gidEtemwmpqEP3VzTIKmrNC3h2mQVaSN7icb+3J6XwVIKZaPXmffp290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359811; c=relaxed/simple;
	bh=mBTW0gp5G+yDP4bubIdkc2BtLvH5Nn/TZ4w99SXq6zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fz0ieDrG6WF/bum+oSqASvMiXSXk0LvImaDDGnUxLiHBi5dVgEKKoKzmHRUcNNSytH/rr/zSj2r2+iVEAePF2938GYh4y3/hirSk8EnI5NhFKQLACa8bK4VzSaK3UDp8zfuqQ2OAnZtEod1BPjyxMbVrjWmxUA4Km9s364qZWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FGMwhruq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FGMwhruq"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC8F72042FD1;
	Mon, 16 Dec 2024 06:36:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC8F72042FD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734359808;
	bh=kFeHL/Hltvo8u4HcCiQOUAbwnrZiuqAyBI4aHMEPhqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FGMwhruq+kajmZPCGhF0Q4jkZKgq8jXGKET/8tCQCHI8wKtwqzj0/BD4HU5GXfYWS
	 wilrLHnldu209rDHoTEs645LK9PJ2qYrX+9n+LfPsowTm/By69becR9izJbIaPxzAs
	 ZfcYaWXeOhnJVAWGafyJsXEVTIUnFCJY5qMe3i08=
Message-ID: <207cc828-d54a-440c-b3fe-da2c2e88270c@linux.microsoft.com>
Date: Mon, 16 Dec 2024 09:36:45 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/22] selinux: use known type instead of void pointer
To: cgzones@googlemail.com, selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Jacob Satterfield <jsatterfield.linux@gmail.com>,
 Eric Suen <ericsu@linux.microsoft.com>, =?UTF-8?Q?Bram_Bonn=C3=A9?=
 <brambonne@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?=
 <tweek@google.com>, Canfeng Guo <guocanfeng@uniontech.com>,
 linux-kernel@vger.kernel.org
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
 <20241115133619.114393-7-cgoettsche@seltendoof.de>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20241115133619.114393-7-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/2024 8:35 AM, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> Improve type safety and readability by using the known type.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>   security/selinux/ss/avtab.c       |  8 +--
>   security/selinux/ss/avtab.h       |  9 ++--
>   security/selinux/ss/conditional.c | 12 ++---
>   security/selinux/ss/conditional.h |  6 +--
>   security/selinux/ss/ebitmap.c     |  4 +-
>   security/selinux/ss/ebitmap.h     |  5 +-
>   security/selinux/ss/policydb.c    | 88 +++++++++++++++----------------
>   security/selinux/ss/policydb.h    | 17 +++---
>   8 files changed, 76 insertions(+), 73 deletions(-)
> 
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 8e400dd736b7..23210faaa046 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -336,7 +336,7 @@ static const uint16_t spec_order[] = {
>   };
>   /* clang-format on */
>   
> -int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
> +int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *pol,
>   		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
>   				   const struct avtab_datum *d, void *p),
>   		    void *p)
> @@ -500,7 +500,7 @@ static int avtab_insertf(struct avtab *a, const struct avtab_key *k,
>   	return avtab_insert(a, k, d);
>   }
>   
> -int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
> +int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol)
>   {
>   	int rc;
>   	__le32 buf[1];
> @@ -543,7 +543,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
>   	goto out;
>   }
>   
> -int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
> +int avtab_write_item(struct policydb *p, const struct avtab_node *cur, struct policy_file *fp)
>   {
>   	__le16 buf16[4];
>   	__le32 buf32[ARRAY_SIZE(cur->datum.u.xperms->perms.p)];
> @@ -579,7 +579,7 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
>   	return 0;
>   }
>   
> -int avtab_write(struct policydb *p, struct avtab *a, void *fp)
> +int avtab_write(struct policydb *p, struct avtab *a, struct policy_file *fp)
>   {
>   	u32 i;
>   	int rc = 0;
> diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> index e10b78e61611..c671b6e909d4 100644
> --- a/security/selinux/ss/avtab.h
> +++ b/security/selinux/ss/avtab.h
> @@ -105,15 +105,16 @@ static inline void avtab_hash_eval(struct avtab *h, const char *tag)
>   #endif
>   
>   struct policydb;
> -int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
> +struct policy_file;
> +int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *pol,
>   		    int (*insert)(struct avtab *a, const struct avtab_key *k,
>   				  const struct avtab_datum *d, void *p),
>   		    void *p);
>   
> -int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
> +int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol);
>   int avtab_write_item(struct policydb *p, const struct avtab_node *cur,
> -		     void *fp);
> -int avtab_write(struct policydb *p, struct avtab *a, void *fp);
> +		     struct policy_file *fp);
> +int avtab_write(struct policydb *p, struct avtab *a, struct policy_file *fp);
>   
>   struct avtab_node *avtab_insert_nonunique(struct avtab *h,
>   					  const struct avtab_key *key,
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 64ba95e40a6f..244dc8279113 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -206,7 +206,7 @@ static int bool_isvalid(struct cond_bool_datum *b)
>   	return 1;
>   }
>   
> -int cond_read_bool(struct policydb *p, struct symtab *s, void *fp)
> +int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct cond_bool_datum *booldatum;
> @@ -323,7 +323,7 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
>   	return 0;
>   }
>   
> -static int cond_read_av_list(struct policydb *p, void *fp,
> +static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
>   			     struct cond_av_list *list,
>   			     struct cond_av_list *other)
>   {
> @@ -375,7 +375,7 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
>   	return 1;
>   }
>   
> -static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
> +static int cond_read_node(struct policydb *p, struct cond_node *node, struct policy_file *fp)
>   {
>   	__le32 buf[2];
>   	u32 i, len;
> @@ -415,7 +415,7 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>   	return cond_read_av_list(p, fp, &node->false_list, &node->true_list);
>   }
>   
> -int cond_read_list(struct policydb *p, void *fp)
> +int cond_read_list(struct policydb *p, struct policy_file *fp)
>   {
>   	__le32 buf[1];
>   	u32 i, len;
> @@ -453,7 +453,7 @@ int cond_write_bool(void *vkey, void *datum, void *ptr)
>   	char *key = vkey;
>   	struct cond_bool_datum *booldatum = datum;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	__le32 buf[3];
>   	u32 len;
>   	int rc;
> @@ -536,7 +536,7 @@ static int cond_write_node(struct policydb *p, struct cond_node *node,
>   	return 0;
>   }
>   
> -int cond_write_list(struct policydb *p, void *fp)
> +int cond_write_list(struct policydb *p, struct policy_file *fp)
>   {
>   	u32 i;
>   	__le32 buf[1];
> diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
> index 8827715bad75..468e98ad3ea1 100644
> --- a/security/selinux/ss/conditional.h
> +++ b/security/selinux/ss/conditional.h
> @@ -68,10 +68,10 @@ int cond_destroy_bool(void *key, void *datum, void *p);
>   
>   int cond_index_bool(void *key, void *datum, void *datap);
>   
> -int cond_read_bool(struct policydb *p, struct symtab *s, void *fp);
> -int cond_read_list(struct policydb *p, void *fp);
> +int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp);
> +int cond_read_list(struct policydb *p, struct policy_file *fp);
>   int cond_write_bool(void *key, void *datum, void *ptr);
> -int cond_write_list(struct policydb *p, void *fp);
> +int cond_write_list(struct policydb *p, struct policy_file *fp);
>   
>   void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>   		     struct av_decision *avd, struct extended_perms *xperms);
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 99c01be15115..cd84357db2c4 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -360,7 +360,7 @@ void ebitmap_destroy(struct ebitmap *e)
>   	e->node = NULL;
>   }
>   
> -int ebitmap_read(struct ebitmap *e, void *fp)
> +int ebitmap_read(struct ebitmap *e, struct policy_file *fp)
>   {
>   	struct ebitmap_node *n = NULL;
>   	u32 mapunit, count, startbit, index, i;
> @@ -478,7 +478,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
>   	goto out;
>   }
>   
> -int ebitmap_write(const struct ebitmap *e, void *fp)
> +int ebitmap_write(const struct ebitmap *e, struct policy_file *fp)
>   {
>   	struct ebitmap_node *n;
>   	u32 bit, count, last_bit, last_startbit;
> diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
> index ba2ac3da1153..e0150695566c 100644
> --- a/security/selinux/ss/ebitmap.h
> +++ b/security/selinux/ss/ebitmap.h
> @@ -129,8 +129,9 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
>   int ebitmap_get_bit(const struct ebitmap *e, u32 bit);
>   int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value);
>   void ebitmap_destroy(struct ebitmap *e);
> -int ebitmap_read(struct ebitmap *e, void *fp);
> -int ebitmap_write(const struct ebitmap *e, void *fp);
> +struct policy_file;
> +int ebitmap_read(struct ebitmap *e, struct policy_file *fp);
> +int ebitmap_write(const struct ebitmap *e, struct policy_file *fp);
>   u32 ebitmap_hash(const struct ebitmap *e, u32 hash);
>   
>   #ifdef CONFIG_NETLABEL
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index d04d9ada3835..e94ecb81c6d3 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -994,7 +994,7 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
>    * Read a MLS range structure from a policydb binary
>    * representation file.
>    */
> -static int mls_read_range_helper(struct mls_range *r, void *fp)
> +static int mls_read_range_helper(struct mls_range *r, struct policy_file *fp)
>   {
>   	__le32 buf[2];
>   	u32 items;
> @@ -1054,7 +1054,7 @@ static int mls_read_range_helper(struct mls_range *r, void *fp)
>    * from a policydb binary representation file.
>    */
>   static int context_read_and_validate(struct context *c, struct policydb *p,
> -				     void *fp)
> +				     struct policy_file *fp)
>   {
>   	__le32 buf[3];
>   	int rc;
> @@ -1092,7 +1092,7 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
>    * binary representation file.
>    */
>   
> -static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
> +static int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
>   {
>   	int rc;
>   	char *str;
> @@ -1115,7 +1115,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>   	return 0;
>   }
>   
> -static int perm_read(struct policydb *p, struct symtab *s, void *fp)
> +static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct perm_datum *perdatum;
> @@ -1148,7 +1148,7 @@ static int perm_read(struct policydb *p, struct symtab *s, void *fp)
>   	return rc;
>   }
>   
> -static int common_read(struct policydb *p, struct symtab *s, void *fp)
> +static int common_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct common_datum *comdatum;
> @@ -1200,7 +1200,7 @@ static void type_set_init(struct type_set *t)
>   	ebitmap_init(&t->negset);
>   }
>   
> -static int type_set_read(struct type_set *t, void *fp)
> +static int type_set_read(struct type_set *t, struct policy_file *fp)
>   {
>   	__le32 buf[1];
>   	int rc;
> @@ -1219,7 +1219,7 @@ static int type_set_read(struct type_set *t, void *fp)
>   }
>   
>   static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
> -			    u32 ncons, int allowxtarget, void *fp)
> +			    u32 ncons, int allowxtarget, struct policy_file *fp)
>   {
>   	struct constraint_node *c, *lc;
>   	struct constraint_expr *e, *le;
> @@ -1313,7 +1313,7 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
>   	return 0;
>   }
>   
> -static int class_read(struct policydb *p, struct symtab *s, void *fp)
> +static int class_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct class_datum *cladatum;
> @@ -1410,7 +1410,7 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
>   	return rc;
>   }
>   
> -static int role_read(struct policydb *p, struct symtab *s, void *fp)
> +static int role_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct role_datum *role;
> @@ -1467,7 +1467,7 @@ static int role_read(struct policydb *p, struct symtab *s, void *fp)
>   	return rc;
>   }
>   
> -static int type_read(struct policydb *p, struct symtab *s, void *fp)
> +static int type_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct type_datum *typdatum;
> @@ -1519,7 +1519,7 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
>    * Read a MLS level structure from a policydb binary
>    * representation file.
>    */
> -static int mls_read_level(struct mls_level *lp, void *fp)
> +static int mls_read_level(struct mls_level *lp, struct policy_file *fp)
>   {
>   	__le32 buf[1];
>   	int rc;
> @@ -1541,7 +1541,7 @@ static int mls_read_level(struct mls_level *lp, void *fp)
>   	return 0;
>   }
>   
> -static int user_read(struct policydb *p, struct symtab *s, void *fp)
> +static int user_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct user_datum *usrdatum;
> @@ -1592,7 +1592,7 @@ static int user_read(struct policydb *p, struct symtab *s, void *fp)
>   	return rc;
>   }
>   
> -static int sens_read(struct policydb *p, struct symtab *s, void *fp)
> +static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct level_datum *levdatum;
> @@ -1633,7 +1633,7 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
>   	return rc;
>   }
>   
> -static int cat_read(struct policydb *p, struct symtab *s, void *fp)
> +static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
>   {
>   	char *key = NULL;
>   	struct cat_datum *catdatum;
> @@ -1668,7 +1668,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
>   
>   /* clang-format off */
>   static int (*const read_f[SYM_NUM])(struct policydb *p, struct symtab *s,
> -				    void *fp) = {
> +				    struct policy_file *fp) = {
>   	common_read,
>   	class_read,
>   	role_read,
> @@ -1838,7 +1838,7 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
>   	return 1U << (perdatum->value - 1);
>   }
>   
> -static int range_read(struct policydb *p, void *fp)
> +static int range_read(struct policydb *p, struct policy_file *fp)
>   {
>   	struct range_trans *rt = NULL;
>   	struct mls_range *r = NULL;
> @@ -1915,7 +1915,7 @@ static int range_read(struct policydb *p, void *fp)
>   	return rc;
>   }
>   
> -static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
> +static int filename_trans_read_helper_compat(struct policydb *p, struct policy_file *fp)
>   {
>   	struct filename_trans_key key, *ft = NULL;
>   	struct filename_trans_datum *last, *datum = NULL;
> @@ -2000,7 +2000,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
>   	return rc;
>   }
>   
> -static int filename_trans_read_helper(struct policydb *p, void *fp)
> +static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp)
>   {
>   	struct filename_trans_key *ft = NULL;
>   	struct filename_trans_datum **dst, *datum, *first = NULL;
> @@ -2089,7 +2089,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
>   	return rc;
>   }
>   
> -static int filename_trans_read(struct policydb *p, void *fp)
> +static int filename_trans_read(struct policydb *p, struct policy_file *fp)
>   {
>   	u32 nel, i;
>   	__le32 buf[1];
> @@ -2130,7 +2130,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
>   	return 0;
>   }
>   
> -static int genfs_read(struct policydb *p, void *fp)
> +static int genfs_read(struct policydb *p, struct policy_file *fp)
>   {
>   	int rc;
>   	u32 i, j, nel, nel2, len, len2;
> @@ -2244,7 +2244,7 @@ static int genfs_read(struct policydb *p, void *fp)
>   }
>   
>   static int ocontext_read(struct policydb *p,
> -			 const struct policydb_compat_info *info, void *fp)
> +			 const struct policydb_compat_info *info, struct policy_file *fp)
>   {
>   	int rc;
>   	unsigned int i;
> @@ -2441,7 +2441,7 @@ static int ocontext_read(struct policydb *p,
>    * Read the configuration data from a policy database binary
>    * representation file into a policy database structure.
>    */
> -int policydb_read(struct policydb *p, void *fp)
> +int policydb_read(struct policydb *p, struct policy_file *fp)
>   {
>   	struct role_allow *ra, *lra;
>   	struct role_trans_key *rtk = NULL;
> @@ -2764,7 +2764,7 @@ int policydb_read(struct policydb *p, void *fp)
>    * Write a MLS level structure to a policydb binary
>    * representation file.
>    */
> -static int mls_write_level(struct mls_level *l, void *fp)
> +static int mls_write_level(struct mls_level *l, struct policy_file *fp)
>   {
>   	__le32 buf[1];
>   	int rc;
> @@ -2785,7 +2785,7 @@ static int mls_write_level(struct mls_level *l, void *fp)
>    * Write a MLS range structure to a policydb binary
>    * representation file.
>    */
> -static int mls_write_range_helper(struct mls_range *r, void *fp)
> +static int mls_write_range_helper(struct mls_range *r, struct policy_file *fp)
>   {
>   	__le32 buf[3];
>   	size_t items;
> @@ -2825,7 +2825,7 @@ static int sens_write(void *vkey, void *datum, void *ptr)
>   	char *key = vkey;
>   	struct level_datum *levdatum = datum;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	__le32 buf[2];
>   	size_t len;
>   	int rc;
> @@ -2853,7 +2853,7 @@ static int cat_write(void *vkey, void *datum, void *ptr)
>   	char *key = vkey;
>   	struct cat_datum *catdatum = datum;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	__le32 buf[3];
>   	size_t len;
>   	int rc;
> @@ -2878,7 +2878,7 @@ static int role_trans_write_one(void *key, void *datum, void *ptr)
>   	struct role_trans_key *rtk = key;
>   	struct role_trans_datum *rtd = datum;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	struct policydb *p = pd->p;
>   	__le32 buf[3];
>   	int rc;
> @@ -2898,7 +2898,7 @@ static int role_trans_write_one(void *key, void *datum, void *ptr)
>   	return 0;
>   }
>   
> -static int role_trans_write(struct policydb *p, void *fp)
> +static int role_trans_write(struct policydb *p, struct policy_file *fp)
>   {
>   	struct policy_data pd = { .p = p, .fp = fp };
>   	__le32 buf[1];
> @@ -2912,7 +2912,7 @@ static int role_trans_write(struct policydb *p, void *fp)
>   	return hashtab_map(&p->role_tr, role_trans_write_one, &pd);
>   }
>   
> -static int role_allow_write(struct role_allow *r, void *fp)
> +static int role_allow_write(struct role_allow *r, struct policy_file *fp)
>   {
>   	struct role_allow *ra;
>   	__le32 buf[2];
> @@ -2940,7 +2940,7 @@ static int role_allow_write(struct role_allow *r, void *fp)
>    * Write a security context structure
>    * to a policydb binary representation file.
>    */
> -static int context_write(struct policydb *p, struct context *c, void *fp)
> +static int context_write(struct policydb *p, struct context *c, struct policy_file *fp)
>   {
>   	int rc;
>   	__le32 buf[3];
> @@ -2993,7 +2993,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
>   	char *key = vkey;
>   	struct common_datum *comdatum = datum;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	__le32 buf[4];
>   	size_t len;
>   	int rc;
> @@ -3018,7 +3018,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
>   	return 0;
>   }
>   
> -static int type_set_write(struct type_set *t, void *fp)
> +static int type_set_write(struct type_set *t, struct policy_file *fp)
>   {
>   	int rc;
>   	__le32 buf[1];
> @@ -3037,7 +3037,7 @@ static int type_set_write(struct type_set *t, void *fp)
>   }
>   
>   static int write_cons_helper(struct policydb *p, struct constraint_node *node,
> -			     void *fp)
> +			     struct policy_file *fp)
>   {
>   	struct constraint_node *c;
>   	struct constraint_expr *e;
> @@ -3088,7 +3088,7 @@ static int class_write(void *vkey, void *datum, void *ptr)
>   	char *key = vkey;
>   	struct class_datum *cladatum = datum;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	struct policydb *p = pd->p;
>   	struct constraint_node *c;
>   	__le32 buf[6];
> @@ -3173,7 +3173,7 @@ static int role_write(void *vkey, void *datum, void *ptr)
>   	char *key = vkey;
>   	struct role_datum *role = datum;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	struct policydb *p = pd->p;
>   	__le32 buf[3];
>   	size_t items, len;
> @@ -3213,7 +3213,7 @@ static int type_write(void *vkey, void *datum, void *ptr)
>   	struct type_datum *typdatum = datum;
>   	struct policy_data *pd = ptr;
>   	struct policydb *p = pd->p;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	__le32 buf[4];
>   	int rc;
>   	size_t items, len;
> @@ -3254,7 +3254,7 @@ static int user_write(void *vkey, void *datum, void *ptr)
>   	struct user_datum *usrdatum = datum;
>   	struct policy_data *pd = ptr;
>   	struct policydb *p = pd->p;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	__le32 buf[3];
>   	size_t items, len;
>   	int rc;
> @@ -3439,7 +3439,7 @@ static int ocontext_write(struct policydb *p,
>   	return 0;
>   }
>   
> -static int genfs_write(struct policydb *p, void *fp)
> +static int genfs_write(struct policydb *p, struct policy_file *fp)
>   {
>   	struct genfs *genfs;
>   	struct ocontext *c;
> @@ -3497,7 +3497,7 @@ static int range_write_helper(void *key, void *data, void *ptr)
>   	struct range_trans *rt = key;
>   	struct mls_range *r = data;
>   	struct policy_data *pd = ptr;
> -	void *fp = pd->fp;
> +	struct policy_file *fp = pd->fp;
>   	struct policydb *p = pd->p;
>   	int rc;
>   
> @@ -3519,7 +3519,7 @@ static int range_write_helper(void *key, void *data, void *ptr)
>   	return 0;
>   }
>   
> -static int range_write(struct policydb *p, void *fp)
> +static int range_write(struct policydb *p, struct policy_file *fp)
>   {
>   	__le32 buf[1];
>   	int rc;
> @@ -3546,7 +3546,7 @@ static int filename_write_helper_compat(void *key, void *data, void *ptr)
>   	struct filename_trans_key *ft = key;
>   	struct filename_trans_datum *datum = data;
>   	struct ebitmap_node *node;
> -	void *fp = ptr;
> +	struct policy_file *fp = ptr;
>   	__le32 buf[4];
>   	int rc;
>   	u32 bit, len = strlen(ft->name);
> @@ -3583,7 +3583,7 @@ static int filename_write_helper(void *key, void *data, void *ptr)
>   {
>   	struct filename_trans_key *ft = key;
>   	struct filename_trans_datum *datum;
> -	void *fp = ptr;
> +	struct policy_file *fp = ptr;
>   	__le32 buf[3];
>   	int rc;
>   	u32 ndatum, len = strlen(ft->name);
> @@ -3628,7 +3628,7 @@ static int filename_write_helper(void *key, void *data, void *ptr)
>   	return 0;
>   }
>   
> -static int filename_trans_write(struct policydb *p, void *fp)
> +static int filename_trans_write(struct policydb *p, struct policy_file *fp)
>   {
>   	__le32 buf[1];
>   	int rc;
> @@ -3660,7 +3660,7 @@ static int filename_trans_write(struct policydb *p, void *fp)
>    * structure to a policy database binary representation
>    * file.
>    */
> -int policydb_write(struct policydb *p, void *fp)
> +int policydb_write(struct policydb *p, struct policy_file *fp)
>   {
>   	unsigned int num_syms;
>   	int rc;
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 5c11069121d3..985f319e2266 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -318,8 +318,14 @@ extern int policydb_context_isvalid(struct policydb *p, struct context *c);
>   extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
>   extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
>   extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
> -extern int policydb_read(struct policydb *p, void *fp);
> -extern int policydb_write(struct policydb *p, void *fp);
> +
> +struct policy_file {
> +	char *data;
> +	size_t len;
> +};
> +
> +extern int policydb_read(struct policydb *p, struct policy_file *fp);
> +extern int policydb_write(struct policydb *p, struct policy_file *fp);

nit: It feels weird to me to have the struct definition break up the 
policydb_*() declarations like this.  I feel as though the file scans 
more cleanly if the policy_file struct definition is directly below the 
policydb struct definition, keeping the policydb_*() functions all together.

>   
>   extern struct filename_trans_datum *
>   policydb_filenametr_search(struct policydb *p, struct filename_trans_key *key);
> @@ -342,14 +348,9 @@ policydb_roletr_search(struct policydb *p, struct role_trans_key *key);
>   #define POLICYDB_MAGIC	SELINUX_MAGIC
>   #define POLICYDB_STRING "SE Linux"
>   
> -struct policy_file {
> -	char *data;
> -	size_t len;
> -};
> -
>   struct policy_data {
>   	struct policydb *p;
> -	void *fp;
> +	struct policy_file *fp;
>   };
>   
>   static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)

