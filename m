Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4M9RaI4020189
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 05:27:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4M9RCuO000355
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 09:27:12 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id h4M9RBlV000352
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 09:27:12 GMT
Date: Thu, 22 May 2003 11:28:39 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: run_init woes
Message-ID: <20030522112833.A2615@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I've started writing a policy for PXE daemon, improving tftpd policy,
etc - when something weird happend to me.

# run_init /etc/init.d/pxe start
Authenticating root.
Password:
Starting PXE daemon: Intel PXE daemon, PXE-2.0 Beta-1 (build 001)
Copyright (C) 1999  Intel Corporation
pxe.


So far, so good. Except that the pxe daemon dies right away. No debug 
output either, nothing in the logfiles.

However, if I do

# /etc/init.d/pxe start

Everything works just fine. (the machine is running in permissive mode)
Except that it runs in the wrong domain, of course. But IMHO this shows
that the problem isn't in the pxe daemon.

Also, if I do a reboot, the pxe daemon comes up just fine, running in
the correct domain and everything.


Is there anything in run_init that could cause this kind of problems?
If so, what can I about it? If not, what is it that I'm missing here?


(I have the feeling I've had this before, but I could find nothing in
the mailing list archive)


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
