Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBJCDBZk006092
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 07:13:11 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17280C0467EC
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 12:13:08 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/setfiles: Mention customizable types in
 restorecon man page
Date: Mon, 19 Dec 2016 13:12:56 +0100
Message-Id: <1482149576-13771-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/setfiles/restorecon.8 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index fdb468b..1803c12 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -58,6 +58,12 @@ The
 .B \-F
 option will force a replacement of the entire context.
 .P
+If a file is labeled with
+.BR customizable
+SELinux type (for list of customizable
+types see /etc/selinux/targeted/contexts/customizable_types), restorecon
+won't reset the label unless the \-F option is used.
+.P
 It is the same executable as
 .BR setfiles
 but operates in a slightly different manner depending on its argv[0].
@@ -124,7 +130,7 @@ change files and directories file labels recursively (descend directories).
 .br
 .TP
 .B \-v
-show changes in file labels. Note that the
+show changes in file labels. Multiple -v options increase the verbosity. Note that the
 .B \-v
 and
 .B \-p
-- 
2.7.4
