Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2UM5uDo019600
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 17:05:56 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2UM24ph014734
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 22:02:05 GMT
Date: Wed, 30 Mar 2005 17:04:43 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Steve G <linux_4ever@yahoo.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Getting the real task name in avc messages
In-Reply-To: <Xine.LNX.4.44.0503301550070.14531-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0503301704130.15296-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 30 Mar 2005, James Morris wrote:

> This will be looked upon dimly upstream:
> 
> +        char name[sizeof(current->comm)];
> 
> the kernel stack space is very limited.

Actually, current->comm is only defined by default to be 16 bytes, so it's 
ok.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
