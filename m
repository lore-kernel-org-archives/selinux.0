Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44Kjoqe031752
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 16:45:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so5878935wmh.0
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 13:45:50 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] sestatus: show checkreqprot status
Date: Thu,  4 May 2017 22:45:38 +0200
Message-Id: <20170504204538.17853-3-cgzones@googlemail.com>
In-Reply-To: <20170504204538.17853-1-cgzones@googlemail.com>
References: <20170504204538.17853-1-cgzones@googlemail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Show the current active checkreqprot state in sestatus
---
 policycoreutils/sestatus/sestatus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 2111b15d..a461251d 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -330,6 +330,20 @@ int main(int argc, char **argv)
 			break;
 	}
 
+	printf_tab("Current checkreqprot mode:");
+	rc = security_get_checkreqprot();
+	switch (rc) {
+		case 0:
+			printf("Kernel preset\n");
+			break;
+		case 1:
+			printf("Application requested\n");
+			break;
+		default:
+			printf("error (%s)\n", strerror(errno));
+			break;
+	}
+
 	rc = security_policyvers();
 	printf_tab("Max kernel policy version:");
 	if (rc < 0)
-- 
2.11.0
