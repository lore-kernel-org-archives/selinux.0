Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8I3uPxF004133
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 23:56:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8I3uJmw028548
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 03:56:24 GMT
Received: from tama5.ecl.ntt.co.jp (tama5.ecl.ntt.co.jp [129.60.39.102])
        by jazzband.ncsc.mil  with ESMTP id h8I3uB9d028533 for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 03:56:18 GMT
Received: from vcs3.rdh.ecl.ntt.co.jp (vcs3.rdh.ecl.ntt.co.jp [129.60.39.110])
	by tama5.ecl.ntt.co.jp (8.12.8p1/8.12.8) with ESMTP id h8I3txUC021817
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 12:55:59 +0900 (JST)
Received: from nttmail3.ecl.ntt.co.jp (localhost [127.0.0.1])
	by vcs3.rdh.ecl.ntt.co.jp (8.12.8p1/8.12.8) with ESMTP id h8I3twpo022905
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 12:55:58 +0900 (JST)
Received: from eclscan3.m.ecl.ntt.co.jp (eclscan3.m.ecl.ntt.co.jp [129.60.5.69])
	by nttmail3.ecl.ntt.co.jp (8.12.8p1/8.12.8) with ESMTP id h8I3tv8H027657
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 12:55:58 +0900 (JST)
Received: from ima.m.ecl.ntt.co.jp (localhost [127.0.0.1])
	by eclscan3.m.ecl.ntt.co.jp (8.9.3p2/3.7W) with ESMTP id MAA29334
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 12:55:57 +0900 (JST)
Received: from [129.60.17.83]
	by ima.m.ecl.ntt.co.jp (8.9.3p2/3.7W) with ESMTP id MAA22909
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 12:55:56 +0900 (JST)
Date: Thu, 18 Sep 2003 12:55:53 +0900
From: WATASE Jumpei <watase.jumpei@lab.ntt.co.jp>
To: selinux@tycho.nsa.gov
Subject: how to update openssh
Message-Id: <20030918093542.9C48.WATASE.JUMPEI@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

I've tried updating openssh RPM for selinux-2003081307
on Red Hat 9.

I got openssh-3.5p1-11.src.rpm, and copied
openssh-selinux.patch and openssh-3.5p1-socklen.patch
from selinux-usr-2003081307.tgz into source tree of
openssh-3.5p1-11, then modify %patch entry in
openssh.spec.

I put the updated SRPM on
https://sourceforge.jp/projects/selinux/files/

If I left any neccesary item for updating selinux patched program,
I will appreciate you to tell me what and how to do in addition.

Regards,

-- 
WATASE Jumpei <watase.jumpei@lab.ntt.co.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
