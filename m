Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KJntrT020410
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 15:49:55 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KJnsT2012061
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 19:49:55 GMT
Subject: Re: Important fix for targeted policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <414B034A.4050407@redhat.com>
References: <200409162151.44819.russell@coker.com.au>
	 <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>
	 <1095356454.17251.10.camel@moss-lions.epoch.ncsc.mil>
	 <414B034A.4050407@redhat.com>
Content-Type: text/plain
Message-Id: <1095709723.3225.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 20 Sep 2004 15:48:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2004-09-17 at 11:31, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r 
> nsapolicy/targeted/domains/program/init.te 
> policy-1.17.18/targeted/domains/program/init.te
> --- nsapolicy/targeted/domains/program/init.te  2004-09-09 
> 15:36:12.000000000 -0400
> +++ policy-1.17.18/targeted/domains/program/init.te     2004-09-17 
> 10:22:33.591562641 -0400
> @@ -15,4 +15,4 @@
>  # strict policy.  /sbin/init will get this policy.
>  #
>  type init_exec_t, file_type, sysadmfile, exec_type;
> -type initctl_t, file_type, sysadmfile;
> +type initctl_t, file_type, sysadmfile, dev_fs;
> diff --exclude-from=exclude -N -u -r 
> nsapolicy/targeted/domains/program/udev.te 
> policy-1.17.18/targeted/domains/program/udev.te
> --- nsapolicy/targeted/domains/program/udev.te  2004-09-09 
> 15:36:12.000000000 -0400
> +++ policy-1.17.18/targeted/domains/program/udev.te     2004-09-17 
> 10:22:22.119860649 -0400
> @@ -13,4 +13,4 @@
>  #
>  type udev_exec_t, file_type, sysadmfile, exec_type;
>  type udev_helper_exec_t, file_type, sysadmfile, exec_type;
> -type udev_tbl_t, file_type, sysadmfile;
> +type udev_tbl_t, file_type, sysadmfile, dev_fs;
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
