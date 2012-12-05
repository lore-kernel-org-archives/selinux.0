Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB5KQPHD011854
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2012 15:26:30 -0500
Subject: [RFC PATCH v2 1/3] tun: correctly report an error in tun_flow_init()
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com
Date: Wed, 05 Dec 2012 15:26:04 -0500
Message-ID: <20121205202604.18626.71229.stgit@localhost>
In-Reply-To: <20121205202144.18626.61966.stgit@localhost>
References: <20121205202144.18626.61966.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On error, the error code from tun_flow_init() is lost inside
tun_set_iff(), this patch fixes this by assigning the tun_flow_init()
error code to the "err" variable which is returned by
the tun_flow_init() function on error.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 drivers/net/tun.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a1b2389..14a0454 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1591,7 +1591,8 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 
 		tun_net_init(dev);
 
-		if (tun_flow_init(tun))
+		err = tun_flow_init(tun);
+		if (err < 0)
 			goto err_free_dev;
 
 		dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
