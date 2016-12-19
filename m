Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBJI1MMd015365
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 13:01:25 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0077685540
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 18:00:49 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/setfiles: Mention customizable types in
 restorecon man page
Date: Mon, 19 Dec 2016 19:00:30 +0100
Message-Id: <1482170430-698-1-git-send-email-vmojzis@redhat.com>
In-Reply-To: <1482159099.28570.22.camel@tycho.nsa.gov>
References: <1482159099.28570.22.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/setfiles/restorecon.8 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index fdb468b..ec2b1b1 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -58,6 +58,12 @@ The
 .B \-F
 option will force a replacement of the entire context.
 .P
+If a file is labeled with
+.BR customizable
+SELinux type (for list of customizable
+types see /etc/selinux/{SELINUXTYPE}/contexts/customizable_types), restorecon
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
@@ -209,4 +215,5 @@ The program was written by Dan Walsh <dwalsh@redhat.com>.
 .SH "SEE ALSO"
 .BR setfiles (8),
 .BR load_policy (8),
-.BR checkpolicy (8)
+.BR checkpolicy (8),
+.BR customizable_types (8)
-- 
2.7.4
