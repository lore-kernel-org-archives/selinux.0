Received: from [144.51.25.4] (moss-lions [144.51.25.4])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n39FSk6V005845
	for <selinux@tycho.nsa.gov>; Thu, 9 Apr 2009 11:28:46 -0400
Subject: Problems related to the policy language
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 09 Apr 2009 11:28:27 -0400
Message-Id: <1239290907.22856.57.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. Inflexibility
	a. Limitations to what can be in a module
2. Gaps in features
	a. User transitions
	b. Type inheritance
3. Ordering issues
	a. Unless the rules are in the same file, proper ordering cannot
	be guaranteed for portcon and other rules for which ordering is
	important
4. Confusing semantics
	a. Between templates and interfaces
	b. Between tunables and booleans
	c. Require rules
	d. Optional blocks
5. Inconsistencies in the syntax
	a. Some rules end with a semi-colon, others do not
	b. Some lists are space separated, some are comma separated
	c. Some lists require curly braces even when there is only one
	member, others do not
	d. For some rules the order of the rules matter, in others they
	do not
	e. File contexts start with the path

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
