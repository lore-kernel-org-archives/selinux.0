Subject: Re: [PATCH v2 1/1] libsepol/cil: create user and role caches when
 building binary policy
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
References: <cover.1475494730.git.gary.tierney@gmx.com>
 <357ffe964dc8190d1945d6147e241bce587a0004.1475494730.git.gary.tierney@gmx.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <29d2d67a-ddb8-019c-ec5c-c8e2d1eef704@tycho.nsa.gov>
Date: Mon, 3 Oct 2016 15:11:17 -0400
MIME-Version: 1.0
In-Reply-To: <357ffe964dc8190d1945d6147e241bce587a0004.1475494730.git.gary.tierney@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/03/2016 07:44 AM, Gary Tierney wrote:
> Pre-expands the role and user caches used in context validation when
> conerting a cildb to a binary policydb.  This is currently only done
> when loading a binary policy and prevents context validation from
> working correctly with a newly built policy (i.e., when semanage builds
> a new policy and then runs genhomedircon).
>
> Also adds declarations for the hashtable mapping functions used:
> policydb_role_cache and policydb_user_cache().
>
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>

Applied.

Thanks,
Jim

> ---
>  libsepol/cil/src/cil_binary.c              | 13 +++++++++++++
>  libsepol/include/sepol/policydb/policydb.h |  8 ++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index cc73648..5402272 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -4794,6 +4794,19 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
>
>  	}
>
> +	/* This pre-expands the roles and users for context validity checking */
> +	if (hashtab_map(pdb->p_roles.table, policydb_role_cache, pdb)) {
> +		cil_log(CIL_INFO, "Failure creating roles cache");
> +		rc = SEPOL_ERR;
> +		goto exit;
> +    }
> +
> +	if (hashtab_map(pdb->p_users.table, policydb_user_cache, pdb)) {
> +		cil_log(CIL_INFO, "Failure creating users cache");
> +		rc = SEPOL_ERR;
> +		goto exit;
> +	}
> +
>  	rc = SEPOL_OK;
>
>  exit:
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
> index 26cec13..d99fcf4 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -608,6 +608,14 @@ extern int policydb_index_bools(policydb_t * p);
>  extern int policydb_index_others(sepol_handle_t * handle, policydb_t * p,
>  				 unsigned int verbose);
>
> +extern int policydb_role_cache(hashtab_key_t key,
> +			       hashtab_datum_t datum,
> +			       void *arg);
> +
> +extern int policydb_user_cache(hashtab_key_t key,
> +			       hashtab_datum_t datum,
> +			       void *arg);
> +
>  extern int policydb_reindex_users(policydb_t * p);
>
>  extern void policydb_destroy(policydb_t * p);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
