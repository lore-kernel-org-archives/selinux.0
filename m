Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3FLjqRb010839
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2004 17:45:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3FLjpmw018606
	for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2004 21:45:51 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
        by jazzband.ncsc.mil  with ESMTP id i3FLjo4w018601 for <selinux@tycho.nsa.gov>; Thu, 15 Apr 2004 21:45:50 GMT
Message-Id: <200404152145.i3FLjOJx021857@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Mark Shakespeare'" <mshakes@llnl.gov>, <selinux@tycho.nsa.gov>
Subject: RE: Setools 1.2.1 broken after upgrading to NSA release 2.6.5
Date: Thu, 15 Apr 2004 17:45:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <p06100505bca4727973a5@[128.115.96.64]>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Mark Shakespeare [mailto:mshakes@llnl.gov]
> Sent: Thursday, April 15, 2004 1:26 PM
> To: selinux@tycho.nsa.gov
> Cc: kmacmillan@tresys.com
> Subject: Setools 1.2.1 broken after upgrading to NSA release 2.6.5
> 
> I recently upgraded my kernel and packages to 2.6.5 from the NSA
> site. ( Apr 8 )
> 
> The package included Setools 1.2.1, and was installed as well.
> 
> Now only Sepcut works,  .....Apol,SeuserX,Seinfo and Seaudit complain
> about
> bad policy files and other things.
> 

All of these problems are fixed by the new setools 1.3 version that I just
released.

Karl

Karl MacMillan
Tresys Technology
http://www.tresys.com
(410)290-1411 ext 134

> What exact components/Libraries are needed to have this function again?
> 
> Any help would be greatly appreciated.
> 
> I currently have...
> 
> policy-1.11.2-3
> policy-sources-1.11.2-3
> setools-1.2-1
> kernel-2.6.5-selinux1
> libselinux-1.10.1
> libselinux-devel-1.10-1
> 
> Thanks.
> 
> 
> 							Mark
> --
> ******************************************
> * Mark Shakespeare			 *
> * Engineering Computer Operations Team   *
> * Lawrence Livermore National Laboratory *
> * 7000 East Ave		L-130            *
> * Livermore,Ca 94550			 *
> * 925-423-9922	      mshakes@llnl.gov   *
> ******************************************


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
