Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QMdWEm031879
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 18:39:32 -0400
Received: from bay0-omc1-s31.bay0.hotmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QMcTaC011193
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 22:38:29 GMT
Message-ID: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: MLS and Biba
Date: Wed, 27 Sep 2006 00:39:29 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good morning, is it possible to configure the MLS policy, using 
mlsconstraint, to enforce a Biba integrity model of security (no read down, 
no write up), instead of the Bell-LaPadula (no read up, no write down)? I'm 
reading the book "SELinux by example", and there there's written that the 
MLS facility in the Security Server is not very flexible, and allows only to 
enforce the rules "no read up, no write down". But, if I'm the one 
configuring the policy in the file "mls", shouldn't I be able to change the 
rules to the opposite?
Thanks a lot...

_________________________________________________________________
Blocca le pop-up pubblicitarie con MSN Toolbar! http://toolbar.msn.it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
