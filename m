Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SAA3rT008730
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 06:10:03 -0400 (EDT)
Received: from mx2.eyp.ee (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6SA9WAN029205
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 10:09:33 GMT
Received: from internal by mx2.eyp.ee;
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 13:07:59 +0300
Message-ID: <41077AFE.3050306@eyp.ee>
Date: Wed, 28 Jul 2004 13:07:58 +0300
From: Tanel Kokk <tanel.kokk@eyp.ee>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problem: myscript, crontab and policy rules for this
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have Fedora Core 2 with SElinux. I added a script into the crontab 
/etc/cron.d/myscript (it includes a line:
0 * * * *		/usr/local/bin/myscript > /dev/null 2>&1)

selinux logs following audit message:
avc:  denied  { transition } for  pid=17845 exe=/usr/sbin/crond 
path=/bin/bash dev=dm-0 ino=2850852 scontext=root:system_r:crond_t 
tcontext=user_u:sysadm_r:sysadm_t tclass=process

I use program audit2allow to generate correct rule to policy:
allow crond_t sysadm_t:process { transition };

I put it into the file domains/misc/local.te and 'make load'

Unfortunately it won't help because same audit log message will appear, 
when cron will try execute myscript.

What I have to do? Why audit2allow won't generate correct rules?

Tanel


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
