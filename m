Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86JMxWg017784
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 15:22:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l86JMwOd026823
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 19:22:58 GMT
Subject: Re: [refpolicy] selinuxutils (semodule)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <D041BDDB-B989-4DA5-B312-5D9387DE8A9A@sf-net.com>
References: <477DC293-F96F-4AFB-AD19-E66C80CC3AB4@sf-net.com>
	 <1187721931.13874.37.camel@gorn>
	 <D041BDDB-B989-4DA5-B312-5D9387DE8A9A@sf-net.com>
Content-Type: text/plain
Date: Thu, 06 Sep 2007 15:21:39 -0400
Message-Id: <1189106499.3664.41.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-22 at 12:43 -0400, Stefan Schulze Frielinghaus wrote:
> --- /usr/src/refpolicy-20070629/policy/modules/system/selinuxutil.te    2007-06-29 16:48:13.000000000 +0200
> +++ policy/modules/system/selinuxutil.te        2007-08-22 18:37:38.000000000 +0200
> @@ -479,6 +479,11 @@
>  files_read_usr_files(semanage_t)
>  files_list_pids(semanage_t)
>  
> +ifdef(`distro_debian',`
> +       files_read_var_lib_files(semanage_t)
> +       files_read_var_lib_symlinks(semanage_t)
> +')
> +
>  mls_file_write_down(semanage_t)
>  mls_rangetrans_target(semanage_t)
>  mls_file_read_up(semanage_t)

Merged, but moved down several lines.

> @@ -518,6 +523,8 @@
>  
>  userdom_search_sysadm_home_dirs(semanage_t)
>  
> +selinux_dontaudit_getattr_fs(semanage_t)
> +
>  # cjp: need a more general way to handle this:
>  ifdef(`enable_mls',`
>         # read secadm tmp files

Changed this to the allow version, since this is due to the libselinux
constructor.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
