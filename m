Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11661
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 12:05:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA23143
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 17:05:53 GMT
Received: from lodgistix.com ([64.123.115.90])
	by jazzswing.ncsc.mil  with ESMTP id RAA23139
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 17:05:52 GMT
Message-ID: <A4EDF51C1ED0D411818E0004AC4C1D7E04918A@EXCHANGE_ICT>
From: "Ellis, Wes" <wes.ellis@aremissoft.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: RedHat 7.0?
Date: Fri, 9 Mar 2001 10:57:03 -0600 
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Out-of the box, Red Hat 7.0 Comes packaged with Kernel headers for a
completely different kernel than the system was released on, if you check
the included packages, the only headers are for 2.4.X, I had to find the
correct headers before I was able to build some things with gcc.

-----Original Message-----
From: richard offer [mailto:offer@sgi.com]
Sent: Friday, March 09, 2001 9:24 AM
To: Wade Hampton; Westerman, Mark
Cc: selinux@tycho.nsa.gov
Subject: Re: RedHat 7.0?



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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
