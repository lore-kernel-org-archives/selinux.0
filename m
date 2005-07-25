Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PL3xgA027479
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 17:03:59 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PKwdeR018950
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 20:58:39 GMT
Message-ID: <36282A1733C57546BE392885C0618592AF2E1F@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: gyurdiev@redhat.com, Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito"
	 <cpebenito@tresys.com>,
   James Morris <jmorris@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Karl MacMillan
	 <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: RE: Iptables discussion
Date: Mon, 25 Jul 2005 17:00:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> > The interfaces to do this work should be exported through libsemanage to

> > do it seamlessly regardless of policy backend. The labels will have to 
> > (unfortunatly) be part of some configutation file, which is policy 
> > specific. 
> 
> The labels can be inferred from the card name, if necessary.
> 

contexts for interfaces and nodes need to managed and shouldn't be just
inferred.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
