Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i29MU5Rb015622
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 17:30:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i29MSN6Q008346
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 22:28:23 GMT
Received: from maja.beep.pl (smtp.sys.beep.pl [195.245.198.13])
	by jazzswing.ncsc.mil  with ESMTP id i29MSN5t008315
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 22:28:23 GMT
Received: from [156.17.236.105] (helo=arm.t19.ds.pwr.wroc.pl ident=arekm)
	by maja.beep.pl with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.30)
	id 1B0pdT-0004r5-Ri
	for selinux@tycho.nsa.gov; Tue, 09 Mar 2004 23:23:40 +0100
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: selinux@tycho.nsa.gov
Subject: blocking security xattr changes when policy is not loaded
Date: Tue, 9 Mar 2004 23:29:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403092329.42958.arekm@pld-linux.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The case is that 2.6 selinux enabled kernel but _without_ policy loaded do not 
allow to change security xattr for root user.

The question is why is that?

I'm asking because for example I'm using pwconv from pwdutils (which replace 
shadow-utils + have nice selinux support) and pwconv creates temporary 
file /etc/shadow.tmpWAjQQd + does rename(). Of course pwconv wants to keep 
security xattr on shadow file intact so it tries to 
label /etc/shadow.tmpWAjQQd with same security xattr as /etc/shadow has 
but ... kernel won't allow it to do that! setfilecon -> invalid argument

Solution is to disable copying security xattr in pwconv but then I just loose 
proper security xattr on shadow and that's bad.

Why such restriction is made in kernel? It doesn't give more security to the 
system. If I get root account (policy not loaded) then I can do anything like 
replacing kernel with modified one etc, etc.

Blocking security xattr for root in such case smells like security by 
obscurity.
-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
