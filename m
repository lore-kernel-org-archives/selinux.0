Subject: Re: [PATCH 2/3] libsepol/cil: add ioctl whitelist support
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1440788386-17637-1-git-send-email-slawrence@tresys.com>
 <1440788386-17637-3-git-send-email-slawrence@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55E0C1D8.6070209@tycho.nsa.gov>
Date: Fri, 28 Aug 2015 16:17:28 -0400
MIME-Version: 1.0
In-Reply-To: <1440788386-17637-3-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/28/2015 02:59 PM, Steve Lawrence wrote:

...

> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 6d095db..1439581 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c

...

> @@ -3162,6 +3444,9 @@ int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
>   				}
>   			}
>   			break;
> +		case CIL_AVRULEX:
> +			rc = cil_avrulex_to_hashtable(pdb, db, node->data, args);
> +			break;
>   		case CIL_ROLEALLOW:
>   			rc = cil_roleallow_to_policydb(pdb, db, node->data);
>   			break;
> @@ -3595,6 +3880,58 @@ static int role_trans_compare(hashtab_t h
>   	return a->role != b->role || a->type != b->type || a->tclass != b->tclass;
>   }
>
> +/* Based on MurmurHash3, written by Austin Appleby and placed in the
> + * public domain.
> + */
> +static unsigned int avrulex_hash(hashtab_t h, hashtab_key_t key)
> +{

Doesn't compile without DEBUG=1 because h is unused in this function.

Also, all three patches have some whitespace issues.

Finally, some CIL test policy would be nice. You could add it to policy.cil or 
create a new one starting with minimum.cil.

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
