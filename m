Subject: [PATCH 44/46] selinux: Adjust two checks for null pointers
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <e12da517-36fb-2247-e9b4-488708d6cda7@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:44:04 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Jan 2017 13:30:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script "checkpatch.pl" pointed information out like the following.

Comparison to NULL could be written !…

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/ss/sidtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index c9533b21942b..f6915f257486 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -54,7 +54,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 	}
 
 	newnode = kmalloc(sizeof(*newnode), GFP_ATOMIC);
-	if (newnode == NULL) {
+	if (!newnode) {
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -98,7 +98,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
 	if (force && cur && sid == cur->sid && cur->context.len)
 		return &cur->context;
 
-	if (cur == NULL || sid != cur->sid || cur->context.len) {
+	if (!cur || sid != cur->sid || cur->context.len) {
 		/* Remap invalid SIDs to the unlabeled SID. */
 		sid = SECINITSID_UNLABELED;
 		hvalue = SIDTAB_HASH(sid);
-- 
2.11.0
