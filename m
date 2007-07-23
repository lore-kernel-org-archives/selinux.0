Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NHwEPJ032419
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 13:58:14 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6NHwD6V023592
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 17:58:13 GMT
Message-Id: <20070723173440.880072184@tresys.com>
Date: Mon, 23 Jul 2007 13:34:40 -0400
From: mgoldman@tresys.com
To: selinux@tycho.nsa.gov
Cc: jbrindle@tresys.com
Subject: [patch 0/1] Add user object to libpolicyrep
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Added User object to libpolicyrep.

Signed-off-by: Joshua Brindle

 include/policyrep/policy.hpp |    1 
 include/policyrep/user.hpp   |   46 ++++++++++++++++++++++
 src/policy_parse.y           |    8 +++
 src/user.cpp                 |   89 +++++++++++++++++++++++++++++++++++++++++++
 tests/example.te             |    4 +
 tests/libpolicyrep-test.cpp  |    4 +
 6 files changed, 152 insertions(+)
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
