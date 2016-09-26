Subject: Re: [PATCH] libselinux: drop unused stdio_ext.h header file
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov
References: <1474737005-1907-1-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c9974ee5-670b-8573-7778-9fd1770ef4d4@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 11:05:17 -0400
MIME-Version: 1.0
In-Reply-To: <1474737005-1907-1-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/24/2016 01:10 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Nothing was being used from the stdio_ext.h header file, so
> remove it. Additionally, Mac builds, required for the
> Android build, do not have this header.
> 
> Change-Id: Ic61c87fcda79ffebeef93a20a2b3802f048bb0b0
> Signed-off-by: William Roberts <william.c.roberts@intel.com>

Thanks, applied. However, technically this was because an earlier change
from you dropped the use of __fsetlocking(), so we may need to restore
this at some point if that becomes an issue.

> ---
>  libselinux/src/label_file.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 7156825..8ff1170 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -10,7 +10,6 @@
>  #include <stdarg.h>
>  #include <string.h>
>  #include <stdio.h>
> -#include <stdio_ext.h>
>  #include <ctype.h>
>  #include <errno.h>
>  #include <limits.h>
> 
