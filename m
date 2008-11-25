Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAP40ndD007023
	for <selinux@tycho.nsa.gov>; Mon, 24 Nov 2008 23:00:49 -0500
Received: from mho-01-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAP40kl0000591
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2008 04:00:49 GMT
Received: from cpe-66-68-165-162.austin.res.rr.com ([66.68.165.162] helo=[192.168.20.230])
	by mho-01-bos.mailhop.org with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <joe@nall.com>)
	id 1L4p6U-0004nH-53
	for selinux@tycho.nsa.gov; Tue, 25 Nov 2008 04:00:46 +0000
Message-Id: <D52C0637-73C3-42BB-862E-447D5B404B48@nall.com>
From: Joe Nall <joe@nall.com>
To: SE-Linux Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Polyinstantiation in cron
Date: Mon, 24 Nov 2008 22:00:44 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I created a normal user (urss) and added a crontab entry for that user  
that runs a script. I can get the script launched at level, but not  
polyinstantiated. A 'cat /proc/mounts' shows no polyinstantiation for  
the cron session, but a normal login session has properly  
polyinstantiated directories.

The crontab entry looks like:

SELINUX_ROLE_TYPE=user_u:user_r:user_t:UNCLASSIFIED-UNCLASSIFIED
* * * * * /opt/jcdx/libexec/urss-rss2email-cron.sh
SELINUX_ROLE_TYPE=user_u:user_r:user_t:UNCLASSIFIED-UNCLASSIFIED
* * * * * /opt/jcdx/libexec/urss-delivermail-cron.sh

The relevant portion of /opt/jcdx/libexec/urss-delivermail-cron.sh

#!/bin/bash
id
ls -Z /var/mailboxes
cat /proc/mounts

Have I missed some cron specific pam configuration? Did this work for  
RHEL 5.X LSPP?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
