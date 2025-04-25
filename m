Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152654437C
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604426; cv=pass; b=a734S9OBQJ0tB35Tin01qjydXqowDAdMiZ25N6QyzbstXpPIj9kNyTV8dha2DzDA/z10vvTMUPQqZLVSOWTRFqvquJVms5WKFdMiVqlREAeRhE6JinOOuWC2jnzY2tuvlN4/Q60kGcWb24x6yyrr0cofpZTX+8SvEkWmGaxvErg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604426; c=relaxed/simple;
	bh=QkQlnZHyne9Gd6xlosO2hXKf5xKXiEb+jOGBJdMTHso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zxu2qZWFU5PBCwnDiCroDhvf+QJiovCxmrANEOY5qCWm6vcPwNHrxJ7Qq747icgmDnhcwYI8Zkhh6eYSwuvl3BpEKb7rKtUVVLrKEqy43KpM3tEOPRz1jc8piDg82iuFTgXl5MhMHKMRuqi1H9b7nUXOBEU+adExoP4wcdEcNO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=WQGSMf9I; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="WQGSMf9I"
ARC-Seal: i=1; a=rsa-sha256; t=1745604421; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PzzyFgBBxwWR5BfqoZmPcZr6Mr+bKmmO9UMRoNLwYD42NoH/lfMIiHPByVNBF0CI8QMxdER6wNKtcaGGeBcLvXE3sJY0zQhWW7gMRhXce5bKGimJlkGF2z7m8EtSWBvXAdZtqo86jFCmuWum6ljip6EpoCP+A7H/Qg359Pn9CmY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745604421; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SKBUiEtQ/Gx64yOnqIgyLSn5JQdDdDAZQC1W8IG3ce0=; 
	b=dOVcyRQkLXEro2sxiEhxxfVN3nRREsykSSrqdl0LgloSnju6HLayUrSFJjdy4QoldfBlRAJ34z/D3hyj63YdxkesWJaWfPP1o/LCwbjFpauCGq8L82iTbOdbWld4UUKdXqSHFYOl8wK5pUSWVS8tfZTOh/R6oVJAWcUgZjyN/9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745604421;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SKBUiEtQ/Gx64yOnqIgyLSn5JQdDdDAZQC1W8IG3ce0=;
	b=WQGSMf9INyG5SAyyis/mQ5PaunYX1ehKLy9MxdWtyPwmMhNTBrIqsDhC2+8Wb7jg
	j0D3ClOVgBJJXE41yQvtAKRej3BFc09tf//wFlisqfnACS2lo+r8/vlpdZ5UW2N2KKT
	6khX0kjZZikVIXCQMmxbdhVeQKY0d90iVdjr4ltE=
Received: by mx.zohomail.com with SMTPS id 1745604419013904.4768452213897;
	Fri, 25 Apr 2025 11:06:59 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 2/2] semodule: add config argument
Date: Fri, 25 Apr 2025 11:06:45 -0700
Message-ID: <20250425180646.240485-2-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250425180646.240485-1-tristan.ross@midstall.com>
References: <CAP+JOzSG74saeVmTz5kdX_Lj3B+5BO-5MbKtxU7VLBOhp-h8Vw@mail.gmail.com>
 <20250425180646.240485-1-tristan.ross@midstall.com>
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
index ebe062bf..ab5168eb 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -145,6 +145,7 @@ static void usage(char *progname)
 	printf("  -v,--verbose     be verbose\n");
 	printf("  -P,--preserve_tunables	Preserve tunables in policy\n");
 	printf("  -C,--ignore-module-cache	Rebuild CIL modules compiled from HLL files\n");
+	printf("  -g,--config=PATH use an alternate path for the semanage config\n");
 	printf("  -p,--path        use an alternate path for the policy root\n");
 	printf("  -S,--store-path  use an alternate path for the policy store root\n");
 	printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
@@ -210,6 +211,7 @@ static void parse_command_line(int argc, char **argv)
 		{"enable", required_argument, NULL, 'e'},
 		{"disable", required_argument, NULL, 'd'},
 		{"path", required_argument, NULL, 'p'},
+		{"config", required_argument, NULL, 'g'},
 		{"store-path", required_argument, NULL, 'S'},
 		{"checksum", 0, NULL, 'm'},
 		{NULL, 0, NULL, 0}
@@ -223,7 +225,7 @@ static void parse_command_line(int argc, char **argv)
 	check_ext_changes = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm",
+		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:g:S:E:cHm",
 			    opts, &longind)) != -1) {
 		switch (i) {
 		case '\0':
@@ -304,6 +306,14 @@ static void parse_command_line(int argc, char **argv)
 		case 'C':
 			ignore_module_cache = 1;
 			break;
+		case 'g':
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

