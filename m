Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KFghE8032238
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 11:42:43 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F0AD1176AD
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 15:42:16 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Cc: David King <dking@redhat.com>
Subject: [PATCH 2/2] libselinux: man: Clarify is_selinux_mls_enabled()
 description
Date: Mon, 20 Jun 2016 17:41:54 +0200
Message-Id: <1466437314-9813-2-git-send-email-plautrba@redhat.com>
In-Reply-To: <1466437314-9813-1-git-send-email-plautrba@redhat.com>
References: <1466437314-9813-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: David King <dking@redhat.com>

Improve the description by mentioning that if is_selinux_mls_enabled(),
it simply means that the kernel has MLS support and the policy contains
MLS features. To check whether MLS support is enabled on the running
system, use selinux_getpolicytype().

Signed-off-by: David King <dking@redhat.com>
---
 libselinux/man/man3/is_selinux_enabled.3 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man3/is_selinux_enabled.3 b/libselinux/man/man3/is_selinux_enabled.3
index b2df562..df62c22 100644
--- a/libselinux/man/man3/is_selinux_enabled.3
+++ b/libselinux/man/man3/is_selinux_enabled.3
@@ -18,7 +18,9 @@ returns 1 if SELinux is running or 0 if it is not.
 On error, \-1 is returned.
 
 .BR is_selinux_mls_enabled ()
-returns 1 if SELinux is running in MLS mode or 0 if it is not. 
+returns 1 if SELinux is capable of running in MLS mode or 0 if it is not. To
+determine the policy in use on the system, use
+.BR selinux_getpolicytype (3).
 .
 .SH "SEE ALSO"
 .BR selinux "(8)"
-- 
2.7.4
