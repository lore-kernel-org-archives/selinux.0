Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA10778
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 10:25:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA17728
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 15:25:04 GMT
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA17718
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 15:25:02 GMT
From: "richard offer" <offer@sgi.com>
Message-Id: <1010309072340.ZM45572@sgi.com>
Date: Fri, 9 Mar 2001 07:23:39 -0800
In-Reply-To: Wade Hampton <whampton@staffnet.com>
        "Re: RedHat 7.0?" (Mar  9,  9:19am)
References: <72222DC86846D411ABD300A0C9EB08A1015240BD@csoc-mail-box.csoconline.com>
	<3AA8E660.8F9E0690@staffnet.com>
To: Wade Hampton <whampton@staffnet.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: RedHat 7.0?
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


* $ from whampton@staffnet.com at "9-Mar: 9:19am" | sed "1,$s/^/* /"
*
*
* "Westerman, Mark" wrote:
* >
* > I had to modify the Makefile to point the CC compiler to kgcc.
* > The is a bug somewhere the prevents the gcc from compiling the
* > kernel. Redhat has kgcc to compile the kernel. I have a working
* > somewhat version of the Redhat 7.0. Let me know how it goes
* > with your try of 7.0
* I thought the kgcc issue was only for stock 7.0 and not
* for after one has upgraded the compiler?  At home, I built
* stock 2.4.0 on my upgraded 7.0 w/o any problems....
*
* I'll tgz my VMWare image and try it at home this weekend.....

Right, but the 2.2 stream wont build with the 7.0 gcc.

*
* Thanks,
* --
* Wade


richard.


-----------------------------------------------------------------------
Richard Offer                         Technical Lead, Trust Technology.
"Specialization is for insects"
__________________________________________http://reality.sgi.com/offer/


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
