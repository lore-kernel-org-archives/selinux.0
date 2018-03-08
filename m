To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180306115808.17470-1-vmojzis@redhat.com>
 <20180306115808.17470-3-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <fb30ffea-93d4-4c90-d963-001e5d834553@tycho.nsa.gov>
Date: Thu, 8 Mar 2018 14:54:49 -0500
MIME-Version: 1.0
In-Reply-To: <20180306115808.17470-3-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/3] libsemanage: remove access() check to make setuid
 programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/06/2018 06:58 AM, Vit Mojzis wrote:
> F_OK access checks only work properly as long as all directories along
> the path are accessible to real user running the program.
> Replace F_OK access checks by testing return value of open, write, etc.

Applied patches 1 and 2 (not 3 as per my comments).

> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/direct_api.c | 47 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index b7899d68..49cac14f 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1171,6 +1171,14 @@ cleanup:
>  	return status;
>  }
>  
> +/* Copies a file from src to dst. If dst already exists then
> + * overwrite it. If source doesn't exist then return success.
> + * Returns 0 on success, -1 on error. */
> +static int copy_file_if_exists(const char *src, const char *dst, mode_t mode){
> +	int rc = semanage_copy_file(src, dst, mode);
> +	return (rc < 0 && errno != ENOENT) ? rc : 0;
> +}
> +
>  /********************* direct API functions ********************/
>  
>  /* Commits all changes in sandbox to the actual kernel policy.
> @@ -1563,34 +1571,25 @@ rebuild:
>  		goto cleanup;
>  	}
>  
> -	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL);
> -	if (access(path, F_OK) == 0) {
> -		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
> -							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
> -							sh->conf->file_mode);
> -		if (retval < 0) {
> -			goto cleanup;
> -		}
> +	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
> +						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
> +						sh->conf->file_mode);
> +	if (retval < 0) {
> +		goto cleanup;
>  	}
>  
> -	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
> -	if (access(path, F_OK) == 0) {
> -		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
> -							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
> -							sh->conf->file_mode);
> -		if (retval < 0) {
> -			goto cleanup;
> -		}
> +	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
> +						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
> +						sh->conf->file_mode);
> +	if (retval < 0) {
> +		goto cleanup;
>  	}
>  
> -	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
> -	if (access(path, F_OK) == 0) {
> -		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
> -							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
> -							sh->conf->file_mode);
> -		if (retval < 0) {
> -			goto cleanup;
> -		}
> +	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
> +						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
> +						sh->conf->file_mode);
> +	if (retval < 0) {
> +		goto cleanup;
>  	}
>  
>  	/* run genhomedircon if its enabled, this should be the last operation
> 
