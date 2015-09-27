Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8R1AoJQ020962
 for <selinux@tycho.nsa.gov>; Sat, 26 Sep 2015 21:10:50 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 2CF5D1A1BB
 for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2015 03:10:44 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lfjH1wQrpkCM for <selinux@tycho.nsa.gov>;
 Sun, 27 Sep 2015 03:10:09 +0200 (CEST)
Received: from [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073] (unknown
 [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 9F9FB1A053
 for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2015 03:10:09 +0200 (CEST)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: newrole not working when built with LSPP_PRIV=y
Message-ID: <560741F0.9090709@debian.org>
Date: Sun, 27 Sep 2015 03:10:08 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

Running newrole executable compiled with LSPP_PRIV=y I get the following
error while it's trying to switch role:

Error sending audit message.

It seems that the CAP_AUDIT_WRITE capability is not set [0]. Adding this
capability to the list doesn't seems enough, I then get the following error:

failed to exec shell: Operation not permitted

Looking at the fedora tree, I've found this patch[1] (which is not
merged upstream) that seems to fix both issues.

The patch seems to break an other thing, it Fedora the newrole
executable is not setuid root, but it is granted a bunch of capabilities
explicitly, if I setuid this executable instead of granting these
capabilities, I get yet an other error:

Sorry, newrole failed to drop capabilities: Operation not permitted

So I guess something need to be fixed here.

Cheers,

Laurent Bigonville

[0]
https://github.com/SELinuxProject/selinux/blob/master/policycoreutils/newrole/newrole.c#L590

[1]
https://github.com/fedora-selinux/selinux/commit/339a6fed0b37f8b82e4382bc6a5c9367119ed92b
