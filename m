Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17310
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2001 13:56:33 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA14545
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2001 17:55:28 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA14541
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2001 17:55:27 GMT
Message-ID: <3B717D48.C76441D5@fwsystems.com>
Date: Wed, 08 Aug 2001 13:56:24 -0400
From: Forrest Whitcher <fw@fwsystems.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>, SE Linux list <selinux@tycho.nsa.gov>
Subject: selinux and AFS
References: <Pine.SOL.3.95.1010723090133.3466D-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen et al.

I imagine you've had enough 'progress' reports from me, however
I *think* I have figured out the cause of the failure in getting
openAFS to run under the selinux kernel (2.2.19).

Diagnostics on attempting mount were:

>From afsd:
--afsd: Mounting the AFS root on '/afs', flags: 0.
--afsd: Can't mount AFS on /afs(22)

>From the kernel:
--security_compute_av:  unrecognized SID 0
--psid_release:  uninitialized super block

I traced the return call error (EINVAL) to two places. 

First in super.c lines 973, 981 - psid_release when afs attempts 
the mount.

Second in security/services.c at lines 727, 278 - security_compute_av.

I then modified the former to never return an error code, thus 
allowing the mount to proceed. At this point, every attempt to
touch an object at or below the /afs root results in a repetition
of the last diagnostic

--security_compute_av:  unrecognized SID 0

(in these instances it is failing on the 'tsid' lookup- services.c l 278;
in the mount attempt it is the ssid lookup - services.c l 272)

obviously I can  'echo /*' and see that the afs dir is there, however
the above error is returned by any attempt to actually read data
from the filesystem (ls || stat || ...)

Although I have not had time to further trace into the kernel 
sources (spent some time digging, but other things came up)..

I believe I have a good guess about what's causing the problem.

AFS identifies the inode of the 'AFS' type filesystem (mounted
on /afs) as '0'. Is it likely that your routines are seeing the
'0' inode number and giving up / returning the errors to the
callers?

Thanks for any comments, I will have time later in the month to 
delve into this further, meantime, I'd hope to understand the 
hangup prior to heading down to DC next week for the security 
symp.


-- 
Forrest Whitcher    Principal      FW Systems 
617.254.3506                       fw@fwsystems.com                 
fw@world.std.com                   6174803245@mobile.att.net
Information systems consulting     http://www.fwsystems.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
