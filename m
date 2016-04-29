Subject: Re: [PATCH] libsepol/cil: Do not add an attribute as a type in the
 attr_type_map
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1461952039-18483-1-git-send-email-jwcart2@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5acf1c2c-3472-e747-071b-5641389e3a69@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 14:26:28 -0400
MIME-Version: 1.0
In-Reply-To: <1461952039-18483-1-git-send-email-jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2016 01:47 PM, James Carter wrote:
> The attribute to type map is used to get all of the types that are
> asociated with an attribute. To make neverallow and bounds checking
> easier it was convienent to map a type to itself. However, CIL was
> wrongly mapping an attribute to itself in addition to the types
> associated with it. This caused type bounds checking to fail if the
> parent was granted a permission through one attribute while the child
> was granted the permission through another attribute.
> 
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  libsepol/cil/src/cil_binary.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index b8437c9..1cd12d2 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -609,9 +609,11 @@ int __cil_typeattr_bitmap_init(policydb_t *pdb)
>  			rc = SEPOL_ERR;
>  			goto exit;
>  		}
> -		if (ebitmap_set_bit(&pdb->attr_type_map[i], i, 1)) {
> -			rc = SEPOL_ERR;
> -			goto exit;
> +		if (pdb->type_val_to_struct[i] && pdb->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
> +			if (ebitmap_set_bit(&pdb->attr_type_map[i], i, 1)) {
> +				rc = SEPOL_ERR;
> +				goto exit;
> +			}
>  		}
>  
>  	}
> 
