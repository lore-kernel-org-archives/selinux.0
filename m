Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2TE6nRb003161
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 09:06:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2TDeL5r013052
	for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 14:06:46 GMT
Received: from kokytos.rz.informatik.uni-muenchen.de (kokytos.rz.informatik.uni-muenchen.de [141.84.214.13])
        by jazzband.ncsc.mil  with ESMTP id i2TCPf36019389 for <selinux@tycho.nsa.gov>; Mon, 29 Mar 2004 12:25:42 GMT
Date: Mon, 29 Mar 2004 14:25:41 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Koen Vervloesem <koen.vervloesem@student.kuleuven.ac.be>
Cc: selinux@tycho.nsa.gov
Subject: Re: make relabel: invalid context
Message-ID: <20040329122541.GB20797@bern.cip.informatik.uni-muenchen.de>
References: <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be> <200403262039.i2QKdELb020746@turing-police.cc.vt.edu> <5D73C9A0-7F6C-11D8-A718-003065725CB8@student.kuleuven.ac.be> <200403270025.i2R0PK2l029036@turing-police.cc.vt.edu> <20040328192930.GA12067@bern.cip.informatik.uni-muenchen.de> <7204F773-8108-11D8-AC4F-000A95D903E6@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <7204F773-8108-11D8-AC4F-000A95D903E6@student.kuleuven.ac.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Koen Vervloesem <koen.vervloesem@student.kuleuven.ac.be> [2004-03-29 00:37]:
> >I hit this problem when trying to use a version 16 policy on a kernel
> >which was not configured for it (that is vanilla 2.6.4). Try to set
> >POLICYCOMPAT = -c in the Makefile and also delete
> >/etc/security/selinux/policy.16 , this should fix it.
> 
> OK. Many thanks for the help. I changed the Makefile, deleted the 
> policy.16 file, and reran make policy and make install. Now I didn't 
> get any errors. But is this normal:
> 
> root@carnivore:~/policy-1.8# make load
> /usr/sbin/load_policy /etc/security/selinux/policy.15
> touch tmp/load
> root@carnivore:~/policy-1.8# make relabel
> /usr/sbin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]| 
> xfs).*rw/{print $3}'`
> /usr/sbin/setfiles:  read 0 specifications

I'm not completely sure here, but you might try to replace
/usr/sbin/genhomedircon with the version from the NSA home page (package
policycoreutils) Last time I checked the Debian version was a little
outdated[0] and didn't work on my system. The NSA version needed a
little tweaking (change policy-source-directory to /etc/selinux and
create /etc/default/useradd with one line "HOME=/home") but worked fine
afterwards.

Thomas

[0]: see: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=239539

-- 
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7
"Work like you don't need the money, love like you've never been hurt
and dance like you do when nobody's watching."

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
