Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBMBlNwH006814
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 06:47:23 -0500
From: Huw Davies <huw@codeweavers.com>
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: [RFC PATCH 00/17] CALIPSO implementation
Date: Tue, 22 Dec 2015 11:46:36 +0000
Message-Id: <1450784813-18304-1-git-send-email-huw@codeweavers.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch series implements RFC 5570 - Common Architecture Label IPv6
Security Option (CALIPSO).  Its goal is to set MLS sensitivity labels
on IPv6 packets using a hop-by-hop option.  CALIPSO very similar to
its IPv4 cousin CIPSO and much of this series is based on that code.

Most of this series involves adding support to NetLabel and adding a
CALIPSO module within IPv6, and as such is fairly self-contained.
There are however a few places where I've needed to add things to the
core networking stack, so I'd be particularly interested in hearing
comments about these:

[PATCH 08/17] ipv6: Add ipv6_renew_options_kern() that accepts a kernel mem pointer.
  Hopefully not too controversial - adds a kernel memory version of
  ipv6_renew_options()

[PATCH 12/17] ipv6: Allow request socks to contain IPv6 options.
  We need a way to set the IPv6 options on request sockets, just like
  we do for IPv4.  This is so that the LSM can ensure the SYN-ACK is
  correctly labelled.

The series is based off v4.4-rc6.

Thoughts about these and any of the other patches are most welcome.

If anybody actually wants to play with this, then you'll need some patches
to netlabel-tools that are currently available on the 'calipso' branch at:
https://github.com/hdmdavies/netlabel_tools.git

Thanks to Paul Moore for his guidance in getting this far.

Huw.
