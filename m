Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h68M5DHa020845
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2003 18:05:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h68M5CH5013983
	for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2003 22:05:12 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h68M5CRX013975 for <selinux@tycho.nsa.gov>; Tue, 8 Jul 2003 22:05:12 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 81E2C41401C
	for <selinux@tycho.nsa.gov>; Tue,  8 Jul 2003 18:05:48 -0400 (EDT)
Subject: context trouble with 2.5 bits
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1057701768.25921.53.camel@columbia>
Mime-Version: 1.0
Date: 08 Jul 2003 18:02:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I think I'm pretty close to getting my Debian system running with the
SELinux 2.5 bits.  However, I can't seem to get either the patched sshd
or login to give me the correct context.  When I login (using login) as
root, I see:

Warning!  Could not get new context for tty1, not relabeling.

...followed by a bunch of avc denials about tty1 and /root, and then my
context is:

meta:~# id
uid=0(root) gid=0(root) groups=0(root) context:system_u:system_r:user_t

Now, since Debian uses the login in shadow-utils (not the one in
util-linux), I had to port over the patch, but I'm fairly sure that's
not the problem, because I get the exact same symptoms when logging in
over the patched ssh.

Does anyone have any ideas for what could be going wrong?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
