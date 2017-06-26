Message-ID: <1498484260.13301.6.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] libsemanage: remove access() check to make setuid
 programs work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Mon, 26 Jun 2017 09:37:40 -0400
In-Reply-To: <20170626123835.8234-2-vmojzis@redhat.com>
References: <1495202170.2209.3.camel@tycho.nsa.gov>
 <20170626123835.8234-1-vmojzis@redhat.com>
 <20170626123835.8234-2-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-06-26 at 14:38 +0200, Vit Mojzis wrote:
> F_OK access checks only work properly as long as all directories
> along
> the path are accessible to real user running the program.
> Replace F_OK access checks by testing return value of open, write,
> etc.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
> ---
>  libsemanage/src/direct_api.c | 36 +++++++++++++++-------------------
> --
>  1 file changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c
> b/libsemanage/src/direct_api.c
> index b761b68..ed11a7c 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1538,33 +1538,27 @@ rebuild:
>  	}
>  
>  	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL);
> -	if (access(path, F_OK) == 0) {
> -		retval =
> semanage_copy_file(semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_FC_LOCAL),
> -							semanage_fin
> al_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
> -							sh->conf-
> >file_mode);
> -		if (retval < 0) {
> -			goto cleanup;
> -		}
> +	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_FC_LOCAL),
> +						semanage_final_path(
> SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
> +						sh->conf-
> >file_mode);
> +	if (retval < 0 && errno != ENOENT) {
> +		goto cleanup;
>  	}
>  	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
> -	if (access(path, F_OK) == 0) {
> -		retval =
> semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
> -							semanage_fin
> al_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
> -							sh->conf-
> >file_mode);
> -		if (retval < 0) {
> -			goto cleanup;
> -		}
> +	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_FC),
> +						semanage_final_path(
> SEMANAGE_FINAL_TMP, SEMANAGE_FC),
> +						sh->conf-
> >file_mode);
> +	if (retval < 0 && errno != ENOENT) {
> +		goto cleanup;
>  	}
>  
>  	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
> -	if (access(path, F_OK) == 0) {
> -		retval =
> semanage_copy_file(semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_SEUSERS),
> -							semanage_fin
> al_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
> -							sh->conf-
> >file_mode);
> -		if (retval < 0) {
> -			goto cleanup;
> -		}
> +	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP,
> SEMANAGE_STORE_SEUSERS),
> +						semanage_final_path(
> SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
> +						sh->conf-
> >file_mode);
> +	if (retval < 0 && errno != ENOENT) {
> +		goto cleanup;
>  	}
>  
>  	/* run genhomedircon if its enabled, this should be the last
> operation

Isn't the assignment to path in each of the sequences above rendered
moot by your removal of the call to access()?  So you could either
remove the assignment to path each time, or alternatively retain it but
pass path as the first argument to semanage_copy_file() rather than
calling semanage_path() again.
