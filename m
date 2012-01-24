Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0OGMCNw012478
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 11:22:12 -0500
Received: from countercultured.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id q0OGMBiC004465
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 16:22:11 GMT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 24 Jan 2012 11:22:10 -0500
From: David Quigley <selinux@davequigley.com>
To: <selinux@lists.fedoraproject.org>, <selinux@tycho.nsa.gov>
Subject: Recent /proc/pid/mem exploit
Message-ID: <a2c83875882386021eb7ccd57df283ee@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So I read through the recent privilege escalation vulnerability using 
su and gpasswd which exploits weak permission checks in /proc/pid/mem 
and tried to figure out why we didn't stop it. What it comes down to is 
that /proc/pid and everything under it is given the same type as the 
process itself. In the case of the gpasswd that type is groupadd_t. 
Looking at the kernel code for /proc/pid/mem and its read/write 
functions it seems that the only permission checking we do on that node 
is done by the vfs. So from the SELinux perspective you would need allow 
groupadd_t groupadd_t file:{open read write} to have access to 
/proc/pid/mem. For some odd reason tons and tons of applications have 
file:{open read and write} on itself.

One question that should be asked is why is is that we have so many 
rules that contain sometype_t sometype_t file: {open read write}. Is it 
necessary or something that is just being pulled in from a macro. If 
this is necessary for other reasons the followup to this would be should 
/proc/pid/mem have the same type as the process or should we have some 
additional requirements permission wise for a process to read and write 
to its own memory through /proc/pid/mem. What are the valid reasons for 
a process to be poking around through its memory using /proc/pid/mem?

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
