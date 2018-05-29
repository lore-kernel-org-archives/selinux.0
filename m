Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4TFQWED032128
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 11:26:33 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 568D61A0C0
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 17:20:06 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LJWlqTdBHzyC for <selinux@tycho.nsa.gov>;
 Tue, 29 May 2018 17:19:44 +0200 (CEST)
Received: from [10.20.225.173] (unknown [193.53.238.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id B60C51A055
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 17:19:44 +0200 (CEST)
To: selinux <selinux@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <e5db3333-4185-c009-6faf-4136757f829d@debian.org>
Date: Tue, 29 May 2018 17:19:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: fixfiles and load_policy moved from /sbin to /usr/sbin
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

While packaging policycoreutils 2.8 I've seen that the fixfiles and 
load_policy executables were moved from /sbin to /usr/sbin

Any reasons for this? This seems to me like an involuntary side effect 
of the cleanup for DESTDIR and PREFIX in the build system.

For distribution with usr-merge that will not change anything, but for 
others that could prevent early boot scripts to load the policy

Shouldn't that be reverted?

Kind regards,

Laurent Bigonville
