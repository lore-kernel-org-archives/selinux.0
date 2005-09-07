Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j87CGqOb027705
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 08:16:53 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j87CDZfE018333
	for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2005 12:13:35 GMT
Message-ID: <431EDA31.9030502@redhat.com>
Date: Wed, 07 Sep 2005 08:16:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ntp policy
References: <1125929266.16388.85.camel@sgc>
In-Reply-To: <1125929266.16388.85.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>While converting the ntpd policy over to a reference policy module, I
>came across a few lines which bring up questions.
>
>	# so the start script can change firewall entries
>	allow initrc_t net_conf_t:file { getattr read ioctl };
>
>This looks like a distro-specific access, or perhaps it just made its
>way in by accident?
>  
>
No idea.  You get these from the can_network call anyways.

>	# for cron jobs
>	# system_crond_t is not right, cron is not doing what it should
>	ifdef(`crond.te', `
>	system_crond_entry(ntpd_exec_t, ntpd_t)
>	')
>
>It is unclear to me what the comment means.  Also, shouldn't this be
>ntpdate_exec_t instead of ntpd_exec_t?
>  
>
Yes, I am sure this rule went in before there was an ntpdate_exec_t, 
although I do not see a cron job that runs it.

>	can_udp_send(ntpd_t, sysadm_t)
>	can_udp_send(sysadm_t, ntpd_t)
>
>There is no comment for these.  Are they needed for sysadm to run
>ntpdate?
>  
>
>	ifdef(`winbind.te', `
>	allow ntpd_t winbind_var_run_t:dir r_dir_perms;
>	allow ntpd_t winbind_var_run_t:sock_file rw_file_perms;
>	')
>
>Generally when using a sock_file, a domain is connecting/sending to
>another domain over a unix domain socket; however, after doing a few
>rule searches in apol, I find no evidence that ntpd_t connects/sends to
>winbind_t.  Is there some other purpose for these rules, or am I missing
>something?
>
>  
>
Must be from nscd.


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
