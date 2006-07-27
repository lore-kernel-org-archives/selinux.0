Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6RFcq3F024476
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 11:38:52 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6RFcnCo023379
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 15:38:50 GMT
Message-ID: <44C8DE0A.1080400@mentalrootkit.com>
Date: Thu, 27 Jul 2006 11:38:50 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Converting ebitmaps to copy-on-write?
References: <44C788CA.8040907@hp.com>
In-Reply-To: <44C788CA.8040907@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> Can anyone think of reason why converting the ebitmap code to a copy on
> write scheme would be a bad idea?  Yes, there would be some overhead in
> maintaining reference counts but I suspect the added overhead would be
> more than offset by the reduction in kmalloc() calls ... thoughts?
>
>   
Which ebitmaps are shared enough for this to help? I don't think I have 
enough context to know whether this would be a good idea or not.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
