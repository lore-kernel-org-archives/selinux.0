Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4LHaPI4017145
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 13:36:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4LHaOtV015754
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 17:36:24 GMT
Received: from unicorn.lemuria.org (c145125.adsl.hansenet.de [213.39.145.125])
        by jazzband.ncsc.mil  with ESMTP id h4LHaAal015739 for <selinux@tycho.nsa.gov>; Wed, 21 May 2003 17:36:23 GMT
Date: Wed, 21 May 2003 19:33:40 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: patched wdm (success)
Message-ID: <20030521193333.B14730@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks to Stephen, who pointed out the mistake, I now have a patched
wdm that works fine and does the transition to user_t

I'm cleaning it up a little further right now and will put it up for
download later. I'm having some minor troubles with the debian build
system, I'm sure I'll figure it out.


Russell - You might want to check your kdm diff files, they might have
the same problem. Stephen pointed out that if(!get_default_sid...
doesn't work because it returns 0 on success, <0 on failure.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
