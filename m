Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQLIkwx018050
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 16:18:52 -0500
Received: from localhost.localdomain (private.iosenag.net [31.7.184.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 01F6156469F
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 22:18:45 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/5] checkpolicy: free id in define_port_context()
Date: Mon, 26 Dec 2016 22:18:29 +0100
Message-Id: <20161226211832.7165-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161226211832.7165-1-nicolas.iooss@m4x.org>
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Variable id is almost never freed in define_port_context().

This leak has been detected with gcc Address Sanitizer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 2ad98c3c851e..ff902787c2aa 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -4899,6 +4899,7 @@ int define_port_context(unsigned int low, unsigned int high)
 		protocol = IPPROTO_DCCP;
 	} else {
 		yyerror2("unrecognized protocol %s", id);
+		free(id);
 		free(newc);
 		return -1;
 	}
@@ -4909,11 +4910,13 @@ int define_port_context(unsigned int low, unsigned int high)
 
 	if (low > high) {
 		yyerror2("low port %d exceeds high port %d", low, high);
+		free(id);
 		free(newc);
 		return -1;
 	}
 
 	if (parse_security_context(&newc->context[0])) {
+		free(id);
 		free(newc);
 		return -1;
 	}
@@ -4945,9 +4948,11 @@ int define_port_context(unsigned int low, unsigned int high)
 	else
 		policydbp->ocontexts[OCON_PORT] = newc;
 
+	free(id);
 	return 0;
 
       bad:
+	free(id);
 	free(newc);
 	return -1;
 }
-- 
2.11.0
