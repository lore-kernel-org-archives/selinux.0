Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB2Do1mn008012
 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2014 08:50:02 -0500
Message-ID: <547DC375.8000707@tresys.com>
Date: Tue, 2 Dec 2014 08:49:41 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Add "RuntimeDirectory=setrans" to the mcstrans.service
References: <1417256655-4207-1-git-send-email-bigon@debian.org>
In-Reply-To: <1417256655-4207-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/29/2014 05:24 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Add "RuntimeDirectory=setrans" to the mcstrans.service, this will make
> systemd automatically create the /run/setrans directory before starting
> the service.
> 
> This directory contains the ".setrans-unix" socket created by the
> daemon.

Thanks!

Acked-by: Steve Lawrence <slawrence@tresys.com>

> ---
>  policycoreutils/mcstrans/src/mcstrans.service | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/policycoreutils/mcstrans/src/mcstrans.service b/policycoreutils/mcstrans/src/mcstrans.service
> index 64bb361..8976b97 100644
> --- a/policycoreutils/mcstrans/src/mcstrans.service
> +++ b/policycoreutils/mcstrans/src/mcstrans.service
> @@ -4,6 +4,7 @@ ConditionSecurity=selinux
>  
>  [Service]
>  ExecStart=/sbin/mcstransd -f
> +RuntimeDirectory=setrans
>  
>  [Install]
>  WantedBy=multi-user.target
> 
