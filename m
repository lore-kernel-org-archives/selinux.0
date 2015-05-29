Message-ID: <5568701C.7010101@tycho.nsa.gov>
Date: Fri, 29 May 2015 09:56:44 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] libsepol: with pp to CIL, only associate declared
 roleattributes with in-scope types
References: <1432316069-24113-1-git-send-email-slawrence@tresys.com>
In-Reply-To: <1432316069-24113-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/22/2015 01:34 PM, Steve Lawrence wrote:
> When a roleattribute is in a declared scope, CIL roletype statements are
> generated for all types associated with it. This incorrectly includes
> types that are associated with the roleattribute in optional blocks,
> which can result in CIL resolution failures if the optional block is
> turned off due to a missing type. So, change the roletype CIL statement
> generation with roleattributes to mimic the behavior of roles, ensuring
> declared roleattributes are only associated with in-scope types.
>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
> Reported-by: Miroslav Grepl <mgrepl@redhat.com>

Thanks, applied.

> ---
>   libsepol/src/module_to_cil.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 8d16d3e..1ded21d 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -2091,7 +2091,9 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
>
>
>   		for (i = 0; i < num_types; i++) {
> -			cil_println(indent, "(roletype %s %s)", key, types[i]);
> +			if (is_id_in_scope(pdb, decl_stack, types[i], SYM_TYPES)) {
> +				cil_println(indent, "(roletype %s %s)", key, types[i]);
> +			}
>   		}
>
>   		break;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
