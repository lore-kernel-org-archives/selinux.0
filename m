Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA12846
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 17:52:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA29294
	for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 21:51:18 GMT
Received: from web40015.mail.yahoo.com (web40015.mail.yahoo.com [66.218.78.55])
        by jazzband.ncsc.mil  with SMTP id VAA29289 for <selinux@tycho.nsa.gov>; Thu, 22 Aug 2002 21:51:17 GMT
Message-ID: <20020822215255.14078.qmail@web40015.mail.yahoo.com>
Date: Thu, 22 Aug 2002 14:52:55 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Correct order to become sysadm_r
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Everyone,

What is the correct sequence of commands to change from Brad:user_r:user_t
to Brad:sysadm_r:sysadm_t without incurring avc: denied errors from either
the transfer itself or any actions performed within sysadm_r? I'm trying to
keep a lot of things out of user_macros.te and su_macros.te, and the only
way to do that IMHO is to become either Brad:sysadm_r:sysadm_t or 
Brad:sysadm_r:sysadm_su_t. How do I do it?

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
