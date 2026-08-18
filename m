Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09344346E43
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081043; cv=none; b=aJ3cy+DaCXGzVqZzo0MZVVnzdtIpLAuYHqYQb8XQnEMv2M1PpxY885zyuoS46kDrrQMJ7l8/lPPZxL7ej8NvkibHueybl+EdNFKpoGWhFllcDyinNMuywpRcccdL+9rp0CxIdMDW1R27qViLzFtTiVCMx8cYr3UITINPjAz8PsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081043; c=relaxed/simple;
	bh=37LFf9GXnwV0pOzRD4gt9hhQE3blKzRczjRksRa85BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQl3qRDY7pHW9nM6caSOkLQqjDv9EZIbj0eBdNdmjGE7dDeyoHtUquqCKopF4os+mBYXnjMBhBvRqg+wI+tdPxDn1NFrfE8KGM07HH6OjASo5ViodH+g1mlu5kOG416rAfpiYqIuGEK5S4WOQGbv65vAkzdicfLwNh336rQ/I5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OphzmeZL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OphzmeZL"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52d7a3defe8so1393901cf.0
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787081041; x=1787685841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFXYDLTNJO1jLxsiZBfc/vX1r+vnUg9g9B6MYM5wfFk=;
        b=OphzmeZLFQnj3tIAY61fpvOWvVmdtWLQctiecEGwO4dJhK1LhJOwcCHd8oqxrfMme9
         Pbq2AhjtnKurKZswRrcv8Swq7A7YI1cz7QdyKHquFJ6K7Zy983GWKy1PEJreaOFRd9bN
         nJWe6/n3p+csRofCgGJR7g+uZdBx6X5vxfa8zrr1s3xHknx85q27FNat54jSuRnV6kHC
         +8noZGce83YITbNUQ9xKcgWswP10EY1m4B20Uv3TlDCnW+16hriJ3UrhsOeq1YQ8KW43
         cvEYVtjDpOio+vuF6rUQpkOKuTcaGEBIPAuOPAuk7NpBMZnEWo0PQMOpg6jCw1Dl3j4w
         FZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787081041; x=1787685841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IFXYDLTNJO1jLxsiZBfc/vX1r+vnUg9g9B6MYM5wfFk=;
        b=UFqd3PMwewdOND42couewF9rr7eMiuK+RTM2GuWPRKiLcgHt4mbt/OtslKo5lFczpH
         O0tmNNUSLelJ9I6MXx9s5ChgjTLgl2UpJWHIsA97bloyUsebCZhcT9HSYxOjBup8PGdk
         g0LDrp8GA4ftJycZvn5GNjfsw3LqP7FMPjHH9HOAXYM137Uk+Xnjb531OE535wEmGgJS
         R+iNrTgMKGNG9S1l6CCnHNi2FZM+3dBltMKLKrPMyYE3XZycg3jCg/CjuucPgBnEo3RX
         ZtPzp2VUIXv4XmKDc8/bY+dBUxxqAqAEhtZlnouj65eXMDGm5GOtpezXX24ffmmB/jAq
         25wQ==
X-Gm-Message-State: AOJu0YzYowvSQiMVb9xptrRP/TBeKzb/Y+KRoReQjk87Wr7mwo+2nUOL
	hfCXENvUn8Gqx3SmgwIEF7nEc/WCoF4UaJxgOlo26vaifLte01d9vJXGlqhFMw==
