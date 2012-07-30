Message-ID: <1343653012.2346.21.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] Allow CTS Test apps to access to system_data_file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Mon, 30 Jul 2012 08:56:52 -0400
In-Reply-To: <1343427539-6583-1-git-send-email-hqjiang1988@gmail.com>
References: <1343427539-6583-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 15:18 -0700, Haiqing Jiang wrote:
> ---
>  app.te |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks, applied.

> 
> diff --git a/app.te b/app.te
> index 41866d9..b9b5a17 100644
> --- a/app.te
> +++ b/app.te
> @@ -117,7 +117,7 @@ allow untrusted_app sdcard:file create_file_perms;
>  }
>  # Native app support.
>  bool app_ndk false;
> -if (app_ndk) {
> +if (app_ndk or android_cts) {
>  allow untrusted_app system_data_file:file { execute open };
>  }
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
