Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DKJprT005789
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 16:19:51 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DKIuHC007645
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 20:18:56 GMT
Subject: Re: ssh policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4141BF21.9050004@redhat.com>
References: <200409090428.52881.russell@coker.com.au>
	 <1094761979.2895.64.camel@moss-lions.epoch.ncsc.mil>
	 <4141BF21.9050004@redhat.com>
Content-Type: text/plain
Message-Id: <1095106734.2161.17.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 13 Sep 2004 16:18:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, for the most part, except for what Steve commented on.

On Fri, 2004-09-10 at 10:50, Daniel J Walsh wrote:
> Latest policy.  More stuff for dbus.  Added media file.   Changes for 
> udev on tmpfs.
> 
> ______________________________________________________________________

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.13/domains/program/unused/updfstab.te
> --- nsapolicy/domains/program/unused/updfstab.te	2004-09-10 10:17:49.000000000 -0400
> +++ policy-1.17.13/domains/program/unused/updfstab.te	2004-09-10 10:30:15.342777769 -0400
> @@ -60,5 +60,5 @@
>  allow updfstab_t self:capability dac_override;
>  dontaudit updfstab_t self:capability sys_admin;
>  
> -r_dir_file(updfstab_t, { selinux_config_t file_context_t default_context_t } )
>  can_getsecurity(updfstab_t)
> +dontaudit updfstab_t selinux_config_t:dir search;

Will wait for updfstab to be fixed to update its policy.


-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
