Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0M7QIRb006754
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 02:26:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0M7QGCa027073
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 07:26:16 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i0M7Q4VC027055 for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 07:26:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Kratzer, James R." <JamesK@xetron.com>,
   "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
Subject: Re: transition failure
Date: Thu, 22 Jan 2004 18:24:39 +1100
References: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A87@s3cin>
In-Reply-To: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A87@s3cin>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401221824.39426.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 22 Jan 2004 10:20, "Kratzer, James R." <JamesK@xetron.com> wrote:
> I have SE Linux kernel 2.4 installed and I have a swatch type definition
> file called "swatch.te" in my policy.
> I have the following rule in my policy and I have reloaded my policy:
>
>     allow sysadm_t swatch_t:process { setexec transition };
>
> I log in as root in the sysadm role and run the following command at the
> command line:
>
>     runcon system_u:system_r:swatch_t /etc/rc.d/init.d/swatchd start
>
> The following error occurs:
>
>     avc: denied { transition } for pid=4295 exe=/usr/bin/runcon
> patch=/etc/rc.d/init.d/swatchd dev=08:02 ino=194832
>     scontext=root:sysadm_r:sysadm_t tcontext=system_u:system_r:swatch_t
> tclass=process

In the default "constraints" file you have:
constrain process transition
        ( r1 == r2 or t1 == privrole) ;

The "privrole" attribute is not current assigned to sysadm_t, although changes 
are being made in this area...

Why not just use run_init?  Or allow swatch_t to be in sysadm_r?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
