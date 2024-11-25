Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50631990D3
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533532; cv=none; b=RIVNQG9fEb5jRRfmUeoNDW/DrNpGh+JjQj93s6RNblXQ51txu9P6eRQJedFIazsxmIZfPOvTHv7g8YdztGK9PTshi+HFF6GsCIY1/F4wW7aN7xJnyyzVrDqNqKsBxX48yKnx+o61tuixiwrjh1GKOBOH+IXFOY+QV+XxKjcW6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533532; c=relaxed/simple;
	bh=UgHP+oReoy7OLVBgNQ0IKQJ7ZPFuZlJ3xggYJ7VnxuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMVLjq8Tbi9QbUam2K7EqWIwfxAEEVOAbQtPHTzi5amD43WtP9O7nwsu5gNa3UCJkzhxQ8FqtcUnticAKQVx8lOPrQH34vS2MMBW7PTfQPSnGITrRiRzgXWqkR1ffDGjQq05nVqJ+iAB5chPXRbfps17iGfJG2XA2NC+qwWOw0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Uk0CRlZZ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Uk0CRlZZ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533526;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woLjiBHNAMrp6exXJNdJmHyi+kmMIyT7H1QJKNDoPBE=;
	b=Uk0CRlZZLB5zzVwEIUBPqQaqgQFu5VKuK8OeuRmkCJaywscw+b8qLUSHznf7G6kzcE5aUc
	ET2yUkg9OPgaShRcL1KT1CPzJiK8LZeHnljmkpC4V5eAv45HUUIqmTyZG2HVRkTJqA9Ezs
	LaXxlbee0msW4iS1JmR1Ppk1yNnTQ97wCyQPdejhjvVFx6URGtQ0zU3rSDxrnwyMvfylHj
	MSE1jRCVetfzoa4DVgcIjets061LrHBCJ4yP3LbWQSVVHe//4yRtAPN3ZEA1B6H9H0zmgl
	ucp3QWeAD2H/ZuiGanb0xylHTTOxU3G11HtCjCHrZ6IWqt09n1+X6fctarcqzw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 9/9] libsemanage: respect shell paths with /usr prefix
Date: Mon, 25 Nov 2024 12:18:40 +0100
Message-ID: <20241125111840.63845-9-cgoettsche@seltendoof.de>
In-Reply-To: <20241125111840.63845-1-cgoettsche@seltendoof.de>
References: <20241125111840.63845-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Consider paths with the prefix /usr for shells by including them in the
list of fallback default shells and by extending the check for a nologin
shell.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/genhomedircon.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 19543799..8782e2cb 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -192,15 +192,23 @@ static semanage_list_t *default_shell_list(void)
 	semanage_list_t *list = NULL;
 
 	if (semanage_list_push(&list, "/bin/csh")
+	    || semanage_list_push(&list, "/usr/bin/csh")
 	    || semanage_list_push(&list, "/bin/tcsh")
+	    || semanage_list_push(&list, "/usr/bin/tcsh")
 	    || semanage_list_push(&list, "/bin/ksh")
+	    || semanage_list_push(&list, "/usr/bin/ksh")
 	    || semanage_list_push(&list, "/bin/bsh")
+	    || semanage_list_push(&list, "/usr/bin/bsh")
 	    || semanage_list_push(&list, "/bin/ash")
-	    || semanage_list_push(&list, "/usr/bin/ksh")
+	    || semanage_list_push(&list, "/usr/bin/ash")
+	    || semanage_list_push(&list, "/bin/pdksh")
 	    || semanage_list_push(&list, "/usr/bin/pdksh")
 	    || semanage_list_push(&list, "/bin/zsh")
+	    || semanage_list_push(&list, "/usr/bin/zsh")
 	    || semanage_list_push(&list, "/bin/sh")
-	    || semanage_list_push(&list, "/bin/bash"))
+	    || semanage_list_push(&list, "/usr/bin/sh")
+	    || semanage_list_push(&list, "/bin/bash")
+	    || semanage_list_push(&list, "/usr/bin/bash"))
 		goto fail;
 
 	return list;
@@ -210,6 +218,12 @@ static semanage_list_t *default_shell_list(void)
 	return NULL;
 }
 
+static bool is_nologin_shell(const char *path)
+{
+	return strcmp(path, PATH_NOLOGIN_SHELL) == 0 ||
+	       strcmp(path, "/usr" PATH_NOLOGIN_SHELL) == 0;
+}
+
 static semanage_list_t *get_shell_list(void)
 {
 	FILE *shells;
@@ -223,13 +237,13 @@ static semanage_list_t *get_shell_list(void)
 		return default_shell_list();
 	while ((len = getline(&temp, &buff_len, shells)) > 0) {
 		if (temp[len-1] == '\n') temp[len-1] = 0;
-		if (strcmp(temp, PATH_NOLOGIN_SHELL)) {
-			if (semanage_list_push(&list, temp)) {
-				free(temp);
-				semanage_list_destroy(&list);
-				fclose(shells);
-				return NULL;
-			}
+		if (is_nologin_shell(temp))
+			continue;
+		if (semanage_list_push(&list, temp)) {
+			free(temp);
+			semanage_list_destroy(&list);
+			fclose(shells);
+			return NULL;
 		}
 	}
 	free(temp);
-- 
2.45.2

