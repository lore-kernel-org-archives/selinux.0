Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA12712
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 14:50:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA03697
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 19:50:44 GMT
Received: from staffnet.com (staffnet.com [207.226.80.14])
	by jazzband.ncsc.mil  with ESMTP id TAA03693
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2001 19:50:44 GMT
Message-ID: <3AA93409.77597AF8@staffnet.com>
Date: Fri, 09 Mar 2001 14:50:33 -0500
From: Wade Hampton <whampton@staffnet.com>
MIME-Version: 1.0
To: Michael Tiemann <tiemann@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: RedHat 7.0?
References: <72222DC86846D411ABD300A0C9EB08A1015240BD@csoc-mail-box.csoconline.com> <3AA8F3EF.83B711A@redhat.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Michael Tiemann wrote:
> 
> Another solution is to update your compiler to the latest errata version.
> With this compiler, you can get all the optimizations we put into the
> user-level compiler, plus it works on the kernel (certainly for Wolverine,
> our second public beta).

I checked and realized I did not have the latest compiler loaded,
but had gcc-2.96-54.  I now have gcc-2.96-69 and will retest.
I'll also check with wolverine....

Thanks,
--
Wade

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
