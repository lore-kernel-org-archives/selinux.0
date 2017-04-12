Message-ID: <1492021543.3881.21.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/6] libsemanage: make semanage_..._destroy return void
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Wed, 12 Apr 2017 14:25:43 -0400
In-Reply-To: <20170411214603.28040-1-nicolas.iooss@m4x.org>
References: <20170411214603.28040-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-04-11 at 23:45 +0200, Nicolas Iooss wrote:
> semanage_module_info_destroy() always return 0 ("success") even
> though
> some of its caller want to check its return value. For example commit
> 86e6ae67fd17 ("libsemanage: drop checks on
> semanage_module_info_destroy() value") removed such a caller which
> was
> buggy.
> 
> Discourage using the return value of semanage_..._destroy() functions
> by
> making them return void.

Sorry, my fault - didn't realize this was a public API when I suggested
it.  Can't break the library ABI.  We could use symbol versioning magic
to transition it over, but probably not worth it.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/include/semanage/modules.h | 12 ++++--------
>  libsemanage/src/modules.c              | 22 +++++++++-------------
>  2 files changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/libsemanage/include/semanage/modules.h
> b/libsemanage/include/semanage/modules.h
> index 4b93e54e7d21..a35de815abbf 100644
> --- a/libsemanage/include/semanage/modules.h
> +++ b/libsemanage/include/semanage/modules.h
> @@ -79,12 +79,10 @@ int semanage_module_info_create(semanage_handle_t
> *sh,
>  
>  /* Frees the members of the module info struct.
>   *
> - * Returns 0 on success and -1 on failure.
> - *
>   * The caller should call free() on the struct.
>   */
> -int semanage_module_info_destroy(semanage_handle_t *handle,
> -				 semanage_module_info_t *modinfo);
> +void semanage_module_info_destroy(semanage_handle_t *handle,
> +				  semanage_module_info_t *modinfo);
>  
>  /* Module Info Getters */
>  
> @@ -168,11 +166,9 @@ int semanage_module_key_create(semanage_handle_t
> *sh,
>  
>  /* Frees members of the @modkey, but not the struct. The caller
> should
>   * call free() on struct.
> - *
> - * Returns 0 on success, and -1 on error.
>   */
> -int semanage_module_key_destroy(semanage_handle_t *sh,
> -				semanage_module_key_t *modkey);
> +void semanage_module_key_destroy(semanage_handle_t *sh,
> +				 semanage_module_key_t *modkey);
>  
>  /* Module Key Getters */
>  
> diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
> index 90c5e4917f97..7bbe3aa1e6db 100644
> --- a/libsemanage/src/modules.c
> +++ b/libsemanage/src/modules.c
> @@ -281,19 +281,19 @@ int
> semanage_module_info_create(semanage_handle_t *sh,
>  
>  hidden_def(semanage_module_info_create)
>  
> -int semanage_module_info_destroy(semanage_handle_t *sh,
> -				 semanage_module_info_t *modinfo)
> +void semanage_module_info_destroy(semanage_handle_t *sh,
> +				  semanage_module_info_t *modinfo)
>  {
>  	assert(sh);
>  
>  	if (!modinfo) {
> -		return 0;
> +		return;
>  	}
>  
>  	free(modinfo->name);
>  	free(modinfo->lang_ext);
>  
> -	return semanage_module_info_init(sh, modinfo);
> +	semanage_module_info_init(sh, modinfo);
>  }
>  
>  hidden_def(semanage_module_info_destroy)
> @@ -323,11 +323,7 @@ int semanage_module_info_clone(semanage_handle_t
> *sh,
>  	int status = 0;
>  	int ret = 0;
>  
> -	ret = semanage_module_info_destroy(sh, target);
> -	if (ret != 0) {
> -		status = -1;
> -		goto cleanup;
> -	}
> +	semanage_module_info_destroy(sh, target);
>  
>  	ret = semanage_module_info_set_priority(sh, target, source-
> >priority);
>  	if (ret != 0) {
> @@ -685,18 +681,18 @@ int
> semanage_module_key_create(semanage_handle_t *sh,
>  
>  hidden_def(semanage_module_key_create)
>  
> -int semanage_module_key_destroy(semanage_handle_t *sh,
> -				semanage_module_key_t *modkey)
> +void semanage_module_key_destroy(semanage_handle_t *sh,
> +				 semanage_module_key_t *modkey)
>  {
>  	assert(sh);
>  
>  	if (!modkey) {
> -		return 0;
> +		return;
>  	}
>  
>  	free(modkey->name);
>  
> -	return semanage_module_key_init(sh, modkey);
> +	semanage_module_key_init(sh, modkey);
>  }
>  
>  hidden_def(semanage_module_key_destroy)
