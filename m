Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87HmNrT028098
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 13:48:23 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87HlQxo015417
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 17:47:26 GMT
Subject: Re: crontab -u
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409052245.53741.russell@coker.com.au>
References: <200409052245.53741.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1094579253.3227.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 07 Sep 2004 13:47:33 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Sun, 2004-09-05 at 08:45, Russell Coker wrote:
> --- macros/admin_macros.te      2004-09-03 05:14:42.000000000 +1000
> +++ /root/admin_macros.te       2004-09-05 21:28:38.504868911 +1000
> @@ -67,7 +67,7 @@
> 
>  # Manipulate other user crontab.
>  allow $1_t self:passwd crontab;
> -
> +can_getsecurity(sysadm_crontab_t)
> 
>  # Change system parameters.
>  can_sysctl($1_t)
> 
> 
> The above patch is needed to have crontab -u work as administrator.  The below 
> patch is needed to have rpm run crontab -u (IE installing mailman).
> 
> 
> --- /root/rpm.te        2004-09-05 21:37:55.677133067 +1000
> +++ domains/program/rpm.te      2004-09-05 21:39:08.658793880 +1000
> @@ -161,6 +161,7 @@
>  ')
>  ifdef(`crond.te', `
>  allow crond_t rpm_t:fifo_file r_file_perms;
> +allow rpm_script_t self:passwd crontab;
>  ')
> 
>  allow rpm_script_t proc_t:dir { search getattr };
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
