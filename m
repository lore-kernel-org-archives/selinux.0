Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6EIxWIr009796
	for <selinux@tycho.nsa.gov>; Sat, 14 Jul 2012 14:59:32 -0400
Message-ID: <1342292366.87435.YahooMailClassic@web87702.mail.ir2.yahoo.com>
Date: Sat, 14 Jul 2012 19:59:26 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] Android build project: Fix 'mkyaffs2image -f ...' selabel_lookup error
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When building SE-Android, mkyaffs2image fails with an selabel_lookup error
as the 'mountpoint' parameter does not match the file_context entry
(requires a leading '/').

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tools/releasetools/build_image.py |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/releasetools/build_image.py b/tools/releasetools/build_image.py
index a615d1a..2b42d7d 100755
--- a/tools/releasetools/build_image.py
+++ b/tools/releasetools/build_image.py
@@ -126,11 +126,11 @@ def main(argv):
   image_filename = os.path.basename(out_file)
   mount_point = ""
   if image_filename == "system.img":
-    mount_point = "system"
+    mount_point = "/system"
   elif image_filename == "userdata.img":
-    mount_point = "data"
+    mount_point = "/data"
   elif image_filename == "cache.img":
-    mount_point = "cache"
+    mount_point = "/cache"
   else:
     print >> sys.stderr, "error: unknown image file name ", image_filename
     exit(1)
-- 
1.7.10.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
