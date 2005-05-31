Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VIcXgA007801
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 14:38:33 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VIWGpZ014464
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 18:32:16 GMT
Received: from moss-lions.epoch.ncsc.mil (moss-lions [144.51.25.4])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VIWxRH025328
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 14:32:59 -0400 (EDT)
Subject: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 31 May 2005 14:33:23 -0400
Message-Id: <1117564403.3260.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.23.18 2005-05-31
* Merged minor fixes to pppd.fc and courier.te by Russell Coker
* Removed devfsd policy as suggested by Russell Coker
* Merged patch from Dan Walsh.  Includes beginnings of Ivan Gyurdiev's
Font Config policy.  Don't transition to fsadm_t from unconfined_t
(sysadm_t) in targeted policy.  Add support for debugfs in modutil.
Allow automount to create and delete directories in /root and /home
dirs.  Move can_ypbind to chkpwd_macro.te.  Allow useradd to create
additional files and types via the skell mechanism.  Other minor
cleanups and fixes.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
