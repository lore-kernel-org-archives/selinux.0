Message-ID: <43C28BB0.1070601@redhat.com>
Date: Mon, 09 Jan 2006 11:13:36 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: MLS/MCS Constraints causing problems for unconfined_t.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently unconfined_t can not read the pid of certain domains in 
targeted policy that are running at s0-s0:c0.c255
For instance audit2allow will give the following after a reboot. since 
the shutdown process tries to killall processes and reads these.

allow unconfined_t auditd_t:file read;
allow unconfined_t crond_t:file read;
allow unconfined_t cupsd_t:file read;
allow unconfined_t hald_t:file read;
allow unconfined_t udev_t:file read;
allow unconfined_t self:file read;
allow unconfined_t xdm_t:file read;

Also if a sysadm run top it will generate this kind of AVC messages.  
These are somewhat expected, should we dontaudit these?  Will dontaudit 
work on an MLS Constraint failure?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
