Message-ID: <4314A7BE.20001@redhat.com>
Date: Tue, 30 Aug 2005 14:38:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: MCS Policy.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have now added the following range_transitions to mcs policy
+range_transition init_t getty_exec_t s0 - s0:c0.c127;
+range_transition getty_t login_exec_t s0 - s0:c0.c127;
+range_transition initrc_t cupsd_exec_t s0 - s0:c0.c127;
+range_transition initrc_t udev_exec_t s0 - s0:c0.c127;

Kernel is starting out with s0. 

The only problem I am seeing now is initrc wants to read the processs 
pid on a killall and gets denials for getty, login, udev and cups.  Is 
there an easy way to allow this without increasing initrc's range?



I am also having problems getting root to login with s0-s0:c0.127

Seems to always transiton to s0.

In targetd policy local login logs root in as
user_u:system_r:unconfined_t:s0

ssh and su logs in as
root:system_r:unconfined_t:s0

/etc/selinux/targeted/contexts/users/root looks like

system_r:unconfined_t:s0       system_r:unconfined_t:s0 - s0:c0.c127
system_r:initrc_t:s0   system_r:unconfined_t:s0 - s0:c0.c127
system_r:local_login_t:s0 system_r:unconfined_t:s0 - s0:c0.c127
system_r:remote_login_t:s0 system_r:unconfined_t:s0 - s0:c0.c127
system_r:rshd_t:s0             system_r:unconfined_t:s0 - s0:c0.c127
system_r:crond_t:s0    system_r:unconfined_t:s0 - s0:c0.c127

Dan
-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
