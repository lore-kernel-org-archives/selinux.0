Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NEOHrT009406
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 10:24:17 -0400 (EDT)
Received: from mail.mvalent.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NENHv8018688
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 14:23:17 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: bash_profile: Permission denied
Date: Thu, 23 Sep 2004 10:24:17 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CB71F3E@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


When I login in enforced mode I get this error as root:
-bash: /root/.bash_profile: Permission denied
ftp root # pwd       
/root
ftp root # ls -aZ
ls: .: Permission denied
ftp root #

I thought it might be a labeling issue so I ran this command:
ftp domains # newrole -r sysadm_r
Authenticating root.
Password: 
ftp domains # cd /
ftp / # setfiles /etc/security/selinux/file_contexts /root/
setfiles:  read 575 specifications
setfiles:  labeling files under /root/
setfiles:  hash table stats: 5 elements, 5/65536 buckets used, longest
chain length 1
setfiles:  Done.

I'm not getting any messages in /var/log/messages when I avc_toggle.


Am I on the right track?

James





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
