Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3HMIWYn026445
	for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2006 18:18:32 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3HMIVND003100
	for <selinux@tycho.nsa.gov>; Mon, 17 Apr 2006 22:18:31 GMT
Subject: Re: VPN module
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Petre Rodan <kaiowas@gentoo.org>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1145045255.8881.12.camel@sgc.columbia.tresys.com>
References: <1144238374.19128.11.camel@wintermute.xmldesign.de>
	 <1144248600.12875.2.camel@sgc.columbia.tresys.com>
	 <20060414185125.GA7399@peter.sunspire.org>
	 <1145045255.8881.12.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 18 Apr 2006 00:18:31 +0200
Message-Id: <1145312312.8014.67.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Christopher,
> Merged.  One fix, I moved the initrc_t reading openvpn_etc_t to the init
> module.

policy/modules/kernel/corenetwork.te.in currently has port 5000 for
OpenVPN.

Port 1194 is the official IANA port for OpenVPN and should be added, too
(or maybe even instead of port 5000, which is more likely to conflict
with custom applications IMHO)

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Why waste time learning, when ignorance is instantaneous? --- Calvin //\
   Wenn zwei gute Freunde sind, die einander kennen, Sonn' und Mond   V_/_
     begegnen sich, ehe sie sich trennen. --- Clemens von Brentano


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
