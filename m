Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2S1Lrx6028036
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2003 20:21:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2S1IJlY022440
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 01:18:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2S1IGKX022437
	for <selinux@tycho.nsa.gov>; Fri, 28 Mar 2003 01:18:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE Linux on ARM
Date: Fri, 28 Mar 2003 02:21:21 +0100
References: <200303242201.33705.russell@coker.com.au>
In-Reply-To: <200303242201.33705.russell@coker.com.au>
Cc: familiar@handhelds.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303280221.21079.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Mar 2003 22:01, Russell Coker wrote:
> I have also ported it to the 2.4.19 ARM kernel and put it on
> http://www.coker.com.au/arm/
> One patch is for the main LSM and SE code, the other is for the ARM
> specific SE code, both patches are required.  They are separate for ease of
> management.
>
> The following entry in /etc/ipkg.conf is for a feed of kernel packages
> based on the above patches:
> src 2.4.19 http://adsl.coker.com.au/ipaq/

I have just updated this feed to include the latest hh8 kernel build (with the 
Oops fixed) which is compiled with the latest gcc 3.2.3 compiler to fix the 
JFFS2 errors.

I have also added a package "selinux" to the feed which contains the core SE 
Linux utility programs.  Tomorrow I expect to put a policy online which 
allows the machine to boot in enforcing mode.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
