Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v43AUqwW029541
 for <selinux@tycho.nsa.gov>; Wed, 3 May 2017 06:30:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 818B683F3A
 for <selinux@tycho.nsa.gov>; Wed,  3 May 2017 10:30:50 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 02/19] sepolicy: Fix spelling mistakes in commands in
 generated manpages
Date: Wed,  3 May 2017 12:30:19 +0200
Message-Id: <20170503103036.17514-3-plautrba@redhat.com>
In-Reply-To: <20170503103036.17514-1-plautrba@redhat.com>
References: <20170503103036.17514-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/manpage.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 3ebdfeb7..bd5a64ac 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -1172,7 +1172,7 @@ Three things can happen when %(type)s attempts to execute a program.
 
 Execute the following to see the types that the SELinux user %(type)s can execute without transitioning:
 
-.B search -A -s %(type)s -c file -p execute_no_trans
+.B sesearch -A -s %(type)s -c file -p execute_no_trans
 
 .TP
 
@@ -1180,7 +1180,7 @@ Execute the following to see the types that the SELinux user %(type)s can execut
 
 Execute the following to see the types that the SELinux user %(type)s can execute and transition:
 
-.B $ search -A -s %(type)s -c process -p transition
+.B $ sesearch -A -s %(type)s -c process -p transition
 
 """ % {'user': self.domainname, 'type': self.type})
 
-- 
2.12.2
