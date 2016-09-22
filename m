Subject: Re: [PATCH] Fix redefinition of XATTR_NAME_SELINUX
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov, jwcart2@tycho.nsa.gov
References: <1474502367-6943-1-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5ea3a34b-1719-c43a-ef81-415e963b0b3d@tycho.nsa.gov>
Date: Thu, 22 Sep 2016 13:26:40 -0400
MIME-Version: 1.0
In-Reply-To: <1474502367-6943-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2016 07:59 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> When the Kernel UAPI header is present, this error occurs:
> 
> external/selinux/libselinux/src/policy.h:7:9: warning: 'XATTR_NAME_SELINUX' macro redefined [-Wmacro-redefined]
> \#define XATTR_NAME_SELINUX "security.selinux"
>         ^
> bionic/libc/kernel/uapi/linux/xattr.h:52:9: note: previous definition is here
> \#define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
> 
> Just use the kernel UAPI version on that case.
> 
> Change-Id: I1b2d34e463477adaec227ac8c3364f1b9d49e997
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Thanks, applied.

> ---
>  libselinux/src/policy.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/policy.h b/libselinux/src/policy.h
> index bf270b5..f6d7242 100644
> --- a/libselinux/src/policy.h
> +++ b/libselinux/src/policy.h
> @@ -3,8 +3,13 @@
>  
>  /* Private definitions used internally by libselinux. */
>  
> -/* xattr name for SELinux attributes. */
> +/*
> + * xattr name for SELinux attributes.
> + * This may have been exported via Kernel uapi header.
> + */
> +#ifndef XATTR_NAME_SELINUX
>  #define XATTR_NAME_SELINUX "security.selinux"
> +#endif
>  
>  /* Initial length guess for getting contexts. */
>  #define INITCONTEXTLEN 255
> 
