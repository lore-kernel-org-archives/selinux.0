Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m28A1Yhe014513
	for <selinux@tycho.nsa.gov>; Sat, 8 Mar 2008 05:01:34 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m28A1WEN002954
	for <selinux@tycho.nsa.gov>; Sat, 8 Mar 2008 10:01:33 GMT
Received: from [IPv6:2001:6f8:1294:1:211:24ff:fee1:776c] ([IPv6:2001:6f8:1294:1:211:24ff:fee1:776c])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id m28A15Mg003450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Sat, 8 Mar 2008 11:01:31 +0100
Subject: prelink, cron-job and SELinux compliance
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sat, 08 Mar 2008 11:01:05 +0100
Message-Id: <1204970465.4229.10.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In RHEL/CentOS 5.1 a cron job (/etc/cron.daily/prelink) runs prelink.
The cron job itself removes a file (/etc/prelink.cache) if necessary and
updates the database. This does not work with the strict SELinux policy.

To solve this I patched the prelink application to
use /var/cache/prelink/prelink.cache instead of /etc/prelink.cache
This would make it more easier to write SELinux policies. But know my
actual question is how to modify the cron job to work properly? All cron
jobs on my system are labeled as bin_t. This would mean that
system_crond_t needs write/create etc. permissions
on /var/cache/prelink. Thats not really nice and I would prefer to
create a domain like cron_script_prelink_t for /etc/cron.daily/prelink
which gets all the rights to manage /var/cache/prelink.

What are your ideas to handle cron scripts properly?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
