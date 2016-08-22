Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7ML3CfA019975
 for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2016 17:03:12 -0400
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v3 1/2] genhomedircon: generate contexts for logins mapped to
 the default user
Date: Mon, 22 Aug 2016 22:03:04 +0100
Message-Id: <1471899785-22194-2-git-send-email-gary.tierney@gmx.com>
In-Reply-To: <1471899785-22194-1-git-send-email-gary.tierney@gmx.com>
References: <1471899785-22194-1-git-send-email-gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Removes a test in get_users() which excludes any logins that are
explicitly mapped to the default user from file context generation,
which results in logins mapped to the fallback user with home
directories outside of LU_HOMEDIRECTORY (in the absence of
usepasswd=True) having no matching file_contexts.homedirs entries.

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 libsemanage/src/genhomedircon.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index c5ea436..698b907 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -853,9 +853,6 @@ static genhomedircon_user_entry_t *get_users(genhomedircon_settings_t * s,
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
 		name = semanage_seuser_get_name(seuser_list[i]);
 
-		if (strcmp(name,"root") && strcmp(seuname, s->fallback->sename) == 0)
-			continue;
-
 		if (strcmp(name, DEFAULT_LOGIN) == 0)
 			continue;
 
-- 
2.7.4
