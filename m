Message-ID: <1C693F61F78ADA449B9FDAE7737665E001A0155E@fskrsm41.hill.af.mil>
From: Michael Alexander S Contr OO-ALC/YPVS
	 <Alexander.Michael@HILL.af.mil>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: RH8.0 Install problems
Date: Tue, 26 Nov 2002 11:37:56 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been trying to install 2.4.19 onto RedHat 8.0.  When I try to reboot
I get the following kernel panic:

<snip>
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Cannot open root device "LABEL=/" or 00:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 00:00

I was concerned at first of editing the utils/Makefile as directed in the
README.  As I was neither running RH7.1 nor RH7.2 and did not know what to
set the correct LOGROTATE_VER to, so left it at the default for RH7.2
(LOGROTATE_VER=3.5.9).

What other patches might I need to worry about for installing on RH8.0?  Are
my problems unrelated with the kernel panic and the fact I'm trying to
install on RH8.0?

Thanks,
Alex Michael
alexander.michael@hill.af.mil 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
