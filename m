Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB7M2xiZ005248
 for <selinux@tycho.nsa.gov>; Mon, 7 Dec 2015 17:03:00 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 1D9E81A1D8
 for <selinux@tycho.nsa.gov>; Mon,  7 Dec 2015 23:02:30 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nJj4hW6VX7Vu for <selinux@tycho.nsa.gov>;
 Mon,  7 Dec 2015 23:02:28 +0100 (CET)
Received: from [IPv6:2a02:578:85fc:1::6b5] (unknown
 [IPv6:2a02:578:85fc:1::6b5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 37BB01A070
 for <selinux@tycho.nsa.gov>; Mon,  7 Dec 2015 23:02:28 +0100 (CET)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: New setools3 release
Message-ID: <566601F3.2020307@debian.org>
Date: Mon, 7 Dec 2015 23:02:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

Are there any plans to do a new setools3 release?

The current version is not building with the userspace 2.4 so I was 
wondering if somebody could roll a new release? Otherwise I'll take a 
snapshot of the git repository.

Cheers,

Laurent Bigonville
