Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AE43DA39
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577779; cv=none; b=bDPrkdKIVgZ5HtPcK6D3nXZDFnGiPoPDpCED0Ud2omvt+zJia9JtXYJrsLTls7W0xYpl+R4EKnhGCBLn3DN+CkzqkwCMz39elwcrkMKN5v3ckrwGp/jPfPAvxheFxmcsR26AlDVBsZDI4Dz47nrKlvM8yujq/1AdW0sYA3om7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577779; c=relaxed/simple;
	bh=JMGa2CVzUG0WqR+R3BbsrkkpMxk9uqElV9Gx8VAo9rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lh89c278gRD2nH87IcXcFMLNU0sKnoCx2bG9oDNP6FD19II3xD+EWqkYAJEWFeb9uOqhEAh36GiIcZ2sWKDJs17gVSqvlf6sd/+2bR7Q5UB6ASvX/gDiqWlRxtlT8OsF433+NGEZzuiiCrs68gOB/wNJPviZUnJp+iDJRqbN1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcTvyLrB; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcTvyLrB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-915767ea2d0so66804785a.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577776; x=1781182576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjNBVwQuDrhVT6pZGGrhhWqx82KnVXuQAGHdRnxTfT0=;
        b=jcTvyLrB13KV9ZBsbzy4zJGFYqod2ehiO60JGauBGzOtGc4FXxZeVT9LO1e6LDciF1
         hBFPa3hum9+pCYxsvAvkyOGHcr2fiXWQnDE8MCcIiN3vsCX2CTz/P/X1AkA3sxNnRhIh
         pUz7H+gFYAzyBOgGefGurYzRhD8jYKf+ORS/q3PbqOkFZLqPNbIWAvRSwY5FjZiBi+G3
         aOmXKnmFyaWBrOYGewQ4/8Pj9Smp9VUP2hGxGWKUf2IfDShiuW5NknRwBGPUQTL1Viob
         PO88cz1Nqj8iCB3h9Gp+onU0c4jGcTqoDmI6ycZT4WMUXzPj4NluEvZAziYejUaJAm3G
         /dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577776; x=1781182576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjNBVwQuDrhVT6pZGGrhhWqx82KnVXuQAGHdRnxTfT0=;
        b=Rpa7TDvkPzHkv1V84cNDj0JZgZETwLUhM0aCMl7ZQV/CivLFCnP1tZLm+tThw6aIrr
         SAKnRy2FxevlsqaEH51PY5+RPX5fEO4gZkExwXCtFN5SpLd7JFKtWdCvorafH4F1i5Le
         Gyymq2Vkr+tQP69vhoAPiCzYH7odQA2JUYYz2SPrnFlLOSCKvuveUedAyi0Gia9dpS3+
         P2OVZa5L7JH0U5LusQB1yA7yocUouWf/D85vOAF3hvBgdnWC2l9paf05Ly5kGZ5ZaMsb
         jvCSV3UsUo9w6uEN9+0SPvz2LAL7BMhyfRnriJZs4hFLn7iefCmxF32jyWFJwkXscVG9
         8wAQ==
X-Gm-Message-State: AOJu0YwLl0myYFFlE1kmaHJzUvk9K9lvxaWdKY2PKLBtFvx0MzIdSeE9
	9Xt35XEEkYiXK38nGU7NKxT89MgD9HMRuxxUlhAlaP/CEZ7SHEJPbZBNg1hi3A==
