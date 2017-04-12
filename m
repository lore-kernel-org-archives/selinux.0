Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3CM0qVI030674
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 18:00:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so6145003wrc.2
 for <selinux@tycho.nsa.gov>; Wed, 12 Apr 2017 15:00:55 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] sestatus: show checkreqprot status
Date: Thu, 13 Apr 2017 00:00:38 +0200
Message-Id: <20170412220038.9792-3-cgzones@googlemail.com>
In-Reply-To: <20170412220038.9792-1-cgzones@googlemail.com>
References: <20170412220038.9792-1-cgzones@googlemail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: cgzones <cgzones@googlemail.com>

Show the current active checkreqprot state in sestatus
---
 policycoreutils/sestatus/sestatus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 2111b15d..f9ed5b66 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -330,6 +330,20 @@ int main(int argc, char **argv)
 			break;
 	}
 
+	printf_tab("Policy checkreqprot status:");
+	rc = security_checkreqprot();
+	switch (rc) {
+		case 0:
+			printf("kernel\n");
+			break;
+		case 1:
+			printf("application\n");
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
