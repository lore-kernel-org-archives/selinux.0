Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA6GBo9V021218
 for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2017 11:11:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A01B97EA97
 for <selinux@tycho.nsa.gov>; Mon,  6 Nov 2017 15:35:36 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22B4E60FC8
 for <selinux@tycho.nsa.gov>; Mon,  6 Nov 2017 15:35:35 +0000 (UTC)
From: Jan Zarsky <jzarsky@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon,  6 Nov 2017 16:35:30 +0100
Message-Id: <20171106153530.5390-1-jzarsky@redhat.com>
Subject: [PATCH] libsemanage: free genhomedircon fallback user
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Function semanage_genhomedircon() adds fallback user and function
setup_fallback_user() may add another one. But only one fallback
user is freed. Make sure to free all fallback users in
semanage_genhomedircon().

Signed-off-by: Jan Zarsky <jzarsky@redhat.com>
---
 libsemanage/src/genhomedircon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 27a269ea..d09d82ff 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1385,7 +1385,9 @@ done:
 	if (out != NULL)
 		fclose(out);
 
-	pop_user_entry(&(s.fallback));
+	while (s.fallback)
+		pop_user_entry(&(s.fallback));
+
 	ignore_free();
 
 	return retval;
-- 
2.14.3
