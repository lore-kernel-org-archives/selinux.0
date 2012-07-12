Message-ID: <1342101558.8057.30.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: SEAndroid: Labels of files in /data/data/APPDIR/lib directory
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal =?UTF-8?Q?Ma=C5=A1ek?= <michal.masek@circletech.net>
Cc: selinux@tycho.nsa.gov, "Craig, Robert P." <rpcraig@tycho.ncsc.mil>
Date: Thu, 12 Jul 2012 09:59:18 -0400
In-Reply-To: <4FFD8E74.5090601@circletech.net>
References: <4FFC34C1.7000803@circletech.net>
	 <1341929590.16964.22.camel@moss-pluto.epoch.ncsc.mil>
	 <4FFC4ED0.8040509@circletech.net>
	 <1341935990.16964.52.camel@moss-pluto.epoch.ncsc.mil>
	 <4FFD8E74.5090601@circletech.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-11 at 16:32 +0200, Michal Mašek wrote:
> Thank you. The app_ndk boolean is exactly what I was looking for.
> However, to resolve all denials, I also had to allow the application to
> "open" the system_data_file, not just to "execute" it:
> 
> diff --git a/app.te b/app.te
> index ed76ccf..137aad7 100644
> --- a/app.te
> +++ b/app.te
> @@ -70,7 +70,7 @@ allow untrusted_app sdcard:file create_file_perms;
>  # Native app support.
>  bool app_ndk false;
>  if (app_ndk) {
> -allow untrusted_app app_data_file:file execute;
> +allow untrusted_app system_data_file:file { execute open };
>  }

Thanks.  Patch was corrupted (maybe whitespace-damaged by your mail
client?) so I had to apply it by hand, but you are still listed as the
author.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
