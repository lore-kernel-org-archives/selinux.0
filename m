Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0F74HDK026699
	for <selinux@tycho.nsa.gov>; Fri, 15 Jan 2010 02:04:17 -0500
Received: from mail-gx0-f209.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0F72m7E012376
	for <selinux@tycho.nsa.gov>; Fri, 15 Jan 2010 07:02:48 GMT
Received: by gxk1 with SMTP id 1so224563gxk.14
        for <selinux@tycho.nsa.gov>; Thu, 14 Jan 2010 23:04:06 -0800 (PST)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Cc: selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH] fix some typo's in avc.c
Date: Thu, 14 Jan 2010 23:03:18 -0800
Message-Id: <1263538998-20088-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
---
 security/selinux/avc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index f2dde26..3328b1f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -337,7 +337,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
  * Look up an AVC entry that is valid for the
  * (@ssid, @tsid), interpreting the permissions
  * based on @tclass.  If a valid AVC entry exists,
- * then this function return the avc_node.
+ * then this function returns the avc_node.
  * Otherwise, this function returns NULL.
  */
 static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass)
@@ -526,7 +526,7 @@ void avc_audit(u32 ssid, u32 tsid,
  * @perms: permissions
  *
  * Register a callback function for events in the set @events
- * related to the SID pair (@ssid, @tsid) and
+ * related to the SID pair (@ssid, @tsid) 
  * and the permissions @perms, interpreting
  * @perms based on @tclass.  Returns %0 on success or
  * -%ENOMEM if insufficient memory exists to add the callback.
@@ -571,7 +571,7 @@ static inline int avc_sidcmp(u32 x, u32 y)
  *
  * if a valid AVC entry doesn't exist,this function returns -ENOENT.
  * if kmalloc() called internal returns NULL, this function returns -ENOMEM.
- * otherwise, this function update the AVC entry. The original AVC-entry object
+ * otherwise, this function updates the AVC entry. The original AVC-entry object
  * will release later by RCU.
  */
 static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
-- 
1.6.5.GIT


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
