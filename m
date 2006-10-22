Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9MFHVAR009097
	for <selinux@tycho.nsa.gov>; Sun, 22 Oct 2006 11:17:33 -0400
Received: from bay0-omc2-s20.bay0.hotmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9MFG2g7026557
	for <selinux@tycho.nsa.gov>; Sun, 22 Oct 2006 15:16:03 GMT
Message-ID: <BAY114-F35A32B2A224839C49B0E50AF030@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: Booleans and tunable_policy
Date: Sun, 22 Oct 2006 17:17:28 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I saw that in the reference policy there aren't anymore if-else constructs 
for the conditional evaluation of rules; instead, the tunable_policy macro 
is used (which I don't understand where it is declared)...What's wrong with 
the old "if-else" method? And, why should the booleans be first declared in 
global_booleans?
Thanks

_________________________________________________________________
Usa il tuo PC come un telefono per chiamare cellulari e telefoni fissi! 
http://imagine-msn.com/messenger/launch80/?locale=it-it&TAB=2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
