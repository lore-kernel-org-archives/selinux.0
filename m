From: Dan Walsh <dwalsh@redhat.com>
To: sds@tycho.nsa.gov, eparis@redhat.com
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>
Subject: [PATCH 02/08] Only return writeable files that are enabled
Date: Fri,  8 Nov 2013 08:17:29 -0500
Message-Id: <1383916655-9354-3-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
References: <1383916655-9354-1-git-send-email-dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/sepolicy/sepolicy/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policycoreutils/sepolicy/sepolicy/__init__.py b/policycoreutils/sepolicy/sepolicy/__init__.py
index fd95c16..679725d 100644
--- a/policycoreutils/sepolicy/sepolicy/__init__.py
+++ b/policycoreutils/sepolicy/sepolicy/__init__.py
@@ -141,6 +141,9 @@ def get_writable_files(setype):
     for i in permlist:
         if i['target'] in attributes:
             continue
+        if "enabled" in i:
+            if not i["enabled"]:
+                continue
         if i['target'].endswith("_t"):
             if i['target'] not in file_types:
                 continue
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
