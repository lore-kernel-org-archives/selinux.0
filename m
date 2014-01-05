Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s05AjKuV031353
 for <selinux@tycho.nsa.gov>; Sun, 5 Jan 2014 05:45:20 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id DE1AC1A054
 for <selinux@tycho.nsa.gov>; Sun,  5 Jan 2014 11:45:14 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ljvyNJkm1Ozs for <selinux@tycho.nsa.gov>;
 Sun,  5 Jan 2014 11:45:13 +0100 (CET)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:578:85fc:1:226:18ff:fe08:6073])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 13D6B1A00F
 for <selinux@tycho.nsa.gov>; Sun,  5 Jan 2014 11:45:13 +0100 (CET)
Date: Sun, 5 Jan 2014 11:45:02 +0100
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: Mounting selinuxfs as read-only inside chroot
Message-ID: <20140105114502.4a9fd0ff@fornost.bigon.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I'm maybe missing something, but was wondering, what is the benefit of
mounting the selinuxfs in a chroot as read-only vs not mounting it at
all as the user space will anyway report selinux as disabled.

For example, it seems that mock is doing that (looking at the ML
archive it's the primary reasons this has been implemented).

I'm asking this because several tools in debian that are using chroot
to build/test (pbuilder, piuparts,...) .deb are mounting the selinuxfs
r/w and this is causing issues with dpkg if the policy is not installed
in the chroot.

I'm planing to propose to mount the selinuxfs as r/o in the chroot they
are using, but I would like to understand this a bit more first.

Cheers,

Laurent Bigonville
