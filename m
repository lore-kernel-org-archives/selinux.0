To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov,
 William Roberts <bill.c.roberts@gmail.com>
References: <1498485334.13301.9.camel@tycho.nsa.gov>
 <20180228101510.21023-1-vmojzis@redhat.com>
 <20180228101510.21023-2-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d9c8be28-2fbe-b22d-aaff-571073781b2e@tycho.nsa.gov>
Date: Wed, 28 Feb 2018 13:26:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180228101510.21023-2-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 2/3] libsemanage: remove access() check to make setuid
 programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/28/2018 05:15 AM, Vit Mojzis wrote:
> F_OK access checks only work properly as long as all directories along
> the path are accessible to real user running the program.
> Replace F_OK access checks by testing return value of open, write, etc.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/direct_api.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index b7899d68..f4d57cf8 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1563,34 +1563,25 @@ rebuild:
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
> +	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
> +						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
> +						sh->conf->file_mode);
> +	if (retval < 0 && errno != ENOENT) {
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
> +	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
> +						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
> +						sh->conf->file_mode);
> +	if (retval < 0 && errno != ENOENT) {
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
> +	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
> +						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
> +						sh->conf->file_mode);
> +	if (retval < 0 && errno != ENOENT) {
> +		goto cleanup;
>  	}

I think we need to clear retval here to ensure that we don't later
misinterpret a negative retval as an error.  Otherwise, if
disable_genhomedircon && !do_install, we'll fall through to the end of
the function without ever setting retval again, so the mere absence of a
seusers file will cause a fatal error from semanage_direct_commit.

>  
>  	/* run genhomedircon if its enabled, this should be the last operation
