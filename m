Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9JH8E8M015294
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 13:08:15 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Thu, 19 Oct 2017 16:57:31 +0100
Message-Id: <20171019155731.26625-1-richard_c_haines@btinternet.com>
Subject: [RFC PATCH 0/1] selinux-testsuite: Add CALIPSO/IPv6 tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've tested this patch with and without the kernel patch described in
"Add SCM_SECURITY support to IPv6" [1] over a few kernel releases (4.13.4
was my latest test).

Thought I would post and see how it goes as you may want the datagram
support removed as the kernel patch has not been submitted yet.

[1] https://github.com/SELinuxProject/selinux-kernel/issues/24

Richard Haines (1):
  selinux-testsuite: Add CALIPSO/IPv6 tests

 tests/inet_socket/Makefile      |   3 +
 tests/inet_socket/calipso-flush |   5 ++
 tests/inet_socket/calipso-load  |   7 +++
 tests/inet_socket/server.c      |  67 +++++++++++++++++------
 tests/inet_socket/test          | 118 ++++++++++++++++++++++++++++++++++++----
 5 files changed, 173 insertions(+), 27 deletions(-)
 create mode 100644 tests/inet_socket/calipso-flush
 create mode 100644 tests/inet_socket/calipso-load

-- 
2.13.6
