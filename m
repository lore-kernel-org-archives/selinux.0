Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1L4xPdW016065
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 23:59:25 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1L4t2pm021400
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 04:55:02 GMT
Received: from [192.168.2.105] (cpe-24-58-1-204.twcny.res.rr.com [24.58.1.204])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j1L4vNEA024193
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 23:57:24 -0500 (EST)
Subject: Access_terminal + ioctl
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Sun, 20 Feb 2005 23:59:54 -0500
Message-Id: <1108961995.20655.8.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is it all right if I add back ioctl permission
on $1_devpts_t, $1_tty_device_t, and devtty_t (chr_file)
in the access_terminal macro?

Already all of those domains need it:
- smbmount_t
- $1_su_t
- $1_ssh_t
- $1_gpg_t
- $1_mplayer_t
- $1_mencoder_t

Can I just use rw_file_perms?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
