Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m09FCHe6016073
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2008 10:12:17 -0500
Received: from florence.astrium.eads.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m09FCFxW022270
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2008 15:12:16 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: UNCLASSIFIED - Developing Policies for SELinux on Embedded Systems
Date: Wed, 9 Jan 2008 15:11:26 -0000
Message-ID: <7F6B06837A5DBD49AC6E1650EFF5490601C64BEB@auk52177.ukr.astrium.corp>
From: "HAWKER, Dan 2 \(external\)" <Dan.HAWKER@uk4.astrium.eads.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Hi All,

Not 100% sure if this is the right list to enquire about this, if not
can someone point me towards somewhere that might be :)

Have been tasked with generating a series of SELinux policies for some
embedded Linux devices we are developing. Naturally, time is not in
abundance :(

The target system is a special stripped-down FC4 variant (i386, about
80MB footprint), we have developed in-house for our embedded platform
and runs a custom 2.6.12ish kernel with some modifications for the
target hardware.

I planned to start with the base reference policy, strip out the bits we
don't need (it only runs our own apps plus the minimum to boot) and then
add policies for our apps. All presuming the relatively old kernel we
are using can handle the ref policy and subsequent libselinux, etc
updates of course.

Obviously with time being of the essence, I'd like a quick and easy way
of developing the appropriate policies. I have looked at the tools that
are available at present (SLIDE, SETools, etc) however tbh am a bit
confused about what would be the best way forward and whether it'll all
work as expected before I spend days/weeks of development time down a
dead end.

Naturally the embedded nature of the hardware means I am unable to
develop directly on the target and as such SLIDE seems a good tool and
with the SLIDERemote, would seem a good fit, (install SLIDE on my RHEL5
DevBox and connect to my remote target, which has network access but
limited onboard resources). However am just unsure as to whether it will
work as expected or indeed if there is another better route or toolset I
should take.

Any ideas/insights gratefully received :)

Thanks for any help

Dan

--

Dan Hawker
Linux System Administrator
Astrium
http://www.astrium.eads.net

-- 

This email (including any attachments) may contain confidential and/or
privileged information or information otherwise protected from disclosure.
If you are not the intended recipient, please notify the sender
immediately, do not copy this message or any attachments and do not use it
for any purpose or disclose its content to any person, but delete this
message and any attachments from your system. Astrium disclaims any and all
liability if this email transmission was virus corrupted, altered or
falsified.
---------------------------------------------------------------------
Astrium Limited, Registered in England and Wales No. 2449259
REGISTERED OFFICE:-
Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
