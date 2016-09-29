Subject: Re: [PATCH 2/2] libselinux: set DISABLE_RPM default to y.
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1475078424-21486-1-git-send-email-william.c.roberts@intel.com>
 <1475078424-21486-2-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9ad82ff0-843c-bffe-b6a0-1b5bd1f4623b@tycho.nsa.gov>
Date: Thu, 29 Sep 2016 15:46:56 -0400
MIME-Version: 1.0
In-Reply-To: <1475078424-21486-2-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 12:00 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Change the default build behavior to always use DISABLE_RPM.
> To get the old behavior call make with DISABLE_RPM=n.
> 
> eg.)
> make DISABLE_RPM=n

I reverted this change.  It would break rpm on RHEL 7 and earlier, so it
is still too soon to make this the default ;(

> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 41d836c..cec2943 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -1,7 +1,7 @@
>  SUBDIRS = src include utils man
>  
>  DISABLE_SETRANS ?= n
> -DISABLE_RPM ?= n
> +DISABLE_RPM ?= y
>  ifeq ($(DISABLE_RPM),y)
>  	DISABLE_FLAGS+= -DDISABLE_RPM
>  endif
> 
