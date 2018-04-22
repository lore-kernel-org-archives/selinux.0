Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3MJMZF4030652
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 15:22:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40TfcS3kcrz25sS3
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 19:22:32 +0000 (UTC)
Received: from UPDC3CPA10_EEMSG_MP26.eemsg.mil (unknown [192.168.18.21])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40TfcS1kcNz25sRt
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BF77E5646F2
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 21:22:18 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 22 Apr 2018 21:21:48 +0200
Message-Id: <20180422192148.7320-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180422192148.7320-1-nicolas.iooss@m4x.org>
References: <20180422192148.7320-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/2] sestatus: free process and file contexts which are checked
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang's static analyzer reports a potential memory leak because the
buffers allocated in pc and fc are not freed in main(), in sestatus.c.
Free these buffers properly.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/sestatus/sestatus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index d7f198c2fa0d..9a92e72ff4fd 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -436,6 +436,7 @@ int main(int argc, char **argv)
 			printf("%s\n", context);
 			freecon(context);
 		}
+		free(pc[i]);
 	}
 
 	printf("\nFile contexts:\n");
@@ -478,6 +479,7 @@ int main(int argc, char **argv)
 				freecon(context);
 			}
 		}
+		free(fc[i]);
 	}
 
 	return 0;
-- 
2.17.0
