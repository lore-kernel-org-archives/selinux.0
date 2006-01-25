Message-ID: <43D79DF0.2010506@redhat.com>
Date: Wed, 25 Jan 2006 10:49:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: sudo selinux patch has been removed.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This means that for mls/strict policy you need to newrole before 
executing sudo.

Sudo policy needs to be written to handle the transition from

staff_t -> staff_sudo_t -> staff_t
or
sysadm_t->sysadm_sudo_t->sysadm_t



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
