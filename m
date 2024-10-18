Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF462022C1
	for <selinux@vger.kernel.org>; Fri, 18 Oct 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264394; cv=none; b=Xy91+4LJoQ2zGro/tj7tgL2ftuOZpLAab7P59K1P2f+JC4IxyFxSgrxnRCa/xsU0VZcDw0p9xBymiegpGf6/JB9HQLGtwmLwhtS9IHEVuBSS6fsqgvZg9+DZpcBqif6WS5RZW3wLqW2aQE5fAIDbysQad+fZPxVJDmiIk9i5LpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264394; c=relaxed/simple;
	bh=MHg9Sy6d/d/67nxZ+Kku8SAaQBKWHkE9gaN9DN1LiR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPNts6yESVBwLU+VNTrXO1+Eh38TNG0oVtI955Ikbon3Vq/9bcUASmkrQguwZsVqFFZfu9eCTsIuutQtOfrUyV1zW3LrU+ZCTjyoMgiKqeqq8KICsSS2wCwKrvI3yRNVYsD+QArL9NBpN+gGRlQwTT7Nk/+j9tYZ40Kg34yu0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XCX3s/+e; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XCX3s/+e"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729264388;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kgyjG0I2pptuyQUEyBJ6ZbXaVitwir7sqnBvzvnqlQ=;
	b=XCX3s/+e0qED/svO5N+goQcLvXsiGU6y1HkpkKDrdGFl0BQoRS53GqC/7CZJII+h60UkEM
	eLKmcBNY7isHXnQoFOCNMuQVwRIhsOCNCRqGmIFcr2ejuRmvZHIvh1x7HpDmpH6Nqhd6d6
	ECjLB2F7dViHXOyWR6K0CvWdrJ2/6OUOqdh7jOks/7eddYuxWiD1nHwOgbgf04Q9jvXI7I
	1p+KPwUU1cUVTOGCD0BNU6KEMxM7BlMvNNoI9S73l4IKlLPkTcqfvyLY20Fui5X/NtG+v8
	CtubciDsf734hG5uq7m0Y/XWilTyEQlfEmbZI25Y9FrvEWcYwN5YPGUmscWcVQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/4] selinux: free memory in error branch
Date: Fri, 18 Oct 2024 17:12:58 +0200
Message-ID: <20241018151300.445618-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241018151300.445618-1-cgoettsche@seltendoof.de>
References: <20241018151300.445618-1-cgoettsche@seltendoof.de>
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

Free the allocated line if it fails to parse via process_line() for the
X or media database.

Also declare the line_buf parameter of process_line() const, so it is
more obvious it is not modified or free'd.

Reported-by: clang-analyzer
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_media.c | 6 +++---
 libselinux/src/label_x.c     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index bae065c1..d535ef86 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -30,12 +30,12 @@ struct saved_data {
 	spec_t *spec_arr;
 };
 
-static int process_line(const char *path, char *line_buf, int pass,
+static int process_line(const char *path, const char *line_buf, int pass,
 			unsigned lineno, struct selabel_handle *rec)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	int items;
-	char *buf_p;
+	const char *buf_p;
 	char *key, *context;
 
 	buf_p = line_buf;
@@ -145,7 +145,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				goto finish;
 		}
 	}
-	free(line_buf);
 
 	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
 	if (status)
@@ -154,6 +153,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	digest_gen_hash(rec->digest);
 
 finish:
+	free(line_buf);
 	fclose(fp);
 	return status;
 }
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index ddae4f6c..c0d1d475 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -32,12 +32,12 @@ struct saved_data {
 	spec_t *spec_arr;
 };
 
-static int process_line(const char *path, char *line_buf, int pass,
+static int process_line(const char *path, const char *line_buf, int pass,
 			unsigned lineno, struct selabel_handle *rec)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
 	int items;
-	char *buf_p;
+	const char *buf_p;
 	char *type, *key, *context;
 
 	buf_p = line_buf;
@@ -172,7 +172,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 				goto finish;
 		}
 	}
-	free(line_buf);
 
 	status = digest_add_specfile(rec->digest, fp, NULL, sb.st_size, path);
 	if (status)
@@ -181,6 +180,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	digest_gen_hash(rec->digest);
 
 finish:
+	free(line_buf);
 	fclose(fp);
 	return status;
 }
-- 
2.45.2

