Date: Sat, 23 Oct 2004 21:23:27 +1000
From: Rene Cunningham <rene@dclabs.com.au>
To: SELinux@tycho.nsa.gov
Subject: login as sysadm_r remotely
Message-ID: <20041023112327.GW8603@eden.office.dclabs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Gday,

Im trying to allow remote logins via ssh as root to use the sysadm_r role
by default. At the moment root logs in using staff_r and newrole -r needs
to be executed. I do want to force logins via tty's to default to
staff_r though.

Looking at /etc/selinux/context/root_default_contexts i just need to
unhash the following

system_r:sshd_t sysadm_r:sysadm_t staff_r:staff_t user_r:user_t

I rebuild the policy, though root still logs in as staff_r via ssh.  

Im running debian with selinux-policy-default 1.14-2.

How do i enable this?

-- 

Rene Cunningham
DCLabs Pty Ltd
http://www.dclabs.com.au

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
