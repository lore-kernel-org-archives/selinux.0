Date: Fri, 30 Jun 2017 10:56:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Paul Moore <paul@paul-moore.com>, Daniel Jurgens <danielj@mellanox.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] selinux: return -ENOMEM if kzalloc() fails
Message-ID: <20170630075614.ywv3y3tptor5ox7g@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We accidentally return success instead of -ENOMEM on this failure path.

Fixes: 409dcf31538a ("selinux: Add a cache for quicker retreival of PKey SIDs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index e3614ee5f1c0..36e61f622b5a 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -160,8 +160,10 @@ static int sel_ib_pkey_sid_slow(u64 subnet_prefix, u16 pkey_num, u32 *sid)
 	 * is valid, it just won't be added to the cache.
 	 */
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (!new)
+	if (!new) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	new->psec.subnet_prefix = subnet_prefix;
 	new->psec.pkey = pkey_num;
