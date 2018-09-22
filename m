Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M09cNd009758
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:09:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so6721324pgp.11
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 17:09:15 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Date: Fri, 21 Sep 2018 17:08:59 -0700
Message-Id: <20180922000859.121485-1-nnk@google.com>
MIME-Version: 1.0
Subject: [PATCH] secilc: better error handling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix a situation where the secilc command line tool could return success
even though the compilation failed.

  $ secilc /dev/null -o /dev/null -f /dev/null
  Failure reading file: /dev/null
  $ echo $?
  0

Fix a few other minor oversights while I'm here.

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 libsepol/include/sepol/errcodes.h | 2 +-
 secilc/secilc.c                   | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

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
index 0be6975b..8578cc26 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -257,14 +257,16 @@ int main(int argc, char *argv[])
 		rc =3D stat(argv[i], &filedata);
 		if (rc =3D=3D -1) {
 			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
+			rc =3D SEPOL_ERR;
 			goto exit;
 		}
-		file_size =3D filedata.st_size;=09
+		file_size =3D filedata.st_size;
=20
 		buffer =3D malloc(file_size);
 		rc =3D fread(buffer, file_size, 1, file);
 		if (rc !=3D 1) {
 			fprintf(stderr, "Failure reading file: %s\n", argv[i]);
+			rc =3D SEPOL_ERR;
 			goto exit;
 		}
 		fclose(file);
@@ -345,11 +347,13 @@ int main(int argc, char *argv[])
=20
 	if (file_contexts =3D=3D NULL) {
 		fprintf(stderr, "Failed to open file_contexts file\n");
+		rc =3D SEPOL_ERR;
 		goto exit;
 	}
-=09
+
 	if (fwrite(fc_buf, sizeof(char), fc_size, file_contexts) !=3D fc_size) =
{
 		fprintf(stderr, "Failed to write file_contexts file\n");
+		rc =3D SEPOL_ERR;
 		goto exit;
 	}
=20
--=20
2.19.0.444.g18242da7ef-goog
