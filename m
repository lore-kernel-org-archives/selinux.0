Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2C44064F
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207121; cv=none; b=AYTY1h55godRRoG5ic7Gl1vvoMxikOALKa9e9+YIvqsz2KiMnU/GpS4IU6soM/+ujG4aZt25d8MUGppQKdZMwbMI/yjEb6tapZHCHg3M4cz9pECQjrSw80fjXbGqVMrDxjdNhNuirEuufKB2l4GMcXrGLVGpJgVkvJXBj4xMk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207121; c=relaxed/simple;
	bh=tstICVkmpteASA/stpD9TiGs/2q6aZvdLgWR56gZb2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=HbZc/0QB3vh7zOBQoeIZRQNmLumMUe5Sb4HhEOd6nXgsmyXFIXg6ANpfvNBxhl8ovUXFvqz/PUUR4YXNRK2MzpMyE0bVeJ0PnZxzXhb/etRyMtYEfieMVh0D9xOyAoEPFDKMSO0DzJO87cWIwf1h5g6VTSxt4Y+LvGd7AHB051I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoxTmXuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoxTmXuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791207118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFE2c+p0p7dx4nHU3pjojEIeMlMaDuuoj0c+d4KbJoo=;
	b=VoxTmXucOFVTWDtPTrPWzsts1l5rRaTt806qNkkR9NdTFKFi+j0BdhxkwD5PgPyoKor+Kl
	wxFz8lU2TdROxHuJiSzNvUDi9DBKNEd9ViPyqKVijKBldF8ca8a49hfWfRtA7wQA9iaf48
	yERJXS6D/tO5T5WCU/pMwYKL9404Uo8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-vUKZ-stUONqvCLPBFGJbTw-1; Mon,
 05 Oct 2026 09:31:57 -0400
X-MC-Unique: vUKZ-stUONqvCLPBFGJbTw-1
X-Mimecast-MFC-AGG-ID: vUKZ-stUONqvCLPBFGJbTw_1791207116
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 269371829E31
	for <selinux@vger.kernel.org>; Mon,  5 Oct 2026 13:31:56 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EC0D19373D8;
	Mon,  5 Oct 2026 13:31:54 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2 1/2] libsemanage: backport sha256 WaterJuice/WjCryptLib 3.0.0 fixes
Date: Mon,  5 Oct 2026 15:29:16 +0200
Message-ID: <20261005133143.91648-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

https://github.com/WaterJuice/WjCryptLib/releases/tag/Version_3.0.0

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 libsemanage/src/sha256.c | 4 ++--
 libsemanage/src/sha256.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/sha256.c b/libsemanage/src/sha256.c
index a62ebd6f20fa..1fc80cefa5a5 100644
--- a/libsemanage/src/sha256.c
+++ b/libsemanage/src/sha256.c
@@ -181,7 +181,7 @@ void Sha256Update(Sha256Context *Context, // [in out]
 {
 	uint32_t n;
 
-	if (Context->curlen > sizeof(Context->buf)) {
+	if (Context->curlen >= sizeof(Context->buf)) {
 		return;
 	}
 
@@ -263,7 +263,7 @@ void Sha256Finalise(Sha256Context *Context, // [in out]
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 void Sha256Calculate(void const *Buffer, // [in]
 		     size_t BufferSize, // [in]
-		     SHA256_HASH *Digest // [in]
+		     SHA256_HASH *Digest // [out]
 )
 {
 	Sha256Context context;
diff --git a/libsemanage/src/sha256.h b/libsemanage/src/sha256.h
index 1390c1bd481e..a55a5bcdb5f8 100644
--- a/libsemanage/src/sha256.h
+++ b/libsemanage/src/sha256.h
@@ -71,5 +71,5 @@ void Sha256Finalise(Sha256Context *Context, // [in out]
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 void Sha256Calculate(void const *Buffer, // [in]
 		     size_t BufferSize, // [in]
-		     SHA256_HASH *Digest // [in]
+		     SHA256_HASH *Digest // [out]
 );
-- 
2.55.0

