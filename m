Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w739aGqv013322
 for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2018 05:36:18 -0400
Received: by mail-qk0-f202.google.com with SMTP id t81-v6so4701768qkt.7
 for <selinux@tycho.nsa.gov>; Fri, 03 Aug 2018 02:36:12 -0700 (PDT)
Date: Fri,  3 Aug 2018 11:36:04 +0200
Message-Id: <20180803093604.38254-1-jannh@google.com>
Mime-Version: 1.0
From: Jann Horn <jannh@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov, jannh@google.com
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: [PATCH] selinux: stricter parsing in mls_context_to_sid()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

mls_context_to_sid incorrectly accepted MLS context strings that are
followed by a dash and trailing garbage.

Before this change, the following command works:

# mount -t tmpfs -o 'context=system_u:object_r:tmp_t:s0-s0:c0-BLAH' \
none mount

After this change, it fails with the following error message in dmesg:

SELinux: security_context_str_to_sid(system_u:object_r:tmp_t:s0-s0:c0-BLAH)
failed for (dev tmpfs, type tmpfs) errno=-22

This is not an important bug; but it is a small quirk that was useful for
exploiting a vulnerability in fusermount.

This patch does not change the behavior when the policy does not have MLS
enabled.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/ss/mls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 39475fb455bc..2c73d612d2ee 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -344,7 +344,7 @@ int mls_context_to_sid(struct policydb *pol,
 					break;
 			}
 		}
-		if (delim == '-') {
+		if (delim == '-' && l == 0) {
 			/* Extract high sensitivity. */
 			scontextp = p;
 			while (*p && *p != ':')
-- 
2.18.0.597.ga71716f1ad-goog
