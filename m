Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E822331B
	for <selinux@vger.kernel.org>; Fri, 18 Apr 2025 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999988; cv=pass; b=Wr6I010XxYTVUgvL/LXWzsbnQi5wczRsvD/ujTcwDG0WM/Z3D3dx/wEgeXz2WahqoFMwbIOYNX4D8NI2SHbMnkNYeN+xmGiBnkK2P6cmJIPyHGhZs/ApAedHlojx7Qz07WpsN1uzaT6AGQl6+lWxtHiEKX4KsxPQVKpbuUja8ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999988; c=relaxed/simple;
	bh=qoYLJR3Iwg9PiNoqK09Fxk7sDkVSKhKRmLIT9BWQBR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYuE5YdQW6Oaq9kBLyFkj3WUm7MAqFHKPr/Q8jvbz1z7qbhsiYMNiRQ6PF3G6ePFLbxO1RS1gXN6fHCi+jZ/Y40iLHh6xKEYYehTwxWPLBgom2IXxgox5llni/HweduRL6zoY9KLcsUZf/SFvbYRskeKFce6Skj7+jGC74lBB1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=KLo4RmlJ; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="KLo4RmlJ"
ARC-Seal: i=1; a=rsa-sha256; t=1744999983; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K8xVlKx/h6tb84sYotYHrvqzfNiIqV5SplX+LeRdnWocOo7RaJShvgeHsE24xY7VDZAT0q/6Nspo9BcTzxVYnu8hvQHG3RlJN6V0lAehCkh9mlPHWT5n9zMa1Ao3a2+/2AM4Bm9V6N+ZEFq038X3xiQluYbenL3a35IjE6oBRIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744999983; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3RPwDCJRqjPCkMfABwfetgWryaChCnrlWaPXbD+E0v0=; 
	b=NIVcCRC1eVXTXuF2/RjaZ4kTwvbVmyQfETVwNwQanRZWOL0iI+P80LL7bgVCqhvNb0AIHCLVcO8usFOhAo1geDIq0QBSwkgDuNGKkwpc5ES1K8NdVhYf5WvizvdLqPgBIj2ipZz+AXd9z797cZ/IWGGaLoex7jjAJe+GP8m3Zgs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744999982;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3RPwDCJRqjPCkMfABwfetgWryaChCnrlWaPXbD+E0v0=;
	b=KLo4RmlJhUjZLR2INwx04jvRKvP4CYVzkXF7Gk9n1tDCeQUD0lKBF2RW/O65sr86
	OiRIHxIR800m9dkged3kowrXHlHeW0Q+qcvlXpM4oJx12r7ofuTrNlfIWcCdBLpwyVG
	lFfyvp6cAlZFviSzlXvZXBwknVAYNADRhbr90tHY=
Received: by mx.zohomail.com with SMTPS id 1744999980869764.6774290015588;
	Fri, 18 Apr 2025 11:13:00 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 2/2] semodule: add config argument
Date: Fri, 18 Apr 2025 11:12:56 -0700
Message-ID: <20250418181256.98701-2-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250418181256.98701-1-tristan.ross@midstall.com>
References: <87bjsvzy6k.fsf@redhat.com>
 <20250418181256.98701-1-tristan.ross@midstall.com>
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

