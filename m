Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l29HN1AA030336
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 12:23:01 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l29HN0I5019342
	for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2007 17:23:00 GMT
From: Paul Moore <paul.moore@hp.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Running racoon from init_t?
Date: Fri, 9 Mar 2007 12:09:24 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J.PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703091209.24393.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is in regards to RHEL5 and the MLS policy.

I'm trying to run racoon at startup, from within the rc.local script, which 
means it is being run from init/init_t.  Whenever I try to do this I see the 
following AVC denials:

***
type=AVC msg=audit(1173457995.784:305): avc:  denied  { use } for  pid=2105 
comm="racoon" name="console" dev=tmpfs ino=725 
scontext=system_u:system_r:racoon_t:s0-s15:c0.c1023 
tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
type=AVC msg=audit(1173457995.784:305): avc:  denied  { use } for  pid=2105 
comm="racoon" name="console" dev=tmpfs ino=725 
scontext=system_u:system_r:racoon_t:s0-s15:c0.c1023 
tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
type=AVC msg=audit(1173457995.784:305): avc:  denied  { use } for  pid=2105 
comm="racoon" name="console" dev=tmpfs ino=725 
scontext=system_u:system_r:racoon_t:s0-s15:c0.c1023 
tcontext=system_u:system_r:init_t:s0-s15:c0.c1023 tclass=fd
***

I suspect this can fixed by adding the following to the policy, suggestions?

 init_use_fds(racoon_t)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
