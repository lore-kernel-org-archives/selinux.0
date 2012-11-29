Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qATM6iUm029187
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2012 17:06:44 -0500
Subject: [RFC PATCH 1/2] tun: correctly report an error in tun_flow_init()
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: jasowang@redhat.com
Date: Thu, 29 Nov 2012 17:06:29 -0500
Message-ID: <20121129220629.30020.99947.stgit@sifl>
In-Reply-To: <20121129215724.30020.69464.stgit@sifl>
References: <20121129215724.30020.69464.stgit@sifl>
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
index 607a3a5..877ffe2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1605,7 +1605,8 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 
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
