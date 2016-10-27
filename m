Subject: Re: [PATCH] libselinux: fix pointer handling in realpath_not_final
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <1477569156-12380-1-git-send-email-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2d9fad41-9839-8ddc-10ed-ae50376b6e0b@tycho.nsa.gov>
Date: Thu, 27 Oct 2016 10:49:55 -0400
MIME-Version: 1.0
In-Reply-To: <1477569156-12380-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/27/2016 07:52 AM, Vit Mojzis wrote:
> From: vmojzis <vmojzis@redhat.com>
> 
> Loop designed for stripping leading "//" was changing
> the only pointer referencing block of memory allocated
> by "strdup", resulting in "free()" failure. The loop
> had no effect because "realpath" is used later on.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1376598
> 
> Signed-off-by: vmojzis <vmojzis@redhat.com>

Thanks, applied.

This reminds me that we want to get rid of all matchpathcon users,
moving them over to selabel_lookup and selinux_restorecon.  Upstream
setfiles no longer calls matchpathcon or realpath_not_final.  Looks like
the python wrappers for libselinux define their own restorecon() method
that uses matchpathcon() and implements their own tree walk  - that
should be converted to use selinux_restorecon().

> ---
>  libselinux/src/matchpathcon.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index 724eb65..58b4144 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -389,12 +389,6 @@ int realpath_not_final(const char *name, char *resolved_path)
>  		goto out;
>  	}
>  
> -	/* strip leading // */
> -	while (tmp_path[len] && tmp_path[len] == '/' &&
> -	       tmp_path[len+1] && tmp_path[len+1] == '/') {
> -		tmp_path++;
> -		len++;
> -	}
>  	last_component = strrchr(tmp_path, '/');
>  
>  	if (last_component == tmp_path) {
> 
