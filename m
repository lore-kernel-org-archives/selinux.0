From: Stephen Smalley <sds@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 27 Oct 2017 11:28:22 -0400
Message-Id: <20171027152822.16406-1-sds@tycho.nsa.gov>
Subject: [RFC PATCH] xfrm: fix regression introduced by xdst pcpu cache
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit ec30d78c14a813db39a647b6a348b4286 ("xfrm: add xdst pcpu cache")
introduced a regression in the use of labeled IPSEC.  The cache was only
checking that the policies are the same, but did not validate that the
policy, state, and flow matched with respect to security context labeling.
As a result, the wrong SA could be used and the receiver could end up
performing permission checking and providing SO_PEERSEC or SCM_SECURITY
values for the wrong security context.  This was triggering failures in
the selinux-testsuite.  The security_xfrm_state_pol_flow_match() hook
exists for this purpose and is already called elsewhere from the xfrm
state code for matching purposes.  Add a call to this hook when validating
the cache entry.  With this change, the selinux-testsuite passes all tests
again.

Fixes: ec30d78c14a813db39a647b6a348b4286ba4abf5 ("xfrm: add xdst pcpu cache")
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
Sending this as an RFC to lsm and selinux for comments before sending it
to netdev. See https://github.com/SELinuxProject/selinux-kernel/issues/36
for earlier discussion about the bug.

 net/xfrm/xfrm_policy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index f062539..e7ec47f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1820,6 +1820,8 @@ xfrm_resolve_and_create_bundle(struct xfrm_policy **pols, int num_pols,
 	    !xfrm_pol_dead(xdst) &&
 	    memcmp(xdst->pols, pols,
 		   sizeof(struct xfrm_policy *) * num_pols) == 0 &&
+	    security_xfrm_state_pol_flow_match(xdst->u.dst.xfrm,
+					       xdst->pols[0], fl) &&
 	    xfrm_bundle_ok(xdst)) {
 		dst_hold(&xdst->u.dst);
 		return xdst;
-- 
2.9.5
