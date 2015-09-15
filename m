Subject: Re: [PATCH] libselinux: Free memory when processing media and x
 specfiles
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1442325075-5178-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55F82DC1.7060809@tycho.nsa.gov>
Date: Tue, 15 Sep 2015 10:40:01 -0400
MIME-Version: 1.0
In-Reply-To: <1442325075-5178-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/15/2015 09:51 AM, Richard Haines wrote:
> Ensure all memory is freed - checked using valgrind
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
>  libselinux/src/label_media.c | 2 +-
>  libselinux/src/label_x.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
> index 725d5bd..c589ca3 100644
> --- a/libselinux/src/label_media.c
> +++ b/libselinux/src/label_media.c
> @@ -161,7 +161,7 @@ static void close(struct selabel_handle *rec)
>  	if (spec_arr)
>  	    free(spec_arr);
>  
> -	memset(data, 0, sizeof(*data));
> +	free(data);
>  }
>  
>  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
> index 3f2ee1c..3d13b23 100644
> --- a/libselinux/src/label_x.c
> +++ b/libselinux/src/label_x.c
> @@ -188,7 +188,7 @@ static void close(struct selabel_handle *rec)
>  	if (spec_arr)
>  	    free(spec_arr);
>  
> -	memset(data, 0, sizeof(*data));
> +	free(data);
>  }
>  
>  static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> 
