Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJEoWRb018185
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 09:50:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJEoVqY003498
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:50:31 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAJEoU0o003489 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:50:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: Policy error of the day
Date: Thu, 20 Nov 2003 01:50:21 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20031119144708.GB8546@vnl.com>
In-Reply-To: <20031119144708.GB8546@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311200150.21987.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 Nov 2003 01:47, Dale Amon <amon@vnl.com> wrote:
> The policy build error for today is:
>
> ERROR 'unknown type mailman_queue_chkpwd_t' at token ';' on line 81971:
> #line 10047
> allow mailman_queue_su_t mailman_queue_chkpwd_t:process transition;
> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [/etc/security/selinux/policy.15] Error 1

The chkpwd changes broke mailman.  I'm not sure whether it's worth trying to 
fix this or whether mailman itself should be fixed instead.  I'll probably do 
a work-around soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
