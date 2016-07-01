Subject: Re: [PATCH libsepol] Add missing <stdarg.h> include
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 selinux@tycho.nsa.gov
References: <20160701105149.154f5be9@free-electrons.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a5d8ac68-464f-01ae-461b-22a2cf637c67@tycho.nsa.gov>
Date: Fri, 1 Jul 2016 13:04:35 -0400
MIME-Version: 1.0
In-Reply-To: <20160701105149.154f5be9@free-electrons.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/01/2016 04:51 AM, Thomas Petazzoni wrote:
> Add missing <stdarg.h> include
> 
> This is needed to fix the build on uClibc, due to the usage of
> va_list.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks, applied.

> 
> Index: b/cil/src/cil_log.h
> ===================================================================
> --- a/cil/src/cil_log.h
> +++ b/cil/src/cil_log.h
> @@ -30,6 +30,7 @@
>  #define CIL_LOG_H_
>  
>  #include <stdlib.h>
> +#include <stdarg.h>
>  #include <cil/cil.h>
>  
>  #define MAX_LOG_SIZE 512
> 
