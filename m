Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2SJTaRb001457
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 14:29:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2SJTZFV027623
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 19:29:35 GMT
Received: from kokytos.rz.informatik.uni-muenchen.de (kokytos.rz.informatik.uni-muenchen.de [141.84.214.13])
        by jazzband.ncsc.mil  with ESMTP id i2SJTY36027615 for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 19:29:35 GMT
Received: from bern.cip.informatik.uni-muenchen.de (bern.cip.informatik.uni-muenchen.de [141.84.214.132])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id E4CB8435E9
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 21:29:31 +0200 (CEST)
Date: Sun, 28 Mar 2004 21:29:31 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: selinux@tycho.nsa.gov
Subject: Re: make relabel: invalid context
Message-ID: <20040328192930.GA12067@bern.cip.informatik.uni-muenchen.de>
References: <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be> <200403262039.i2QKdELb020746@turing-police.cc.vt.edu> <5D73C9A0-7F6C-11D8-A718-003065725CB8@student.kuleuven.ac.be> <200403270025.i2R0PK2l029036@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200403270025.i2R0PK2l029036@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Valdis.Kletnieks@vt.edu [2004-03-27 02:52]:
> On Fri, 26 Mar 2004 22:27:20 +0100, Koen Vervloesem said:
> 
> > This is the first time I load the policy, I just did the SELinux 
> > installation, of which the last step is the make relabel. When I do 
> > what you suggest, I get this:
> 
> > /usr/sbin/load_policy /etc/security/selinux/policy.16
> > /usr/sbin/load_policy:  security_load_policy failed
> 
> Not good..
> 
> > root@carnivore:~/policy-1.8# make relabel
> > /usr/sbin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]| xfs).*rw/{print $3}'`
> > /usr/sbin/setfiles:  read 0 specifications
> 
> And even worse.
> 
> Is it possible that you've installed the SELinux software on the box, but
> are still running on a non-SELinux kernel, and need a reboot?

I hit this problem when trying to use a version 16 policy on a kernel
which was not configured for it (that is vanilla 2.6.4). Try to set
POLICYCOMPAT = -c in the Makefile and also delete
/etc/security/selinux/policy.16 , this should fix it.

Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
