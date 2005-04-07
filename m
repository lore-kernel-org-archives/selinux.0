Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37NHDue001094
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 19:17:16 -0400 (EDT)
Received: from leapster.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j37NBqsH028774
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 23:11:53 GMT
Received: from rosso.dwerryhouse.com.au (doof-vpn [10.150.0.2])
	by leapster.org (Postfix) with ESMTP id D7F3C398C3
	for <selinux@tycho.nsa.gov>; Fri,  8 Apr 2005 09:14:30 +1000 (EST)
Date: Fri, 8 Apr 2005 09:14:25 +1000
From: Paul Dwerryhouse <paul@dwerryhouse.com.au>
To: selinux@tycho.nsa.gov
Subject: SELinux packages for SuSE 9.2
Message-ID: <20050407231425.GA14489@dwerryhouse.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi all,

I have created SELinux-enabled packages for SuSE 9.2, and these can be
found here:

http://suse-selinux.leapster.org/

Packages such as libselinux, policycoreutils, etc, have been built from
the main NSA SELinux CVS tree.

I built the other userspace packages by patching SuSE's 9.2 SRPMs with
the selinux patches from Fedora's devel CVS tree, and in many cases
modified them to make the patches apply properly.

Also provided is an SELinux-enabled kernel, based on the 2.6.11.4
kernel-of-the-day source from SuSE's ftp server, with the latest
SELinux patch applied.

I have not altered the policy yet, so as it stands, the system will hang
if placed into enforcing mode. This is fairly simple to fix - just a small
change to the getty policy is required - and I hope to have an updated
policy package available later today. However, there will still be a
considerable number of policy fixes needed before this is usable.

Cheers,

Paul.

-- 
Paul Dwerryhouse				| PGP Key ID: 0x6B91B584
Melbourne, Australia				|

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
