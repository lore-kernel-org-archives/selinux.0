Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJu3WL019292
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:56:03 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJu2H3002113
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:56:03 GMT
Subject: Re: [PATCH] refpolicy: services_avahi changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021925.l72JPEeJ025012@redsox.boston.devel.redhat.com>
References: <200708021925.l72JPEeJ025012@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:08 -0400
Message-Id: <1187812508.13874.101.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:25 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/avahi.te     2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/avahi.te  2007-08-02 11:02:02.000000000 -0400
> @@ -57,6 +57,7 @@
> 
>  fs_getattr_all_fs(avahi_t)
>  fs_search_auto_mountpoints(avahi_t)
> +fs_list_inotifyfs(avahi_t)
> 
>  domain_use_interactive_fds(avahi_t)
> 

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
