Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0D1A00D6
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=ruWcOuqTj0ADvXeMW390bRLDzeVCxbaQOi9u3W9FBncE4s4Ze1lwE2vglJsn1nUJ/MkvL8ukO56lE1FRBLCEUuf8BL9ghQhpmF+dbw3g5Idpoi1+0oAFPS1EC3gUj2Dfjs+Xgdtats2Rg6c1g3iL+UweWgp63CdMUEMw2pHQNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=L8IGVhYD8htZLNR23bfoQsBM7vC26Vt2xwSuTv6++Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/4ljqpuh5cl/2GllbYW712TNbpDlrL2uuu3g2cbmaDkk6ETmXGw6K8ksfsWWqd5kTKFWp1gv9xtyyBOwkKRWdpltX/4e5ouE1/CUaeydlOsku+gNDssWiXRbpWqQhcenO6POigaI8+ZEKh59CsfEu8EovP7BYakNh/m5dGTM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VmGCUwFf; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VmGCUwFf"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334639;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptn2dur4Spw/kDJiK3uMrF0jJ9/x1YjXh1diV/fmzwg=;
	b=VmGCUwFf3rPR8hzZlWZ9W0ybe0Jsx6obEKE2lSno0WAbl6UZuUQOEofNVmlmyBn0MVUDk/
	bY7w2vgK1jeecv4bDfrbftai6ZXzWBOaOhODoenPDZ0ExAntUT+RpG+Fjpe2YKR0oRdmgN
	t1I3zHVn4hRC5qzEHY3LQx7aYTVCuJLEagC5OzjpkkscFCbu2E+ydC/vq3/1VFOyoC479o
	XoEDD+Wgu6GTMjNKyPjbP6H1dUlKHvhdLkxF1qC8vx96jxyEZzKus22WTj8hmBF/C/AyRO
	hhDpK3eSlSVTbmTf1HIp0yU3v4Oa1DXEdzbbhgMmZKkGqnMyW8meCrbAp3Z3JQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 35/47] libsemanage: handle shell allocation failure
Date: Mon, 11 Nov 2024 15:16:54 +0100
Message-ID: <20241111141706.38039-35-cgoettsche@seltendoof.de>
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

Return failure instead of silently using a fallback.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/genhomedircon.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 53673645..c38d284b 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -228,7 +228,7 @@ static semanage_list_t *get_shell_list(void)
 				free(temp);
 				semanage_list_destroy(&list);
 				fclose(shells);
-				return default_shell_list();
+				return NULL;
 			}
 		}
 	}
@@ -333,7 +333,10 @@ static semanage_list_t *get_home_dirs(genhomedircon_settings_t * s)
 		return homedir_list;
 
 	shells = get_shell_list();
-	assert(shells);
+	if (!shells) {
+		ERR(s->h_semanage, "Allocation failure!");
+		goto fail;
+	}
 
 	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MIN", NULL);
 	if (path && *path) {
-- 
2.45.2

