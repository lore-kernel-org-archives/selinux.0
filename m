Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3IHZC2h023520
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 13:35:18 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: linux-audit@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: [PATCH 3/6] netlink: implement unbind to netlink_setsockopt
 NETLINK_DROP_MEMBERSHIP
Date: Fri, 18 Apr 2014 13:34:07 -0400
Message-Id: <05abbc9f1bad49dd7adca5f434fb47404caddd84.1397831970.git.rgb@redhat.com>
In-Reply-To: <20140324183406.GE28666@madcap2.tricolour.ca>
References: <20140324183406.GE28666@madcap2.tricolour.ca>
In-Reply-To: <cover.1397831970.git.rgb@redhat.com>
References: <cover.1397831970.git.rgb@redhat.com>
Cc: hadi@mojatatu.com, eparis@redhat.com, netfilter-devel@vger.kernel.org,
 sgrubb@redhat.com, davem@davemloft.net
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
index 3f43e5a..cdb236f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2118,7 +2118,7 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 			return err;
 		if (!val || val - 1 >= nlk->ngroups)
 			return -EINVAL;
-		if (nlk->netlink_bind) {
+		if (optname == NETLINK_ADD_MEMBERSHIP && nlk->netlink_bind) {
 			err = nlk->netlink_bind(val);
 			if (err)
 				return err;
@@ -2127,6 +2127,8 @@ static int netlink_setsockopt(struct socket *sock, int level, int optname,
 		netlink_update_socket_mc(nlk, val,
 					 optname == NETLINK_ADD_MEMBERSHIP);
 		netlink_table_ungrab();
+		if (optname == NETLINK_DROP_MEMBERSHIP && nlk->netlink_unbind)
+			nlk->netlink_unbind(val);
 
 		err = 0;
 		break;
-- 
1.7.1
