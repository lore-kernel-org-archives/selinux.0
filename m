Subject: Running sshd shells in sysadm_t
From: Justin Smith <jsmith@mcs.drexel.edu>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: 05 Feb 2002 20:17:59 -0500
Message-Id: <1012958279.1816.3.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I noticed that sshd shells are, by default, run in user_t and are
allowed to be run in sysadm_t as well.

Is there some way to make them run in sysadm_t by default when certain
users log in?
-- 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
