Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PMYjVu002140
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 18:34:49 -0400
Received: by laclj5 with SMTP id lj5so17621981lac.3
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 15:34:46 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] selinux: use kmemdup in security_sid_to_context_core()
Date: Sat, 26 Sep 2015 00:34:17 +0200
Message-Id: <1443220459-11042-4-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1443220459-11042-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 security/selinux/ss/services.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index c550df0e0ff1..994c824a34c6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1259,12 +1259,12 @@ static int security_sid_to_context_core(u32 sid, char **scontext,
 			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
 			if (!scontext)
 				goto out;
-			scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
+			scontextp = kmemdup(initial_sid_to_string[sid],
+					    *scontext_len, GFP_ATOMIC);
 			if (!scontextp) {
 				rc = -ENOMEM;
 				goto out;
 			}
-			strcpy(scontextp, initial_sid_to_string[sid]);
 			*scontext = scontextp;
 			goto out;
 		}
-- 
2.1.3
