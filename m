Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9L9N8ui006179
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 05:23:09 -0400
Received: from ikarus.tarent.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9L9N7wL005485
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 09:23:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by ikarus.tarent.de (Postfix) with ESMTP id D14377F471C
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 11:25:26 +0200 (CEST)
Received: from ikarus.tarent.de ([127.0.0.1])
	by localhost (ikarus.tarent.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05224-04 for <selinux@tycho.nsa.gov>;
	Tue, 21 Oct 2008 11:25:18 +0200 (CEST)
Received: from dell-desktop2 (ckuest.entwickler.tarent.de [172.16.4.30])
	by ikarus.tarent.de (Postfix) with ESMTP id 2EAD07F54DE
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2008 11:25:18 +0200 (CEST)
Date: Tue, 21 Oct 2008 11:25:18 +0200
From: Chris Kuester <c.kuester@tarent.de>
To: selinux@tycho.nsa.gov
Subject: Conditional Access to Network Resources
Message-ID: <20081021092518.GA6606@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi List,

I'm facing the following problem:

I want to allow my domain to access certain ports on the local interface
and certain ports on a nonlocal interface. 
Example:
Domain may connect to port 25 over eth0
Domain may connect to port 4242 only on the loopback interface.

But if I allow my domain to access port 25 over eth0 it can also 
access port 25 on the local interface because I have to allow full
access to both, local and remote nodes and sending traffic over
both network interfaces.

I think I need to have some kind of condition, or do I missunderstand 
something here?

Constraint: Switching to SECMARKing instead of the "old" network 
confinement code is not an option at the moment. :(

Regards,
Chris

-- 
tarent Gesellschaft für Softwareentwicklung und IT-Beratung mbH

Heilsbachstr. 24, 53123 Bonn  | Poststr. 4-5, 10178 Berlin
fon: +49(228) / 52675-0       | fon: +49(30) / 27594853
fax: +49(228) / 52675-25      | fax: +49(30) / 78709617

Geschäftsführer
Boris Esser, Elmar Geese
HRB AG Bonn 5168
Ust-ID: DE122264941


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
