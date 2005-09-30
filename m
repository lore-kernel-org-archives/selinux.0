Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U3UmNs024024
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:30:48 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U3P8A9015967
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 03:25:08 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8U3P3wF027994
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:25:08 -0400 (EDT)
Message-ID: <433CB22C.20808@cornell.edu>
Date: Thu, 29 Sep 2005 23:34:04 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Linking to semanage
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Okay, this test compiled a while ago... and now it won't link. I don't 
understand why - can someone who knows something about linking give me a 
hint? I hope I didn't break static linking with my patches somehow 
(can't see how)...

[phantom@cobra test5]$ ./compile
test.c:(.text+0x1d): undefined reference to `semanage_handle_create'
test.c:(.text+0x41): undefined reference to `semanage_handle_destroy'
collect2: ld returned 1 exit status
[phantom@cobra test5]$ cat compile
gcc -static /usr/lib/libselinux.a /usr/lib/libsepol.a 
/usr/lib/libsemanage.a test.c -o test
[phantom@cobra test5]$ nm /usr/lib/libsemanage.a|grep semanage_handle
00000000 T semanage_handle_create
00000209 T semanage_handle_destroy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
