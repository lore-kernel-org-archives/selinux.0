Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU3lqcv011686
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 22:47:52 -0500
Received: from facesaver.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAU3kAbM017441
	for <selinux@tycho.nsa.gov>; Thu, 30 Nov 2006 03:46:10 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAU3gkSe014380
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 22:42:46 -0500
Subject: [PATCH 0/5] libselinux: labeling API for userspace object managers
	(try 2)
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 29 Nov 2006 22:47:51 -0500
Message-Id: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a companion interface to the userspace AVC, for use by userspace
object managers to look up contexts for use in labeling their objects.
It also provides an alternate interface to the file contexts
configuration.

In this iteration, the interface has been changed to return handles to
the user.  This should clear up confusion regarding the "prefix" string
(now "name") which is now passed together with the security class to the
label_open() function that creates the handle.

Also added is the av_perm to string call requested by KaiGai Kohei.
There are two functions, security_av_perm_to_string() which does a
single bit, and security_av_string() which duplicates
print_access_vector() except returns the result in a malloc'ed buffer.

Patch 1: basic interface
Patch 2: basic implementation
Patch 3: string functions
Patch 4: simple, generic backend
Patch 5: file contexts backend

Comments welcome!

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
