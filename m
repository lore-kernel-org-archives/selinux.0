Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA10308
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 09:19:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA16289
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 14:19:25 GMT
Received: from staffnet.com (staffnet.com [207.226.80.14])
	by jazzband.ncsc.mil  with ESMTP id OAA16285
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 14:19:22 GMT
Message-ID: <3AA8E660.8F9E0690@staffnet.com>
Date: Fri, 09 Mar 2001 09:19:12 -0500
From: Wade Hampton <whampton@staffnet.com>
MIME-Version: 1.0
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
CC: selinux@tycho.nsa.gov
Subject: Re: RedHat 7.0?
References: <72222DC86846D411ABD300A0C9EB08A1015240BD@csoc-mail-box.csoconline.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

"Westerman, Mark" wrote:
> 
> I had to modify the Makefile to point the CC compiler to kgcc.
> The is a bug somewhere the prevents the gcc from compiling the
> kernel. Redhat has kgcc to compile the kernel. I have a working
> somewhat version of the Redhat 7.0. Let me know how it goes
> with your try of 7.0
I thought the kgcc issue was only for stock 7.0 and not
for after one has upgraded the compiler?  At home, I built
stock 2.4.0 on my upgraded 7.0 w/o any problems....

I'll tgz my VMWare image and try it at home this weekend.....

Thanks,
--
Wade

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
