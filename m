Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBHEHhMx018743
 for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2015 09:17:43 -0500
Subject: Re: [PATCH] libselinux/man: Add information about thread specific on
 setfscreatecon
To: Petr Lautrbach <plautrba@redhat.com>, <selinux@tycho.nsa.gov>
References: <1449694330-30280-1-git-send-email-plautrba@redhat.com>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <5672C3FB.90405@tresys.com>
Date: Thu, 17 Dec 2015 09:17:31 -0500
MIME-Version: 1.0
In-Reply-To: <1449694330-30280-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/09/2015 03:52 PM, Petr Lautrbach wrote:
> From: Dan Walsh <dwalsh@redhat.com>
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied. Thanks.

> ---
>  libselinux/man/man3/getfscreatecon.3   | 5 +++++
>  libselinux/man/man3/getkeycreatecon.3  | 4 ++++
>  libselinux/man/man3/getsockcreatecon.3 | 5 +++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/libselinux/man/man3/getfscreatecon.3 b/libselinux/man/man3/getfscreatecon.3
> index e348d3b..8cc4df5 100644
> --- a/libselinux/man/man3/getfscreatecon.3
> +++ b/libselinux/man/man3/getfscreatecon.3
> @@ -49,6 +49,11 @@ Signal handlers that perform a
>  must take care to
>  save, reset, and restore the fscreate context to avoid unexpected behavior.
>  .
> +
> +.br
> +.B Note:
> +Contexts are thread specific.
> +
>  .SH "RETURN VALUE"
>  On error \-1 is returned.
>  On success 0 is returned.
> diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
> index 4d70f10..b51008d 100644
> --- a/libselinux/man/man3/getkeycreatecon.3
> +++ b/libselinux/man/man3/getkeycreatecon.3
> @@ -48,6 +48,10 @@ Signal handlers that perform a
>  .BR setkeycreatecon ()
>  must take care to
>  save, reset, and restore the keycreate context to avoid unexpected behavior.
> +
> +.br
> +.B Note:
> +Contexts are thread specific.
>  .
>  .SH "RETURN VALUE"
>  On error \-1 is returned.
> diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
> index 4dd8f30..26086d9 100644
> --- a/libselinux/man/man3/getsockcreatecon.3
> +++ b/libselinux/man/man3/getsockcreatecon.3
> @@ -49,6 +49,11 @@ Signal handlers that perform a
>  must take care to
>  save, reset, and restore the sockcreate context to avoid unexpected behavior.
>  .
> +
> +.br
> +.B Note:
> +Contexts are thread specific.
> +
>  .SH "RETURN VALUE"
>  On error \-1 is returned.
>  On success 0 is returned.
> 
