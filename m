Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n45L3UUf000712
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 17:03:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n45L3Pc8016151
	for <selinux@tycho.nsa.gov>; Tue, 5 May 2009 21:03:29 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: policy as configuration data
Date: Tue, 5 May 2009 17:03:20 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E010D6962@exchange2.columbia.tresys.com>
From: "Caleb Case" <ccase@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We've been looking into a couple of improvements to the SELinux
infrastructure. One of the options we are looking at is treating policy
as configuration data. We've found a couple of sticking points though.

First, removing a set of trusted tools (running in domains only able to
access files of appropriate types) from the policy modification process
makes it more difficult to control the flow of low integrity data into
the policy.

Also, how can we also support policy access control? For example, how do
we determine who changed the policy if multiple people can edit the
policy files? How do we handle simultaneous edits? What about
transactions?

It's unclear if this is important since part of the goal here is to
simplify and improve the SELinux experience.

Using a trusted set to tools has its advantages and doesn't necessarily
preclude the use of a text based policy. A tool that could give the user
a text module back for modification and accept a text module as input
may be sufficient but doesn't exactly fit into how configuration data
typically works.

We are looking for input on whether having an uncontrolled conf.d style
policy directory that is admin-modifiable without the need for tools is
a high priority for people or if the disadvantages outweigh the desire
to edit files directly.

Questions/comments/rants/flames welcome.

Caleb


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
