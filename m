Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UKpvDo018626
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 15:51:58 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UKm6ph010083
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 20:48:07 GMT
Date: Wed, 30 Mar 2005 15:50:45 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Steve G <linux_4ever@yahoo.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Getting the real task name in avc messages
In-Reply-To: <20050330195313.44516.qmail@web51504.mail.yahoo.com>
Message-ID: <Xine.LNX.4.44.0503301550070.14531-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Mar 2005, Steve G wrote:

> Hello,
> 
> Attached is a patch to the kernel that puts the program's name into the avc
> message. This lets you know the script that caused the problem instead of
> /bin/bash. Feedback would be appreciated.

This will be looked upon dimly upstream:

+        char name[sizeof(current->comm)];

the kernel stack space is very limited.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
