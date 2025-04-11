Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734E270EB4
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398000; cv=pass; b=Bk3iIJEXgzrE5fSSLkDtbG8/Y4d6yKWbD1N0jygEvn2ncjt700BgPCmpjqQuTajr50uxiq3FGX5ureXEFizcEv7vp+vUfsXMIO9fvUvVy4opYnizItytgwXu67HagY1edyaSqVbN5v8f1YyB6GxGV7HlaVkoqRSysECkTPDDe6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398000; c=relaxed/simple;
	bh=hm5KNTm8+tgRDOHJMU9nBzCEZltXvTMF8j99FpWoEuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8VMFuFMebAmsUpmQNgQQQPF2Pu0IRhanQp5LeS9jnFoR1F/TRI8rZ+7y39GcvwbN2S9VG+fRbhshZzifdcK1sgtl3EUIm+b5PzoWvuTMgIZXFWYOjnpjXwPzqIrpLglfaZY7PSxKtZCNa0ZenNOY37DjMhYVWJ/B7P9TnWkBH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=BKMP1bjt; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="BKMP1bjt"
ARC-Seal: i=1; a=rsa-sha256; t=1744397995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GT8u2bBSN/wnifk2Tz4Iqa3PJvazrtwCQ1InEk2p5djHc9W5HC5vqgedwogTzBTCQq9jR/VrjH4glJ1AQdjKRr2mmEnnWsJ9r1wgdLjGw6cP0kDV6nohVRPekzX+lv0uFujYbwBTGsMAE1p3NhTQv0VUIdJRWY8xr7zta9RTcTw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744397995; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gNietghu485Z6DAMScs68FVomVIIzD93QqSBXIW5/DU=; 
	b=L3ywG0J0IM4x95qeZCC04eWbjs7cxbSfXjdvDfIEHWXMhJE2IlgcTsabLLvbcYCCH2QhgICmiutzir1OyHypS0sqFAs21+cOeDQOmRYdSmnD1E5HLxnlPH7rnYcw6UMpfNivNU5av1jsvRkO5Mb8H47at1bjEvB9SHS+4Z/Aq+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744397995;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gNietghu485Z6DAMScs68FVomVIIzD93QqSBXIW5/DU=;
	b=BKMP1bjtLYdA763wggs+0SffejbzoADrHaf3lVVhtmr7qS9qvDDmD+qLTh8QwFAa
	MaPxdEw62250i+fIe4ctJ8LjzixmnPHUetuNiznuEOnO+ynNnkVyGFwoSVWBJmFAVgF
	Q22CMaIRVobiULpwi4vNzTNwRoCtsz5g0scRB/xM=
Received: by mx.zohomail.com with SMTPS id 1744397992343900.7138540302352;
	Fri, 11 Apr 2025 11:59:52 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 2/2] semodule: add config argument
Date: Fri, 11 Apr 2025 11:59:30 -0700
Message-ID: <20250411185929.47912-3-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411185929.47912-2-tristan.ross@midstall.com>
References: <20250411185929.47912-2-tristan.ross@midstall.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

---
 policycoreutils/semodule/semodule.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ebe062bf..274cdbd9 100644
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
@@ -223,7 +224,7 @@ static void parse_command_line(int argc, char **argv)
 	check_ext_changes = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm",
+		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:o:S:E:cHm",
 			    opts, &longind)) != -1) {
 		switch (i) {
 		case '\0':
@@ -304,6 +305,14 @@ static void parse_command_line(int argc, char **argv)
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
@@ -421,11 +430,13 @@ int main(int argc, char *argv[])
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

