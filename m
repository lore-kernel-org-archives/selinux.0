Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EDjeZK026336
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 09:45:42 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7EDjeqV005917
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 13:45:40 GMT
Subject: Re: [patch 14/35] remotelogin policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123736.929887318@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123736.929887318@hardeman.nu>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 09:44:30 -0400
Message-Id: <1218721470.8095.69.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment
> (policy_modules_services_remotelogin.patch)
> Additional user homedir permissions
> Index: refpolicy/policy/modules/services/remotelogin.te
> ===================================================================
> --- refpolicy.orig/policy/modules/services/remotelogin.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/services/remotelogin.te	2008-08-03 18:01:36.000000000 +0200
> @@ -85,6 +85,7 @@
>  
>  miscfiles_read_localization(remote_login_t)
>  
> +userdom_read_all_users_home_dirs_symlinks(remote_login_t)
>  userdom_use_unpriv_users_fds(remote_login_t)
>  userdom_search_all_users_home_content(remote_login_t)
>  # Only permit unprivileged user domains to be entered via rlogin,

Interface does not exist.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
