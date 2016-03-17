Subject: Re: [PATCH] libsepol/cil: fix bug when resetting class permission
 values
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1458242991-25215-1-git-send-email-slawrence@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <56EB0EA6.7050706@tycho.nsa.gov>
Date: Thu, 17 Mar 2016 16:08:06 -0400
MIME-Version: 1.0
In-Reply-To: <1458242991-25215-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/17/2016 03:29 PM, Steve Lawrence wrote:
> During resolution of classcommon statements (cil_resolve_classcommon),
> we add the number of class common permissions to the values of the class
> permissions. This way, the internal CIL values of the common permission
> go from 0 to N, and the values of class permissions start at N+1 (where
> N is the number of common permissions). When we reset a class due to
> reresolve (cil_reset_class), we must then reverse this process by
> subtracting the number of common permissions from the class permission
> values.
>
> However, there is a bug when resetting classes in which we subtract the
> number of common permissions from the common permissions value rather
> than the class permissions value. This means that class permissions
> could be too high (since they are not reduced on reset) and common
> permissions underflowed (since they are reduced, but should not be).
>
> In most cases, this didn't actually matter since these permission values
> aren't used when creating the binary. Additionally, we always access the
> permissions via a hash table lookup or map, and then use whatever value
> they have to set bits in bitmaps. As long as the bits in the bitmap
> match the values, things work as expected. However, the one case where
> these values do matter is if you use 'all' in a class permission set. In
> this case, we enable bits 0 through number of permissions in a bitmap.
> But because our permission values are all mixed up, these enabled bits
> do not correspond to the permission values. This results in making it
> look like no permissions were set in a class permission set, and the
> rule is essentially ignored.
>
> This patch fixes the bug so that the values of class permissions are
> properly reset, allowing one to use 'all' in class permission sets in a
> policy that reresolves.
>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>

Applied.

Thanks.

> ---
>   libsepol/cil/src/cil_reset_ast.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
> index 06146ca..de00679 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -23,7 +23,7 @@ static void cil_reset_class(struct cil_class *class)
>   {
>   	if (class->common != NULL) {
>   		struct cil_class *common = class->common;
> -		cil_symtab_map(&common->perms, __class_reset_perm_values, &common->num_perms);
> +		cil_symtab_map(&class->perms, __class_reset_perm_values, &common->num_perms);
>   		/* during a re-resolve, we need to reset the common, so a classcommon
>   		 * statement isn't seen as a duplicate */
>   		class->num_perms -= common->num_perms;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
