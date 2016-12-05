Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB5GDQix014625
 for <selinux@tycho.nsa.gov>; Mon, 5 Dec 2016 11:13:26 -0500
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [RFC PATCH 0/1] selinux-testsuite: Add IPv6 client/server support
 plus tests
Date: Mon,  5 Dec 2016 16:13:03 +0000
Message-Id: <20161205161303.9159-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've added support for IPv6 to the test suite and added some additional
tests. Thought I would make this an RFC as I'm not sure if all tests are
suitable. If any additions required let me know.

Remember if you add this with patch(1) the tests/inet_socket/cipso-flush
and load files do not get their executable bits set so need to do this
manually.

Runs okay on Fedora 25 apart from the overlay test that is a known problem.

Richard Haines (1):
  selinux-testsuite: Add IPv6 client/server support plus tests

 README                                             |   1 +
 .../inet_socket/{netlabel-flush => cipso-fl-flush} |   0
 tests/inet_socket/{netlabel-load => cipso-fl-load} |   2 +-
 tests/inet_socket/cipso-flush                      |   5 +
 tests/inet_socket/cipso-load                       |  11 ++
 tests/inet_socket/client.c                         |  91 +++++++-------
 tests/inet_socket/ipsec-load                       |   6 +
 tests/inet_socket/iptables-flush                   |   2 +
 tests/inet_socket/iptables-load                    |  20 +++
 tests/inet_socket/server.c                         |  67 +++++-----
 tests/inet_socket/test                             | 140 ++++++++++++++++++---
 11 files changed, 251 insertions(+), 94 deletions(-)
 rename tests/inet_socket/{netlabel-flush => cipso-fl-flush} (100%)
 rename tests/inet_socket/{netlabel-load => cipso-fl-load} (89%)
 create mode 100755 tests/inet_socket/cipso-flush
 create mode 100755 tests/inet_socket/cipso-load

-- 
2.9.3
