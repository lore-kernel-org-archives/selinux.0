Message-ID: <1516892911.9570.3.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Date: Thu, 25 Jan 2018 10:08:31 -0500
In-Reply-To: <20180122163811.16512-1-richard_c_haines@btinternet.com>
References: <20180122163811.16512-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] libsemanage: Return commit number if save-previous false
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2018-01-22 at 16:38 +0000, Richard Haines wrote:
> Stop overwriting the commit number for the default save-previous flag
> setting (false) in semanage.conf.
> 
> Allows semodule -v -i <policy> to show the correct commit number.

Thanks, applied.  I was concerned that this could possibly break buggy
callers (e.g. if they were handling any non-zero return as an error),
but since the man page does document the return convention and a quick
look at callers suggests they do the right thing, I applied this. I
guess we'll see if anyone complains.

> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libsemanage/src/semanage_store.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libsemanage/src/semanage_store.c
> b/libsemanage/src/semanage_store.c
> index 37ff5ace..936e6495 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1740,9 +1740,9 @@ static int
> semanage_commit_sandbox(semanage_handle_t * sh)
>  
>  	if (!sh->conf->save_previous) {
>  		int errsv = errno;
> -		retval = semanage_remove_directory(backup);
> -		if (retval < 0) {
> +		if (semanage_remove_directory(backup) != 0) {
>  			ERR(sh, "Could not delete previous directory
> %s.", backup);
> +			retval = -1;
>  			goto cleanup;
>  		}
>  		errno = errsv;
