Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46D92Bc002069
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 09:09:05 -0400
Received: by mail-wr0-f173.google.com with SMTP id z52so16314940wrc.2
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 06:08:58 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] sestatus: show checkreqprot status
Date: Sat,  6 May 2017 15:08:48 +0200
Message-Id: <20170506130848.9128-3-cgzones@googlemail.com>
In-Reply-To: <20170506130848.9128-1-cgzones@googlemail.com>
References: <20170506130848.9128-1-cgzones@googlemail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Show the current active checkreqprot state in sestatus
---
 policycoreutils/sestatus/sestatus.8 |  2 ++
 policycoreutils/sestatus/sestatus.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/policycoreutils/sestatus/sestatus.8 b/policycoreutils/sestatus/sestatus.8
index 51ff0566..a89c53fd 100644
--- a/policycoreutils/sestatus/sestatus.8
+++ b/policycoreutils/sestatus/sestatus.8
@@ -33,6 +33,8 @@ Policy MLS status:           enabled
 .br
 Policy deny_unknown status:  allow
 .br
+Memory protection checking:  actual (secure)
+.br
 Max kernel policy version:   26
 .RE
 .sp
diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index 2111b15d..b05e794c 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -330,6 +330,20 @@ int main(int argc, char **argv)
 			break;
 	}
 
+	printf_tab("Memory protection checking:");
+	rc = security_get_checkreqprot();
+	switch (rc) {
+		case 0:
+			printf("actual (secure)\n");
+			break;
+		case 1:
+			printf("requested (insecure)\n");
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
