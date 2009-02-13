Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DNsw11001943
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 18:54:58 -0500
Received: from trauma.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DNpexb017845
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 23:51:41 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
Date: Fri, 13 Feb 2009 18:54:55 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED15BA0249@HAVOC.tcs-sec.com>
References: <20090212211531.619341973@hp.com> <200902131702.10467.paul.moore@hp.com> <170D6ABBBA770349AA49582A86FCED15BA0238@HAVOC.tcs-sec.com> <200902131817.29764.paul.moore@hp.com>
From: <chanson@TrustedCS.com>
To: <paul.moore@hp.com>
Cc: <Glenn.Faden@sun.com>, <refpolicy@oss.tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
> 
> Just out of curiosity, are you guys using any of the new 
> stuff or are you still using your own special kernel with the 
> rejected network controls?  I ask because I would be curious 
> about any feedback you might have on the new bits in mainline.
> 

We can't really use anything new since we use the same baseline for
multiple products, each of which may go through multiple accreditations,
some of which are much stricter than others as to changed content.
Therefore, we continue to use our patch on the approved baseline which
adds the same basic ideas as the mainline enhancements.

-Chad 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
