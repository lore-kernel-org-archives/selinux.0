Subject: Re: [PATCH] libselinux: fix unused variable error
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1475078037-20217-1-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <71042e4c-b3e3-92ec-3fc8-e03283e6fe00@tycho.nsa.gov>
Date: Wed, 28 Sep 2016 12:09:59 -0400
MIME-Version: 1.0
In-Reply-To: <1475078037-20217-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 11:53 AM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> When building for Android, this error manifests itself:
> 
> label_file.c:570:7: error: unused variable ‘subs_file’ [-Werror=unused-variable]
>   char subs_file[PATH_MAX + 1];
> 
> Fix it by moving the variable into the ifdef'd usage block.

Thanks, applied.

> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/src/label_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index adf3dcc..a4dc3cd 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -567,7 +567,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>  	struct saved_data *data = (struct saved_data *)rec->data;
>  	const char *path = NULL;
>  	const char *prefix = NULL;
> -	char subs_file[PATH_MAX + 1];
>  	int status = -1, baseonly = 0;
>  
>  	/* Process arguments */
> @@ -585,6 +584,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>  		}
>  
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
> +	char subs_file[PATH_MAX + 1];
>  	/* Process local and distribution substitution files */
>  	if (!path) {
>  		rec->dist_subs =
> 
