Subject: Re: [PATCH 8/8] libselinux: add booleans.c to ANDROID_HOST=y recipe
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
 <1476735850-7844-8-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3ae5b49a-f2ee-29e7-a0d2-003158e02503@tycho.nsa.gov>
Date: Tue, 18 Oct 2016 14:07:02 -0400
MIME-Version: 1.0
In-Reply-To: <1476735850-7844-8-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/17/2016 04:24 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> We build booleans.c with DISABLE_BOOL set on Android host
> and target. Add that file to the upstream Makefile.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Thanks, applied the series.

> ---
>  libselinux/src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 7a1ae05..ccd8442 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -100,7 +100,7 @@ DISABLE_FLAGS+= -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
>  	-DBUILD_HOST
>  SRCS= callbacks.c freecon.c label.c label_file.c \
>  	label_backends_android.c regex.c label_support.c \
> -	matchpathcon.c setrans_client.c sha1.c
> +	matchpathcon.c setrans_client.c sha1.c booleans.c
>  else
>  DISABLE_FLAGS+= -DNO_ANDROID_BACKEND
>  SRCS:= $(filter-out label_backends_android.c, $(SRCS))
> 
