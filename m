Subject: Re: [PATCH 1/2] libsepol: Only apply bounds checking to source types
 in rules
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1461873759-29136-1-git-send-email-sds@tycho.nsa.gov>
Cc: jwcart2@tycho.ns.gov
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5723B8EE.9060001@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 15:41:34 -0400
MIME-Version: 1.0
In-Reply-To: <1461873759-29136-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/28/2016 04:02 PM, Stephen Smalley wrote:
> The current bounds checking of both source and target types
> requires allowing any domain that has access to the child domain
> to also have the same permissions to the parent, which is undesirable.
> Drop the target bounds checking.
>
> Making this change fully functional requires a corresponding kernel
> change; this change only allows one to build policies that would
> otherwise violate the bounds checking on target type.  The kernel
> change is required to allow the permissions at runtime.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   libsepol/src/hierarchy.c | 26 --------------------------
>   1 file changed, 26 deletions(-)
>
> diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> index 6f73195..ba65978 100644
> --- a/libsepol/src/hierarchy.c
> +++ b/libsepol/src/hierarchy.c
> @@ -329,32 +329,6 @@ static int bounds_check_rule(sepol_handle_t *handle, policydb_t *p,
>   			if (rc) goto exit;
>   		}
>   	}
> -	if (ebitmap_get_bit(&p->attr_type_map[tgt - 1], child - 1)) {
> -		avtab_key.target_type = parent;
> -		ebitmap_for_each_bit(&p->attr_type_map[src - 1], tnode, i) {
> -			if (!ebitmap_node_get_bit(tnode, i))
> -				continue;
> -			avtab_key.source_type = i + 1;
> -			if (avtab_key.source_type == child) {
> -				/* Checked above */
> -				continue;
> -			}
> -			d = bounds_not_covered(global_avtab, cur_avtab,
> -					       &avtab_key, data);
> -			if (!d) continue;
> -			td = p->type_val_to_struct[i];
> -			if (td && td->bounds) {
> -				avtab_key.source_type = td->bounds;
> -				d = bounds_not_covered(global_avtab, cur_avtab,
> -						       &avtab_key, data);
> -				if (!d) continue;
> -			}
> -			(*numbad)++;
> -			rc = bounds_add_bad(handle, i+1, child, class, d, bad);
> -			if (rc) goto exit;
> -		}
> -	}
> -
>   exit:
>   	return rc;
>   }
>

We also don't need to expand the tgt. I will send a new and improved patch.

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
