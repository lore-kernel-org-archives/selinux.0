Subject: Re: [PATCH 2/3] semantic MLS representation for range_trans_rules
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
In-Reply-To: <44F3192B.2000408@trustedcs.com>
References: <44F3192B.2000408@trustedcs.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:37:01 -0400
Message-Id: <1156880221.8075.9.camel@twoface.columbia.tresys.com>
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
> diff --exclude=.svn -ruNp selinux-list/checkpolicy/policy_parse.y selinux-rangetrans/checkpolicy/policy_parse.y
> --- selinux-list/checkpolicy/policy_parse.y	2006-08-25 06:16:11.000000000 -0500
> +++ selinux-rangetrans/checkpolicy/policy_parse.y	2006-08-24 14:08:31.000000000 -0500
> @@ -3616,6 +3616,64 @@ parse_categories(char *id, level_datum_t
>  	return 0;
>  }
>  
> +static int
> +parse_semantic_categories(char *id, level_datum_t * levdatum,
> +                          mls_semantic_cat_t ** cats)
> +{
> +	cat_datum_t *cdatum;
> +	mls_semantic_cat_t *newcat;
> +	unsigned int range_start, range_end;
> +
> +	if (id_has_dot(id)) {
> +		char *id_start = id;
> +		char *id_end = strchr(id, '.');
> +
> +		*(id_end++) = '\0';
> +
> +		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
> +							(hashtab_key_t)
> +							id_start);
> +		if (!cdatum) {
> +			sprintf(errormsg, "unknown category %s", id_start);
> +			yyerror(errormsg);
> +			return -1;
> +		}
> +		range_start = cdatum->s.value;
> +
> +		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
> +							(hashtab_key_t) id_end);
> +		if (!cdatum) {
> +			sprintf(errormsg, "unknown category %s", id_end);
> +			yyerror(errormsg);
> +			return -1;
> +		}
> +		range_end = cdatum->s.value;
> +	} else {
> +		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
> +							(hashtab_key_t) id);
> +		if (!cdatum) {
> +			sprintf(errormsg, "unknown category %s", id);
> +			yyerror(errormsg);
> +			return -1;
> +		}
> +		range_start = range_end = cdatum->s.value;
> +	}
> +
> +	newcat = (mls_semantic_cat_t *) calloc(1, sizeof(mls_semantic_cat_t));
> +	if (!newcat) {
> +		yyerror("out of memory");
> +		return -1;
> +	}
> +
> +	newcat->next = *cats;
> +	newcat->low = range_start;
> +	newcat->high = range_end;
> +

mls_semantic_cat_init?

> +

Otherwise looks fine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
