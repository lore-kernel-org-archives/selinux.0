Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i950eqrT022767
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 20:40:52 -0400 (EDT)
Received: from rwcrmhc11.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i950eps6005076
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 00:40:51 GMT
Message-ID: <4161ED86.2080200@tresys.com>
Date: Mon, 04 Oct 2004 20:40:38 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Trent Jaeger <jaegert@us.ibm.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Add a new class
References: <OF459C4AF8.918C9B11-ON85256F23.00798D88-85256F23.0079ECBE@us.ibm.com>
In-Reply-To: <OF459C4AF8.918C9B11-ON85256F23.00798D88-85256F23.0079ECBE@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Check the files in policy/flask

specifically you must add the class to security_classes and the 
permissions to access_vectors and then rebuild the headers with the 
Makefile in the flask directory and put them in 
linux/security/selinux/include/

then reboot on the new kernel and build a policy with the new classes 
and access vectors, it should be fairly straightforward and no problems 
should occur.

Joshua Brindle

Trent Jaeger wrote:

>
> Hi,
>
> I think this is something I could find in the docs or code, but I 
> don't see it.  
>
> How do I add a new class?  There are a variety of files in 
> security/selinux/include, such as av_permissions.h, that are 
> "automatically generated", but they are already in the distribution, 
> so it is not clear how they are generated.  If I add a class, 
> operations, etc., these files have to be modified and I would rather 
> do it the proper way.
>
> BTW -- this is for adding IPSec security associations for classes, so 
> we can label network connections.  Prototype code should be available 
> soon.
>
> Regards,
> Trent.
> ------------------------------------------------------------
> Trent Jaeger
> IBM T.J. Watson Research Center
> 19 Skyline Drive, Hawthorne, NY 10532
> (914) 784-7225, FAX (914) 784-7225 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
