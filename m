Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0MEuhRb008465
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 09:56:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0MEtUxr011730
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 14:55:30 GMT
Received: from s3cin.xetron.com (fw.xetron.com [216.68.89.2])
	by jazzswing.ncsc.mil  with ESMTP id i0MEtUYc011727
	for <selinux@tycho.nsa.gov>; Thu, 22 Jan 2004 14:55:30 GMT
Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A88@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "'russell@coker.com.au'" <russell@coker.com.au>
Cc: "SE Linux Mail List (E-mail)" <selinux@tycho.nsa.gov>
Subject: RE: transition failure
Date: Thu, 22 Jan 2004 09:56:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks Russ.  I was not aware of the constraints.  I'm am using "runcon"
because when I use "run_init" I get the following error:

    execvp: Permission Denied

I forgot to mention previously that the "runcon" command gives this same
error as well along with the "avc: denied { transition }" message.  

BTW, these errors only occur with enforcing=1 as run_init and runcon execute
swatch just fine with enforcing=0.
What does execvp mean?


-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au]
Sent: Thursday, January 22, 2004 2:25 AM
To: Kratzer, James R.; SE Linux Mail List (E-mail)
Subject: Re: transition failure


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

The "privrole" attribute is not current assigned to sysadm_t, although
changes 
are being made in this area...

Why not just use run_init?  Or allow swatch_t to be in sysadm_r?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
