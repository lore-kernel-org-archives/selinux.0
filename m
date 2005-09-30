Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U5w2Ns024927
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 01:58:02 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U5qLxX025030
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 05:52:21 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8U5qKwF006906
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 01:52:20 -0400 (EDT)
Message-ID: <433CD4B2.2010606@cornell.edu>
Date: Fri, 30 Sep 2005 02:01:22 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Memory leaks
References: <433CA7CA.6000207@cornell.edu> <433CB137.9000002@cornell.edu>
In-Reply-To: <433CB137.9000002@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

> Here's a couple of memory leaks, if anyone wants to investigate. If 
> not, I'll take a look at them eventually. The first one is my fault. 
> The second one isn't. The main binary I used doesn't bother freeing 
> things, but I think valgrind is smart enough to recognize that, and 
> those are real leaks.
>
Disregard this, I am giving valgrind too much credit....adding free() in 
main where appropriate fixes those non-leaks.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
