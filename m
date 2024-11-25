Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4E197512
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533529; cv=none; b=MBzvylFn6TLuURRol8inu7ED2SxOZSDenjImHp2FReDBCUK04Gg8HDr3kT1rkShLV+x5iqb/QGW2loN2vQa2sj7nYz3GiIZYD+lr9j+v6M3JkUEFVH6YmOuI6oSrpUq3WPATmQlAvpvUbI2tk2NRHR8AiH/lPA/7uGQP9UPDCnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533529; c=relaxed/simple;
	bh=L8IGVhYD8htZLNR23bfoQsBM7vC26Vt2xwSuTv6++Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dah6RGpMzI7ZzyoIc53mLhh20VPThEnbU1VG6ZD6vOW8SBArerFE4hO01HpIxAdG/7KhWsQv/3+NPwaqIc7XGUHwQFvMN7748dfP1Zmi17x1TgMZ9fvbNqsn0PCdeYEBmcaHsA7JhblsmirXVqzN8f+vt/7iaod4G/eXOVwCSwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TTiprbWI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TTiprbWI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptn2dur4Spw/kDJiK3uMrF0jJ9/x1YjXh1diV/fmzwg=;
	b=TTiprbWIdujRXr2sSPtBTFwARtAwiC3xzK5CnJJS/brJG38WFDhCl4cQnieIDnzCJU/c0M
	CSkqbGGyFFKBEsMzOrVabcl+MQeLcxCB2tXvDtL+xRXH0cnoE4jcGCi3rUfune/6r8De81
	uAfW10PES2Z9k+W1aB/Zx8jxIqcvRMJv4+HOj3EdPap16UQxZIA3Biwykr+6bSrZ9yBipS
	RdtAZhmGLt6igBlSZqX6+sEHJN2iRDnwVWxJljRYZdSceinaM0zBg2liQvhIcG6mfe4jFr
	SlrdHVNukdIDKBNokIbzupyxdBUqD5v9dFTsC0mfHg+Ok6jOrE8YpgN4WnOjtA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 3/9] libsemanage: handle shell allocation failure
Date: Mon, 25 Nov 2024 12:18:34 +0100
Message-ID: <20241125111840.63845-3-cgoettsche@seltendoof.de>
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

