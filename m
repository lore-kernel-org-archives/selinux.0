Subject: Re: [PATCH 1/2] libselinux: procattr: return error on invalid pid_t
 input.
To: Daniel Cashman <dcashman@android.com>, selinux@tycho.nsa.gov
References: <1456259040-13721-1-git-send-email-dcashman@android.com>
 <1456259040-13721-2-git-send-email-dcashman@android.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56CDBC4D.4060109@tycho.nsa.gov>
Date: Wed, 24 Feb 2016 09:21:01 -0500
MIME-Version: 1.0
In-Reply-To: <1456259040-13721-2-git-send-email-dcashman@android.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/23/2016 03:23 PM, Daniel Cashman wrote:
> From: dcashman <dcashman@android.com>
>
> Signed-off-by: Daniel Cashman <dcashman@android.com>

Thanks, applied.

> ---
>   libselinux/src/procattr.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 527a0a5..c20f003 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -70,9 +70,9 @@ static int openattr(pid_t pid, const char *attr, int flags)
>   	char *path;
>   	pid_t tid;
>
> -	if (pid > 0)
> +	if (pid > 0) {
>   		rc = asprintf(&path, "/proc/%d/attr/%s", pid, attr);
> -	else {
> +	} else if (pid == 0) {
>   		rc = asprintf(&path, "/proc/thread-self/attr/%s", attr);
>   		if (rc < 0)
>   			return -1;
> @@ -82,6 +82,9 @@ static int openattr(pid_t pid, const char *attr, int flags)
>   		free(path);
>   		tid = gettid();
>   		rc = asprintf(&path, "/proc/self/task/%d/attr/%s", tid, attr);
> +	} else {
> +		errno = EINVAL;
> +		return -1;
>   	}
>   	if (rc < 0)
>   		return -1;
>
