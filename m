Subject: Re: [PATCH] libsepol: fix invalid read when policy file is corrupt
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
References: <1470674654-13930-1-git-send-email-william.c.roberts@intel.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <95d5e15c-24b4-77d0-bdc3-6917aadca085@tycho.nsa.gov>
Date: Tue, 9 Aug 2016 16:23:23 -0400
MIME-Version: 1.0
In-Reply-To: <1470674654-13930-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/08/2016 12:44 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> AFL Found this bug:
> ==6523== Invalid read of size 8
> ==6523==    at 0x4166B4: type_set_expand (expand.c:2508)
> ==6523==    by 0x43A0B8: policydb_role_cache (policydb.c:790)
> ==6523==    by 0x41CD70: hashtab_map (hashtab.c:235)
> ==6523==    by 0x43AC9E: policydb_index_others (policydb.c:1103)
> ==6523==    by 0x441B14: policydb_read (policydb.c:3888)
> ==6523==    by 0x442A1F: sepol_policydb_read (policydb_public.c:174)
> ==6523==    by 0x407ED4: init (check_seapp.c:885)
> ==6523==    by 0x408D97: main (check_seapp.c:1231)
>
> This occurs when the type_val_to_struct[] mapping array
> doesn't contain the type indicated in the ebitmap.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Applied.

Thanks,
Jim

> ---
>  libsepol/src/expand.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 9cb7965..4d3c623 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2505,6 +2505,14 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
>  		/* First go through the types and OR all the attributes to types */
>  		ebitmap_for_each_bit(&set->types, tnode, i) {
>  			if (ebitmap_node_get_bit(tnode, i)) {
> +
> +				/*
> +				 * invalid policies might have more types set in the ebitmap than
> +				 * what's available in the type_val_to_struct mapping
> +				 */
> +				if (i > p->p_types.nprim - 1)
> +						return -1;
> +
>  				if (p->type_val_to_struct[i]->flavor ==
>  				    TYPE_ATTRIB) {
>  					if (ebitmap_union
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
