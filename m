Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3MJWrjq031346
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 15:32:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40TfrM1H7wzrKYR
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 19:32:51 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40TfrL0cRmzrKYF
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1F437564779
 for <selinux@tycho.nsa.gov>; Sun, 22 Apr 2018 21:30:41 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun, 22 Apr 2018 21:30:32 +0200
Message-Id: <20180422193032.8132-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/1] libsemanage: always check append_arg return
 value
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When split_args() calls append_arg(), the returned value needs to be
checked in order to detect memory allocation failure. Checks were
missing in two places, which are spotted by clang's static analyzer:

    semanage_store.c:1352:7: warning: Value stored to 'rc' is never
    read
            rc = append_arg(&argv, &num_args, arg);
            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    semanage_store.c:1368:3: warning: Value stored to 'rc' is never read
            rc = append_arg(&argv, &num_args, arg);
            ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/semanage_store.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 14ad99c152ad..bce648c46464 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1350,6 +1350,8 @@ static char **split_args(const char *arg0, char *arg_string,
 				if (isspace(*s) && !in_quote && !in_dquote) {
 					if (arg != NULL) {
 						rc = append_arg(&argv, &num_args, arg);
+						if (rc)
+							goto cleanup;
 						free(arg);
 						arg = NULL;
 					}
@@ -1366,6 +1368,8 @@ static char **split_args(const char *arg0, char *arg_string,
 	}
 	if (arg != NULL) {
 		rc = append_arg(&argv, &num_args, arg);
+		if (rc)
+			goto cleanup;
 		free(arg);
 		arg = NULL;
 	}
-- 
2.17.0
