Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j85E77Ob012398
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2005 10:07:08 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j85E5MFn008507
	for <selinux@tycho.nsa.gov>; Mon, 5 Sep 2005 14:05:22 GMT
Subject: ntp policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 05 Sep 2005 10:07:46 -0400
Message-Id: <1125929266.16388.85.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While converting the ntpd policy over to a reference policy module, I
came across a few lines which bring up questions.

	# so the start script can change firewall entries
	allow initrc_t net_conf_t:file { getattr read ioctl };

This looks like a distro-specific access, or perhaps it just made its
way in by accident?

	# for cron jobs
	# system_crond_t is not right, cron is not doing what it should
	ifdef(`crond.te', `
	system_crond_entry(ntpd_exec_t, ntpd_t)
	')

It is unclear to me what the comment means.  Also, shouldn't this be
ntpdate_exec_t instead of ntpd_exec_t?

	can_udp_send(ntpd_t, sysadm_t)
	can_udp_send(sysadm_t, ntpd_t)

There is no comment for these.  Are they needed for sysadm to run
ntpdate?

	ifdef(`winbind.te', `
	allow ntpd_t winbind_var_run_t:dir r_dir_perms;
	allow ntpd_t winbind_var_run_t:sock_file rw_file_perms;
	')

Generally when using a sock_file, a domain is connecting/sending to
another domain over a unix domain socket; however, after doing a few
rule searches in apol, I find no evidence that ntpd_t connects/sends to
winbind_t.  Is there some other purpose for these rules, or am I missing
something?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
