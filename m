Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j78G1JOb015482
	for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2005 12:01:19 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j78FqhiY019932
	for <selinux@tycho.nsa.gov>; Mon, 8 Aug 2005 15:52:43 GMT
Message-ID: <42F7805B.3040607@tresys.com>
Date: Mon, 08 Aug 2005 11:55:07 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, selinux-dev@tresys.com
Subject: Attributes in new binary format
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the new binary format the attribute values are preserved in the avtab 
but the attribute entries in the type symbol table are destroyed.

This makes analysis on the binary format difficult for a number of reasons.

Tools like apol will have to expand the type bitmaps and will lose 
attibutes on types. This is the same as analysing the current (v19) 
binary format but including attributes will be beneficial to analysis.

Further, the hierarchal constraint checking is currently broken with the 
new format. The reason is that we must be able to expand attributes at 
check time to ensure that types weren't given permissions via attributes 
that violate the constraints. This can be done with the new format but 
it's very time consuming.

I'd like to suggest that we preserve the attibute entries in the type 
table in the binary format and modify the kernel read function to not 
allocate space for them as it reads them in. This makes the binary 
format much more usable in terms of analysis at no cost to the kernel 
memory.

Let me know what you think.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
