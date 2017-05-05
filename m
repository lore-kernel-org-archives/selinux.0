Message-ID: <1494006669.5745.13.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] libselinux: add security_get_checkreqprot
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
 selinux@tycho.nsa.gov
Date: Fri, 05 May 2017 13:51:09 -0400
In-Reply-To: <20170504204538.17853-2-cgzones@googlemail.com>
References: <20170504204538.17853-1-cgzones@googlemail.com>
 <20170504204538.17853-2-cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-04 at 22:45 +0200, Christian Göttsche via Selinux
wrote:
> Add security_get_checkreqprot() function, returning the current
> active
> checkreqprot value
> ---
>  libselinux/include/selinux/selinux.h      |  3 +++
>  libselinux/man/man3/security_getenforce.3 |  9 ++++++-
>  libselinux/src/checkreqprot.c             | 40
> +++++++++++++++++++++++++++++++
>  libselinux/src/selinux_internal.h         |  1 +
>  4 files changed, 52 insertions(+), 1 deletion(-)
>  create mode 100644 libselinux/src/checkreqprot.c
> 
> diff --git a/libselinux/include/selinux/selinux.h
> b/libselinux/include/selinux/selinux.h
> index 45dd6ca5..01201eee 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -331,6 +331,9 @@ extern int security_setenforce(int value);
>  /* Get the behavior for undefined classes/permissions */
>  extern int security_deny_unknown(void);
>  
> +/* Get the checkreqprot value */
> +extern int security_get_checkreqprot(void);
> +
>  /* Disable SELinux at runtime (must be done prior to initial policy
> load). */
>  extern int security_disable(void);
>  
> diff --git a/libselinux/man/man3/security_getenforce.3
> b/libselinux/man/man3/security_getenforce.3
> index 7658014a..346b2cbd 100644
> --- a/libselinux/man/man3/security_getenforce.3
> +++ b/libselinux/man/man3/security_getenforce.3
> @@ -1,6 +1,6 @@
>  .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.au
> " "SELinux API documentation"
>  .SH "NAME"
> -security_getenforce, security_setenforce, security_deny_unknown \-
> get or set the enforcing state of SELinux
> +security_getenforce, security_setenforce, security_deny_unknown,
> security_get_checkreqprot\- get or set the enforcing state of SELinux
>  .
>  .SH "SYNOPSIS"
>  .B #include <selinux/selinux.h>
> @@ -10,6 +10,8 @@ security_getenforce, security_setenforce,
> security_deny_unknown \- get or set th
>  .BI "int security_setenforce(int "value );
>  .sp
>  .B int security_deny_unknown(void);
> +.sp
> +.B int security_get_checkreqprot(void);
>  .
>  .SH "DESCRIPTION"
>  .BR security_getenforce ()
> @@ -24,6 +26,11 @@ returned.
>  .BR security_deny_unknown ()
>  returns 0 if SELinux treats policy queries on undefined object
> classes or
>  permissions as being allowed, 1 if such queries are denied, and \-1
> on error.
> +
> +.BR security_get_checkreqprot ()
> +returns 0 if SELinux checks protection on mmap and mprotect calls
> preset by
> +the kernel, 1 if SELinux checks the protection on mmap and mprotect
> calls
> +requested by the application, and \-1 on error.

I don't think this is very clear.  How about:
security_get_checkreqprot() can be used to determine whether SELinux is
configured to check the protection requested by the application or the
actual protection that will be applied by the kernel (including the
effects of READ_IMPLIES_EXEC) on mmap and mprotect calls.  It returns 0
if SELinux checks the actual protection, 1 if it checks the requested
protection, and \-1 on error.

>  .
>  .SH "SEE ALSO"
>  .BR selinux "(8)"
> diff --git a/libselinux/src/checkreqprot.c
> b/libselinux/src/checkreqprot.c
> new file mode 100644
> index 00000000..9b4b12d7
> --- /dev/null
> +++ b/libselinux/src/checkreqprot.c
> @@ -0,0 +1,40 @@
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +#include "selinux_internal.h"
> +#include "policy.h"
> +#include <stdio.h>
> +#include <limits.h>
> +
> +int security_get_checkreqprot(void)
> +{
> +	int fd, ret, checkreqprot = 0;
> +	char path[PATH_MAX];
> +	char buf[20];
> +
> +	if (!selinux_mnt) {
> +		errno = ENOENT;
> +		return -1;
> +	}
> +
> +	snprintf(path, sizeof(path), "%s/checkreqprot",
> selinux_mnt);
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return -1;
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = read(fd, buf, sizeof(buf) - 1);
> +	close(fd);
> +	if (ret < 0)
> +		return -1;
> +
> +	if (sscanf(buf, "%d", &checkreqprot) != 1)
> +		return -1;
> +
> +	return checkreqprot;
> +}
> +
> +hidden_def(security_get_checkreqprot);
> diff --git a/libselinux/src/selinux_internal.h
> b/libselinux/src/selinux_internal.h
> index 3d5c9fb4..54949c13 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -59,6 +59,7 @@ hidden_proto(selinux_mkload_policy)
>      hidden_proto(security_getenforce)
>      hidden_proto(security_setenforce)
>      hidden_proto(security_deny_unknown)
> +    hidden_proto(security_get_checkreqprot)
>      hidden_proto(selinux_boolean_sub)
>      hidden_proto(selinux_current_policy_path)
>      hidden_proto(selinux_binary_policy_path)
