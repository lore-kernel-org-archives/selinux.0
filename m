Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3U2xlsQ019233
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 22:59:47 -0400
Message-ID: <1398826782.10979.9.camel@localhost>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Date: Tue, 29 Apr 2014 22:59:42 -0400
In-Reply-To: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-xwFyxykdK4Asw11ZBpOG"
Mime-Version: 1.0
Cc: sgrubb@redhat.com, selinux <selinux@tycho.nsa.gov>, linux-audit@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--=-xwFyxykdK4Asw11ZBpOG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-04-29 at 16:54 -0700, Stephen Smalley wrote:
> Requested for Android in order to distinguish denials that are not in
> fact breaking anything yet due to permissive domains versus denials
> that are being enforced, but seems generally useful.  result field was
> already in the selinux audit data structure and was being passed to
> avc_audit() but wasn't being used.  Seems to cause no harm to ausearch
> or audit2allow to add it as a field.  Comments?

I think it's a great idea, but I'm worried that Steve is going to get
grumpy because an AVC record is going to have a result= field which is
similar, but not necessarily related to the res= field of a SYSCALL
record.  Seems easily confused (although probably 9999 times out of
10000 they will be the same)

So while I wholeheartedly think we should take the idea, I wonder if
someone can dream up a name that isn't confusingly similar...

I can't think of anything...

-Eric

--=-xwFyxykdK4Asw11ZBpOG
Content-Disposition: attachment; filename="0001-selinux-Report-result-in-avc-messages.patch"
Content-Type: text/x-patch; name="0001-selinux-Report-result-in-avc-messages.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 651008371f3bf8eb00eeea0e84eca4ba7383860c Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 29 Apr 2014 11:29:04 -0700
Subject: [PATCH] selinux:  Report result in avc messages.

We cannot presently tell from an avc message whether access was in
fact denied or was allowed due to global or per-domain permissive mode.
Add a result= field to the avc message to reflect this information.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c         | 5 ++++-
 security/selinux/hooks.c       | 5 +++--
 security/selinux/include/avc.h | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index fc3e662..916b810 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -444,11 +444,13 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 	avc_dump_query(ab, ad->selinux_audit_data->ssid,
 			   ad->selinux_audit_data->tsid,
 			   ad->selinux_audit_data->tclass);
+	audit_log_format(ab, " result=%s",
+			 ad->selinux_audit_data->result ? "denied" : "allowed");
 }
 
 /* This is the slow part of avc audit with big stack footprint */
 noinline int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
-		u32 requested, u32 audited, u32 denied,
+		u32 requested, u32 audited, u32 denied, int result,
 		struct common_audit_data *a,
 		unsigned flags)
 {
@@ -477,6 +479,7 @@ noinline int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
 	sad.tsid = tsid;
 	sad.audited = audited;
 	sad.denied = denied;
+	sad.result = result;
 
 	a->selinux_audit_data = &sad;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b4beb77..e156b5f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2770,6 +2770,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *na
 
 static noinline int audit_inode_permission(struct inode *inode,
 					   u32 perms, u32 audited, u32 denied,
+					   int result,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
@@ -2780,7 +2781,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 	ad.u.inode = inode;
 
 	rc = slow_avc_audit(current_sid(), isec->sid, isec->sclass, perms,
-			    audited, denied, &ad, flags);
+			    audited, denied, result, &ad, flags);
 	if (rc)
 		return rc;
 	return 0;
@@ -2822,7 +2823,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (likely(!audited))
 		return rc;
 
-	rc2 = audit_inode_permission(inode, perms, audited, denied, flags);
+	rc2 = audit_inode_permission(inode, perms, audited, denied, rc, flags);
 	if (rc2)
 		return rc2;
 	return rc;
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index f53ee3c..ddf8eec 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -102,7 +102,7 @@ static inline u32 avc_audit_required(u32 requested,
 }
 
 int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
-		   u32 requested, u32 audited, u32 denied,
+		   u32 requested, u32 audited, u32 denied, int result,
 		   struct common_audit_data *a,
 		   unsigned flags);
 
@@ -137,7 +137,7 @@ static inline int avc_audit(u32 ssid, u32 tsid,
 	if (likely(!audited))
 		return 0;
 	return slow_avc_audit(ssid, tsid, tclass,
-			      requested, audited, denied,
+			      requested, audited, denied, result,
 			      a, 0);
 }
 
-- 
1.8.3.1


--=-xwFyxykdK4Asw11ZBpOG--
