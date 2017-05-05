Message-ID: <1494016038.5745.25.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/3] libsemanage: remove access() check to make setuid
 programs work
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 05 May 2017 16:27:18 -0400
In-Reply-To: <20170505124947.21392-3-vmojzis@redhat.com>
References: <1488219577.19819.19.camel@tycho.nsa.gov>
 <20170505124947.21392-1-vmojzis@redhat.com>
 <20170505124947.21392-3-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-05 at 14:49 +0200, Vit Mojzis wrote:
> F_OK access checks only work properly as long as all directories
> along
> the path are accessible to real user running the program.
> Replace F_OK access checks by testing return value of open, write,
> etc.

The patch description talks about F_OK tests, but...

> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
> ---
>  libsemanage/src/direct_api.c | 40 +++++++++++++++-------------------
> ------
>  1 file changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/libsemanage/src/direct_api.c
> b/libsemanage/src/direct_api.c
> index dc46f8f..508277d 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -342,10 +342,6 @@ static int
> semanage_direct_disconnect(semanage_handle_t * sh)
>  
>  static int semanage_direct_begintrans(semanage_handle_t * sh)
>  {
> -
> -	if (semanage_access_check(sh) != SEMANAGE_CAN_WRITE) {
> -		return -1;
> -	}

The patch has an unrelated change (possibly belonging in the first
patch?).

>  	if (semanage_get_trans_lock(sh) < 0) {
>  		return -1;
>  	}
> @@ -1491,33 +1487,27 @@ rebuild:
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
>  
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
