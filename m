Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840132;
	b=hlUEiPp43PAAMdaeue8ItMM4CY2OVQYaANOfxlfojTB+ZEbBi2/RDWDiSBmueUL1HzLb
	 S2VJagMy53W5jE4JJl7pR81yX3s+2vY8EzJYK7OMFeCt/dLkOdXPglHMsbJMAiPGTuSxw
	 3t54C7ENOGWEZao6hTOw1Pe+QKgBoyMeuJI8Amk1KzlyDD0Qv1dB2o5l7Vy3wjw3bzEJ8
	 foYVPiaRHew7EhDGS3YXhjNVA3fvZFGG/Rjw0k13DXnc3DMMxoMNbE+JqIU3iYdVFmqJy
	 Cd1486K79Q+1mvpSm5jHZzKr7F5Ucm4fNKEeIuksuidb/OqR1m8dAedn+yjkEMPCQBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IYSlb8GosQk8ker0CxhbSVsiJFd95xW+m4wIQocZNVk=;
	b=gh8nbgdfCO0+iKXmTxn9xtmGwPwVr3+gitTY56TFw4ScyWaEsnQH1WXwAES/USI+V1BV
	 OnUozbOy24KGtPRQ9TG1NEiX8ppwagMXG8KXeWxIkbbK/SvY2bCZ8EIgFCz73orIbK3N9
	 Tppet/nwt9wdfbFwYMVaGct/BGyeeNLhN/0wHF0J+FF/0Ti7QPipwo1J8juveVD/b1j3N
	 K5RtFioRKXR3HqauNa4YBieWy0pDYSTClKvIjzefz6jPUb7V/bH6s7ml29Yefm3ewawcR
	 3b7nVBBJB3W9+f/cR9GC/5YSZbAFQ7FfqPpY3R11NzCIHdTjTa1WnE9p4W4dfzCmO+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc1TMkri;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48863606A31C
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 14:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48863606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wc1TMkri
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55d3563e50eso17458511cf.0
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 06:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794840131; x=1795444931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYSlb8GosQk8ker0CxhbSVsiJFd95xW+m4wIQocZNVk=;
        b=Wc1TMkriBJQfBV3VkOB1H0kwygcw7wIFqJ9C4yKv02Thv6XMbN4oTZHKw4OSSpl9RQ
         pkwY4esnozSIZ/3leef78Jc1VMR5sMbuPQBed7MSOq8h/ei5x2gWZbty0bEwDSzHgHJy
         QcPntqmR5uIb4mwFbqLFT2MJPaYsThyK+Ub0L9uTNqG33eNU+NJfqQu9eST22iR6kQX9
         4UIzmEZr6BPR2FKj5hLzoQXfbYZ1CCqYmNpzFm1I0e3enp8opRgyj9iiiuzHHAwcrarC
         8a5XvR8Gey60k9gckRbCVDD5lwt0TZoyzEXFXv4NuoZovdM5bBBRIdYmetCMucSXeqw4
         WXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840131; x=1795444931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYSlb8GosQk8ker0CxhbSVsiJFd95xW+m4wIQocZNVk=;
        b=2LTWOJjzKGgUkwN9gXUVKIHMdhIs1bkLxGgn6QxZXnYWpJzDfop3UU/vdOGr1+Fn0q
         yzbJhyYWBZEKglJdHrzd0fu01Z3muvjxXyfu6Evryq4iJgaP3wbSH+y3rc2soboaUn2+
         d+GtnAtVLqu5aPDb2WiA/OEJ2c/Anb4BPWCTFUIGwdG6qZnnLftt3+Q9xZQVVLjNAYD9
         xXRTlnA+1LckfBshYtuJ3gDlWvPQ19BhRJWjQCzAjQbSzzjcd2MC5+CPN1hfeEPZAY1p
         qZRZcOlTKbAReEcV7JLXHCBbyiDZCVSPvvtd6yB3tr5b1ZlyvQ2A93jgr0mCVOF/rMEx
         OOcQ==
X-Gm-Message-State: APuU4Z+oU75fq4xSjr8mMYqaPkIckZPcQL1iXeWWdHHDqqQlz4Yxt4pD
	FBf+UcFKtS/+0EDaFHQwp9yACjFEzenuiuNXQaMJ2JSa/PTly/tqSSucWWsxcg9q
