Subject: Re: [PATCH 2/2] libselinux: man: Clarify is_selinux_mls_enabled()
 description
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1466437314-9813-1-git-send-email-plautrba@redhat.com>
 <1466437314-9813-2-git-send-email-plautrba@redhat.com>
Cc: David King <dking@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <688969db-dd27-9b42-696e-b67e82982cfb@tycho.nsa.gov>
Date: Thu, 23 Jun 2016 13:09:38 -0400
MIME-Version: 1.0
In-Reply-To: <1466437314-9813-2-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/20/2016 11:41 AM, Petr Lautrbach wrote:
> From: David King <dking@redhat.com>
> 
> Improve the description by mentioning that if is_selinux_mls_enabled(),
> it simply means that the kernel has MLS support and the policy contains
> MLS features. To check whether MLS support is enabled on the running
> system, use selinux_getpolicytype().
> 
> Signed-off-by: David King <dking@redhat.com>

Thanks, applied both.

> ---
>  libselinux/man/man3/is_selinux_enabled.3 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
> index b2df562..df62c22 100644
> --- a/libselinux/man/man3/is_selinux_enabled.3
> +++ b/libselinux/man/man3/is_selinux_enabled.3
> @@ -18,7 +18,9 @@ returns 1 if SELinux is running or 0 if it is not.
>  On error, \-1 is returned.
>  
>  .BR is_selinux_mls_enabled ()
> -returns 1 if SELinux is running in MLS mode or 0 if it is not. 
> +returns 1 if SELinux is capable of running in MLS mode or 0 if it is not. To
> +determine the policy in use on the system, use
> +.BR selinux_getpolicytype (3).
>  .
>  .SH "SEE ALSO"
>  .BR selinux "(8)"
> 
