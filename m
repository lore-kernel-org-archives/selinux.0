Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KEAobe019600
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 10:10:54 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 278E47F6A7
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 14:10:29 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: compare absolute pathname in matchpathcon -V
Date: Mon, 20 Jun 2016 16:10:18 +0200
Message-Id: <1466431818-20937-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

filepath needs to be resolved first in order to be correctly found by
selabel_lookup_raw()

Fixes:
$ matchpathcon -V passwd
passwd has context system_u:object_r:passwd_file_t:s0, should be
system_u:object_r:passwd_file_t:s0

$ echo $?
1

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/matchpathcon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 3868711..a2f2c3e 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -471,6 +471,17 @@ int selinux_file_context_verify(const char *path, mode_t mode)
 	char * con = NULL;
 	char * fcontext = NULL;
 	int rc = 0;
+	char stackpath[PATH_MAX + 1];
+	char *p = NULL;
+
+	if (S_ISLNK(mode)) {
+		if (!realpath_not_final(path, stackpath))
+			path = stackpath;
+	} else {
+		p = realpath(path, stackpath);
+		if (p)
+			path = p;
+	}
 
 	rc = lgetfilecon_raw(path, &con);
 	if (rc == -1) {
-- 
2.7.4
