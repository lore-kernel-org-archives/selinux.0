Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3KDF07C000259
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 09:15:00 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3KD7QqS028924
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 13:07:26 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3KDAfRH015963
	for <selinux@tycho.nsa.gov>; Wed, 20 Apr 2005 09:10:41 -0400 (EDT)
Subject: CVS Policy on Sourceforge Updated
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 09:11:17 -0400
Message-Id: <1114002677.31519.5.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.23.12 2005-04-20
* Merged Dan Walsh's Netlink changes to handle new auditing pam modules.
* Merged Dan Walsh's patch removing the sysadmfile attribute from policy
files to separate sysadm_t from secadm_t.
* Added CVS and uucpd policy from Dan Walsh.
* Cleanup by Dan Walsh to handle turning off unlimitedRC.
* Merged Russell Coker's fixes to ntpd, postgrey, and named policy.
* Cleanup of chkpwd_domain and added permissions to su_domain macro due
to pam changes to support audit.
* Added nlmsg_relay and nlmsg_readpriv permissions to the
netlink_audit_socket class.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
