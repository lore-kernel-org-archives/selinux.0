Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA5BSh1f029014
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 06:28:43 -0500
Received: from house.lunarmania.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA5BSgG2022844
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 11:28:43 GMT
Received: from localhost ([127.0.0.1] helo=www.rubix.com)
	by house.lunarmania.com with esmtpa (Exim 4.69)
	(envelope-from <warner@rubix.com>)
	id 1KxgYy-00008N-HF
	for selinux@tycho.nsa.gov; Wed, 05 Nov 2008 03:28:40 -0800
Message-ID: <48137.78.3.234.122.1225884520.squirrel@www.rubix.com>
Date: Wed, 5 Nov 2008 03:28:40 -0800 (PST)
Subject: setroubleshoot var types
From: warner@rubix.com
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am running Fedora 9 with the mls policy and was investigating why my
setroubleshoot was not working. I found the following in
/var/log/messages:

Nov  3 09:27:39 localhost kernel: SELinux: inode_doinit_with_dentry: 
context_to_sid(system_u:object_r:setroubleshoot_var_lib_t:s0) returned 22
for dev=dm-2 ino=23923693
Nov  3 09:27:40 localhost kernel: SELinux: inode_doinit_with_dentry: 
context_to_sid(system_u:object_r:setroubleshoot_var_log_t:s0) returned 22
for dev=dm-2 ino=23923743
Nov  3 09:27:40 localhost kernel: SELinux: inode_doinit_with_dentry: 
context_to_sid(system_u:object_r:setroubleshoot_var_run_t:s0) returned 22
for dev=dm-2 ino=23923744
...
Nov  3 18:22:55 localhost setroubleshoot: [program.ERROR] setroubleshoot
generated AVC, exiting to avoid recursion,
context=system_u:system_r:initrc_t:SystemLow:SystemLow-SystemHigh, AVC
scontext=system_u:system_r:initrc_t:s0-s15:c0.c1023


Upon using the Policy Analysis tool I found that none of the
setroubleshoot_var_*_t types were associated with the object_r role. Is
this an issue with the setroubleshoot policy?

Andy




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
