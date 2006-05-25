Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4P3TkUT022002
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 23:29:46 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4P3Tikk018554
	for <selinux@tycho.nsa.gov>; Thu, 25 May 2006 03:29:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Christopher L Tubbs II <chris@tubbs-net.com>
Subject: Re: HTTPD network access Policy Problem
Date: Thu, 25 May 2006 13:21:46 +1000
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
References: <44738020.3090200@tubbs-net.com> <1148479969.31984.183.camel@sgc.columbia.tresys.com> <4474FD2C.3080004@tubbs-net.com>
In-Reply-To: <4474FD2C.3080004@tubbs-net.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605251321.50540.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 25 May 2006 10:41, Christopher L Tubbs II <chris@tubbs-net.com> 
wrote:
> > First we need to see the denial messages (avc: denied messages) to see
> > exactly what permissions are being denied.  You can find them
> > in /var/log/messages (or /var/log/audit/audit.log if you have auditd
> > running).
>
> It should be noted that I am using PHP to do the mailing.
>
> May 24 20:37:15 tubbs-net kernel: audit(1148517435.478:65): avc:  denied
>  { execute } for  pid=2456 comm="httpd" name="bash" dev=dm-0 ino=3470057
> scontext=system_u:system_r:httpd_t:s0
> tcontext=system_u:object_r:shell_exec_t:s0 tclass=file

Try enabling the httpd_ssi_exec boolean.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
