Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBD19DRb012111
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 20:09:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBD192AH002675
	for <selinux@tycho.nsa.gov>; Sat, 13 Dec 2003 01:09:02 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hBD18oZA002628 for <selinux@tycho.nsa.gov>; Sat, 13 Dec 2003 01:09:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: nagray@austin.rr.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Tomcat or SOAP
Date: Sat, 13 Dec 2003 12:07:27 +1100
References: <1071262053.24193.163.camel@hawaii.efficax.net>
In-Reply-To: <1071262053.24193.163.camel@hawaii.efficax.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312131207.27330.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 13 Dec 2003 07:47, Nick <nagray@austin.rr.com> wrote:
> Has anyone done any work on domains for Tomcat and/or SOAP.

Why would SOAP require policy?  I was under the impression that SOAP is merely 
a protocol, and therefore not something that directly requires policy.

As for Tomcat, I'm not aware of any work on that.  Send me a detailed 
description of what it does and I'll write policy to match.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
