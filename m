Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F7101C8
	for <selinux@vger.kernel.org>; Thu, 22 Aug 2024 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287093; cv=none; b=LRyilDnVg0duuL8csOU+ugBuUtdEBrogh0HmA06d+eBqGICYq5cmy6IyPd0KU+QWN1JpGJsO1qcGAT8YhaCANcQdewEKfm8eYo4nm1Oz8DQaUxrX0r8Eg1fLpqK+fU01NHmVJB5tU4CNPHY6TlDk5rK0Z9mkP5cwJPUPQdztNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287093; c=relaxed/simple;
	bh=HTFBcUwfrgVZ1G0Wt9lteHAvCIrExCdAYvi9Reg4dyY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kCGqrJjdeB6Isi7L4ykByOxt/MXVL/WtTGTb18TmGEGYfVOFJ2EtpNhsKeITNBSUr85fgYskF2YVHRDWcvIuIOxg+HaTKKN+i34Fmucy/I4zrZ5L85SE6dtXzmwPs04x7eBqVR3eONLqF0vvFaAQfz/KneS0nPki4s15pid7EsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6HEEBZ9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6HEEBZ9"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6af4700a594so6621507b3.0
        for <selinux@vger.kernel.org>; Wed, 21 Aug 2024 17:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724287091; x=1724891891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEflHXtA+5PsiYpOTAkPvnA4WKakQYg6REX03fMAbjU=;
        b=c6HEEBZ96D00z/oreBSwB8aktIbFW3enISjOIBaT/eRQagR+VrVu+bZxnVPqrDOtsn
         6Wy6Zn2c5Fg/uDHjXfkYAsdhDEljhiyc46iLxTAqr/yiiYZ0VjrLFheQ6UVyJhzQfT5i
         Czsy7pqOESPtGCBmz61oevywyBCHcmotEqiFyuItEfhyESt5FI8wHT1asnKqKpIqOcnW
         28iWw5xqlNP5CHVpVV9re0SSad/BgE/qO8bajg+15tX57FJGYhfvTRlpBnYVdUJxL3q6
         VPjB2VsaUR09UShOsztzDS81RPFw909WlpqQYauwMAnt3aoDfZpADX3ha3WTBDDTUUy3
         6Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724287091; x=1724891891;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEflHXtA+5PsiYpOTAkPvnA4WKakQYg6REX03fMAbjU=;
        b=TsIf83gsgmixwVFardgw0tgbR3dlf03M+oCLIPahnxn4iZVw0e7J9gJqfgnLHUjKr4
         JLq3OG4YWkdci5dt2f/+J3ThxLV+uHypoYLRt/3CU1CLwcLEXp82vJBe1gemw+xgawcA
         oJt6oxP4c7aTYbnhZ+/IFH+Hbt9RFvVAY5LcUxl/AAuD+Lxej4j+a44/iO0Zk6cYNgYE
         GEYT4DCUTLL0k+BATT/qk43oo7dsodPh2SGrVU/SDLdWyINSPRDVr/g4lU0XIMlkYUVP
         Zcqmw3npsQLKR8milK3FGUfgB+EMkvqWkwt1ID4s2zkHEexU5JasEfrlE1sb8L9/b/Yj
         uFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKc89yrqkwVTvElLyw7EnLlsZXabq4k7XnzwVi0GRw/HFxXsxMJMlREj/gDMJvtB49X5UaXWNq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp83FhF3yhTJ/sLjoXpSws5SHSw04RLt55H9DRyJ9PEcw1akHH
	zIqazae/uW7YdGNA/xG0R3bopEn5sYR8AxehRS9sZoUc90YmZkxTHk/L1+HqI3L4BcS1XPEXfw=
	=
X-Google-Smtp-Source: AGHT+IG7B0RNjcFY6oZJ7T3CMpXG0CHy8oMUhF6tkWNeGPyroh6H9MDhXHjLcDThKxfwd5lvmAol5o+grQ==
X-Received: from tweek-syd.c.googlers.com ([fda3:e722:ac3:cc00:b7:3870:c0a8:26])
 (user=tweek job=sendgmr) by 2002:a05:690c:4988:b0:690:8ad7:55f9 with SMTP id
 00721157ae682-6c09b912365mr1991267b3.2.1724287091122; Wed, 21 Aug 2024
 17:38:11 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:37:55 +1000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240822003757.1998016-1-tweek@google.com>
