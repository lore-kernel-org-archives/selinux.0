Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q722aZC3002019
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2012 22:36:35 -0400
From: Joshua Brindle <method@manicmethod.com>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH build/] Fix mkyaffs2image call to add a '/' to the mount point
Date: Wed,  1 Aug 2012 22:36:29 -0400
Message-Id: <1343874989-13155-1-git-send-email-method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Joshua Brindle <jbrindle@tresys.com>

selabel_lookup requires the mountpoint start with a '/' to match specifications in the file_context file. Change mkyaffs2image call to add a '/' to the mount point argument

Change-Id: I255b661822401f9253ef58a2a4bdada85fc96b23

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
---
 tools/releasetools/build_image.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/releasetools/build_image.py b/tools/releasetools/build_image.py
index a615d1a..610e634 100755
--- a/tools/releasetools/build_image.py
+++ b/tools/releasetools/build_image.py
@@ -56,7 +56,7 @@ def BuildImage(in_dir, prop_dict, out_file):
     build_command.append(out_file)
     if "selinux_fc" in prop_dict:
       build_command.append(prop_dict["selinux_fc"])
-      build_command.append(prop_dict["mount_point"])
+      build_command.append("/%s" % prop_dict["mount_point"])
 
   print "Running: ", " ".join(build_command)
   p = subprocess.Popen(build_command);
-- 
1.7.9.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
