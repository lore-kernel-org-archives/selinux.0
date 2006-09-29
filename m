Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TDDxaL019455
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 09:13:59 -0400
Received: from bay0-omc1-s18.bay0.hotmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TDCpi6027256
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 13:12:52 GMT
Message-ID: <BAY114-F2644C21E9B06171BFE5147AF180@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: Indirect access to type
Date: Fri, 29 Sep 2006 15:13:54 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In the book "SELinux by example", at paragraph 14.4.2, the author talks 
about indirect access to types, which is possible to look for using apol 
(checking the option "Include indirect matches" when you search for TE 
rules). I don't understand the meaning of this...How could a domain gain 
access to a type it is not authorized for? Using domain transitions?
Thanks

_________________________________________________________________
Condivi foto, pensieri ed altro ancora creando il tuo Blog su Windows Live 
Spaces ! http://discoverspaces.live.com/?loc=it-IT


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
