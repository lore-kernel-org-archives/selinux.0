Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8OIB8QN017569
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 14:11:08 -0400
Received: by mail-pf1-f176.google.com with SMTP id s5-v6so1582643pfj.7
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 11:11:04 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Date: Mon, 24 Sep 2018 11:10:52 -0700
Message-Id: <20180924181052.130507-2-nnk@google.com>
In-Reply-To: <20180924181052.130507-1-nnk@google.com>
References: <20180924181052.130507-1-nnk@google.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] secilc: better error handling
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

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 secilc/secilc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/secilc/secilc.c b/secilc/secilc.c
index e1347205..ad6862ba 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -257,6 +257,7 @@ int main(int argc, char *argv[])
 		rc =3D stat(argv[i], &filedata);
 		if (rc =3D=3D -1) {
 			fprintf(stderr, "Could not stat file: %s\n", argv[i]);
+			rc =3D SEPOL_ERR;
 			goto exit;
 		}
 		file_size =3D filedata.st_size;
@@ -265,6 +266,7 @@ int main(int argc, char *argv[])
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
=20
 	if (fwrite(fc_buf, sizeof(char), fc_size, file_contexts) !=3D fc_size) =
{
 		fprintf(stderr, "Failed to write file_contexts file\n");
+		rc =3D SEPOL_ERR;
 		goto exit;
 	}
=20
--=20
2.19.0.444.g18242da7ef-goog