X-Gm-Gg: AYBFou3jojiZ94+Egkmr6Enji1iHYAJ3RDDFhEhpRvkK5p2WB/0th3hqVvyqI+D30mt
	2de7W2o73V74wTlDqRNQGppqUcUXCGg4emsjUYse2rVKmmlv61lBcURez6+iD8PNFqebiyK04zX
	tkgT3EN6FeTISAXpsvPOoxIsFSHPM4P489qJfnqMw6qcGS/ndGdIvTY3ygg0dm9X19aQWsflkvo
	P2M/ARLY8Ofa9fBGf6viwZV/9KcVfEOJykQHSykkW2oUODRLwUxNDXaFKjLGNGCCjDHUkSwl7Jb
	sq3gybKKlSgrFLqLRWVXbuToDDoP2VIoBm0HOHN4cjg0TQX/l6q8SedBbp92SgBtkiw9MzDgfJa
	kqiz8CxBabn9o481XieUF5s8D5kmc7sTCGW5PlAjAdD+p9UF6N3nuTs96RIlkNPvUigX6/xeBZ3
	w3jAEqQHMIrpXQU4yEsOWE/ogBODDLEOoZlc4NdAsf200QYNhubeiJvZ8UkzZAyFfiRJ3quWFJo
	ZC+RL5VGWJmBTAbSBmItMfcCH/uezyRKNAqy+1sQx/Pe5NQ6yCNxEqWzuAxt1Ep2sYuZAQ2okJr
	C2o5otxEnyqAc2nzgzzHS7jfJCRHhSIT5QVwbONXfnno2uNmODCLoTJMtAsIjkshOJizPBLuc3+
	f+s43pVowKX9JXybWnIsak2Kt5Kew0NgMK1Ir2vdnO89TOh+H+HtHC76RSOk/XSyWIgOJQwcjIl
	MRUSqcz1mVziz7ynOTNJL9c1n8D7jBqMiuwdjmXP5jVd/YmToLuA8=
X-Received: by 2002:a05:622a:258e:b0:533:2c5b:d668 with SMTP id d75a77b69052e-55ac8894504mr191284491cf.30.1794840130977;
        Mon, 16 Nov 2026 06:42:10 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d94190sm86302496d6.31.2026.11.16.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:42:10 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] libsemanage: use LF record boundaries when sorting file contexts
Date: Mon, 16 Nov 2026 09:41:50 -0500
Message-ID: <20261116144150.131996-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116144150.131996-1-stephen.smalley.work@gmail.com>
References: <20261116144150.131996-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the getline() record boundaries used by the file-context reader.
Consume any remaining bytes as the last line when no newline is found.
Otherwise an unterminated rule can disappear, or a carriage return in
a final comment can turn commented text into an active labeling rule.

Check the sorted bytes and length for terminated and unterminated rules,
CRLF input, and comments containing non-delimiter bytes. Leave the
netfilter context sorter unchanged.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanage_store.c        |  6 +++-
 libsemanage/tests/test_semanage_store.c | 38 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 2ada797b..067643ad 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2847,7 +2847,11 @@ int semanage_fc_sort(semanage_handle_t *sh, const char *buf, size_t buf_len,
 	/* Parse the char buffer into a semanage_file_context_node_t linked list. */
 	line_buf = buf;
 	buf_remainder = buf_len;
-	while ((line_end = semanage_get_line_end(line_buf, buf_remainder))) {
+	while (buf_remainder) {
+		/* Match the LF-delimited records read by getline(). */
+		line_end = memchr(line_buf, '\n', buf_remainder);
+		if (!line_end)
+			line_end = line_buf + (buf_remainder - 1);
 		line_len = line_end - line_buf + 1;
 		sanity_check = buf_remainder - line_len;
 		buf_remainder = buf_remainder - line_len;
diff --git a/libsemanage/tests/test_semanage_store.c b/libsemanage/tests/test_semanage_store.c
index f6d19332..3275970f 100644
--- a/libsemanage/tests/test_semanage_store.c
+++ b/libsemanage/tests/test_semanage_store.c
@@ -151,10 +151,48 @@ int semanage_store_test_cleanup(void)
 	return 0;
 }
 
+static void test_fc_sort_final_line(void)
+{
+	static const char rule[] = "/probe/private -- u:r:private_t:s0\n";
+	static const char sorted_rule[] =
+		"/probe/private\t--\tu:r:private_t:s0\n";
+	static const struct {
+		const char *input;
+		const char *expected;
+	} cases[] = {
+		{ rule, sorted_rule },
+		{ "/probe/private -- u:r:private_t:s0", sorted_rule },
+		{ "/probe/private -- u:r:private_t:s0\r\n", sorted_rule },
+		{ "# disabled\r/probe/private -- u:r:private_t:s0", "" },
+		{ "# disabled\r/probe/private -- u:r:private_t:s0\r", "" },
+		{ "# disabled\xff/probe/private -- u:r:private_t:s0", "" },
+		{ "# disabled\n/probe/private -- u:r:private_t:s0",
+		  sorted_rule },
+	};
+
+	for (size_t i = 0; i < sizeof(cases) / sizeof(cases[0]); i++) {
+		char *sorted = NULL;
+		size_t len = 0;
+		int rc = semanage_fc_sort(sh, cases[i].input,
+					  strlen(cases[i].input), &sorted,
+					  &len);
+		CU_ASSERT_EQUAL_FATAL(rc, 0);
+		CU_ASSERT_EQUAL(len, strlen(cases[i].expected) + 1);
+		CU_ASSERT_STRING_EQUAL(sorted, cases[i].expected);
+		free(sorted);
+	}
+}
+
 /* Adds all the tests needed for this suite.
  */
 int semanage_store_add_tests(CU_pSuite suite)
 {
+	if (!CU_add_test(suite, "fc_sort_final_line",
+			 test_fc_sort_final_line)) {
+		CU_cleanup_registry();
+		return CU_get_error();
+	}
+
 	if (NULL == CU_add_test(suite, "semanage_store_access_check",
 				test_semanage_store_access_check)) {
 		CU_cleanup_registry();
-- 
2.56.0

