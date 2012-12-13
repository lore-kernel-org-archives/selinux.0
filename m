Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBD9Fb1q004226
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 04:15:37 -0500
Received: by mail-ea0-f181.google.com with SMTP id k14so726913eaa.12
        for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 01:15:30 -0800 (PST)
Date: Thu, 13 Dec 2012 10:15:13 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Reachable SIDs given a context
Message-ID: <20121213091512.GA10211@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tl;dr How does the policy dictate what the valid SIDs are that can be
      reached given a certain context (like system_r:crond_t)? And how
      can a policy writer/developer work on this?

I'm trying to understand how to work with the contexts/default_contexts and
contexts/users/* files. As I understood it, the file give the default
contexts to use if a logon-like process (or any process that sets up a PAM
session for a user where PAM triggers pam_selinux.so) is used.

However, it seems like just modifying the files isn't sufficient. I try
reproducing stuff using getseuser command. For instance:

# getseuser root system_u:system_r:crond_t
seuser:  root, level (null)
Context 0       root:sysadm_r:cronjob_t
Context 1       root:staff_r:cronjob_t

This still matches what is in the default_contexts file for the crond_t
domain (and in the specific user file in contexts/users/root):

system_r:crond_t        unconfined_r:unconfined_t sysadm_r:cronjob_t
			staff_r:cronjob_t user_r:cronjob_t

As the root Linux user maps on the root SELinux user, which has staff_r and
sysadm_r as allowed roles, and because of the order in the file, I get the
sysadm_r:cronjob_t first and then staff_r:cronjob_t.

However, when I try to modify the contexts/root file so that another domain
should be used (say portage_t), getseuser still returns the standard
cronjob_t domains:

~# grep crond_t users/root
system_r:crond_t        unconfined_r:unconfined_t sysadm_r:portage_t
			staff_r:portage_t user_r:cronjob_t

~# getseuser root system_u:system_r:crond_t
seuser:  root, level (null)
Context 0       root:staff_r:cronjob_t
Context 1       root:sysadm_r:cronjob_

If I strace getseuser, I notice it first asks the SELinux in-kernel code on
what the contexts are that crond_t can return to for the user (the SIDs),
and then it reads the users/root and default_contexts files. 

The kernel (through /sys/fs/selinux/user) returns 
3715  read(3, "2\0root:staff_r:cronjob_t\0root:sysadm_r:cronjob_t\0", 4095) = 49

In the kernel code I "read" (interpret might be better ;) that the policy is
checked to see what valid SIDs can be reached from the given context (the
system_r:crond_t context) which are then translated into contexts and
returned. I assume that getseuser then sees if one of the files (users/root
and default_contexts) sais the same. When one match occurs, then that is
returned. If none occur, then the value returned by the kernel is used.

How does the kernel know what the valid, reachable SIDs are? I first thought
it was the domains that can be transitioned to, but crond_t can transition
to portage_t, and portage_t is allowed for the sysadm_r role.

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
