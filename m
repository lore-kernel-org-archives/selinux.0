Message-ID: <1342100209.8057.28.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] GPSLocation Provider needs socket connection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hqjiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Thu, 12 Jul 2012 09:36:49 -0400
In-Reply-To: <1342046389-9271-3-git-send-email-hqjiang1988@gmail.com>
References: <1342046389-9271-1-git-send-email-hqjiang1988@gmail.com>
	 <1342046389-9271-3-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 15:39 -0700, hqjiang wrote:
> ---
>  system.te |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/system.te b/system.te
> index 1a94c75..f35e9a2 100644
> --- a/system.te
> +++ b/system.te
> @@ -192,3 +192,6 @@ allow system domain:file r_file_perms;
>  # to uart driver and ctrl proc entry
>  allow system gps_device:chr_file rw_file_perms;
>  allow system gps_control:file rw_file_perms;
> +
> +# GpsLocationProvider Connection
> +allow system rild:unix_stream_socket connectto;

This should be written using the unix_socket_connect() macro, which
takes three arguments: clientdomain, sockettype, serverdomain.  What
type is assigned to the socket file?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
