Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6PFWZrT020320
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 11:32:36 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6PFW6VH012424
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 15:32:06 GMT
Received: from localhost (shorty@debby [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11/Debian-5) with ESMTP id i6PFWaLG007441
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 17:32:37 +0200
Subject: Selinux possible on Debian-Linux/ppc?
From: Wolfgang Pfeiffer <roto@gmx.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1090769556.7265.32.camel@debby>
Mime-Version: 1.0
Date: Sun, 25 Jul 2004 17:32:36 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All

First what I have here:

$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7455, altivec supported
clock           : 867MHz
revision        : 3.2 (pvr 8001 0302)
bogomips        : 864.64
machine         : PowerBook3,5
motherboard     : PowerBook3,5 MacRISC2 MacRISC Power Macintosh
board revision  : 00000000
detected as     : 80 (PowerBook Titanium IV)
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 768MB
pmac-generation : NewWorld

And I'm running 2 OS's on that machine: Mac OS X (that gets booted here
about once in 2 months or so ...  :). And Debian Linux, unstable
edition.

I'm planning to get a SE Kernel 2.6 compiled here.

But I'm not quite sure whether SElinux will run on that machine, and on
Debian-ppc ...

On 
<http://www.nsa.gov/selinux/>:
I read:
"Currently, we can only support the x86 architecture .."

But a quick search for SElinux packages for my system gives this:

      * checkpolicy - SELinux policy compiler
      * libselinux1 - SELinux shared libraries
      * libselinux1-dev - SELinux development headers
      * policycoreutils - SELinux core policy utilities
      * selinux-doc - documentation for Security-Enhanced Linux
      * selinux-policy-default - Policy config files and management for
        NSA Security Enhanced Linux
      * selinux-utils - SELinux utility programs


So my hope is that the info on
<http://www.nsa.gov/selinux/>
isn't valid any more. Or that it simply means that the downloadable
packages on  .<http://www.nsa.gov/selinux/>  are meant for Intel only ..

Thanks for some hints in anticipation

Best Regards
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
