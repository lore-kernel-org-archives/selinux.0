Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA05139
	for <selinux@tycho.nsa.gov>; Sun, 18 Aug 2002 21:55:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA05568
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 01:53:23 GMT
Received: from web40004.mail.yahoo.com (web40004.mail.yahoo.com [66.218.78.22])
        by jazzband.ncsc.mil  with SMTP id BAA05564 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 01:53:22 GMT
Message-ID: <20020819015459.26016.qmail@web40004.mail.yahoo.com>
Date: Sun, 18 Aug 2002 18:54:59 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: psidfiles_init errors
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Everyone,

      Could someone please explain the following errors?

psidfiles_init:  invalid context system_u:object_r:dmesg_exec_t (psid 89).
psidfiles_init:  invalid context system_u:object_r:xdm_log_t (psid 92).
psidfiles_init:  invalid context system_u:object_r:minilogd_exec_t (psid 120). 
...
psidfiles_init:  invalid context system_u:object_r:writeable_t (psid 37).
psidfiles_init:  invalid context system_u:object_r:mesg_exec_t (psid 47).
psidfiles_init:  invalid context Brad:object_r:writeable_t (psid 62).
psidfiles_init:  invalid context system_u:object_r:samba_t (psid 64). 

Thanks,

Brad

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