X-Gm-Gg: Acq92OEUsrcLm9FhTGacgCoDFf49s3+sJo8twslHxhK3I3Tjl5MJ61t8dJ6OXU/sMpV
	iS1X+ugs4FGkxMSHuPgJHCQ0BuTvPk9KOkw1dIB9B+uGN7G51kjLw7BK7D7lyXsGuEYhRna5B8V
	Lw4Q4gSbH+kXyVfAwkeRYonqsMYAQ5SlrVJ3EXN55h5EMEcUYmykeurCW2SMHylKRun/YLhagEK
	RG59TJG0cCeVwtXGaIgv5/F0W1+UCMEXHYBON+D98ktU5qkaKRBuI0ns2IduU7BMw+QJDn59vis
	M1zbrwzuVyfzQbf1orYG8+HUixSzG3A4jkNTwjmcpYeLAcGFI4M96uAsrjejKAUuVc0l7nYKk6B
	68peS4b8by2/QjEnF3//9cs1ujawr5FG41ICHda5WYoNCzrvnfGYEfkxtWzoaFSe3N1IEdJoiUl
	ENrPcoil1+w1RuWV0Ath8urXDLGcPIz1VoYtWYPKhr+h0/nufrE6VyZGYo4FbIjbTuFFpU38Xzp
	Og0xTLB9uld5q9CVMZVk3t5qww1xZvjxXFqzw==
X-Received: by 2002:a05:620a:471f:b0:915:9e84:85d9 with SMTP id af79cd13be357-9159e848e4emr343554985a.18.1780577774900;
        Thu, 04 Jun 2026 05:56:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm598297785a.18.2026.06.04.05.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:56:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/6] mcstrans: fix UAF on SIGHUP
Date: Thu,  4 Jun 2026 08:55:52 -0400
Message-ID: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SIGHUP, mcstransd calls finish_context_translations() followed by
init_translations() which calls read_translations() again to reload
the configuration via process_trans() on each line. However,
process_trans() acts on function-scope static variables that are not
reset currently, so they still refer to the old, freed state. Move the
static variables to file-scope and reset them in
finish_context_translations().

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index 81e73697..b1b73e40 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -749,6 +749,11 @@ err:
 	return -1;
 }
 
+static domain_t *parser_domain;
+static word_group_t *group;
+static int base_classification;
+static int lineno = 0;
+
 static int read_translations(const char *filename);
 
 /* Process line from translation file.
@@ -757,10 +762,6 @@ static int read_translations(const char *filename);
  */
 static int process_trans(char *buffer)
 {
-	static domain_t *domain;
-	static word_group_t *group;
-	static int base_classification;
-	static int lineno = 0;
 	char op = '\0';
 
 	lineno++;
@@ -814,16 +815,16 @@ static int process_trans(char *buffer)
 	}
 
 	if (!strcmp(raw, "Domain")) {
-		domain = create_domain(tok);
-		if (!domain)
+		parser_domain = create_domain(tok);
+		if (!parser_domain)
 			return -1;
 		group = NULL;
 		return 0;
 	}
 
-	if (!domain) {
-		domain = create_domain("Default");
-		if (!domain)
+	if (!parser_domain) {
+		parser_domain = create_domain("Default");
+		if (!parser_domain)
 			return -1;
 		group = NULL;
 	}
@@ -855,7 +856,7 @@ static int process_trans(char *buffer)
 	} else if (!strcmp(raw, "Base")) {
 		base_classification = 1;
 	} else if (!strcmp(raw, "ModifierGroup")) {
-		group = create_group(&domain->groups, tok);
+		group = create_group(&parser_domain->groups, tok);
 		if (!group)
 			return -1;
 		base_classification = 0;
@@ -887,14 +888,15 @@ static int process_trans(char *buffer)
 		}
 	} else {
 		if (base_classification) {
-			if (add_base_classification(domain, raw, tok) < 0) {
+			if (add_base_classification(parser_domain, raw, tok) <
+			    0) {
 				syslog(LOG_ERR,
 				       "unable to add base_classification on line %d",
 				       lineno);
 				return -1;
 			}
 		}
-		if (add_cache(domain, raw, tok) < 0)
+		if (add_cache(parser_domain, raw, tok) < 0)
 			return -1;
 	}
 	return 0;
@@ -2169,6 +2171,11 @@ int untrans_context(const char *incon, char **rcon)
 
 void finish_context_translations(void)
 {
+	parser_domain = NULL;
+	group = NULL;
+	base_classification = 0;
+	lineno = 0;
+
 	while (domains) {
 		domain_t *next = domains->next;
 		destroy_domain(domains);
-- 
2.54.0

