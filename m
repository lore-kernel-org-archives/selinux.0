Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h64F9tHa006445
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 11:09:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h64F92nJ001639
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 15:09:02 GMT
Received: from unicorn.lemuria.org (c152035.adsl.hansenet.de [213.39.152.35])
	by jazzswing.ncsc.mil  with ESMTP id h64F91hr001636
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 15:09:02 GMT
Date: Fri, 4 Jul 2003 17:06:58 +0200
From: Tom <tom@lemuria.org>
To: Mauro Chiarugi <vlaovic@libero.it>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: Policies.. but where there are?
Message-ID: <20030704170656.A2508@lemuria.org>
References: <20030703234800.330f8026.vlaovic@libero.it> <200307040852.51081.russell@coker.com.au> <20030704085135.0ffdf7a7.vlaovic@libero.it> <200307041741.36842.russell@coker.com.au> <20030704133113.2befd387.vlaovic@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030704133113.2befd387.vlaovic@libero.it>; from vlaovic@libero.it on Fri, Jul 04, 2003 at 01:31:13PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 04, 2003 at 01:31:13PM +0200, Mauro Chiarugi wrote:
> > Yes.  There is a special type for it and it is protected against
> > editing.
> 
> And what append if i boot with a normal kernel??

There is no special protection in SELinux against malicious users with
full access to the physical machine. Encrypted filesystems and
physically secure server rooms are your tools in that area.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
