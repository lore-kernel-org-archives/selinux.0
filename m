Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MDc2I4021262
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 09:38:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4MDbcuO010349
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 13:37:38 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id h4MDbalV010346
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 13:37:37 GMT
Date: Thu, 22 May 2003 15:39:05 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: run_init woes
Message-ID: <20030522153858.B6588@lemuria.org>
References: <20030522112833.A2615@lemuria.org> <200305222241.35921.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305222241.35921.russell@coker.com.au>; from russell@coker.com.au on Thu, May 22, 2003 at 10:41:35PM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 22, 2003 at 10:41:35PM +1000, Russell Coker wrote:
> Are you using my run_init or the NSA one?

yours, see the other mail.


> If using mine then put "sleep 1" in the shell script after the daemon gets 
> run.

This makes rsync happy, but not pxe. I've tried with sleep 1, 2 and 5


Is there any way to enable stracing? I know I'd like to see what the
heck is happening.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
