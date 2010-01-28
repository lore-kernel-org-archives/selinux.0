Subject: [PATCH] selinux:  Only audit permissions specified in policy (Was:
 Re: Bad AVC message reported from kernel.)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Fedora SELinux List <selinux@lists.fedoraproject.org>,
        selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <4B61D5C2.9030002@redhat.com>
References: <4B61D5C2.9030002@redhat.com>
Content-Type: text/plain
Date: Thu, 28 Jan 2010 15:01:37 -0500
Message-Id: <1264708897.11700.11.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-28 at 13:21 -0500, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=558499
> 
> 
> In Fedora 13, we had a rule that said  
> 
> dontaudit domain rpm_tmp_t:file { read write };
> 
> rpm changed the access on rpm_tmp_t to be { read append };
> 
> This caused the following avc.
> 
> node=(removed) type=AVC msg=audit(1264430091.330:28): avc:  denied  { read
> append } for  pid=2933 comm="rpc.statd" path="/tmp/tmp9IF8MN" dev=dm-0 ino=432
> scontext=unconfined_u:system_r:rpcd_t:s0
> tcontext=unconfined_u:object_r:rpm_tmp_t:s0 tclass=file
> 
> node=(removed) type=SYSCALL msg=audit(1264430091.330:28): arch=c000003e
> syscall=59 success=yes exit=0 a0=28bd8d0 a1=28bdb50 a2=28bc920 a3=7fff07d44c30
> items=0 ppid=2932 pid=2933 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
> sgid=0 fsgid=0 tty=(none) ses=1 comm="rpc.statd" exe="/sbin/rpc.statd"
> subj=unconfined_u:system_r:rpcd_t:s0 key=(null)
> 
> 
> Indicating that rpcd_t did not have read append access.  When it should have only reported append access, since the read access should have been dontaudited.

Only audit the permissions specified by the policy rules.

Before:
type=AVC msg=audit(01/28/2010 14:30:46.690:3250) : avc:  denied  { read
append } for  pid=14092 comm=foo name=test_file dev=dm-1 ino=132932
scontext=unconfined_u:unconfined_r:load_policy_t:s0-s0:c0.c1023
tcontext=unconfined_u:object_r:rpm_tmp_t:s0 tclass=file

After:
type=AVC msg=audit(01/28/2010 14:52:37.448:26) : avc:  denied
{ append } for  pid=1917 comm=foo name=test_file dev=dm-1 ino=132932
scontext=unconfined_u:unconfined_r:load_policy_t:s0-s0:c0.c1023
tcontext=unconfined_u:object_r:rpm_tmp_t:s0 tclass=file 

Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

---

 security/selinux/avc.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 3ee9b6a..db0fd9f 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -489,17 +489,14 @@ void avc_audit(u32 ssid, u32 tsid,
 	struct common_audit_data stack_data;
 	u32 denied, audited;
 	denied = requested & ~avd->allowed;
-	if (denied) {
-		audited = denied;
-		if (!(audited & avd->auditdeny))
-			return;
-	} else if (result) {
+	if (denied)
+		audited = denied & avd->auditdeny;
+	else if (result)
 		audited = denied = requested;
-	} else {
-		audited = requested;
-		if (!(audited & avd->auditallow))
-			return;
-	}
+	else
+		audited = requested & avd->auditallow;
+	if (!audited)
+		return;
 	if (!a) {
 		a = &stack_data;
 		memset(a, 0, sizeof(*a));

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
