Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB9KqShN002352
 for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2015 15:52:33 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id ED4848E3E7
 for <selinux@tycho.nsa.gov>; Wed,  9 Dec 2015 20:52:30 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux/man: Add information about thread specific on
 setfscreatecon
Date: Wed,  9 Dec 2015 21:52:10 +0100
Message-Id: <1449694330-30280-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Walsh <dwalsh@redhat.com>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/man/man3/getfscreatecon.3   | 5 +++++
 libselinux/man/man3/getkeycreatecon.3  | 4 ++++
 libselinux/man/man3/getsockcreatecon.3 | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/libselinux/man/man3/getfscreatecon.3 b/libselinux/man/man3/getfscreatecon.3
index e348d3b..8cc4df5 100644
--- a/libselinux/man/man3/getfscreatecon.3
+++ b/libselinux/man/man3/getfscreatecon.3
@@ -49,6 +49,11 @@ Signal handlers that perform a
 must take care to
 save, reset, and restore the fscreate context to avoid unexpected behavior.
 .
+
+.br
+.B Note:
+Contexts are thread specific.
+
 .SH "RETURN VALUE"
 On error \-1 is returned.
 On success 0 is returned.
diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
index 4d70f10..b51008d 100644
--- a/libselinux/man/man3/getkeycreatecon.3
+++ b/libselinux/man/man3/getkeycreatecon.3
@@ -48,6 +48,10 @@ Signal handlers that perform a
 .BR setkeycreatecon ()
 must take care to
 save, reset, and restore the keycreate context to avoid unexpected behavior.
+
+.br
+.B Note:
+Contexts are thread specific.
 .
 .SH "RETURN VALUE"
 On error \-1 is returned.
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 4dd8f30..26086d9 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -49,6 +49,11 @@ Signal handlers that perform a
 must take care to
 save, reset, and restore the sockcreate context to avoid unexpected behavior.
 .
+
+.br
+.B Note:
+Contexts are thread specific.
+
 .SH "RETURN VALUE"
 On error \-1 is returned.
 On success 0 is returned.
-- 
2.6.3
