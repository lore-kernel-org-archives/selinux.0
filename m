Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBA05pRb025605
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 19:05:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBA03jlU028125
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 00:03:45 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id hBA03cSX028112
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 00:03:42 GMT
Date: Wed, 10 Dec 2003 11:03:59 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: Policy in arch/tla
Message-ID: <20031210000359.GB27706@snoopy.apana.org.au>
References: <20031209115448.B1732@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031209115448.B1732@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 09, 2003 at 11:54:49AM +0100, Tom wrote:
> tom@lemuria.org--selinux-public
>     http://guest:guest@nox.lemuria.org/arch/public/
> 
> And there is one item there named "policy--default--0.1"

For people not entirely familiar with tla, the commands to
check this out are:

tla register-archive tom@lemuria.org--selinux-public http://guest:guest@nox.lemuria.org/arch/public/
tla get tom@lemuria.org--selinux-public/policy--default--0.1 policy

In any case I recommend new users read the tla tutorial.

<URL:http://regexps.srparish.net/tutorial-tla/arch.html>

(actually, I cannot seem to get this to work via my squid proxy despite
adding the required exension_methods parameter to squid; but thats a
topic for another mailing list).
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
