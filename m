Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840887;
	b=w7htZI2a1uFnLlg5ONxfw16dRQoAjtnyQyUXvH1/VT3kytUYSlsoDnwBYg2h0s+wmO7l
	 ZFz5bB72X+0UQ8L7aiT/UbXtE3eCiLP9w/JnzFngcjppCR5eGf4YBlSapH+slEaOomS4c
	 iTkbhoRpfGNH91alXwsS4B9/qW2i/lDmlZ18JI0EAW6HjK4VpbcBXm1AZXf/q+n9DUwln
	 2L45rTvrCrmN7AzNsHBY8PDHRvDCP3qpYbMAbAgOpfiammSDG2w0/Ho8KsKXddmYFIUNh
	 tjHjOjpzf7jIlghKExbMhzXBvQkZLQl8jMEuVz8R0C854EBc5T49x2he5RTlWFiaNvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vyxfgyqSCSgv26hGb/4RPkExELeGjQIYx/YX7rznghQ=;
	b=g8/6RudmGAlS1IhBgiHQyDPAFP4xr2Zczk61+VqhgGGJgPh757aT4C4eW428TinnL+Q6
	 2KFIbVnwC/Nsg51DRM9Mmq7nsgspKHHa5n+fueehTs5mI7P+OarS8qpisMD+nh5BIVBGX
	 c9ibq15JMxuCOw5cpQU7V8RuQP898hiNhBKnRELqktN90HLgOp5say2ROVskPioBQp2wj
	 0FJ5Jmmbha4LhwXGxgL3Oy4GNw7vmLPyM3CsunSfe7TYPslOr3rrx+s6BhbqE7jq+4IPS
	 qXH3rCGiAJsdB4qq8xo0LqMm9NgxYP/Thy+CakfF0nB3icl5IOgxGEK9LQwsrpd286w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXdApYyq;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B152606A31C
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 14:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B152606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXdApYyq
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9495e8ae239so353159585a.2
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794840886; x=1795445686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vyxfgyqSCSgv26hGb/4RPkExELeGjQIYx/YX7rznghQ=;
        b=uXdApYyqUInnITQMTPfea2TMN4p9lT6jcYwCZZvz8HXUKMXnHsvEjbIMrCfG45bHku
         KD/QN1vWxhpZ48rrctnUslTkKD9hSPD9lTnNp8kP9UUs5+eyNknUaSnVCEwB9GrY+fG/
         V4PUG4A/wO4PlVJUERqIQdWTOBKmlPrOot6tToubIy8txIxwdpnSqnh/b2cnyaO9WMe8
         8gjFCahjU5ukaHav9UZIif8v1jbghjszeZIT6B/Lji3kMTnXRff8jqMpszRCJk+WvTwS
         x/q4/MH9aY3ydNW/sNIaf15y9sKDLcY7ButQxeIS/JfUk3mmmJnEorsh6L2usVrw4cMJ
         pGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840886; x=1795445686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vyxfgyqSCSgv26hGb/4RPkExELeGjQIYx/YX7rznghQ=;
        b=ERw0PK2t+AXNDJjsp4JxVevvNrj/FYFcjRW4jQovWHPI9KbyQ7LqjkCIhp+a4soDWb
         E4GSo/UdHovIpsRm+D2ejtYZF4+tbBrlmXVGyH4Msyf1FVgrnn6eR32HUAQSMRZCPxqL
         QeH3wbX4sCObQZ2lhmey5L6yhHCTcr7GKBAZvSAnPhXuWUs9Cv6S0qKSto+hNaTVa7jH
         6uaI+gxYQZwA8RbdDI+sYpBRI01MfpaKDFvYMiw+PEyEkGVS3q4lyLPUPVLYeJ0G/K7U
         rg9isqGotmJtqpke8bbbzcR6dSnIiKaHdYRA+5DO/q8FE2vqiMbYHYPAUbrnTH5YyfaK
         VSow==
X-Gm-Message-State: APuU4Z+53ObEB5M+5EXBhJf0s0IbQkZ6b2LP02qBHkV4Jk+bJPcs4Pav
	XX+xdXHmP9cV7GxTbFwXBSy8X2NOMEw/g4pcW8QDfXjC/C+tZamp0/wi3E/YTlXI
X-Gm-Gg: AYBFou1CkHrCgkv51DXuhwy4GsnXN7zWRm+xVpuZ1tD8LfRbiUfm4IjJ40mzwBqXCs4
	lihtv+ZPCtkvrDjL4bgCDZhYZA7eaEHTL/b+4H9s2bny5xesKeHEQDSpRQpGVNaD72TwkVwu31R
	eDcDO5kQ1zupUfAAjHdP2wvRJhHUsM83CPihE2WZpYe11E4jAdGsBBllHZtaTNY2kqS0vqU8Kca
	gU/mcDLE/x/ygPo5Vr2A5tJnzffsQPKzVGqzEQiZidR15wHMFPLvcCDZyiCmaqwLmPyCcGBnvT7
	jwk2TNgscxgvwSC6lv9BJ7TxIqUOk8ul4D7R5jjqk2Nomzd/kIIFHM8+hjjKgCaZTrEojM27xaI
	N3pJpN2t+WcsVhJZAoYaV5ihoQMvMQBgimcSoTfO8rx3RKwazhNakfNKi/9tX85F2mSiz8Y/W+8
	tbN/Ec57rQvqg8C4XDn5qSOgoodKGZUmAy+Wjgz6Iu1hHezrHuaDCqARsWP7hbCwd+6XOK6/IHn
	6UfI3puLAUecSIfU9PlnTUXGRj6NWyfia4On05rRleg88ms5fHT6DEFW42CDPzLZ22oF3/lu7FV
	OmxB9ZuOSAMZsrHKdJ0b5a9yXKyg/r3UW8ZJHinSsSxBX3n8DUyiODBfAMeihmGJIGevHuj7fnP
	frwIzxfuxgqpCa05t4sLrF5cwiCSmNG5htE7xtuqIVqb61PbzwaO4G+cCXgGByyNMTvQ2XrdvEA
	9QHVFuIlsI7L2OYHBZTx4Cw6eeLxIhPeUpMNywBJD7JjTodoWUC3I=
X-Received: by 2002:a05:620a:880a:b0:93f:2c95:658c with SMTP id af79cd13be357-9494bb77a89mr1689274785a.14.1794840885978;
        Mon, 16 Nov 2026 06:54:45 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d952fesm86406956d6.32.2026.11.16.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:54:45 -0800 (PST)
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
Subject: [PATCH v2 2/2] libsemanage: use LF record boundaries when sorting file contexts
Date: Mon, 16 Nov 2026 09:53:53 -0500
Message-ID: <20261116145351.132137-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116145351.132137-2-stephen.smalley.work@gmail.com>
References: <20261116145351.132137-2-stephen.smalley.work@gmail.com>
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

Fixes: ee7e4e1e4e97 ("libsemanage: optionally sort file_contexts.local by specificity")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 adds a Fixes tag.                                                            
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

