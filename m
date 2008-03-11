Subject: [PATCH] SELinux: requesting no permissions in avc_has_perm_noaudit
	is a BUG()
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Tue, 11 Mar 2008 14:19:34 -0400
Message-Id: <1205259574.5297.107.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch turns the case where we have a call into avc_has_perm with no
requested permissions into a BUG_ON.  All callers to this should be in
the kernel and thus should be a function we need to fix if we ever hit
this.  The /selinux/access permission checking it done directly in the
security server and not through the avc, so those requests which we
cannot control from userspace should not be able to trigger this BUG_ON.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/avc.c         |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 187964e..cb3f0ce 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -871,6 +871,8 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 	int rc = 0;
 	u32 denied;
 
+	BUG_ON(!requested);
+
 	rcu_read_lock();
 
 	node = avc_lookup(ssid, tsid, tclass, requested);
@@ -890,7 +892,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 
 	denied = requested & ~(p_ae->avd.allowed);
 
-	if (!requested || denied) {
+	if (denied) {
 		if (selinux_enforcing || (flags & AVC_STRICT))
 			rc = -EACCES;
 		else


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
