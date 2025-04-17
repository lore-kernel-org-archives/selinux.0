Received: from sender3-op-o15.zoho.com (sender3-op-o15.zoho.com [136.143.184.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D5320F
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744856192; cv=pass; b=Z+YUJPA1zMKuyX3a6vBNu/tCQ9RcUpwWGEKJ8CJw7xQt4YvC7jkpZy9QMNa3GNz5z0CWyEbVJeQ8MggaE2kW5qf2FYSLQm1WXV23r/Nl4uCMEjT+yhATVPpmqj73blJjd8F5JmCnC37wX+nRt3cwiljQMCukcnq7/NgG9+bNKS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744856192; c=relaxed/simple;
	bh=qoYLJR3Iwg9PiNoqK09Fxk7sDkVSKhKRmLIT9BWQBR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoY5miB3RJHF7lbCdoIvlqTDiT2zFgxbhzVjQu/livzprr1+QTURxY3uUqb44mz9cfhs2cStnPPcSZcFx0UoWulzl1f8n5DcahNodHR3B7/2jTm3ewEiFxL6zJfAs+J9oOunopEz4WjIsGMj2EjpGdtAJJwMI1sqExq2sAexw0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=daItqhDy; arc=pass smtp.client-ip=136.143.184.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="daItqhDy"
ARC-Seal: i=1; a=rsa-sha256; t=1744856187; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LgIu7DWSFgFZBana8o753mtSNDeG2EH81JpGjsCofsi0WQ7XF+txNkqeV6rj2T6und/BQL5AUvgKyrxtdTXR4yR2+9V3P9NvwGrB4SV5JXjFG22KSMlJASK633/Zn8eUEod0L2wIuTS7vHXXOCkj4m4muVp3Zb7PmHKZxNgUnm4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744856187; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3RPwDCJRqjPCkMfABwfetgWryaChCnrlWaPXbD+E0v0=; 
	b=Yzj58EDfa1Q2LFsNDy4PAS8JUF5EccU5M94KsqHuY5vK/0wDtISTB2zKp3CWg7m7Mms6scrrrer9H0EfUgu8Wf/oi2F0jwaVzK0n1hW481JvZ4bpKXmIDuDxXg7mzXt0mQlXNNI6RvqGibOT7Q8h5n43TAg1+HK74jj1sQ4vk5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744856187;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3RPwDCJRqjPCkMfABwfetgWryaChCnrlWaPXbD+E0v0=;
	b=daItqhDyKu9WlmeEBQVFKZR3HR0ZHwhH3vTURn/QnwVlMa/n6JCXY1ezx4+o7Rs8
	HM/cWL3NhEhcbfHJwmD6Gc+MsL6NMNWy8COBOYZbfga0rdpOU/FbvduN1t5fzmw88fE
	CHj0pjHtTvMs5FfFRVC8+YMhACK4qWBWiMstW1yM=
Received: by mx.zohomail.com with SMTPS id 1744856185325917.5306441993464;
	Wed, 16 Apr 2025 19:16:25 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 2/2] semodule: add config argument
Date: Wed, 16 Apr 2025 19:16:11 -0700
Message-ID: <20250417021611.45594-2-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417021611.45594-1-tristan.ross@midstall.com>
References: <87bjsvzy6k.fsf@redhat.com>
 <20250417021611.45594-1-tristan.ross@midstall.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Use "semanage_handle_create_with_path" and implement a new flag for
handling semanage config files at specific paths.

Signed-off-by: Tristan Ross <tristan.ross@midstall.com>
---
 policycoreutils/semodule/semodule.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ebe062bf..80fd0451 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -145,6 +145,7 @@ static void usage(char *progname)
 	printf("  -v,--verbose     be verbose\n");
 	printf("  -P,--preserve_tunables	Preserve tunables in policy\n");
 	printf("  -C,--ignore-module-cache	Rebuild CIL modules compiled from HLL files\n");
+	printf("  -o,--config=PATH use an alternate path for the semanage config\n");
 	printf("  -p,--path        use an alternate path for the policy root\n");
 	printf("  -S,--store-path  use an alternate path for the policy store root\n");
 	printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
@@ -210,6 +211,7 @@ static void parse_command_line(int argc, char **argv)
 		{"enable", required_argument, NULL, 'e'},
 		{"disable", required_argument, NULL, 'd'},
 		{"path", required_argument, NULL, 'p'},
+		{"config", required_argument, NULL, 'o'},
 		{"store-path", required_argument, NULL, 'S'},
 		{"checksum", 0, NULL, 'm'},
 		{NULL, 0, NULL, 0}
@@ -223,7 +225,7 @@ static void parse_command_line(int argc, char **argv)
 	check_ext_changes = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm",
+		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:o:S:E:cHm",
 			    opts, &longind)) != -1) {
 		switch (i) {
 		case '\0':
@@ -304,6 +306,14 @@ static void parse_command_line(int argc, char **argv)
 		case 'C':
 			ignore_module_cache = 1;
 			break;
+		case 'o':
+			sh = semanage_handle_create_with_path(optarg);
+			if (!sh) {
+				fprintf(stderr, "%s:  Could not create semanage handle\n",
+					argv[0]);
+				exit(1);
+			}
+			break;
 		case 'X':
 			set_mode(PRIORITY_M, optarg);
 			break;
@@ -421,11 +431,13 @@ int main(int argc, char *argv[])
 	if (build || check_ext_changes)
 		commit = 1;
 
-	sh = semanage_handle_create();
 	if (!sh) {
-		fprintf(stderr, "%s:  Could not create semanage handle\n",
-			argv[0]);
-		goto cleanup_nohandle;
+		sh = semanage_handle_create();
+		if (!sh) {
+			fprintf(stderr, "%s:  Could not create semanage handle\n",
+				argv[0]);
+			goto cleanup_nohandle;
+		}
 	}
 
 	if (store) {
-- 
2.47.2

