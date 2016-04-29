Subject: Re: [PATCH 2/2] libsepol: fix type bounds checking for attributes
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1461873759-29136-1-git-send-email-sds@tycho.nsa.gov>
 <1461873759-29136-2-git-send-email-sds@tycho.nsa.gov>
Cc: jwcart2@tycho.ns.gov
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <5723977A.6080306@tycho.nsa.gov>
Date: Fri, 29 Apr 2016 13:18:50 -0400
MIME-Version: 1.0
In-Reply-To: <1461873759-29136-2-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/28/2016 04:02 PM, Stephen Smalley wrote:
> The type bounds / hierarchy checker was incorrectly handling
> rules with attributes as the target type, causing it to trigger
> violations if the parent type lacked a rule directly to the same
> attribute even if the parent had all the permissions to the
> types associated with that attribute.  Skip the degenerate
> case and only check for the individual types.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   libsepol/src/hierarchy.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> index ba65978..79db3a6 100644
> --- a/libsepol/src/hierarchy.c
> +++ b/libsepol/src/hierarchy.c
> @@ -318,6 +318,8 @@ static int bounds_check_rule(sepol_handle_t *handle, policydb_t *p,
>   					       &avtab_key, data);
>   			if (!d) continue;
>   			td = p->type_val_to_struct[i];
> +			if (!td || td->flavor == TYPE_ATTRIB)
> +				continue;
>   			if (td && td->bounds) {
>   				avtab_key.target_type = td->bounds;
>   				d = bounds_not_covered(global_avtab, cur_avtab,
>

There shouldn't be any attributes here. CIL is wrongly including the attribute 
itself in the attr_type_map. Patch coming.

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
