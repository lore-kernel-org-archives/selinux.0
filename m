Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0VJicMl020117
 for <selinux@tycho.nsa.gov>; Tue, 31 Jan 2017 14:44:38 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/2] checkpolicy & libsepol: process declarations and
 requirements
Date: Tue, 31 Jan 2017 14:44:52 -0500
Message-Id: <1485891894-18949-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently, a declaration and requirment of the same identifier is different
depending on whether it is declared first or required first.

Nicolas Iooss reported that a require followed by a declaration is accepted,
but a duplicate declaration error is given if the declaration comes first.

This code works:

optional {
  require {
    type TYPE1;
  }
}
optional {
  require {
    attribute ATTR;
  }
  type TYPE1, ATTR;
}

But this does not:

optional {
  require {
    attribute ATTR;
  }
  type TYPE1, ATTR;
}
optional {
  require {
    type TYPE1;
  }
}

Handle the case of a declaration followed by a requirement the same as
a requirement followed by a declaration.

James Carter (2):
  libsepol: Return +1 when declaration is followed by a require
  checkpolicy: Remove uneeded return check in require_symbol()

 checkpolicy/module_compiler.c | 20 ++++++--------------
 libsepol/src/policydb.c       |  3 ---
 2 files changed, 6 insertions(+), 17 deletions(-)

-- 
2.7.4
