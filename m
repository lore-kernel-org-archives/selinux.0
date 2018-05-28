Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4SLlR4S019366
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 17:47:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 40vr6Y22Jlz1pF1G
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 21:47:01 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 40vr6X1J0wz1pF1J
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 21:47:00 +0000 (UTC)
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 4A33B1A158
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 23:46:56 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id IiSoiqSHM5gD for <selinux@tycho.nsa.gov>;
 Mon, 28 May 2018 23:46:34 +0200 (CEST)
Received: from valinor.bigon.be (unknown
 [IPv6:2a02:a03f:3cdd:ea00:78cd:ee5b:2d35:292b])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 9DA941A071
 for <selinux@tycho.nsa.gov>; Mon, 28 May 2018 23:46:34 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Date: Mon, 28 May 2018 23:46:31 +0200
Message-Id: <20180528214633.19374-1-bigon@debian.org>
Subject: [PATCH 1/3] libselinux: Fix spelling errors in manpages
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libselinux/man/man3/selinux_boolean_sub.3      | 2 +-
 libselinux/man/man3/selinux_restorecon_xattr.3 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man3/selinux_boolean_sub.3 b/libselinux/man/man3/selinux_boolean_sub.3
index 308c2684..d24c12a3 100644
--- a/libselinux/man/man3/selinux_boolean_sub.3
+++ b/libselinux/man/man3/selinux_boolean_sub.3
@@ -12,7 +12,7 @@ selinux_boolean_sub \-
 searches the
 .I \%/etc/selinux/{POLICYTYPE}/booleans.subs_dist
 file
-for a maching boolean_name record.  If the record exists the boolean substitution name is returned.  If not
+for a matching boolean_name record.  If the record exists the boolean substitution name is returned.  If not
 .BR \%selinux_boolean_sub ()
 returns the original
 .IR \%boolean_name .
diff --git a/libselinux/man/man3/selinux_restorecon_xattr.3 b/libselinux/man/man3/selinux_restorecon_xattr.3
index 7280c958..516d2669 100644
--- a/libselinux/man/man3/selinux_restorecon_xattr.3
+++ b/libselinux/man/man3/selinux_restorecon_xattr.3
@@ -119,7 +119,7 @@ By default
 .BR selinux_restorecon_xattr (3)
 will use the default set of specfiles described in
 .BR files_contexts (5)
-to calculate the initial SHA1 digest to be used for comparision.
+to calculate the initial SHA1 digest to be used for comparison.
 To change this default behavior
 .BR selabel_open (3)
 must be called specifying the required
-- 
2.17.0
