Subject: [PATCH 46/46] selinuxfs: Use seq_puts() in sel_avc_stats_seq_show()
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <9c268e0b-a323-5f72-e445-dbf247f274d8@users.sourceforge.net>
Date: Sun, 15 Jan 2017 16:46:07 +0100
MIME-Version: 1.0
In-Reply-To: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Jan 2017 14:04:53 +0100

A string which did not contain data format specifications should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 security/selinux/selinuxfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 55345f84f17d..0d81ebf7ff23 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1445,10 +1445,10 @@ static int sel_avc_stats_seq_show(struct seq_file *seq, void *v)
 {
 	struct avc_cache_stats *st = v;
 
-	if (v == SEQ_START_TOKEN)
-		seq_printf(seq, "lookups hits misses allocations reclaims "
-			   "frees\n");
-	else {
+	if (v == SEQ_START_TOKEN) {
+		seq_puts(seq,
+			 "lookups hits misses allocations reclaims frees\n");
+	} else {
 		unsigned int lookups = st->lookups;
 		unsigned int misses = st->misses;
 		unsigned int hits = lookups - misses;
-- 
2.11.0
