Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5MNsWgA022416
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 19:54:32 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5MNinrk021432
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 23:44:50 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by free.hands.com (Postfix) with ESMTP id A3D46BF30
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 00:44:50 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1DlF2O-0005Cs-Jg
	for selinux@tycho.nsa.gov; Thu, 23 Jun 2005 00:53:44 +0100
Date: Thu, 23 Jun 2005 00:53:44 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: http://www.securityfocus.com/columnists/334/3
Message-ID: <20050622235344.GP14480@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

quote:

	What about buying a switch that includes a packet
	filter? This solution should provide a trustworthy
	network with the added bonus of isolating and filtering
	each host.

	It's not a technology problem, it's a management
	problem. There are plenty of tools that can be used to
	control inter-host trust, but they are generally not
	used because they're "too hard" or "inconvenient" or
	whatever. For example, the big Cisco switches all have
	the ability to process ACLs at high speed. Isolating
	and filtering each host is very possible and would be
	very effective using existing technology.


	Let's imagine a simple scenario: suppose I have a
	subnet consisting of 150 hosts that all access a local
	departmental server with file serviceand print service,
	etc. Further, let's imagine that the hosts on that
	subnet need Internet browsing access and access to
	an enterprise Email server (IMAP + SMTP) that sits
	someplace else on my corporate LAN.  And, perhaps,
	some of my users need access to the mainframe for SQL,
	while others don't. So, I could put ACLs in the switch
	to, "allow all/all to the local subnet server," "allow
	IMAP, SMTP to the off-network mail server," "allow all,
	port 80, to the web caching proxy off-network," "allow
	{list} SQL to the mainframe," "default: deny all."
	That's not very hard, is it? Does Bob's workstation need
	to talk directly to Jane's? No? Then don't allow it.

	And a network like that is going to be extremely
	resistant to worms or active penetration. Of course
	nobody does that kind of thing: they just plug it all
	together, make it work, and then ignore it and hope
	it doesn't get hacked.


scenario:

	utilise selinux to (assuming individual hosts' selinux
	policies can be trusted!!!!) set up the above, as a
	lo-cost alternative [not have to have expensive Cisco
	routers which achieve the ACLs]

wish-list:

	have fwbuilder create selinux policies creating the
	network-based access rules!!!!!

pie-in-sky-wish-list:

	have fwbuilder create selinux network-based firewall
	policies in XML format *grin*

background [for people who might not know what i'm talking about]:

	it is possible to do some of the same job as a
	firewall, in selinux policy rules: start by looking
	at /etc/selinux/src/net_contexts and search for strings
	occuring in there in the rest of your selinux policy
	source.

	selinux policy rules can do a certain degree of network
	access restriction based on the program _and_ the user
	that's doing the network access.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
