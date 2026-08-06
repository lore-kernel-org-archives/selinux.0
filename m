Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7347F784
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049009; cv=none; b=OCY1WrlHXhTSmXhz0sNeYzc7Y9wv88F+2+R8Ns2oJkVbnZk0TA69Wg2x+Gc7gllUQ1rB66sbmmalwb6d6LhPjho2sRaPvF04I5J0FdVSNVjHEJQSwTgXnyd+1ncNU8Rr3cyuCJl+b9KFtBEaLr9UZmmFWL8VWJGCl/cfCTNb22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049009; c=relaxed/simple;
	bh=9hXSyLerzqMZvSBfaZQ2bAb9HXcRJtQ9QU+1/zm+SLU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=vCJOWlsKz0PC19ATWf8bx6dsorRUdLzXSyviftJxVWx6xFvTMtkbOdc/ofoPjZboYlMeLE5xTvO/DzpiGXi7+fjsoYAklVAeuDchdZX1kbOzD0vOr3jkWNJjU33KbUaFlFL7NdDKmOuwHdfuunAPQpoBlba4DZp5+N5NS4FofQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FsKY6KiT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsKY6KiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786049006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j065qOAfhfvzRJhX6Ax0pTv+NJSeAuVFNLR4wyTHmaU=;
	b=FsKY6KiTcO4mAB7lPKfXMpjhpoqi9tBNpeFvPMpgHrO90QabA9Gu+22VqxMiHlL9YnIgOL
	lq0hnLRSIcVylx6pZeNV5nufUyO9elVRwoAi99UBDLVbCKMX4RzFX542NgT3TYmxsKgA4d
	hTKIAHm5Q8va5rbKQtU+KAA7xPZCVQQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-ihPwoqBiO9OErz2PT0FtLA-1; Thu,
 06 Aug 2026 16:43:25 -0400
X-MC-Unique: ihPwoqBiO9OErz2PT0FtLA-1
X-Mimecast-MFC-AGG-ID: ihPwoqBiO9OErz2PT0FtLA_1786049004
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E8E018001E2
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 20:43:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 821611800347
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 20:43:23 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol/cil: fix size truncation in cil_add_file()
Date: Thu,  6 Aug 2026 22:42:13 +0200
Message-ID: <20260806204320.381649-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

cil_add_file() receives size as size_t but passes size + 2 to
cil_parser() which takes uint32_t. The existing overflow guard
(size > SIZE_MAX - 2) only prevents size_t wraparound but does
not catch truncation to 32 bits. Use UINT32_MAX - 2 as the limit
to match the downstream parameter type.

Fixes:
2. libsepol-3.11/cil/src/cil.c:561:2: cast_overflow: Truncation due to cast operation on "size + 2UL" from 64 to 32 bits.
3. libsepol-3.11/cil/src/cil.c:561:2: overflow_sink: "size + 2UL", which might have overflowed, is passed to "cil_parser(name, buffer, size + 2UL, &db->parse)".
4. libsepol-3.11/cil/src/cil_parser.c:247:2: taint_sink_lv_call: Passing tainted expression "size" to taint sink "cil_lexer_setup".
5. libsepol-3.11/cil/src/cil_lexer.l:71:2: var_assign_parm: Assigning: "size" = "size".
6. libsepol-3.11/cil/src/cil_lexer.l:72:2: taint_sink_lv_call: Passing tainted expression "size" to taint sink "cil_yy_scan_buffer".
8. libsepol-3.11/cil/src/cil_lexer.c:1770:2: lower_bounds: Checking lower bounds of unsigned scalar "size" by taking the false branch of "size < 2UL".
9. libsepol-3.11/cil/src/cil_lexer.c:1770:2: data_index: Using tainted expression "size - 2UL" as an index to pointer "base".

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---

Not sure if this could be a genuine issue as the parser is not likely to  
encounter a 4GiB file.

 libsepol/cil/src/cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 18b98fe2..d9a5a825 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -549,7 +549,7 @@ int cil_add_file(cil_db_t *db, const char *name, const char *data, size_t size)
 
 	cil_log(CIL_INFO, "Parsing %s\n", name);
 
-	if (size > SIZE_MAX - 2) {
+	if (size > UINT32_MAX - 2) {
 		cil_log(CIL_ERR, "File size is too large\n");
 		return SEPOL_ERR;
 	}
-- 
2.53.0

