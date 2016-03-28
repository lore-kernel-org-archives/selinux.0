Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SJgCge001026
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 15:42:12 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id D2B53C0005DA
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 19:42:08 +0000 (UTC)
Subject: [PATCH] selinux: don't revalidate inodes in
 selinux_socket_getpeersec_dgram()
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 28 Mar 2016 15:42:07 -0400
Message-ID: <145919412765.2232.4990618801531525717.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

We don't have to worry about socket inodes being invalidated so
use inode_security_novalidate() to fetch the inode's security blob.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f8110cf..ec1a1a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4598,6 +4598,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
+	struct inode_security_struct *isec;
 
 	if (skb && skb->protocol == htons(ETH_P_IP))
 		family = PF_INET;
@@ -4608,9 +4609,10 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 	else
 		goto out;
 
-	if (sock && family == PF_UNIX)
-		selinux_inode_getsecid(SOCK_INODE(sock), &peer_secid);
-	else if (skb)
+	if (sock && family == PF_UNIX) {
+		isec = inode_security_novalidate(SOCK_INODE(sock));
+		peer_secid = isec->sid;
+	} else if (skb)
 		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
 out:
