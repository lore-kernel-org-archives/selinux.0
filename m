Message-ID: <1343652982.2346.20.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] socket permissions to untrusted_app
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 30 Jul 2012 08:56:22 -0400
In-Reply-To: <1343427416-6520-1-git-send-email-hqjiang1988@gmail.com>
References: <1343427416-6520-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 15:16 -0700, Haiqing Jiang wrote:
> ---
>  app.te |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks, applied.  Future work:  Extend SELinux kernel code and policy to
distinguish a separate security class for bluetooth sockets.

> 
> diff --git a/app.te b/app.te
> index be0983f..41866d9 100644
> --- a/app.te
> +++ b/app.te
> @@ -105,7 +105,7 @@ unix_socket_connect(untrusted_app, dnsproxyd, netd)
>  }
>  # Bluetooth access.
>  bool app_bluetooth false;
> -if (app_bluetooth) {
> +if (app_bluetooth or android_cts) {
>  # No specific SELinux class for bluetooth sockets presently.
>  allow untrusted_app self:socket *;
>  }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
