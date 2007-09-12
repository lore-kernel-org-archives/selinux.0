Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CEkjRX031163
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 10:46:45 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8CEka13026178
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 14:46:41 GMT
Subject: Re: [PATCH] refpolicy: services_rhgb changes rhgb searches /root
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022042.l72Kgc0v032643@redsox.boston.devel.redhat.com>
References: <200708022042.l72Kgc0v032643@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 12 Sep 2007 10:45:07 -0400
Message-Id: <1189608308.7512.34.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:42 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/rhgb.te      2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/rhgb.te   2007-08-02 11:02:02.000000000 -0400
> @@ -109,6 +109,7 @@
> 
>  userdom_dontaudit_use_unpriv_user_fds(rhgb_t)
>  userdom_dontaudit_search_sysadm_home_dirs(rhgb_t)
> +userdom_dontaudit_search_all_users_home_content(rhgb_t)
> 
>  xserver_read_xdm_xserver_tmp_files(rhgb_t)
>  xserver_kill_xdm_xserver(rhgb_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
