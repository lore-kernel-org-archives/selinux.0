Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9F0blWt022671
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:37:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9F0bkmR008537
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 00:37:46 GMT
Received: from zaphod.crypt.gen.nz (203-79-124-63.adsl.paradise.net.nz [203.79.124.63])
        by jazzband.ncsc.mil  with ESMTP id h9F0bgjp008532 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 00:37:46 GMT
Message-ID: <3586.202.27.185.71.1066178261.squirrel@www.crypt.gen.nz>
In-Reply-To: <GMECJOINLDFDGEEPGINLAEGECKAA.richard.wanner@cgi.com>
References: <GMECJOINLDFDGEEPGINLAEGECKAA.richard.wanner@cgi.com>
Date: Wed, 15 Oct 2003 13:37:41 +1300 (NZDT)
Subject: Re: Compile/build problem in Red Hat 9.0
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: "Richard Herbert Wanner" <richard.wanner@cgi.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Looks like the net drivers haven't been built, or not built properly - its
just the kernel, not an SELinux specific problem. Go back and 'make
menuconfig' - making sure the appropriate net modules are enabled. Then
run the usual:

make dep
make bzImage
make modules
make install
make modules_install

Checking that each completes successfully.

Kerry

-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz

Richard Herbert Wanner said:
> I am trying to build the SE-Linux 2.4 kernel on Red Hat 9.0.  The make
> does not generate any obvious errors, (but there are .o files missing, and
> when we try to compile dummy.c by hand, it fails), but the make
> module_install fails.
>
> Here is the tail end of the console for the make module_install (sorry, I
> didn't capture the make console)
>
> make[2]: Entering  directory '/tmp/linux-2.4/drivers/net'
> mkdir -p /lib/modules/2.4.21-selinux2/kernel/drivers/net/
> cp dummy.o /lib/modules/2.4.21-selinux2/kernel/drivers/net/
> cp: cannot stat 'dummy.o': No such file or directory
> make[2]: *** [_modinst_] Error 1
>
>
> Anybody have any idea what I can do to resolve this?
>
>
>
>
> Richard (Rick) Wanner B.Sc. GCFW
>
> Consultant
>
> Security Engineering & Evaluation Group
>
> InfoSec Centre of Expertise (COE)
>
> CGI Information Systems & Management Consultants Inc.
>
> Ottawa, Canada
>
> http://www.infosec.cgi.com/
>
> Email: richard.wanner@cgi.com
>
> Tel:    (613) 234-2155
>
> Cell:    (613) 220-2045
>
> Fax:    (613) 234-6934
>
> Confidentiality Notice: This e-mail message, including any attachments, is
> for the sole use of the intended recipient(s) and may contain confidential
> and privileged information. Any unauthorized review, use, disclosure or
> distribution is prohibited. If you are not the intended recipient, please
> contact the sender by reply e-mail and destroy all copies of the original
> message.
>
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
