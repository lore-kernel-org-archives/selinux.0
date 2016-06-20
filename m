Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KFghE9032238
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 11:42:44 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C86EB1CA0
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 15:42:15 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Cc: David King <dking@redhat.com>
Subject: [PATCH 1/2] libselinux: man: Explain how to free policy type from
 selinux_getpolicytype()
Date: Mon, 20 Jun 2016 17:41:53 +0200
Message-Id: <1466437314-9813-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: David King <dking@redhat.com>

Additionally, fix a typo.

Signed-off-by: David King <dking@redhat.com>
---
 libselinux/man/man3/selinux_getpolicytype.3 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man3/selinux_getpolicytype.3 b/libselinux/man/man3/selinux_getpolicytype.3
index c947e2c..b219d42 100644
--- a/libselinux/man/man3/selinux_getpolicytype.3
+++ b/libselinux/man/man3/selinux_getpolicytype.3
@@ -13,7 +13,10 @@ Reads the contents of the
 .I /etc/selinux/config
 file to determine the SELinux policy used on the system, and sets
 .I \%policytype
-accordinly.
+accordingly. Free
+.I \%policytype
+with
+.BR free (3).
 .
 .SH "RETURN VALUE"
 On success, zero is returned.
-- 
2.7.4
