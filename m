Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846C37CD33
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222158; cv=none; b=VkudFNwcIGmCCS5oTCP8lZ5LHT0inR5LJxwQLV0Vzydj0xUFdmWPeFctiXlmnQED9WtpWeyyVCLW6TUFooDEuVQLQ6qGiPYTDPOPBS6+G4/gGk+d+s7FkbGu7EZ57M9m+nTDNcl8OBREQqZ3KF465Npf1GfrOnplNnO4PX8Kyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222158; c=relaxed/simple;
	bh=UN4go6g4dk3zujSz2vTSJOJOTzXXyXm89/6XNA5EJCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmVNlT/upXg9s7Srj4JU7wUJLPGsqyP+8Wv7vwPaVvF7TSYt5a29SPFn/7zrEfvV10rjcCbneXxnbpUKl1eRafYR+NzZMuBm435YzF+v82uiWGLsZ1yZ84evjCa+o1lMmhJDQpKAudn0Sa+WzGkoabbOtqtNrkjQ+8xW+tR9mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Kqfsm8tk; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Kqfsm8tk"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222155;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KHPqGiwEMN7O/8j4W898X2iOQJDE/L6kU2AggaSpNs=;
	b=Kqfsm8tkDSZAuDurv5Q8MKP6Dd04b7lgK9cRxuDQVjdhgIaIZbn/Vl10+gTsTA/31ZenHp
	YeyAjf0n4cEGbpA5UjSWINCG4N3gc7qjhykysM0vMt9qnUkNCIj7gfwpR7xkEcerz96Pei
	6NrBUOISYxGrt9adMG+GGxl2N1U85xPoE8x3fEphkHeKW1svJY6ZIZAeW8ELQnCfVCrBNC
	nP11AQjY1d/ipByWmYDl4yX2fMhXvCHzw1n07KMCCNllhzcXK0znGdT+Hv3QR2C5U25Sr7
	rHyjG60KAllIVIfaUzSxOvoiTR99v26wkUE7YEPgj1EJKsCAvIwgvSiUACfkBg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 24/24] libselinux/audit2why: fix double-free and harden boolean handling
Date: Tue, 23 Jun 2026 15:42:13 +0200
Message-ID: <20260623134215.98273-23-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

On the sepol_compute_av_reason() error path check_booleans() freed
`boolean` inline and then again in the post-loop cleanup, since the
break left it non-NULL: a double-free. Drop the inline free and let
the post-loop cleanup own it, matching the other break paths.

Also harden the surrounding code: bound load_booleans() against the
array sized by sepol_bool_count() (passed via the iterator arg),
check the strdup() of result boolean names, and avoid calloc(0) on a
policy with no booleans (which could spuriously raise MemoryError).

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/audit2why.c | 40 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
index 5dc94302..0552f690 100644
--- a/libselinux/src/audit2why.c
+++ b/libselinux/src/audit2why.c
@@ -46,11 +46,16 @@ static struct avc_t *avc = NULL;
 
 static sidtab_t sidtab;
 
-static int load_booleans(const sepol_bool_t *boolean,
-			 void *arg __attribute__((__unused__)))
+static int load_booleans(const sepol_bool_t *boolean, void *arg)
 {
-	struct boolean_t *b = malloc(sizeof(struct boolean_t));
+	const unsigned int *boolmax = arg;
+	struct boolean_t *b;
+
+	/* Guard against writing past the array sized by sepol_bool_count(). */
+	if ((unsigned int)boolcnt >= *boolmax)
+		return -1;
 
+	b = malloc(sizeof(struct boolean_t));
 	if (!b)
 		return -1;
 	b->name = strdup(sepol_bool_get_name(boolean));
@@ -73,7 +78,12 @@ static int check_booleans(struct boolean_t **bools)
 	sepol_bool_key_t *key = NULL;
 	sepol_bool_t *boolean = NULL;
 	int fcnt = 0;
-	int *foundlist = calloc(boolcnt, sizeof(int));
+	int *foundlist;
+
+	if (boolcnt == 0)
+		return 0;
+
+	foundlist = calloc(boolcnt, sizeof(int));
 	if (!foundlist) {
 		PyErr_SetString(PyExc_MemoryError, "Out of memory\n");
 		return fcnt;
@@ -116,7 +126,7 @@ static int check_booleans(struct boolean_t **bools)
 				"Error during access vector computation, skipping...");
 			PyErr_SetString(PyExc_RuntimeError, errormsg);
 
-			sepol_bool_free(boolean);
+			/* boolean is freed by the post-loop cleanup */
 			break;
 		} else {
 			if (!reason) {
@@ -158,6 +168,11 @@ static int check_booleans(struct boolean_t **bools)
 		for (i = 0; i < fcnt; i++) {
 			int ctr = foundlist[i];
 			b[i].name = strdup(boollist[ctr]->name);
+			if (!b[i].name) {
+				PyErr_SetString(PyExc_MemoryError,
+						"Out of memory\n");
+				break;
+			}
 			b[i].active = !boollist[ctr]->active;
 		}
 	}
@@ -274,13 +289,16 @@ static int __policy_init(const char *init_path)
 		goto err;
 	}
 
-	boollist = calloc(cnt, sizeof(*boollist));
-	if (!boollist) {
-		PyErr_SetString(PyExc_MemoryError, "Out of memory\n");
-		goto err;
-	}
+	if (cnt > 0) {
+		boollist = calloc(cnt, sizeof(*boollist));
+		if (!boollist) {
+			PyErr_SetString(PyExc_MemoryError, "Out of memory\n");
+			goto err;
+		}
 
-	sepol_bool_iterate(avc->handle, avc->policydb, load_booleans, NULL);
+		sepol_bool_iterate(avc->handle, avc->policydb, load_booleans,
+				   &cnt);
+	}
 
 	/* Initialize the sidtab for subsequent use by sepol_context_to_sid
 	   and sepol_compute_av_reason. */
-- 
2.53.0

