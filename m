Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3N1Wa9g021067
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 21:32:41 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: linux-audit@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: [PATCH 3/6][v2] netlink: implement unbind to netlink_setsockopt
 NETLINK_DROP_MEMBERSHIP
Date: Tue, 22 Apr 2014 21:31:55 -0400
Message-Id: <7a5855accebc1a4f90bc7e03f39451ca0f088c98.1398215388.git.rgb@redhat.com>
In-Reply-To: <20140422.161904.1187535812839850973.davem@davemloft.net>
References: <20140422.161904.1187535812839850973.davem@davemloft.net>
In-Reply-To: <cover.1398215388.git.rgb@redhat.com>
References: <cover.1398215388.git.rgb@redhat.com>
Cc: jamal@mojatatu.com, sgrubb@redhat.com, davem@davemloft.net,
 eparis@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Call the per-protocol unbind function rather than bind function on
NETLINK_DROP_MEMBERSHIP in netlink_setsockopt().

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 net/netlink/af_netlink.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 7e8d229..92f4b69 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2129,7 +2129,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 			return err;
 		if (!val || val - 1 >= nlk->ngroups)
 			return -EINVAL;
-		if (nlk->netlink_bind) {
+		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
 			err = nlk->netlink_bind(val);
 			if (err)
 				return err;
@@ -2138,6 +2138,8 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		netlink_update_socket_mc(nlk, val,
 					 optname == NETLINK_ADD_MEMBERSHIP);
 		netlink_table_ungrab();
+		if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
+			nlk->netlink_unbind(val);
 
 		err = 0;
 		break;
-- 
1.7.1
