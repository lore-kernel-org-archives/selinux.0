Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA04097
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 10:11:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA21308
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 14:09:23 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id OAA21304 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 14:09:21 GMT
Date: Tue, 1 Oct 2002 16:11:07 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: policy version
Message-ID: <20021001161106.C24885@lemuria.org>
References: <20021001131535.A21503@lemuria.org> <200210011604.25300.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210011604.25300.russell@coker.com.au>; from russell@coker.com.au on Tue, Oct 01, 2002 at 04:04:25PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 04:04:25PM +0200, Russell Coker wrote:
> Firstly your machine should still work.  The way things are designed to 
> operate is that a unique file name is used for each version of the policy.  
> So if you had a previously operational system with policy V11 and you did not 
> delete any files then it should still boot up loading that V11 policy.  You 
> won't be able to load a new V12 policy but that should not be a serious 
> problem, your machine should still be in a state that allows you to compile 
> the kernel.

The v11 policy went down the drain due to a mistake that I made before
upgrading (ironically, the intent of moving some stuff away was to make
sure it neither gets overwritten nor is in the way of something).


> The way this is designed to work is that the "se_apt-get upgrade" will get you 
> a new policy (which will install but not load) and a new kernel patch to 
> match.  Then if you build a new kernel-image package with that kernel patch 
> then it'll support the V12 policy and everything will be fine after a reboot.

I will do that once I restored networking and report back with the
result. If it works, I'll collect what I learned today into a small
"howto save your soul after messing up your SELinux install" doc.



> Another option is to use the kernel-image packages Brian is producing, he has 
> re-built all his packages with V12 policy support.  He appears to be going to 
> a lot of effort to build those packages so it would be good if someone uses 
> them...

Roger, I'll do that on the other machine which I'm installing from
scratch.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
