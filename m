Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1AAxIvt012165
 for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2016 05:59:18 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 470261A1D5
 for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2016 11:59:12 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Xxds1jsNaOxJ for <selinux@tycho.nsa.gov>;
 Wed, 10 Feb 2016 11:59:09 +0100 (CET)
Received: from [10.20.187.159] (unknown [193.53.238.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 3C34D1A1B0
 for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2016 11:59:09 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
Subject: Copying/setting security.selinux xattr explicitly
To: selinux@tycho.nsa.gov
Message-ID: <56BB17FC.70507@debian.org>
Date: Wed, 10 Feb 2016 11:59:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I've a question concerning copying the security.selinux xattr explicitly.

In you opinion what should happen in an implementation if it cannot be 
reset security.selinux on the target file?

Apparently GNU cp -a ignore failures (while cp --preserve=context fails).

In some python helper function (_copyxattr(), see 
https://bugs.python.org/issue14082), it will return an exception if the 
copy of any of the xattr is failing, there is no special case for 
security.selinux.

What do you think should be the behavior here?

Cheers,

Laurent Bigonville
