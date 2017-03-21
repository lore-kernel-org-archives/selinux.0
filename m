Subject: Re: [PATCH 1/1] libsepol/cil: make reporting conflicting type
 transitions work
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170317210526.6813-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5b62a204-902f-21e0-dbcf-74aadb2147f6@tycho.nsa.gov>
Date: Tue, 21 Mar 2017 14:28:28 -0400
MIME-Version: 1.0
In-Reply-To: <20170317210526.6813-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/17/2017 05:05 PM, Nicolas Iooss wrote:
> When compiling a CIL policy which defines conflicting type transitions,
> secilc crashes when trying to format an error message with uninitialized
> values. This is caused by __cil_typetransition_to_avtab() not
> initializing the ..._str fields of its local variable "struct
> cil_type_rule trans" before calling __cil_type_rule_to_avtab().
>
> While at it, make the error report clearer about what is wrong by
> showing the types and classes which got expanded in
> __cil_type_rule_to_avtab(). Here is an example of the result:
>
>     Conflicting type rules (scontext=testuser_emacs.subj
>     tcontext=fs.tmpfs.fs tclass=dir
>     result=users.generic_tmpfs.user_tmpfs_file),
>     existing=emacs.tmpfs.user_tmpfs_file
>
>     Expanded from type rule (scontext=ARG1 tcontext=fs tclass=ARG3
>     result=ARG2)
>
> Reported-By: Dominick Grift <dac.override@gmail.com>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,
Jim

> ---
>  libsepol/cil/src/cil_binary.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index ac371aef7b2d..ac18c4e2ee5d 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1018,7 +1018,14 @@ int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_
>  		 * non-duplicate rule using the same key.
>  		 */
>  		if (existing->datum.data != res) {
> -			cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s)\n", cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
> +			cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s), existing=%s\n",
> +				pdb->p_type_val_to_name[src - 1],
> +				pdb->p_type_val_to_name[tgt - 1],
> +				pdb->p_class_val_to_name[obj - 1],
> +				pdb->p_type_val_to_name[res - 1],
> +				pdb->p_type_val_to_name[existing->datum.data - 1]);
> +			cil_log(CIL_ERR, "Expanded from type rule (scontext=%s tcontext=%s tclass=%s result=%s)\n",
> +				cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
>  			rc = SEPOL_ERR;
>  		}
>  		goto exit;
> @@ -1044,7 +1051,14 @@ int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src, uint32_
>  			search_datum = cil_cond_av_list_search(&avtab_key, other_list);
>  			if (search_datum == NULL) {
>  				if (existing->datum.data != res) {
> -					cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s)\n", cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
> +					cil_log(CIL_ERR, "Conflicting type rules (scontext=%s tcontext=%s tclass=%s result=%s), existing=%s\n",
> +						pdb->p_type_val_to_name[src - 1],
> +						pdb->p_type_val_to_name[tgt - 1],
> +						pdb->p_class_val_to_name[obj - 1],
> +						pdb->p_type_val_to_name[res - 1],
> +						pdb->p_type_val_to_name[existing->datum.data - 1]);
> +					cil_log(CIL_ERR, "Expanded from type rule (scontext=%s tcontext=%s tclass=%s result=%s)\n",
> +						cil_rule->src_str, cil_rule->tgt_str, cil_rule->obj_str, cil_rule->result_str);
>  					rc = SEPOL_ERR;
>  					goto exit;
>  				}
> @@ -1146,6 +1160,10 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
>  		trans.tgt = typetrans->tgt;
>  		trans.obj = typetrans->obj;
>  		trans.result = typetrans->result;
> +		trans.src_str = typetrans->src_str;
> +		trans.tgt_str = typetrans->tgt_str;
> +		trans.obj_str = typetrans->obj_str;
> +		trans.result_str = typetrans->result_str;
>  		return __cil_type_rule_to_avtab(pdb, db, &trans, cond_node, cond_flavor);
>  	}
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
