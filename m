Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SFAjpg001565
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 11:10:46 -0400
Subject: [PATCH] netlabel: fix a problem with netlbl_secattr_catmap_setrng()
From: Paul Moore <pmoore@redhat.com>
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Janak Desai <Janak.Desai@gtri.gatech.edu>
Date: Mon, 28 Mar 2016 11:10:38 -0400
Message-ID: <145917783800.9565.7759086668991534988.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Janak Desai <Janak.Desai@gtri.gatech.edu>

We try to be clever and set large chunks of the bitmap at once, when
possible; unfortunately we weren't very clever when we wrote the code
and messed up the if-conditional.  Fix this bug and restore proper
operation.

Signed-off-by: Janak Desai <Janak.Desai@gtri.gatech.edu>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 net/netlabel/netlabel_kapi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 28cddc8..1325776 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -677,7 +677,7 @@ int netlbl_catmap_setrng(struct netlbl_lsm_catmap **catmap,
 	u32 spot = start;
 
 	while (rc == 0 && spot <= end) {
-		if (((spot & (BITS_PER_LONG - 1)) != 0) &&
+		if (((spot & (BITS_PER_LONG - 1)) == 0) &&
 		    ((end - spot) > BITS_PER_LONG)) {
 			rc = netlbl_catmap_setlong(catmap,
 						   spot,
