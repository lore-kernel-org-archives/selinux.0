Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9F9PiNs014435
	for <selinux@tycho.nsa.gov>; Sat, 15 Oct 2005 05:25:44 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9F9NN42021936
	for <selinux@tycho.nsa.gov>; Sat, 15 Oct 2005 09:23:23 GMT
Message-ID: <4350CCFC.80900@cornell.edu>
Date: Sat, 15 Oct 2005 05:33:48 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Record keys
References: <434F5E3A.5030003@cornell.edu> <434F5E8C.1050708@cornell.edu>
In-Reply-To: <434F5E8C.1050708@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
>> Please help me decide what to do with the record key for the record 
>> structures which I've added into libsepol and libsemanage. Stephen 
>> has now exported those functions into the shared library, so after an 
>> official release, it would be good not to be changing those APIs.
Joshua? No comments?
(see original message for details)

If nobody suggests anything, I am likely to leave the key in, and add a 
key_unpack function, and pass the key down to the sepol level....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