X-Gm-Gg: AR+sD13SRYQlhW5+ER2PoVflTNI5KViwNi09f8rnvzKSu5D/RmJZWK/QI+E3XEQnf+K
	IsHHY5J908HKKmElDNoBTq/YgmcWLi4GfCLjsbopSqnBxwPSpnD653Kvtpfxt52HEoctMbfl4cJ
	Qtf4lBsas03yBtecHp1+PdrMMckRnRM5Nr2yA3tM/1nU2t4iAzScG+NLqEvseZmpX531epzqd5n
	huZ0M+U3bjQ1uOscWELz642yS2qcQCJbC9TfavmzEoenIitNfOn9ihNu9hqctdx4M0M6p8+W9V9
	uGkW2PeFG895+66dr6U+FCdc7+D4qZ0MaS/FA2gQHbXf4/N3Gjn7CiwZNeAObq3rPVNdEbrQggH
	EcLNv3whFG3hKjozqZFeOYqlRzN369AAZ2oPYF9FtCqw9I8CTsvur5Sz+wjKKy9S7BSmhaTgfMt
	4EK27bGIAx7y2MBNn/NydlMFcMh7iToFzCGjqQjEgx3cXY+0KJA/pxOeq+KA==
X-Received: by 2002:a05:622a:1805:b0:51c:1132:c80d with SMTP id d75a77b69052e-52dd325fbfamr2916641cf.28.1787081040594;
        Tue, 18 Aug 2026 12:24:00 -0700 (PDT)
Received: from z840.flat.mawenzy.com ([2603:6000:acf0:3410::10d7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db62175b1sm48784351cf.19.2026.08.18.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:23:59 -0700 (PDT)
From: jboero <boeroboy@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	cgzones@googlemail.com,
	Johnny Boero <boeroboy@gmail.com>
Subject: [PATCH v1 1/3] policycoreutils/setfiles: reject invalid -T arguments
Date: Tue, 18 Aug 2026 14:23:31 -0500
Message-ID: <20260818192340.119297-2-boeroboy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818192340.119297-1-boeroboy@gmail.com>
References: <20260818192340.119297-1-boeroboy@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johnny Boero <boeroboy@gmail.com>

The -T option is parsed with strtoull(3), which happily accepts leading
whitespace, a sign and, in particular, negative values: "-T -1" wraps
around to SIZE_MAX threads, which then fails a calloc(3) of SIZE_MAX
pthread_t entries rather than reporting a usage error.

Factor the parsing out into a helper and reject anything that is not a
plain decimal thread count.

Signed-off-by: Johnny Boero <boeroboy@gmail.com>
---
 policycoreutils/setfiles/setfiles.c | 31 ++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index da5d2024..c86cc0c9 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -64,6 +64,32 @@ static void set_rootpath(const char *arg)
 	}
 }
 
+/*
+ * Parse a thread count, as given by the -T option.  Returns -1 on invalid
+ * input.
+ */
+static int parse_nthreads(const char *str, size_t *nthreads)
+{
+	unsigned long long value;
+	char *endptr;
+
+	/*
+	 * Reject anything strtoull(3) would silently accept but that is not
+	 * a plain thread count, most notably negative values, which would
+	 * otherwise wrap around to a huge number of threads.
+	 */
+	if (!isdigit((unsigned char)*str))
+		return -1;
+
+	errno = 0;
+	value = strtoull(str, &endptr, 10);
+	if (errno != 0 || *endptr != '\0' || value > SIZE_MAX)
+		return -1;
+
+	*nthreads = value;
+	return 0;
+}
+
 static int canoncon(char **contextp)
 {
 	char *context = *contextp, *tmpcon;
@@ -141,7 +167,7 @@ int main(int argc, char **argv)
 	int opt, i = 0;
 	const char *input_filename = NULL;
 	int use_input_file = 0;
-	char *buf = NULL, *endptr;
+	char *buf = NULL;
 	size_t buf_len = 0, nthreads = 1;
 	const char *base;
 	int errors = 0;
@@ -376,8 +402,7 @@ int main(int argc, char **argv)
 			r_opts.xdev = SELINUX_RESTORECON_XDEV;
 			break;
 		case 'T':
-			nthreads = strtoull(optarg, &endptr, 10);
-			if (*optarg == '\0' || *endptr != '\0')
+			if (parse_nthreads(optarg, &nthreads) < 0)
 				usage(argv[0]);
 			break;
 		case 'A':
-- 
2.55.0

