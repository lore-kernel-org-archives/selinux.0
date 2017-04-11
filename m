Message-ID: <1491935725.14576.5.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/6] libsemanage: drop checks on
 semanage_module_info_destroy() value
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Tue, 11 Apr 2017 14:35:25 -0400
In-Reply-To: <20170407204431.8572-2-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
 <20170407204431.8572-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-07 at 22:44 +0200, Nicolas Iooss wrote:
> semanage_module_info_destroy() always returns 0. Nevertheless
> semanage_direct_list_all() uses its return value in a surprising way:
> 
>     cleanup:
>         if (priorities != NULL) {
>             /* ... */
>             free(priorities);
>         }
>         /* ... */
>         ret = semanage_module_info_destroy(sh, modinfo_tmp);
>         if (ret != 0) {
>             status = -1;
>             goto cleanup;
>         }
> 
> The last "goto cleanup;" leads clang's static analyzer to believe a
> double free is possible. Even though this is a false positive, the
> body of condition "if (ret != 0)" contains dead code. Remove it.

I'm merging this one but we should likely follow up with a patch to
change semodule_module_info_destroy() to explicitly return void.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/direct_api.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c
> b/libsemanage/src/direct_api.c
> index 568732355f54..1d53c0d64e0c 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -2499,11 +2499,7 @@ static int
> semanage_direct_list_all(semanage_handle_t *sh,
>  				goto cleanup;
>  			}
>  
> -			ret = semanage_module_info_destroy(sh,
> modinfo_tmp);
> -			if (ret != 0) {
> -				status = -1;
> -				goto cleanup;
> -			}
> +			semanage_module_info_destroy(sh,
> modinfo_tmp);
>  			free(modinfo_tmp);
>  			modinfo_tmp = NULL;
>  
> @@ -2528,11 +2524,7 @@ cleanup:
>  		free(modules);
>  	}
>  
> -	ret = semanage_module_info_destroy(sh, modinfo_tmp);
> -	if (ret != 0) {
> -		status = -1;
> -		goto cleanup;
> -	}
> +	semanage_module_info_destroy(sh, modinfo_tmp);
>  	free(modinfo_tmp);
>  	modinfo_tmp = NULL;
>  
