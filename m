Received: from [144.51.25.4] (moss-lions [144.51.25.4])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n39FSXXJ005778
	for <selinux@tycho.nsa.gov>; Thu, 9 Apr 2009 11:28:33 -0400
Subject: Problems related to the policy management infrastructure
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 09 Apr 2009 11:28:14 -0400
Message-Id: <1239290894.22856.55.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. Distribution of policy
	a. No way to easily distribute custom policy
2. Policy module format 
	a. All of the disadvantages of a binary format with none of the
	advantages.
3. Many policy file formats 
	a. Normal policy files (*.te *.if, *.fc)
	b. Object manager files (dbus_contexts, x_contexts)
	c. Misc context files (default_contexts, initrc_context,
	removable_context, etc)
	d. Other management files (setrans.conf, seusers, etc)
4. Policy store
	a. Both managed and unmanaged files are in /etc/selinux
5. Build process
	a. Fragile and brittle
	b. Difficult to add new features
6. Resource usage
	a. Tools are slow and/or require a lot of memory

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
