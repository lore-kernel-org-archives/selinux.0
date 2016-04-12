Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3CE8HLL009500
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 10:08:19 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55ECA47048
 for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2016 14:08:14 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Fix typo in sefcontext_compile.8
Date: Tue, 12 Apr 2016 16:07:56 +0200
Message-Id: <1460470076-2823-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The man page contains 'prce' instead of 'pcre'

Reported-by: Milos Malik <mmalik@redhat.com>
Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/man/man8/sefcontext_compile.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man8/sefcontext_compile.8 b/libselinux/man/man8/sefcontext_compile.8
index b77ff3a..4eae173 100644
--- a/libselinux/man/man8/sefcontext_compile.8
+++ b/libselinux/man/man8/sefcontext_compile.8
@@ -13,14 +13,14 @@ sefcontext_compile \- compile file context regular expression files
 .SH "DESCRIPTION"
 .B sefcontext_compile
 is used to compile file context regular expressions into
-.BR prce (3)
+.BR pcre (3)
 format.
 .sp
 The compiled file is used by libselinux file labeling functions.
 .sp
 By default
 .B sefcontext_compile
-writes the compiled prce file with the
+writes the compiled pcre file with the
 .B .bin
 suffix appended (e.g. \fIinputfile\fB.bin\fR).
 .SH OPTIONS
-- 
2.7.3
