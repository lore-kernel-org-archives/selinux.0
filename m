Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k87Lq5pO028211
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:52:06 -0400
Received: from e5.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k87LpKuU008968
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 21:51:20 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87Lq5BK006180
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:52:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k87Lq526233208
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:52:05 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k87Lq537004448
	for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2006 17:52:05 -0400
Message-ID: <4500947C.6090400@us.ibm.com>
Date: Thu, 07 Sep 2006 16:51:56 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, lspp-list <redhat-lspp@redhat.com>,
        selinux@tycho.nsa.gov
Subject: Re: MLS Policy (rawhide)
References: <4500906A.3000502@us.ibm.com>
In-Reply-To: <4500906A.3000502@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> Hey all,
> 
> It seems that ssh is unable to add entries to known_hosts for the root 
> user as sysadm_t. Is this a known issue? And if so, who can add entries 
> to /root/.ssh/known_hosts ?

I think I should point out that this isn't as the user, but when 
executing ssh as root.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
