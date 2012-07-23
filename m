Message-ID: <1343049641.23118.22.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 3/3] external/sepolicy: system r/w udp_socket of
 untrusted apps
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 23 Jul 2012 09:20:41 -0400
In-Reply-To: <1342734563-32644-4-git-send-email-hqjiang1988@gmail.com>
References: <1342734563-32644-1-git-send-email-hqjiang1988@gmail.com>
	 <1342734563-32644-4-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 14:49 -0700, Haiqing Jiang wrote:
> From: hqjiang <hqjiang1988@gmail.com>
> 
> ---
>  system.te |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/system.te b/system.te
> index a4065cf..5c34f81 100644
> --- a/system.te
> +++ b/system.te
> @@ -196,3 +196,6 @@ allow system domain:file r_file_perms;
>  # to uart driver and ctrl proc entry
>  allow system gps_device:chr_file rw_file_perms;
>  allow system gps_control:file rw_file_perms;
> +
> +# system Read/Write udp_socket of untrusted_app
> +allow system untrusted_app:udp_socket { read write };

So an app is passing a socket fd to the system_server over Binder and
the system_server is then writing to the socket?  Wonder why.  Anyway,
rather than writing this only in terms of one app domain
(untrusted_app), cover all cases by using the appdomain attribute, i.e.
allow system appdomain:udp_socket { read write };

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
