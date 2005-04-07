Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37FjEue026808
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 11:45:14 -0400 (EDT)
Message-ID: <425553ED.1040703@redhat.com>
Date: Thu, 07 Apr 2005 11:38:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: I am attempting to add a secadm_r
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I do not want to get in a conversation about how many ways there are 
around this, from sysadm_r.   I know that, but when I was at DOD
a couple of weeks ago they stated that they wanted a separate role from 
policy management, from the role of the system administrator.  They
did not care about this being protected, but wanted a way to stop 
accidentally modifying the machine.  In DOD the System Administrator and
the Security Administrator are different roles. 

Any ways trying a simple experiment I have added the following  roles

role secadm_r types sysadm_t
role secadm_r types checkpolicy_t
role secadm_r types newrole_t

And I add secadm_r as a "root" role in the users file.

Now when I try to newrole from root:sysadm_r:sysadm_t to 
root:secadm_r:sysadm_t

I get a process transition failure

from

root:sysadm_r:newrole_t to root:secadm_r:sysadm_t.

What am I missing?

the
allow newrole_t sysadm_t:process transition;

rule exists

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
