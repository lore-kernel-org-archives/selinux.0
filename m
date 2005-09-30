Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U5qbNs024868
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 01:52:37 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U5kjCQ027182
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 05:46:45 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8U5kvwF005826
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 01:46:58 -0400 (EDT)
Message-ID: <433CD370.2070008@cornell.edu>
Date: Fri, 30 Sep 2005 01:56:00 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Linking to semanage
References: <433CA7CA.6000207@cornell.edu> <433CB22C.20808@cornell.edu>
In-Reply-To: <433CB22C.20808@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

> Okay, this test compiled a while ago... and now it won't link. I don't 
> understand why - can someone who knows something about linking give me 
> a hint? I hope I didn't break static linking with my patches somehow 
> (can't see how)...

Hmm..apparently order of arguments to gcc matters for static linking. I 
did not know that... reordering things differently makes it work.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