Subject: [PATCH 1/3] libsepol: Rename ioctl xperms structures and functions
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: paul@paul-moore.com
Cc: brambonne@google.com, jeffv@google.com, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The ioctl extended permission structures and functions can be reused for
other extended permissions. Use the more generic term "xperm" instead of
"ioctl".

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 checkpolicy/policy_define.c | 72 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 4931f23d..4f6b2266 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1874,27 +1874,27 @@ avrule_t *define_cond_pol_list(avrule_t * avlist, a=
vrule_t * sl)
 	return sl;
 }
=20
-typedef struct av_ioctl_range {
+typedef struct av_xperm_range {
 	uint16_t low;
 	uint16_t high;
-} av_ioctl_range_t;
+} av_xperm_range_t;
=20
-struct av_ioctl_range_list {
+struct av_xperm_range_list {
 	uint8_t omit;
-	av_ioctl_range_t range;
-	struct av_ioctl_range_list *next;
+	av_xperm_range_t range;
+	struct av_xperm_range_list *next;
 };
=20
-static int avrule_sort_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_sort_xperms(struct av_xperm_range_list **rangehead)
 {
-	struct av_ioctl_range_list *r, *r2, *sorted, *sortedhead =3D NULL;
+	struct av_xperm_range_list *r, *r2, *sorted, *sortedhead =3D NULL;
=20
 	/* order list by range.low */
 	for (r =3D *rangehead; r !=3D NULL; r =3D r->next) {
-		sorted =3D malloc(sizeof(struct av_ioctl_range_list));
+		sorted =3D malloc(sizeof(struct av_xperm_range_list));
 		if (sorted =3D=3D NULL)
 			goto error;
-		memcpy(sorted, r, sizeof(struct av_ioctl_range_list));
+		memcpy(sorted, r, sizeof(struct av_xperm_range_list));
 		sorted->next =3D NULL;
 		if (sortedhead =3D=3D NULL) {
 			sortedhead =3D sorted;
@@ -1933,9 +1933,9 @@ error:
 	return -1;
 }
=20
-static void avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
+static void avrule_merge_xperms(struct av_xperm_range_list **rangehead)
 {
-	struct av_ioctl_range_list *r, *tmp;
+	struct av_xperm_range_list *r, *tmp;
 	r =3D *rangehead;
 	while (r !=3D NULL && r->next !=3D NULL) {
 		/* merge */
@@ -1952,15 +1952,15 @@ static void avrule_merge_ioctls(struct av_ioctl_ran=
ge_list **rangehead)
 	}
 }
=20
-static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_read_xperm_ranges(struct av_xperm_range_list **rangehead=
)
 {
 	char *id;
-	struct av_ioctl_range_list *rnew, *r =3D NULL;
+	struct av_xperm_range_list *rnew, *r =3D NULL;
 	uint8_t omit =3D 0;
=20
 	*rangehead =3D NULL;
=20
-	/* read in all the ioctl commands */
+	/* read in all the ioctl/netlink commands */
 	while ((id =3D queue_remove(id_queue))) {
 		if (strcmp(id,"~") =3D=3D 0) {
 			/* these are values to be omitted */
@@ -1979,7 +1979,7 @@ static int avrule_read_ioctls(struct av_ioctl_range_l=
ist **rangehead)
 			free(id);
 		} else {
 			/* read in new low value */
-			rnew =3D malloc(sizeof(struct av_ioctl_range_list));
+			rnew =3D malloc(sizeof(struct av_xperm_range_list));
 			if (rnew =3D=3D NULL)
 				goto error;
 			rnew->next =3D NULL;
@@ -2006,11 +2006,11 @@ error:
 }
=20
 /* flip to included ranges */
-static int avrule_omit_ioctls(struct av_ioctl_range_list **rangehead)
+static int avrule_omit_xperms(struct av_xperm_range_list **rangehead)
 {
-	struct av_ioctl_range_list *rnew, *r, *newhead, *r2;
+	struct av_xperm_range_list *rnew, *r, *newhead, *r2;
=20
-	rnew =3D calloc(1, sizeof(struct av_ioctl_range_list));
+	rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
 	if (!rnew)
 		goto error;
=20
@@ -2028,7 +2028,7 @@ static int avrule_omit_ioctls(struct av_ioctl_range_l=
ist **rangehead)
=20
 	while (r) {
 		r2->range.high =3D r->range.low - 1;
-		rnew =3D calloc(1, sizeof(struct av_ioctl_range_list));
+		rnew =3D calloc(1, sizeof(struct av_xperm_range_list));
 		if (!rnew)
 			goto error;
 		r2->next =3D rnew;
@@ -2054,26 +2054,26 @@ error:
 	return -1;
 }
=20
-static int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
+static int avrule_xperm_ranges(struct av_xperm_range_list **rangelist)
 {
-	struct av_ioctl_range_list *rangehead;
+	struct av_xperm_range_list *rangehead;
 	uint8_t omit;
=20
 	/* read in ranges to include and omit */
-	if (avrule_read_ioctls(&rangehead))
+	if (avrule_read_xperm_ranges(&rangehead))
 		return -1;
 	if (rangehead =3D=3D NULL) {
-		yyerror("error processing ioctl commands");
+		yyerror("error processing ioctl/netlink commands");
 		return -1;
 	}
 	omit =3D rangehead->omit;
-	/* sort and merge the input ioctls */
-	if (avrule_sort_ioctls(&rangehead))
+	/* sort and merge the input ranges */
+	if (avrule_sort_xperms(&rangehead))
 		return -1;
-	avrule_merge_ioctls(&rangehead);
+	avrule_merge_xperms(&rangehead);
 	/* flip ranges if these are omitted */
 	if (omit) {
-		if (avrule_omit_ioctls(&rangehead))
+		if (avrule_omit_xperms(&rangehead))
 			return -1;
 	}
=20
@@ -2261,11 +2261,11 @@ static int avrule_xperms_used(const av_extended_per=
ms_t *xperms)
 #define IOC_DRIV(x) ((x) >> 8)
 #define IOC_FUNC(x) ((x) & 0xff)
 #define IOC_CMD(driver, func) (((driver) << 8) + (func))
-static int avrule_ioctl_partialdriver(struct av_ioctl_range_list *rangelis=
t,
+static int avrule_xperm_partialdriver(struct av_xperm_range_list *rangelis=
t,
 				av_extended_perms_t *complete_driver,
 				av_extended_perms_t **extended_perms)
 {
-	struct av_ioctl_range_list *r;
+	struct av_xperm_range_list *r;
 	av_extended_perms_t *xperms;
 	uint8_t low, high;
=20
@@ -2300,10 +2300,10 @@ static int avrule_ioctl_partialdriver(struct av_ioc=
tl_range_list *rangelist,
=20
 }
=20
-static int avrule_ioctl_completedriver(struct av_ioctl_range_list *rangeli=
st,
+static int avrule_ioctl_completedriver(struct av_xperm_range_list *rangeli=
st,
 			av_extended_perms_t **extended_perms)
 {
-	struct av_ioctl_range_list *r;
+	struct av_xperm_range_list *r;
 	av_extended_perms_t *xperms;
 	uint16_t low, high;
 	xperms =3D calloc(1, sizeof(av_extended_perms_t));
@@ -2342,10 +2342,10 @@ static int avrule_ioctl_completedriver(struct av_io=
ctl_range_list *rangelist,
 	return 0;
 }
=20
-static int avrule_ioctl_func(struct av_ioctl_range_list *rangelist,
+static int avrule_ioctl_func(struct av_xperm_range_list *rangelist,
 		av_extended_perms_t **extended_perms, unsigned int driver)
 {
-	struct av_ioctl_range_list *r;
+	struct av_xperm_range_list *r;
 	av_extended_perms_t *xperms;
 	uint16_t low, high;
=20
@@ -2457,13 +2457,13 @@ static int avrule_cpy(avrule_t *dest, const avrule_=
t *src)
 static int define_te_avtab_ioctl(const avrule_t *avrule_template)
 {
 	avrule_t *avrule;
-	struct av_ioctl_range_list *rangelist, *r;
+	struct av_xperm_range_list *rangelist, *r;
 	av_extended_perms_t *complete_driver, *partial_driver, *xperms;
 	unsigned int i;
=20
=20
 	/* organize ioctl ranges */
-	if (avrule_ioctl_ranges(&rangelist))
+	if (avrule_xperm_ranges(&rangelist))
 		return -1;
=20
 	/* create rule for ioctl driver types that are entirely enabled */
@@ -2482,7 +2482,7 @@ static int define_te_avtab_ioctl(const avrule_t *avru=
le_template)
 	}
=20
 	/* flag ioctl driver codes that are partially enabled */
-	if (avrule_ioctl_partialdriver(rangelist, complete_driver, &partial_drive=
r))
+	if (avrule_xperm_partialdriver(rangelist, complete_driver, &partial_drive=
r))
 		return -1;
=20
 	if (!partial_driver || !avrule_xperms_used(partial_driver))
--=20
2.46.0.184.g6999bdac58-goog

