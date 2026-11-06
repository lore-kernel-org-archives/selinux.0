Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968532;
	b=pqKijNqqr43Tfouq8hcQKCmakjodnHkVcmrGzaOYANAaZCK+/2EzcJZIzfy9/GYF0qBx
	 C89gA8PvP4xSH7EpXlEI9XqvitfFIfLveEuzttomBMpjmrHGIWGPwQWqeTG1JL/99RmxO
	 lJxKI9pI0Q4AXoomAw5dBXqGc/uU78V+N8/2x12ZyI7wTqjS5xPBEa8bxPzax9jAoPXeE
	 Cs8TxwE546tW9JOL65+buf9KLXx+JTInYqle7y9uyEVI/gahc/oR2Wfz5PRcuGOYGwcOj
	 kCPkFhFT31l/Rn+50r3LN3Td4Oae7imXxwveTwQraHRiDQjOgnFxe36HiehAv6bG03Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968532;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FMU3aEALcKkqEt8LrBzWoqNqpqGxg+KaEhASdROoYE0=;
	b=GXv308SHtwahaV5ASd5xKt93qyLc7QJr+B1+wajvAzuKKXnSUZasMQvXNN+l3qeqkIcP
	 KJxk1DFI7m6ko+UCJ/E8xc7WtkBn8dlY50WolWyZimp+SXzYpaqFsWOAleo4sDn56Gv/h
	 9OIV0KJUoVPiWwfFtBhf24se6m/roobZmZzq5wK8EneVaH6GzeLd49j80fa8jViVxfW+U
	 a1MOs/+o0H2rQd2/pYar5Vm6muy/75TT/SguMqoOfIfVLwzljMb4MNJjCLFDMpHvLEq2y
	 hfmM3O6k9weQxaqdmoiYL11EmeJtgq6AHO7CCwyp0Gpmw3nVNpkRUdSSCNWR3H9O82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Uq3HS3oC;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBB606A332
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73EBB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=Uq3HS3oC
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968527;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMU3aEALcKkqEt8LrBzWoqNqpqGxg+KaEhASdROoYE0=;
	b=Uq3HS3oCH+Pc9U/5t2v0aMSLTLGhTkOtRlpGLhFrP4mMjzmIjur/CbN+J2Z5UGsruWWVH8
	4mPKtn9zk/cywdRn9TgYqgmMTxAIbYH/tX+wj98ktSdD3NBdXU6BLIYbfcZOWT9AFWKg9o
	vCmUNLuHIljtQGaUQ+k6QjRNWLVvWlj5oJUO3Avppwg+hsxNeET2ezROexWHm59YzCRsio
	Ey3BmvTkbXfqlCt3r9rwByTQ62fyV9IWXQIdpWALD/yRDAcxd48Cp24KjBbQd4fV4mWpmc
	ZnpWelxM70SvYCQkS4cjvz7z+pzPxyPRQy/O13X8OihMjSXxm/9dI4vnErTGrw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 01/16] libselinux: correct realpath_not_final() buffer size documentation
Date: Fri,  6 Nov 2026 13:35:10 +0100
Message-ID: <20261106123510.76727-16-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

realpath_not_final() checks the combined length of the resolved parent,
final component, separator and terminating NUL against PATH_MAX. A buffer
of PATH_MAX bytes is therefore sufficient, as for realpath().

Correct the public header's PATH_MAX + 1 requirement and fix the grammar
of the surrounding comment.

Reported-by: Petr Lautrbach <plautrba@redhat.com>
Link: https://lore.kernel.org/selinux/87czpkacxf.fsf@redhat.com/
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index b789ee08..db850d1d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -483,8 +483,8 @@ extern void matchpathcon_fini(void)
 	;
 
 /* Resolve all of the symlinks and relative portions of a pathname, but NOT
- * the final component (same a realpath() unless the final component is a
- * symlink.  Resolved path must be a path of size PATH_MAX + 1 */
+ * the final component (same as realpath() unless the final component is a
+ * symlink).  resolved_path must point to a buffer of at least PATH_MAX bytes. */
 extern int realpath_not_final(const char *name, char *resolved_path);
 
 /* Match the specified pathname and mode against the file contexts
-- 
2.55.0

