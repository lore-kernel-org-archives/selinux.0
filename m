Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA24924
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 04:41:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA00892
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 08:39:09 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id IAA00888 for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 08:39:08 GMT
Date: Thu, 17 Oct 2002 10:40:49 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: latest policy patch
Message-ID: <20021017104049.D12896@lemuria.org>
References: <200210170017.38299.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210170017.38299.russell@coker.com.au>; from russell@coker.com.au on Thu, Oct 17, 2002 at 12:17:38AM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 17, 2002 at 12:17:38AM +0200, Russell Coker wrote:
> This one has my latest patch.  It's nothing serious at all.

Will you update your policy.tgz file on coker.com.au as well? I've
deviated somewhat from the old default policy, and believe it's easier
and cleaner to install a new one and redo the few changes that were not
added with the apache diff.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
