From: "Carl Carpenter" <ccarpenter@hillcountry.org>
To: "SELinux" <SELinux@tycho.nsa.gov>
Subject: Problems with eth0
Date: Wed, 10 Oct 2001 09:06:04 -0500
Message-ID: <DIECIJMLKGOOCPBJIBKJAELJCEAA.ccarpenter@hillcountry.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have discovered how SELinux provides such terrific security--it doesn't
load the eth0 drivers, thereby keeping the server off the network.
Seriously, I have a problem when running the SELinux kernel in that the eth0
module can't be found during bootup (modprobe:  can't locate module eth0).
I'm running 2.4.10-lsm on RH 7.1 (I386).  It works fine in normal mode.  I
followed the install instructions step-for-step, selecting the preferred
method of building the SELinux module as part of the kernel.  If I got any
error messages, I didn't see them with all the other messages on the screen.
I'm fairly new to Linux, so this may be an easy fix, but it's beyond me at
the moment.  Thanks in advance for any help.

Carl Carpenter
IT Manager
Hill Country Community MHMR Center
"Hiroshima 1945, Chernobyl 1986, Windows 2000"

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.285 / Virus Database: 151 - Release Date: 10/5/2001



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
