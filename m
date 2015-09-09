Subject: Re: [PATCH] libsepol/cil: fix NULL pointer dereference when copying
 classpermission/set
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1441825769-18936-1-git-send-email-slawrence@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55F08BE8.6030107@tycho.nsa.gov>
Date: Wed, 9 Sep 2015 15:43:36 -0400
MIME-Version: 1.0
In-Reply-To: <1441825769-18936-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/09/2015 03:09 PM, Steve Lawrence wrote:
> When copying classpermission or classpermissionset statements, we did
> not properly initialize the new structs. This would cause a segfault
> when one used either of these statements inside a tunableif block, e.g.
>
>    (tunableif foo
>      (true
>        (classpermissionset cps (cls (perm1 perm2))))
>      (false
>        (classpermissionset cps (cls (perm1)))))
>
> Reported-by: Dominick Grift <dac.override@gmail.com>
> Signed-off-by: Steve Lawrence <slawrence@tresys.com>

Thanks. Applied.

Jim

> ---
>   libsepol/cil/src/cil_copy_ast.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index 34d8d4c..c611dbc 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -282,6 +282,8 @@ int cil_copy_classpermission(__attribute__((unused)) struct cil_db *db, void *da
>   		}
>   	}
>
> +	cil_classpermission_init(&new);
> +
>   	cil_copy_classperms_list(orig->classperms, &new->classperms);
>
>   	*copy = new;
> @@ -294,6 +296,8 @@ int cil_copy_classpermissionset(__attribute__((unused)) struct cil_db *db, void
>   	struct cil_classpermissionset *orig = data;
>   	struct cil_classpermissionset *new = NULL;
>
> +	cil_classpermissionset_init(&new);
> +
>   	new->set_str = orig->set_str;
>
>   	cil_copy_classperms_list(orig->classperms, &new->classperms);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
