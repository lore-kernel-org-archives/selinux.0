Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA11558
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 18:01:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA12441
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 22:00:33 GMT
Received: from web40004.mail.yahoo.com (web40004.mail.yahoo.com [66.218.78.22])
	by jazzswing.ncsc.mil  with SMTP id WAA12437
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 22:00:32 GMT
Message-ID: <20020819220134.41324.qmail@web40004.mail.yahoo.com>
Date: Mon, 19 Aug 2002 15:01:34 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Changing the default role/type of a user
To: SELinux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Everyone,

In my policy, my username of Brad is placed in the role user_r and the domain
user_t. However, the login program has my username in the role sysadm_r and
the domain sysadm_t, despite there being no such role configured in the users
file. Why does the login program do this?

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
