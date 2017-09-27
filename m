Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8R8H7bA014919
 for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2017 04:17:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D28D81E07
 for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2017 08:17:01 +0000 (UTC)
Received: from Thinkpad_450.redhat.com (unknown [10.40.205.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67E3E7EA38
 for <selinux@tycho.nsa.gov>; Wed, 27 Sep 2017 08:17:00 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 27 Sep 2017 10:16:43 +0200
Message-Id: <20170927081645.32481-1-vmojzis@redhat.com>
Subject: Enable listing fcontexts.homedirs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

"semanage fcontext -l" so far ignored content of file_contexts.homedirs
file which is confusing to users (more specific rules may be ignored in
favor of rules unseen to the user since file_contexts.homedirs has
higher priority than file_contexts).

These patches introduce the content of file_contexts.homedirs into 
the listing.

I am still unsure if it would not be better to list each file
separately (ideally in the order in which they are evaluated by
"restorecon").

 libsemanage/include/semanage/fcontexts_policy.h |  4 ++++
 libsemanage/src/direct_api.c                    |  6 ++++++
 libsemanage/src/fcontexts_policy.c              |  8 ++++++++
 libsemanage/src/handle.h                        | 19 +++++++++++++------
 python/semanage/seobject.py                     |  5 +++++
 5 files changed, 36 insertions(+), 6 deletions(-)
