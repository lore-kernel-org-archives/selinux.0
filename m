Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88I8vVA028555
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 14:08:57 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88I8XW3007396
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 18:08:33 GMT
Message-ID: <4501B1B1.4020103@redhat.com>
Date: Fri, 08 Sep 2006 14:08:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: lspp-list <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov
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
> user as sysadm_t. Is this a known issue? And if so, who can add 
> entries to /root/.ssh/known_hosts ?
>
> Thanks,
> Mike
>
This works for me.  How is the file labeled?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
