Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3IHZC2d023520
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 13:35:12 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: linux-audit@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: [PATCH 1/6] netlink: simplify nfnetlink_bind
Date: Fri, 18 Apr 2014 13:34:05 -0400
Message-Id: <8ae3bd558cb6619428cc40e467d1643f9d382a0a.1397831970.git.rgb@redhat.com>
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

Remove duplicity and simplify code flow by moving the rcu_read_unlock() above
the condition and let the flow control exit naturally at the end of the
function.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 net/netfilter/nfnetlink.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index e8138da..0df800a 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -407,12 +407,9 @@ static void nfnetlink_bind(int group)
 
 	rcu_read_lock();
 	ss = nfnetlink_get_subsys(type);
-	if (!ss) {
-		rcu_read_unlock();
-		request_module("nfnetlink-subsys-%d", type);
-		return;
-	}
 	rcu_read_unlock();
+	if (!ss)
+		request_module("nfnetlink-subsys-%d", type);
 }
 #endif
 
-- 
1.7.1
