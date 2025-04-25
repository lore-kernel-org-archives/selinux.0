Received: from sender3-op-o15.zoho.com (sender3-op-o15.zoho.com [136.143.184.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5871A256E
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604585; cv=pass; b=I4qHogxi/EtfHLIrL2zkavOs7v9F88R344RRSuiBKQSigptcfZTDdorsljuh5Boz6x9wC5ezpz8x07CoXHJiKfnxw+jAJsRmOqNUTuv49YHlDAciB1N2NysXai23oC3i2Onsr1sU6zxxe/mmUWsoaH38P8fKiXppapbkqjYIcpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604585; c=relaxed/simple;
	bh=coy3ZyxyOIUsKbrQszqG7tQ8+8o69Xkn9V50E+mBdh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLd/JG0XO3WhuGd80zhWFm/MtRUTh1XIT60tjUfDST3mMisSki0I3l2YvEFyH36X025icYv9mDenahYg/mDnLs0pjfzSR/LWPgtb7V24bXYHOu3hHEjInXRkqR5iYyxn20m003qipUoEf74quNj60OkNzkHTT8sNGg4QC6dKKY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com; spf=pass smtp.mailfrom=midstall.com; dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b=XpA4uOlv; arc=pass smtp.client-ip=136.143.184.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=midstall.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=midstall.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=midstall.com header.i=tristan.ross@midstall.com header.b="XpA4uOlv"
ARC-Seal: i=1; a=rsa-sha256; t=1745604579; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dzO+PLYWHqMlqeZqJpr/hwde3TZnVS/fVrBpq2XUWBMx4B0u094JbzVlhUjFHi8KWYCjGXGIseb1/6oz4pLgE44MoxzZyK0Q4QSQGcKCO+fkMDkKfhn9VmZUDecSa64J6XlrnRw7B+kUIH1W2Tit9O3HOBBfnOvgnoy4txLu7dk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745604579; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zZRCJhZzRHcNVFPikNQ/dNQ3hGtk/VolgP2DP16QllM=; 
	b=Ls/HJ/w7k0FzWOAqXRxTXaM+CloGYPTzzQ6hx/XaaFtd9udMM7jRcq3NtPuAH6jXOXLBunKtCxLdxtYUZvpaT4DJK4po583T72amfPtO66GTSqY3Tgv3ZbFnJPLLRLBfrO7UoSX3NoDa7zpY8JNlrknwTfM1rNrTTpDi9+tyIbI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=midstall.com;
	spf=pass  smtp.mailfrom=tristan.ross@midstall.com;
	dmarc=pass header.from=<tristan.ross@midstall.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745604579;
	s=zmail; d=midstall.com; i=tristan.ross@midstall.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zZRCJhZzRHcNVFPikNQ/dNQ3hGtk/VolgP2DP16QllM=;
	b=XpA4uOlvt7kmcvD2voazMM6JSfM0OQ7URKTJ4TslwukQ/65M1se4A3I0EpJebFkk
	UMQYJQAIRYwnr4Shte8DCET91BABx3nEcT8xJ5xrjFwv+Y3Z2Z14UdyiKNNkgyk69Yq
	JDl5Dh7QMv7SATho+6pqhyVw4t1WdOMtz9fYu3JQ=
Received: by mx.zohomail.com with SMTPS id 1745604577222109.49236657793972;
	Fri, 25 Apr 2025 11:09:37 -0700 (PDT)
From: Tristan Ross <tristan.ross@midstall.com>
To: selinux@vger.kernel.org
Cc: Tristan Ross <tristan.ross@midstall.com>
Subject: [PATCH 2/2] semodule: add config argument
Date: Fri, 25 Apr 2025 11:09:25 -0700
Message-ID: <20250425180925.241079-2-tristan.ross@midstall.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250425180925.241079-1-tristan.ross@midstall.com>
References: <CAP+JOzSG74saeVmTz5kdX_Lj3B+5BO-5MbKtxU7VLBOhp-h8Vw@mail.gmail.com>
 <20250425180925.241079-1-tristan.ross@midstall.com>
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
 policycoreutils/semodule/semodule.8 |  3 +++
 policycoreutils/semodule/semodule.c | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 00c60c1e..ae928611 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -86,6 +86,9 @@ Preserve tunables in policy
 .B \-C,\-\-ignore-module-cache
 Recompile CIL modules built from HLL files
 .TP
+.B \-g,\-\-config=PATH
+use an alternate path for the semanage config
+.TP
 .B \-p,\-\-path
 Use an alternate path for the policy root
 .TP
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

