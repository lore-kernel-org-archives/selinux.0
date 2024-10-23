Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897A1AAE02
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691035; cv=none; b=gXgYD7uPn7yqR1iT3ZEL3EBC56DjC//QWXLVViHjW4WjisAGPSOYqUqvRgKwwbSOqmHUQCkeAaTTcMQmV8lWsXPZj2Ve0p+w3Y8GPOjiyVqa6ru9RXtqFojmHWJX6x41khtEJ6Kc6ketggwhOyyJaCxxA5YMEoDeq0taZ0UTTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691035; c=relaxed/simple;
	bh=a58WhftuYwmQhPFE68btykTXHEJ0TAPMyWbaywwjrCc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYbtRwTDpjs7iRj7HZZOL1E8TGzJX+Gw1TrOO73WrdY85IIfqdcU6A5B9VsRkjmpCXiyRhphsH6VmMyHRvzL+7BVs3OoavYDj/p47QJdFxYwl9PkR0FFdlQNl4Uv1ResboBLctqWZD1ZA0cCJoYRX5VM8n3Lcfo1HYKq/V+f7Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0jrLq6y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0jrLq6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729691032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDC8es8Dnm4/AG+tkdPlI3NpIOUFXCnikfcCobDEcU0=;
	b=I0jrLq6yGgtC55vUyll/MDBVATEUfGdwznFKKkJAkfJfHgMIk16y4VMjaZGwyoF7nVReZ5
	FYdTD488Y6Kc+lvH2vpqgv+B+mBkpjMb4/CdGjCTN08zGY528VBFXBz8nczdlWknqIV4Nz
	ruB1mh8WQStA085bd1vv4GjIRvRUwIo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-bUcv4vo4PNWiydbrvfFHIg-1; Wed,
 23 Oct 2024 09:43:51 -0400
X-MC-Unique: bUcv4vo4PNWiydbrvfFHIg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D67C1936DAA
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:43:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CC571956046
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 13:43:35 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH v2 2/4] libsepol/mls: Do not destroy context on memory error
Date: Wed, 23 Oct 2024 15:43:16 +0200
Message-ID: <20241023134318.733305-2-vmojzis@redhat.com>
In-Reply-To: <20241023134318.733305-1-vmojzis@redhat.com>
References: <CAP+JOzRURZwsyvGzs3U7M7mw4NWD3Brh-K4wnztCS81MLYRHYg@mail.gmail.com>
 <20241023134318.733305-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

In case of malloc error, ctx1, or ctx2 may be pointing to uninitialized
space and context_destroy should not be used on it.

Fixes:
Error: UNINIT (CWE-457):
libsepol-3.7/src/mls.c:673:2: alloc_fn: Calling "malloc" which returns uninitialized memory.
libsepol-3.7/src/mls.c:673:2: assign: Assigning: "ctx1" = "malloc(64UL)", which points to uninitialized data.
libsepol-3.7/src/mls.c:699:2: uninit_use_in_call: Using uninitialized value "ctx1->range.level[0].cat.node" when calling "context_destroy".
 \#  697|   	ERR(handle, "could not check if mls context %s contains %s",
 \#  698|   	    mls1, mls2);
 \#  699|-> 	context_destroy(ctx1);
 \#  700|   	context_destroy(ctx2);
 \#  701|   	free(ctx1);

Error: UNINIT (CWE-457):
libsepol-3.7/src/mls.c:674:2: alloc_fn: Calling "malloc" which returns uninitialized memory.
libsepol-3.7/src/mls.c:674:2: assign: Assigning: "ctx2" = "malloc(64UL)", which points to uninitialized data.
libsepol-3.7/src/mls.c:700:2: uninit_use_in_call: Using uninitialized value "ctx2->range.level[0].cat.node" when calling "context_destroy".
 \#  698|   	    mls1, mls2);
 \#  699|   	context_destroy(ctx1);
 \#  700|-> 	context_destroy(ctx2);
 \#  701|   	free(ctx1);
 \#  702|   	free(ctx2);

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsepol/src/mls.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 45db8920..a37405d1 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -672,8 +672,10 @@ int sepol_mls_contains(sepol_handle_t * handle,
 	context_struct_t *ctx1 = NULL, *ctx2 = NULL;
 	ctx1 = malloc(sizeof(context_struct_t));
 	ctx2 = malloc(sizeof(context_struct_t));
-	if (ctx1 == NULL || ctx2 == NULL)
+	if (ctx1 == NULL || ctx2 == NULL){
+		ERR(handle, "out of memory");
 		goto omem;
+	}
 	context_init(ctx1);
 	context_init(ctx2);
 
@@ -690,16 +692,14 @@ int sepol_mls_contains(sepol_handle_t * handle,
 	free(ctx2);
 	return STATUS_SUCCESS;
 
-      omem:
-	ERR(handle, "out of memory");
-
       err:
-	ERR(handle, "could not check if mls context %s contains %s",
-	    mls1, mls2);
 	context_destroy(ctx1);
 	context_destroy(ctx2);
+      omem:
 	free(ctx1);
 	free(ctx2);
+	ERR(handle, "could not check if mls context %s contains %s",
+	    mls1, mls2);
 	return STATUS_ERR;
 }
 
-- 
2.47.0

