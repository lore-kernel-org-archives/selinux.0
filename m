Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2933893D
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680149; cv=none; b=q2ThRBEbQMLWYNi9lf+mrq+N6oEZNSA45j7SNxW1a2UbPz+x4ttS0KLrvlmn43Ml3dNbgmIApOtk6cOAB7dDhSzwT5qudn3QSsjfPJvuSs8yxq3rk1X24fPc6Xavs/F/DBN3taUBihR1qI+e9Nz8+5Qs5EMqMDdp0K7ndcuK6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680149; c=relaxed/simple;
	bh=9lgUBei45/uY5E74VSwO/NX6lsjAq9vyGyK2rsUgS4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lp/T4qvm3tmzz2pfFyrXxMheoIv1FQnYDww4kgafk6PqZtUxZ+0YDeIPOsUBfTLSPAj4IMH5qiYbLCMXeK64vvg45C5KLudnOHaDDwJ5cR487vdj/T7e/KBmqlUqBLq2G078im8cCWkEVD+oz8S52m6IQH7Ddg/QlyXzS8Iyb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XcCldIWu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XcCldIWu"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680145;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrpH/B/UWrXavcRI2NIgV6DWnZPXCOsc44vWfO9osU8=;
	b=XcCldIWuEuynvhAY1gLscVfFCzb+sbXRfMyz20BzWbCNE+aw1xz2NJGoflgKpMaZSq9rEa
	xEqx2gQAx7yVCKnLNbqEG10IVEcQbN6MkvQMTkVtNsianLW9txWGZIEpLkni1mc0wAqds9
	e9Co8dbq2wA/mtS5NAUdxRCHZ7L0xCt2MD8WrEwBkg1vuw6W1Kfe3Hcs3xkRu8D2ya0HUc
	0gEKYvN+cV45aRNIsr+Sz0ApDiLWspPi2GKgpJiJ71FEZyaFGuzivz6RKeoDMqHOovJed4
	zC1qnmUwkqSh7DS+p+B1tqemS3qiegm1M+I+y07zou1X1G0xiMSSI3nnJ2IFQQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 09/11] restorecond: warn on selinux_restorecon(3) failure
Date: Fri,  5 Jun 2026 19:22:04 +0200
Message-ID: <20260605172207.222382-8-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

Warn in case selinux_restorecon(3) fails instead of ignoring.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 restorecond/watch.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 8e1c36fe..30dfb8b5 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -202,7 +202,13 @@ void watch_list_add(int fd, const char *path)
 				continue;
 			if (len > 0 && strcmp(&p[len], "/..") == 0)
 				continue;
-			selinux_restorecon(p, r_opts.restorecon_flags);
+			if (selinux_restorecon(p, r_opts.restorecon_flags) <
+			    0) {
+				if (errno != ENOENT)
+					syslog(LOG_ERR,
+					       "Unable to relabel %s:  %s\n", p,
+					       strerror(errno));
+			}
 		}
 		globfree(&globbuf);
 	}
@@ -286,8 +292,15 @@ int watch_list_find(int wd, const char *file)
 				    0)
 					exitApp("Error allocating memory.");
 
-				selinux_restorecon(path,
-						   r_opts.restorecon_flags);
+				if (selinux_restorecon(
+					    path, r_opts.restorecon_flags) <
+				    0) {
+					if (errno != ENOENT)
+						syslog(LOG_ERR,
+						       "Unable to relabel %s:  %s\n",
+						       path, strerror(errno));
+				}
+
 				free(path);
 				return 0;
 			}
-- 
2.53.0

