Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB7E6BRb013009
	for <selinux@tycho.nsa.gov>; Sun, 7 Dec 2003 09:06:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB7E5SlU003115
	for <selinux@tycho.nsa.gov>; Sun, 7 Dec 2003 14:05:28 GMT
Received: from unicorn.lemuria.org (d003196.adsl.hansenet.de [80.171.3.196])
	by jazzswing.ncsc.mil  with ESMTP id hB7E5RSX003112
	for <selinux@tycho.nsa.gov>; Sun, 7 Dec 2003 14:05:28 GMT
Date: Sun, 7 Dec 2003 14:59:07 +0100
From: Tom <tom@lemuria.org>
To: Russell Coker <bofh@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: policy under version control
Message-ID: <20031207145906.D23499@lemuria.org>
References: <20031129132619.GE26960@lukas.schuldei.com> <20031207123046.D22784@lemuria.org> <20031207134114.GK21303@lukas.schuldei.com> <200312080044.59439.bofh@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312080044.59439.bofh@coker.com.au>; from bofh@coker.com.au on Mon, Dec 08, 2003 at 12:44:59AM +1100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 08, 2003 at 12:44:59AM +1100, Russell Coker wrote:
> Yes, I can do that.  I'm not sure what the best way of managing this is, I 
> want to read every patch before accepting it, so I don't want anything 
> automated at my end.

Russell, my suggestion would be this:

Have one "default policy" repository, that only you a few people can
write to, but other people can use as a base.

I'd also set up a public repository with world-write access,
essentially as an easy place to contribute.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
