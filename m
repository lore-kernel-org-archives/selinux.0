Message-ID: <5568702E.2070805@tycho.nsa.gov>
Date: Fri, 29 May 2015 09:57:02 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libsepol: with pp to CIL, always write auditadm_r
 and secadm_r roles to the base module
References: <1432316069-24113-1-git-send-email-slawrence@tresys.com>
 <1432316069-24113-2-git-send-email-slawrence@tresys.com>
In-Reply-To: <1432316069-24113-2-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/22/2015 01:34 PM, Steve Lawrence wrote:
> In fedora and refpolicy, the auditadm_r and secadm_r roles can be in
> either the base module or a non-base module, or they could be in both.
> This means that it is possible for duplicate role declarations to exist.
> CIL does not allow duplicate declarations of anything, but there is no
> way for the pp compiler to know if the roles are declared in which
> module, or if they are in both when compiling a single module. This
> means we cannot use the same hack that we use for user_r, staff_r, etc.,
> to generate CIL role declarations (i.e. only create role declarations
> for these when defined in base).
>
> So only for these two roles, always declare them as part of base,
> regardless of where or if they are defined. This means that turning off
> the auditadm module will never remove the auditamd_r role (likewise for
> secadm), whereas right now, in some cases it would. This also means that
> role allow rules will still exist for these roles even with the modules
> removed. However, this is okay because the roles would not have any
> types associated with them so no access would be allowed.
>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
> Reported-by: Miroslav Grepl <mgrepl@redhat.com>

Thanks, applied.

> ---
>   libsepol/src/module_to_cil.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 1ded21d..2d8046c 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2035,12 +2035,22 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
>   			// one of these roles in base, the declaration will not appeaer in
>   			// the resulting policy, likely resulting in a compilation error in
>   			// CIL.
> +			//
> +			// To make things more complicated, the auditadm_r and secadm_r
> +			// roles could actually be in either the base module or a non-base
> +			// module, or both. So we can't rely on this same behavior. So for
> +			// these roles, don't declare them here, even if they are in a base
> +			// or non-base module. Instead we will just declare them in the
> +			// base module elsewhere.
>   			int is_base_role = (!strcmp(key, "user_r") ||
>   			                    !strcmp(key, "staff_r") ||
>   			                    !strcmp(key, "sysadm_r") ||
>   			                    !strcmp(key, "system_r") ||
>   			                    !strcmp(key, "unconfined_r"));
> -			if ((is_base_role && pdb->policy_type == SEPOL_POLICY_BASE) || !is_base_role) {
> +			int is_builtin_role = (!strcmp(key, "auditadm_r") ||
> +			                       !strcmp(key, "secadm_r"));
> +			if ((is_base_role && pdb->policy_type == SEPOL_POLICY_BASE) ||
> +			    (!is_base_role && !is_builtin_role)) {
>   				cil_println(indent, "(role %s)", key);
>   			}
>   		}
> @@ -3717,6 +3727,17 @@ static int generate_default_object(void)
>   	return 0;
>   }
>
> +static int generate_builtin_roles(void)
> +{
> +	// due to inconsistentencies between policies and CIL not allowing
> +	// duplicate roles, some roles are always created, regardless of if they
> +	// are declared in modules or not
> +	cil_println(0, "(role auditadm_r)");
> +	cil_println(0, "(role secadm_r)");
> +
> +	return 0;
> +}
> +
>   static int generate_gen_require_attribute(void)
>   {
>   	cil_println(0, "(typeattribute " GEN_REQUIRE_ATTR ")");
> @@ -3801,6 +3822,11 @@ int sepol_module_policydb_to_cil(FILE *fp, struct policydb *pdb, int linked)
>   			goto exit;
>   		}
>
> +		rc = generate_builtin_roles();
> +		if (rc != 0) {
> +			goto exit;
> +		}
> +
>   		// default attribute to be used to mimic gen_require in CIL
>   		rc = generate_gen_require_attribute();
>   		if (rc != 0) {
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
