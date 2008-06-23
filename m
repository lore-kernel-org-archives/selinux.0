Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5NF6s66019243
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 11:06:54 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5NF6r2a012686
	for <selinux@tycho.nsa.gov>; Mon, 23 Jun 2008 15:06:54 GMT
Subject: rbacsep: type transition conflicts uncovered
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 23 Jun 2008 11:03:02 -0400
Message-Id: <1214233382.11146.256.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was going through and doing refactoring on the rbacsep with the goal
of making the branch compilable again after doing all the derived type
collapsing.  I ran into a problem with type transition conflicts.  There
are several domains which have a type transition back to the caller
domain, such as su, sudo, (session) dbus, ssh-agent.  But now that the
derived types are collapsed, we get conflicts such as:

type_transition sudo_t shell_exec_t:process auditadm_t;
type_transition sudo_t shell_exec_t:process secadm_t;
type_transition sudo_t shell_exec_t:process staff_t;
type_transition sudo_t shell_exec_t:process sysadm_t;
type_transition sudo_t shell_exec_t:process user_t;

It would seem that there are two solutions for this:

1. keep derived types for these affected domains
2. make these applications SELinux aware

We can't collapse user domains because of their vast differences.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
