Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87LYsm6027784
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:34:54 -0400
Received: from e3.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87LYTDY013888
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 21:34:30 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87LYpnS008883
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:34:51 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k87LYhTv233338
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:34:51 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k87LYhoB032368
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:34:43 -0400
Message-ID: <4500906A.3000502@us.ibm.com>
Date: Thu, 07 Sep 2006 16:34:34 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>, lspp-list <redhat-lspp@redhat.com>,
        selinux@tycho.nsa.gov
Subject: MLS Policy (rawhide)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hey all,

It seems that ssh is unable to add entries to known_hosts for the root 
user as sysadm_t. Is this a known issue? And if so, who can add entries 
to /root/.ssh/known_hosts ?

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
