Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9F0uLWt022733
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:56:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9F0uKmR009214
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 00:56:20 GMT
Received: from whms0094.cwshs.com (mailout.cgi.com [66.110.7.6])
        by jazzband.ncsc.mil  with ESMTP id h9F0uJjp009211 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 00:56:19 GMT
Received: from whml0343.cgi.com ([10.254.251.20]) by
          whms0094.cwshs.com (Netscape Messaging Server 4.15 whms0094 Jul
          22 2001 13:33:35) with SMTP id HMRX9V01.MKZ for
          <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 20:56:19 -0400
From: "Richard Herbert Wanner" <richard.wanner@cgi.com>
To: <selinux@tycho.nsa.gov>
Cc: "Kerry Thompson" <kerry@crypt.gen.nz>
Subject: RE: Compile/build problem in Red Hat 9.0
Date: Tue, 14 Oct 2003 20:54:32 -0400
Message-ID: <GMECJOINLDFDGEEPGINLMEGFCKAA.richard.wanner@cgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3586.202.27.185.71.1066178261.squirrel@www.crypt.gen.nz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -----Original Message-----
> From: Kerry Thompson [mailto:kerry@crypt.gen.nz]
> Sent: Tuesday, October 14, 2003 8:38 PM

> 
> 
> Looks like the net drivers haven't been built, or not built properly - its
> just the kernel, not an SELinux specific problem. Go back and 'make
> menuconfig' - making sure the appropriate net modules are enabled. Then
> run the usual:
> 
> make dep
> make bzImage
> make modules
> make install
> make modules_install
> 
> Checking that each completes successfully.

Thanks.  These steps are quite a bit different from the ones in the docs in the usr package. Did I miss something?
The 2.6 docs and the 2.4 docs look the same, am I using the wrong ones?

The docs in the usr package in the 2.4 bundle say.

	cd linux-2.4
	make menuconfig
	make 
	make modules_install
	make install

Thanks again.

Rick



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
