Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9KZ8Ii015970
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:35:08 -0500 (EST)
Received: from hawaii.grays-systems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9KZAEj008972
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:35:11 GMT
Received: (from nick@localhost)
	by hawaii.grays-systems.com (8.13.1/8.13.1/Submit) id iB9KZAm4024296
	for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 14:35:10 -0600
Subject: Adding a new user domain
From: Nick Gray <nick-lists@austin.rr.com>
To: SE Linux list <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 09 Dec 2004 14:35:10 -0600
Message-Id: <1102624510.24067.8.camel@hawaii.grays-systems.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am stuck!

System: Core 3 Strict/Targeted
Added: selinux-policy-targeted-sources-1.17.30-2.19.noarch.rpm

Problem 1: I am trying to use the instructions s"Getting started with
SELinux" and there are a lot of inconsistencies

There was no user.te file so I created one
in /etc/selinux/targeted/src/policy, with the contents:

full_user_role(tomcat)
allow system_r (tomcat)
allow sysadm_r (tomcat)

Then I went into
the /etc/selinux/targeted/src/policy/macros/user_macros.te and added 

role tomcat_r types $1;

to this file. I cd'd back up to the policy directory and did a 'make
policy' I didn't see any errors.

I am assuming from any user who has user_u:system_r:unconfined_t I
should be able to do this:

newrole -r tomcat_r

When I do I get:

Couldn't get default type.

Are there updated instructions that make this less of a hunt and peck
operation?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
