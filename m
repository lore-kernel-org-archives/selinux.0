Subject: Installation problems and a web based set of instructions.
From: Nick <nagray@austin.rr.com>
To: SELINUX <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 15 Nov 2003 22:34:20 -0600
Message-Id: <1068957264.955.1498.camel@marquesas>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

All,

I have been a member of this list for probably 2-3 years.On my todo list
was set up a SELinux box for evaluation. Due to other considerations I
haven't been able to do this until now.

Recently I have been task to set up SELinux test boxes for ONI, document
the installations, and begin work on MLS in order to evaluate the
possibility of SELinux as a CMW.

I have created a web page to document the process so far and act as a
guide to the installation/evaluation process.

The web site can be found at.

https://www.efficax.net/Open/SELinux/build.php

This is two days into the process and I am working on Saturday, which I
don't want to do. If anyone has comments about the site (in particular
mistakes). Feel free to let me know.

I started my first installation on Thursday and everything went
relatively well. I converted the notes I took to the web page and
embarked on a rather frustrating attempt to create a kickstart floppy
that I could use to create a standard baseline for my SELinux
installations.

I got the kickstart working friday (with a caveat that I haven't updated
on the page yet) And progressed to install SELinux as per the documented
procedure.

I must admit that the second, third, and fourth installations are not
going as well.

# Everytime I get to step 6 now I lose network connectivity. Here is
what is in the logs regarding networking/selinux.

#1
Nov 15 15:33:50 selinux kernel: Security Scaffold v1.0.0 initialized
Nov 15 15:33:50 selinux kernel: SELinux:  Initializing.
Nov 15 15:33:50 selinux kernel: SELinux:  Starting in permissive mode
Nov 15 15:33:50 selinux kernel: There is already a security framework
initialized, register_security
failed.
Nov 15 15:33:50 selinux kernel: Failure registering capabilities with
the kernel
Nov 15 15:33:50 selinux kernel: selinux_register_security:  Registering
secondary module capability

Nov 15 15:33:51 selinux kernel: e100: eth0 NIC Link is Up 100 Mbps Half
duplex

Nov 15 15:33:49 selinux network: Setting network parameters:  succeeded
Nov 15 15:33:49 selinux modprobe: modprobe: Can't locate module
net-pf-17
Nov 15 15:33:49 selinux ifup: arping: socket: Address family not
supported by protocol
Nov 15 15:33:49 selinux ifup: Error, some other host already uses
address 127.0.0.1.
Nov 15 15:33:49 selinux network: Bringing up loopback interface:  failed
Nov 15 15:33:49 selinux modprobe: modprobe: Can't locate module
net-pf-17
Nov 15 15:33:49 selinux ifup: arping: socket: Address family not
supported by protocol
Nov 15 15:33:49 selinux ifup: Error, some other host already uses
address 24.153.230.188.
Nov 15 15:33:49 selinux network: Bringing up interface eth0:  failed

If I boot the stock kernel again it works just fine.

I am hoping that these errors are common enough for people to pop me
quick answers to whatever blunder I may have made.


-- 
Nick Gray
Senior Network Engineer
Bruzenak Inc.
nagray@bruzenak.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
