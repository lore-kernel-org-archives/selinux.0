Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1AEeOXf009775
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 09:40:25 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1AEeLTR017789
	for <selinux@tycho.nsa.gov>; Fri, 10 Feb 2006 14:40:21 GMT
Subject: Re: seref: trivial patch:
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060209194236.GF10534@sergelap.austin.ibm.com>
References: <20060209194236.GF10534@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 09:41:45 -0500
Message-Id: <1139582505.13925.84.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 13:42 -0600, Serge E. Hallyn wrote:
> Fix compilation failure for cron with apache=off.

> --- refpolicy.orig/policy/modules/services/cron.te
> +++ refpolicy/policy/modules/services/cron.te
> @@ -208,7 +208,7 @@ ifdef(`TODO',`
>  # crond tries to search /root.  Not sure why.
>  allow crond_t sysadm_home_dir_t:dir r_dir_perms;
>  
> -ifdef(`apache.te',`
> +optional_policy(`apache',`
>  allow system_crond_t httpd_modules_t:lnk_file read;
>  # Needed for certwatch
>  can_exec(system_crond_t, httpd_modules_t)

While this change is correct, I'm surprised that it caused a compile
failure in the first place, as its in a ifdef(`TODO' block which should
make this whole section drop out.  Did you define TODO to make the rules
get included?

Merged.  I changed the rules to use the appropriate interface and moved
them to the appropriate places.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
