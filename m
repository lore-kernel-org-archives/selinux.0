Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8OIBmC0017579
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 14:11:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so2629622pgm.7
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 11:11:07 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Date: Mon, 24 Sep 2018 11:10:51 -0700
Message-Id: <20180924181052.130507-1-nnk@google.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] whitespace and spelling cleanup
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 libsepol/include/sepol/errcodes.h |  2 +-
 secilc/secilc.c                   | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/libsepol/include/sepol/errcodes.h b/libsepol/include/sepol/e=
rrcodes.h
index 0136564a..6e9ff316 100644
--- a/libsepol/include/sepol/errcodes.h
+++ b/libsepol/include/sepol/errcodes.h
@@ -12,7 +12,7 @@ extern "C" {
 #define SEPOL_OK             0
=20
 /* These first error codes are defined for compatibility with
- * previous version of libsepol. In the future, custome error
+ * previous version of libsepol. In the future, custom error
  * codes that don't map to system error codes should be defined
  * outside of the range of system error codes.
  */
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 0be6975b..e1347205 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -1,16 +1,16 @@
 /*
  * Copyright 2011 Tresys Technology, LLC. All rights reserved.
- *=20
+ *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions ar=
e met:
- *=20
+ *
  *    1. Redistributions of source code must retain the above copyright =
notice,
  *       this list of conditions and the following disclaimer.
- *=20
+ *
  *    2. Redistributions in binary form must reproduce the above copyrig=
ht notice,
  *       this list of conditions and the following disclaimer in the doc=
umentation
  *       and/or other materials provided with the distribution.
- *=20
+ *
  * THIS SOFTWARE IS PROVIDED BY TRESYS TECHNOLOGY, LLC ``AS IS'' AND ANY=
 EXPRESS
  * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WAR=
RANTIES OF
  * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. =
IN NO
@@ -21,7 +21,7 @@
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING =
NEGLIGENCE
  * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVE=
N IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *=20
+ *
  * The views and conclusions contained in the software and documentation=
 are those
  * of the authors and should not be interpreted as representing official=
 policies,
  * either expressed or implied, of Tresys Technology, LLC.
@@ -259,7 +259,7 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
 			goto exit;
 		}
-		file_size =3D filedata.st_size;=09
+		file_size =3D filedata.st_size;
=20
 		buffer =3D malloc(file_size);
 		rc =3D fread(buffer, file_size, 1, file);
@@ -347,7 +347,7 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "Failed to open file_contexts file\n");
 		goto exit;
 	}
-=09
+
 	if (fwrite(fc_buf, sizeof(char), fc_size, file_contexts) !=3D fc_size) =
{
 		fprintf(stderr, "Failed to write file_contexts file\n");
 		goto exit;
--=20
2.19.0.444.g18242da7ef-goog
