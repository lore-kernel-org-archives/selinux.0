Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U3QdNs023974
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:26:40 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U3KnS2018927
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 03:20:49 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8U3KwwF026811
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:21:00 -0400 (EDT)
Message-ID: <433CB137.9000002@cornell.edu>
Date: Thu, 29 Sep 2005 23:29:59 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Memory leaks
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a couple of memory leaks, if anyone wants to investigate. If not, 
I'll take a look at them eventually. The first one is my fault. The 
second one isn't. The main binary I used doesn't bother freeing things, 
but I think valgrind is smart enough to recognize that, and those are 
real leaks.

==10639== 8 bytes in 2 blocks are definitely lost in loss record 4 of 74
==10639==    at 0x1B9017F2: malloc (vg_replace_malloc.c:149)
==10639==    by 0x805313F: sepol_user_get_roles (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==    by 0x80493D9: main (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==
==10639==
==10639== 64 (32 direct, 32 indirect) bytes in 2 blocks are definitely 
lost in loss record 21 of 74
==10639==    at 0x1B9017F2: malloc (vg_replace_malloc.c:149)
==10639==    by 0x805C46A: ebitmap_read (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==    by 0x804EA64: mls_read_range_helper (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==    by 0x805044D: user_read (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==    by 0x8051923: policydb_read (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==    by 0x8051F50: policydb_from_image (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==    by 0x804AFE9: sepol_genusers (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)
==10639==    by 0x8049291: main (in 
/home/phantom/rpmbuild/BUILD/test.mls/test)




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
