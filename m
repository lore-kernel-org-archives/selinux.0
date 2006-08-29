Subject: Re: [PATCH 2/3] semantic MLS representation for range_trans_rules
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
In-Reply-To: <44F3192B.2000408@trustedcs.com>
References: <44F3192B.2000408@trustedcs.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:36:58 -0400
Message-Id: <1156880218.380.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-28 at 11:26 -0500, Darrel Goeddel wrote:
> Introduce a semantic representation for MLS levels and ranges to be used in
> modular policy formats.  This will allow expansion of levels such as "s0:c1.c5"
> to happen at module expansion time.  The range_trans_rules were updated to use
> this new semantic format.
> 
> All range_transitions are now represented as range_trans_rules when in a modular
> format (old range_trans structs are converted when the policy is read).  The
> semantic rules are expanded along with other rules when the module is expanded.
> 
> The ebitmap used for classes in the range_trans_rules has also been fixed to use
> the standard "value - 1" indexing.
> 
> 
> Signed-off-by:  Darrel Goeddel <dgoeddel@trustedcs.com>
> 
> 
>  checkpolicy/policy_parse.y                  |   76 ++++++++++--
>  libsepol/include/sepol/policydb/expand.h    |    4
>  libsepol/include/sepol/policydb/mls_types.h |   94 ++++++++++++++
>  libsepol/include/sepol/policydb/policydb.h  |    2
>  libsepol/src/expand.c                       |  159 +++++++++++++------------
>  libsepol/src/policydb.c                     |  176 +++++++++++++++++++++++++++-
>  libsepol/src/write.c                        |   51 +++++++-
>  7 files changed, 469 insertions(+), 93 deletions(-)
> 

<snip>

> +
> +static inline void mls_semantic_level_init(mls_semantic_level_t *l)
> +{
> +	memset(l, 0, sizeof(mls_semantic_level_t));
> +}
> +
> +static inline void mls_semantic_level_destroy(mls_semantic_level_t *l)
> +{
> +	mls_semantic_cat_t *cur, *next;
> +
> +	if (l == NULL)
> +		return;
> +
> +	next = l->cat;
> +	while (next) {
> +		cur = next;
> +		next = cur->next;
> +		free(cur);
> +	}
> +}
> +
> +static inline int mls_semantic_level_cpy(mls_semantic_level_t *dst,
> +                                         mls_semantic_level_t *src)
> +{
> +	mls_semantic_cat_t *cat, *newcat, *lnewcat = NULL;
> +
> +	mls_semantic_level_init(dst);
> +	dst->sens = src->sens;
> +	cat = src->cat;
> +	while (cat) {
> +		newcat = (mls_semantic_cat_t *)calloc(1,
> +		                                    sizeof(mls_semantic_cat_t));
> +		if (!newcat)
> +			goto err;
> +
> +		if (lnewcat)
> +			lnewcat->next = newcat;
> +		else
> +			dst->cat = newcat;
> +
> +		newcat->low = cat->low;
> +		newcat->high = cat->high;
> +
> +		lnewcat = newcat;
> +		cat = cat->next;
> +	}
> +	return 0;
> +
> +err:
> +	mls_semantic_level_destroy(dst);
> +	return -1;
> +}
> +
> +static inline void mls_semantic_range_init(mls_semantic_range_t *r)
> +{
> +	mls_semantic_level_init(&r->level[0]);
> +	mls_semantic_level_init(&r->level[1]);
> +}
> +
> +static inline void mls_semantic_range_destroy(mls_semantic_range_t *r)
> +{
> +	mls_semantic_level_destroy(&r->level[0]);
> +	mls_semantic_level_destroy(&r->level[1]);
> +}
> +
> +static inline int mls_semantic_range_cpy(mls_semantic_range_t *dst,
> +                                         mls_semantic_range_t *src)
> +{
> +	if (mls_semantic_level_cpy(&dst->level[0], &src->level[0]) < 0)
> +		return -1;
> +
> +	if (mls_semantic_level_cpy(&dst->level[1], &src->level[1]) < 0) {
> +		mls_semantic_level_destroy(&dst->level[0]);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +

Why are these inlined?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
