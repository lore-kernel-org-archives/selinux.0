Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oAHCjGe9008029
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2010 07:45:16 -0500
Received: from out1.smtp.messagingengine.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oAHCjFbh029532
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2010 12:45:15 GMT
From: Roberto Sassu <roberto.sassu@polito.it>
To: refpolicy@oss1.tresys.com
Subject: SELinux UBAC question
Date: Wed, 17 Nov 2010 13:42:53 +0100
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201011171342.54366.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

i'm using the Fedora 13 operating system with shipped SELinux policy.
I want to add a basic protection for regular users by using the UBAC feature and
letting them to log on the system with the confined domain 'user_t'.
A problem that i have found when using the policy with this feature enabled
is that root logs on the system with user 'unconfined_u' or 'root' and files created
or updated after doing an administrative task cannot be accessed by regular users.
In order to have the system working i have to execute root processes that
make changes on the system with user 'system_u'.
One solution to overcome this issue may be to add an exception to the policy,
as done for the 'system_u' user, so that UBAC will be applied only to SELinux users
tied to regular users, living other users 'sysadm_u', 'staff_u', 'root', 'unconfined_u'
unprotected.
Does this is the right way to modify the policy in order to enforce the protection
required or there are other alternatives?
Thanks in advance for replies.

Roberto Sassu

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
