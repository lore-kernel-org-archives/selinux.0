Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11091
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 12:45:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA11234
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 17:44:06 GMT
Received: from c001.snv.cp.net (c001-h001.c001.snv.cp.net [209.228.32.115])
	by jazzswing.ncsc.mil  with SMTP id RAA11230
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 17:44:06 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: <selinux@tycho.nsa.gov>
Subject: Location of policy rules
Date: Sat, 23 Mar 2002 12:46:21 -0500
Message-ID: <BFEMIIHKHLALNELLMPOMEEMPCAAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0203201538540.11981-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a meta-policy question, if I may:

I want to enable the "halt" userid for console login and ssh access to shut
down a machine remotely, *without* allowing root access over ssh.
Naturally, I want to limit the exposure this gives. So, I created a "halt_t"
domain similar to the other
daemon-type domains, and I lock the "halt" user id into that domain, giving
it exec access to /sbin/halt, which is now of type halt_exec_t etc...

This has the side-effect of locking out /sbin/halt from root, since it
doesn't have any access to halt_exec_t.

Here is my question:
Assuming this is the right approach [if not, do tell what is], where should
I put the additional rules to allow sysadm to halt the machine.  Is it:
(a) in sysadm.te so that all the sysadm rules are in the same place; or
(b) in halt.te so that this "feature" becomes a stand-alone domain
definition in the system?

I know they all end up in the same place, but I'm torn between wanting to
build a modular configuration vs not introducing potentially dangerous
sysadm_t permissions in an unexpected place.

All guidance for the novice gratefully received.

Leslie

PS - I'm a SeLinux convert.  If there's anything I can do to help....


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
