Message-ID: <1343050097.23118.29.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 4/6] external/sepolicy: system talk to rild via socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:28:17 -0400
In-Reply-To: <1342739276-1686-5-git-send-email-hqjiang1988@gmail.com>
References: <Hi, all>
	 <1342739276-1686-5-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 16:07 -0700, Haiqing Jiang wrote:
> ---
>  system.te |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/system.te b/system.te
> index 5c34f81..1a25fd3 100644
> --- a/system.te
> +++ b/system.te
> @@ -107,6 +107,7 @@ unix_socket_connect(system, dbus, dbusd)
>  unix_socket_connect(system, gps, gpsd)
>  unix_socket_connect(system, bluetooth, bluetoothd)
>  unix_socket_send(system, wpa, wpa)
> +unix_socket_connect(system, rild, rild)
>  
>  # Communicate over a socket created by surfaceflinger.
>  allow system surfaceflinger:unix_stream_socket { read write setopt };

Same as prior one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
