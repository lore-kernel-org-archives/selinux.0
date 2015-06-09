From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: do not remap unknown SIDs to the unlabeled context
Date: Tue,  9 Jun 2015 09:09:52 -0400
Message-Id: <1433855392-17188-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinux remaps invalid SIDs to the unlabeled SID/context in order
to provide sane handling of objects whose SIDs become invalid upon
a policy reload (e.g. removal of a type from policy).  However,
this can also hide bugs and yield unexpected behavior, e.g. as described
in https://bugzilla.redhat.com/show_bug.cgi?id=1224211, if a program
sets SO_PASSSEC on a Unix stream socket, it will receive a SCM_SECURITY
control message with the unlabeled context because the secid is not
properly set/propagated for Unix stream sends, only for Unix datagram
sends, but the automatic remapping of any invalid SID to the unlabeled
context still produces a context to be returned when SO_PASSSEC is
set on the socket.  Since commit 12b29f34558b9b45a2c6eabd4f3c6be939a3980f
("selinux: support deferred mapping of contexts") changed SELinux to not
remove invalid SIDs from the SID table but rather to retain them with a
copy of the unmapped context string so that the SID could be made valid
again if a subsequent policy reload made the context valid again, we no
longer need to map unknown SIDs to the unlabeled context, only SIDs that
have unmapped context strings.

With this change applied, we get saner behavior for SCM_SECURITY on
Unix stream sockets:  the kernel will not put any SCM_SECURITY control
message at all rather than putting one with an unlabeled context.  If
we want to support SCM_SECURITY on Unix stream sockets, that can be
taken up as a separate change.  Regardless, this change will help catch
cases where a secid/SID is never set (0) or contain a value beyond the
set of allocated SIDs (e.g. never initialized and contains garbage).  The
change does not break the support for deferred mapping of contexts; one
can still insert a policy module that defines a type, label a file with
that type, remove the policy module (i.e. load a policy that does not
contain the type), check that the file's label is remapped to the
unlabeled context, re-insert the policy module that defined the type,
and see that the file's label is properly restored and valid.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/sidtab.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 5840a35..3bd992c 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -98,7 +98,10 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
 	if (force && cur && sid == cur->sid && cur->context.len)
 		return &cur->context;
 
-	if (cur == NULL || sid != cur->sid || cur->context.len) {
+	if (cur == NULL || sid != cur->sid)
+		return NULL;
+
+	if (cur->context.len) {
 		/* Remap invalid SIDs to the unlabeled SID. */
 		sid = SECINITSID_UNLABELED;
 		hvalue = SIDTAB_HASH(sid);
-- 
2.1.0
