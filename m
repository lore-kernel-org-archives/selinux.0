Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA22877
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 05:52:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA00798
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 10:50:45 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id KAA00794 for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 10:50:44 GMT
Date: Thu, 7 Nov 2002 11:52:29 +0100
From: Tom <tom@lemuria.org>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: Re: SELinux and security tools?
Message-ID: <20021107115229.B28883@lemuria.org>
References: <200211070956.JAA29189@jazzband.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200211070956.JAA29189@jazzband.ncsc.mil>; from sailorn@attglobal.net on Thu, Nov 07, 2002 at 04:55:13AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 07, 2002 at 04:55:13AM -0500, Subba Rao wrote:
> One basic question about policy,  is this some configuration file that you develop
> based on your needs and then use it to compile a new kernel?

It's a configuration file (rather: several), but you don't need to
recompile the kernel to activate a new policy. There is a load_policy
tool that can load/update a policy on a running system, much like you
can activate modules at runtime with insmod.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
