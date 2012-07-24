Message-ID: <1343135045.2383.26.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] external/sepolicy: system r/w udp_socket of appdomain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Tue, 24 Jul 2012 09:04:05 -0400
In-Reply-To: <1343078459-25342-2-git-send-email-hqjiang1988@gmail.com>
References: <1343078459-25342-1-git-send-email-hqjiang1988@gmail.com>
	 <1343078459-25342-2-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-23 at 14:20 -0700, Haiqing Jiang wrote:
> From: hqjiang <hqjiang1988@gmail.com>
> 
> external/sepolicy: allow media_app more permissions on sdcard
> 
> external/sepolicy: allow media_app more permissions on sdcard

Patch description did not match content.  Applied with amended message.

> ---
>  system.te |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/system.te b/system.te
> index a4065cf..bfbc35a 100644
> --- a/system.te
> +++ b/system.te
> @@ -196,3 +196,6 @@ allow system domain:file r_file_perms;
>  # to uart driver and ctrl proc entry
>  allow system gps_device:chr_file rw_file_perms;
>  allow system gps_control:file rw_file_perms;
> +
> +# system Read/Write udp_socket of untrusted_app
> +allow system appdomain:udp_socket { read write };

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
