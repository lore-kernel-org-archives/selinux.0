Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813C1A0BCA
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334648; cv=none; b=orMZym78Z5FZJVx7e/ZsneaiyEin1l3j867D3zTXfpvimWcYE2811EjgURza/E590H5kIs9KayhTI+qgTvtp07Ma51j41b8xwKZXRKl49fOhKNE16x2bX5f2piKw91qKV0f2bHeEnaKiaSBnWwoKlBA/NbFdD0nVDsf2g62QFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334648; c=relaxed/simple;
	bh=UgHP+oReoy7OLVBgNQ0IKQJ7ZPFuZlJ3xggYJ7VnxuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g11wRCeSiLwaPyGK37ZTB/SJrn9EOvv0sTrtrBsoksSE42YgevJrYsGZiq1oXZTXtb57wf42muqInhIjaacNM2FNUanxQlo9BuWTnBBilCrTeJUtI0CHJ/VgIK/oPhLmjg61hL15lfzkdZhbIV9O8Hny87Agr+YVxaP8k46Y7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=A4xCuom/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="A4xCuom/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334641;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woLjiBHNAMrp6exXJNdJmHyi+kmMIyT7H1QJKNDoPBE=;
	b=A4xCuom//aVpD2MsfEJaWcc5uCTE360BRpDs0qwcRJz7NjoQkQspnWGI6+olRM+gFsR6on
	RvARkWgMz8GK26leGo5/j8nbkE1yKM3eiLOE/2M1pAnjyDjFtBNwoz0NuK3DIpPJFEuKkP
	TszlaLopl3/HTuYDx3TVPq+v+vQpddHptyqdxvFr52GGWCFjZAlpzatQQReZDmFcX+mLNB
	QhfA5ZOeRFx1atOq8tx6vkZdERLZDQw/t0w3PsiVIIqb3mGRioaVlF91d0LngXR/D6jjLa
	SJl4tdBU5Q4RFV7TDcuPVskhHmkFjI5c3J5obQ8H4UiPM4Y1rN2n2DtpGZwxWQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 46/47] libsemanage: respect shell paths with /usr prefix
Date: Mon, 11 Nov 2024 15:17:05 +0100
Message-ID: <20241111141706.38039-46-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

