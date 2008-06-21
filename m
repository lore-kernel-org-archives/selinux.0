Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5LBHex8026933
	for <selinux@tycho.nsa.gov>; Sat, 21 Jun 2008 07:17:40 -0400
Received: from mail.seekline.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5LBHdPU005995
	for <selinux@tycho.nsa.gov>; Sat, 21 Jun 2008 11:17:39 GMT
Received: from [IPv6:2001:6f8:1294:1:211:24ff:fee1:776c] ([IPv6:2001:6f8:1294:1:211:24ff:fee1:776c])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id m5LBHZMA009750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Sat, 21 Jun 2008 13:17:38 +0200
Subject: pam_mount
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Sat, 21 Jun 2008 13:17:42 +0200
Message-Id: <1214047062.30904.13.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I try to temporarily create a policy fix for pam_mount and I'm running
into some problems.

While using local console login mount_t tries to "getattr" every
sock_file in /var/run which I could dontaudit using the following:

dontaudit mount_t pidfile:sock_file getattr;

But there is still another very annoying AVC message which I get for
every directory in /proc which is not labeled as proc_t.

type=1400 audit(1214045895.760:29702): avc:  denied  { getattr } for
pid=28153 comm="fuser" path="/proc/1" dev=proc ino=1675
scontext=system_u:system_r:mount_t:s0-s0:c0.c1023
tcontext=system_u:system_r:init_t:s0 tclass=dir

type=1400 audit(1214045895.762:29703): avc:  denied  { search } for
pid=28153 comm="fuser" name="1" dev=proc ino=1675
scontext=system_u:system_r:mount_t:s0-s0:c0.c1023
tcontext=system_u:system_r:init_t:s0 tclass=dir

For the first few tries I dontaudit every occurrence (over a dozen
types) but I realized that's something I can't win ;-) So I tried using
the following rule:

dontaudit mount_t proc_type:dir { getattr search };

But the AVC is still generated. I hoped that proc_type is an attribute
for every file/dir under /proc. Am I wrong? Or why doesn't the dontaudit
rule count?

Best regards
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
