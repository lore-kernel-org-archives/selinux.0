Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA11471
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 09:51:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA09885
	for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 13:49:59 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id NAA09880 for <selinux@tycho.nsa.gov>; Wed, 25 Sep 2002 13:49:57 GMT
Date: Wed, 25 Sep 2002 15:51:33 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on UML
Message-ID: <20020925155133.A19704@lemuria.org>
References: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8429@esebe013.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <98C7D2E5BCD2374C9AAE0BCD2E9C1DD9BE8429@esebe013.ntc.nokia.com>; from pasi.kivikangas@nokia.com on Wed, Sep 25, 2002 at 04:25:54PM +0300
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 25, 2002 at 04:25:54PM +0300, pasi.kivikangas@nokia.com wrote:
> Just wanted to ask if somebody around have done some experiments with SELinux on UML and got it working somehow?

Not of that kind, no. I've had some success running UML on top of an
SELinux system, but combining them is a totally different animal.


I get the purpose though, it would be a pretty cool thing for testing
it out without having to reboot every time you create a bad policy. :)



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
