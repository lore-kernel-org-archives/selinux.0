Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A8367F59
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042963; cv=none; b=TIbwoRI7vtsBlgVnCXtDEBn3vcn52pQYWAE88zIEa8pI1OUKAgQLmAPErtnvFS40g5lQDMUddiKCXaPnGO1RiDRNb1LuDJqlwPRfhsMF/sM+TxfKsvqVxholOTHO90Y5BN1eRz+zcmqwxXQJAOC+t+0Wrn8I6NQIzteGoRXzUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042963; c=relaxed/simple;
	bh=cwh6w4NNfoaCRMM0ggbKAe4AWDlTIq5THduoP4xTSLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5pO1a3M8BCJDntgYc8e8g8RtabDe2rlmzqWgIRWNnHOVpm0BXnDNqCAF9Tdx/50gBe4Au8I+s0kcUpCn5dtg84OKeBAJ9v9/Q7X4DfbgiC/uPIpp0KYXVs+SwpUKlk5LcsALFO+qi+ajEhk1irDQloi84iw5dK0vK9loe+97ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ik7uvDt5; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ik7uvDt5"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042960;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip4iNm2RfyW1o23Xfmmx6z8Ekx9Otayo7JscoRPZTx8=;
	b=ik7uvDt5MaqraSwAnhxmXwYDCskbF/vlzCOjPsRH2b0kd5vNX8yoCVr6ZOqREDXT7I05P7
	1scKZXnibTPYMeHo5sPWzK8+pNmA6uT0bMvFu8kRoI1LfwhBiqD9JTq9afutGNy7z9dvdf
	ICQBP2gteArFXg9GK1mV3SR7u8Ocp2h2HlDma2fdusB9Q/WFlbM36eUxnpdVriqxwdT6ID
	2FyZog560H6DXNY0IZNkaTGEadz8KlUUPS38BLD0eBs8yQySgLy+gLim3peuNCdyTh9siO
	c91FlHlsD66kUwEvWsdjA1TBgLCzmswgVfn8txZvFYmEKvJ+nEAdltJljhCfsg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/4] libselinux: drop unnecessary strdup(3)
Date: Mon,  2 Feb 2026 15:35:54 +0100
Message-ID: <20260202143554.97209-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260202143554.97209-1-cgoettsche@seltendoof.de>
References: <20260202143554.97209-1-cgoettsche@seltendoof.de>
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

Instead of copying the digest and throwing away the original, just move
the original one.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 8fadf4d2..34927126 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -375,13 +375,7 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 		goto oom;
 	}
 
-	new_entry->digest = strdup(sha1_buf);
-	if (!new_entry->digest) {
-		free(new_entry->directory);
-		free(new_entry);
-		free(sha1_buf);
-		goto oom;
-	}
+	new_entry->digest = sha1_buf;
 
 	new_entry->result = digest_result;
 
@@ -393,7 +387,6 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 		dir_xattr_last = new_entry;
 	}
 
-	free(sha1_buf);
 	return 0;
 
 oom:
-- 
2.51.0

