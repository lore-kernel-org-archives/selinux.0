Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HJ8xWt011139
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:08:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9HJ8n0p004384
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 19:08:49 GMT
Received: from dymwsm08.mailwatch.com (dymwsm08.mailwatch.com [204.253.83.44])
	by jazzswing.ncsc.mil  with ESMTP id h9HJ8mr7004375
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 19:08:49 GMT
Received: from mwsc0231.mw4.mailwatch.com (mwsc0231.mw4.mailwatch.com [204.253.83.45])
	by dymwsm08.mailwatch.com (8.12.9/8.12.9) with ESMTP id h9HJ8u2m022105
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:08:56 -0400
Received: from fmpo1.azell.com (fmpo1.azell.com [136.1.7.9])
	by dymwsm15.mailwatch.com (8.12.9/8.12.9) with ESMTP id h9HJ8sng008622
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 15:08:55 -0400
Message-ID: <752E6D5014672D458A593B5E7A3CD5F56165D5@na1fcm51.dearborn.ford.com>
From: "Inger, Slav (S.B.)" <vinger@ford.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "SELinux ML (E-mail)" <selinux@tycho.nsa.gov>
Subject: RE: Sample config
Date: Fri, 17 Oct 2003 15:08:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Friday, October 17, 2003 11:56 AM
To: Inger, Slav (S.B.)
Cc: SELinux ML (E-mail)
Subject: Re: Sample config

> First, you need to get your system into a working state, which it isn't
> if everything is running in kernel_t.  Did you label your filesystem? 
> Does ls --context /sbin/init show the correct context?  If not, then
> relabel your filesystem and reboot as per the README.  If it is labeled
> correctly, then another possible explanation is that you didn't load the
> policy via an initrd prior to executing /sbin/init, so the domain
> transition didn't occur.  


Thanks for feedback, Stephen.  Actually, the problem was that initrd wasn't doing the policy load because I forgot to mount -t selinuxfs before policy_load in /linuxrc (I did my own custom ramdisk config).  The policy is loading fine now and I start to see avc messages right from the get go, so that's a good sign.  ps also shows more encouraging results.  I'll have to play with it some more, but it's looking good so far.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
