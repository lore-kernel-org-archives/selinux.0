Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB9NXJmn024093
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 18:33:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id EA2453415D2
 for <selinux@tycho.nsa.gov>; Fri,  9 Dec 2016 23:33:12 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] selinux(8): fix display of man page references
Date: Fri,  9 Dec 2016 18:33:10 -0500
Message-Id: <20161209233311.11139-1-vapier@gentoo.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The section number shouldn't be bolded.  Fix a few references in
selinux(8) to match all the other man pages.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 libselinux/man/man8/selinux.8 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 6f1034b3664f..e37aee6833b0 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -95,17 +95,17 @@ This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .BR fixfiles (8),
 .BR setfiles (8),
 .BR semanage (8),
-.BR sepolicy(8)
+.BR sepolicy (8)
 
 Every confined service on the system has a man page in the following format:
 .br
 
-.B <servicename>_selinux(8)
+.BR <servicename>_selinux (8)
 
-For example, httpd has the 
-.B httpd_selinux(8) 
+For example, httpd has the
+.BR httpd_selinux (8)
 man page.
 
-.B man -k selinux 
+.B man -k selinux
 
 Will list all SELinux man pages.
-- 
2.11.0.rc2
