Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1NKTup7021577
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 15:29:56 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so115861209pab.3
 for <selinux@tycho.nsa.gov>; Tue, 23 Feb 2016 12:29:54 -0800 (PST)
Subject: Re: [PATCH 2/2] libselinux: procattr: return einval for <= 0 pid args.
To: selinux@tycho.nsa.gov
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
 <1456259040-13721-3-git-send-email-dcashman@android.com>
Cc: nnk@google.com, jeffv@google.com, sds@tycho.nsa.gov
From: Daniel Cashman <dcashman@android.com>
Message-ID: <56CCC13F.3060709@android.com>
Date: Tue, 23 Feb 2016 12:29:51 -0800
MIME-Version: 1.0
In-Reply-To: <1456259040-13721-3-git-send-email-dcashman@android.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/23/2016 12:24 PM, Daniel Cashman wrote:
> From: dcashman <dcashman@android.com>
> 
> getpidcon documentation does not specify that a pid of 0 refers to the
> current process, and getcon exists specifically to provide this
> functionality, and getpidcon(getpid()) would provide it as well.
> Disallow pid values <= 0 that may lead to unintended behavior in
> userspace object managers.
> 
> Signed-off-by: Daniel Cashman <dcashman@android.com>
> ---
>  libselinux/src/procattr.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index c20f003..eee4612 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -306,11 +306,21 @@ static int setprocattrcon(const char * context,
>  #define getpidattr_def(fn, attr) \
>  	int get##fn##_raw(pid_t pid, char **c)	\
>  	{ \
> -		return getprocattrcon_raw(c, pid, #attr); \
> +		if (pid <= 0) { \
> +			errno = EINVAL; \
> +			return -1; \
> +		} else { \
> +			return getprocattrcon_raw(c, pid, #attr); \
> +		} \
>  	} \
>  	int get##fn(pid_t pid, char **c)	\
>  	{ \
> -		return getprocattrcon(c, pid, #attr); \
> +		if (pid <= 0) { \
> +			errno = EINVAL; \
> +			return -1; \
> +		} else { \
> +			return getprocattrcon(c, pid, #attr); \
> +		} \
>  	}
>  
>  all_selfattr_def(con, current)
> 

I need to point out explicitly that this change would, of course, break
the existing ABI and result in a change in behavior for applications
relying on getpidcon(0,) calls to be the same as getcon().

Thanks,
Dan
