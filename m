Received: from [144.51.25.4] (moss-lions [144.51.25.4])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n39FSgOK005828
	for <selinux@tycho.nsa.gov>; Thu, 9 Apr 2009 11:28:42 -0400
Subject: Problems related to customizing policy
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 09 Apr 2009 11:28:23 -0400
Message-Id: <1239290903.22856.56.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. Local policy
	a. Not clear where to store the local policy
	b. To remove permissions, policy modules must be directly
	modified
2. Testing policy
	a. No way to determine what permissions in the current policy
	are actually being checked for or used.
3. Restricting network access
	a. Multiple methods to use, but it is not clear which is the
	best
	b. The steps required are not always clear
4. Resource labeling
	a. It is not always clear which of following should be used to
	label file: semanage, restorecon, restorecond, fixfiles,
	setfiles, chcon, or chcat.
	b. If a denial occurs because of an incorrect label, it is not
	easy to determine what the correct type is.
		i. Example: textrel_shlib_t
	c. No way to guarantee the proper order of the portcon rules
5. Adding user and roles
	a. Adding a user or role takes multiple, sometimes not obvious,
	steps

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
