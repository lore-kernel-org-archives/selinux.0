Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97L99Wt015021
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 17:09:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97L970p008955
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 21:09:07 GMT
Received: from unicorn.lemuria.org (c152019.adsl.hansenet.de [213.39.152.19])
	by jazzswing.ncsc.mil  with ESMTP id h97L96r7008952
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 21:09:06 GMT
Date: Tue, 7 Oct 2003 23:03:52 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: 2.6.0-test6 boot process failures
Message-ID: <20031007230348.E11325@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a few weird dynamic linker "libselinux.so not found" errors during 
bootup, even though libselinux.so is on the initrd image, the policy
loads correctly and everything seems to work fine.

The only thing I can think about is that libselinux.so is in /usr/lib
and that is on a seperate partition, (/usr is).

Is it possible - I'm not familiar with the details of the boot process
- that somewhere inbetween it loses access to the initrd /usr/lib but
before it has mounted all the other partitions?

If so - how do I work around this?


Btw: Russel, I tried to mail you directly, but your mailserver doesn't
like my dialup-IP: Collin already made a script and that works just
fine. I tried replacing it with yours and that broke my initrd, but
that may as well have been my mistake. Well, at least it's not
drop-in-be-happy - should I do more testing? Tell me what to do, boot
details are beyond me.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
