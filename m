Subject: Re: [PATCH] policycoreutils/restorecond: Decrease loglevel of
 termination message
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <1483523947-14979-1-git-send-email-vmojzis@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <dc6946c0-f3df-11a4-7a50-b8b816135e2a@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:30:30 -0500
MIME-Version: 1.0
In-Reply-To: <1483523947-14979-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/04/2017 04:59 AM, Vit Mojzis wrote:
> Decrease loglevel of termination message
> (eg. "restorecond[709]: terminated") to LOG_INFO because it is printed
> upon normal shutdown of the daemon.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1264505
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Applied.

Thanks,

> ---
>  restorecond/watch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/restorecond/watch.c b/restorecond/watch.c
> index 2be45d4..691df82 100644
> --- a/restorecond/watch.c
> +++ b/restorecond/watch.c
> @@ -179,7 +179,7 @@ int watch(int fd, const char *watch_file)
>  			syslog(LOG_ERR, "Read error (%s)", strerror(errno));
>  			return 0;
>  		}
> -		syslog(LOG_ERR, "terminated");
> +		syslog(LOG_INFO, "terminated");
>  		return -1;
>  	} else if (!len)
>  		/* BUF_LEN too small? */
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
