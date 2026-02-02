Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8B36B059
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042256; cv=none; b=I3NbUBAZ6p42q890trPt5B+LYiIEeEXj+gKj4qRaDs8KR023/TFdaXdiTmDTc1b47jf/cViiRrOQ+rUDA6KAzVpFh5dbgb7qqcZoD2kkMLZhleMce9S+28WXdcu0CTRMMEWpYyU4SKNLaGlRzti9sFEr75muLfyrj8cuUPDAeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042256; c=relaxed/simple;
	bh=v32sm4QlwI+T+6jyg2y2arnzizoRXpn2PiBfN3auIig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLotvHMlmEWWbSX225I4hUpf8PgzEX4zfT00ORUbsOzFZopZNJv7LjZ8w7GJhycke3x6C98QSvleSy7qiHgk5LehWG2mISThMPLb3BVs+GgX5VM526qQbeNo5a3pbFBeXX+B0oat3DwcwM5T4pynklcRRnY9t55Xm5QqW9ZyFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=EOdQoqvm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="EOdQoqvm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1770042253;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DujFP/wScHw+DOSzw5PhH3QkFly5nG+iZskWDPaTsG8=;
	b=EOdQoqvmA7bB2lqMd2XEOEo272Pa5VKoW9xbirK0+dGiaSxOJvBqzIt6N4KMZN/lNlxNXj
	MeGKYMXw3iaRdMtOj81nUcHWwdDafhDq2UExo2gUDHX1V3l6pQ3dUpnqqeAFgmPId129p8
	COMos9vSw9FR/ETLMzGyeuB7r0mJiJ0c5oAeb+Pxr/g9XUNaPgddYr5xFbbg5p/Fht6kZe
	M1GtJm9AwIXyyEYtUtrZUoRlXZCAVIrpvIRsJbVLaXqjwHwQqLdOVVgWqH8lqPVslwoHau
	gGXFDCpA60sf/QCmJp0f7OB5krijdJ3aTP7s66gFfPMoOrLjJ+e6MOM9jafcVw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5/8] libselinux: hide regex_data_create()
Date: Mon,  2 Feb 2026 15:24:00 +0100
Message-ID: <20260202142404.92347-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260202142404.92347-1-cgoettsche@seltendoof.de>
References: <20260202142404.92347-1-cgoettsche@seltendoof.de>
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

The function regex_data_create() is only used inside of regex.c, thus do
not expose it in the header file regex.h.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/regex.c | 10 ++++++++--
 libselinux/src/regex.h |  5 -----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index df087367..4ae7c561 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -29,6 +29,12 @@
 
 #endif
 
+/**
+ * This constructor function allocates a buffer for a regex_data structure.
+ * The buffer is being initialized with zeroes.
+ */
+static struct regex_data *regex_data_create(void);
+
 #ifdef USE_PCRE2
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static char arch_string_buffer[32];
@@ -292,7 +298,7 @@ int regex_cmp(const struct regex_data *regex1, const struct regex_data *regex2)
 	return SELABEL_EQUAL;
 }
 
-struct regex_data *regex_data_create(void)
+static struct regex_data *regex_data_create(void)
 {
 	struct regex_data *regex_data =
 		(struct regex_data *)calloc(1, sizeof(struct regex_data));
@@ -539,7 +545,7 @@ int regex_cmp(const struct regex_data *regex1, const struct regex_data *regex2)
 	return SELABEL_EQUAL;
 }
 
-struct regex_data *regex_data_create(void)
+static struct regex_data *regex_data_create(void)
 {
 	return (struct regex_data *)calloc(1, sizeof(struct regex_data));
 }
diff --git a/libselinux/src/regex.h b/libselinux/src/regex.h
index d449b1e7..0bff344d 100644
--- a/libselinux/src/regex.h
+++ b/libselinux/src/regex.h
@@ -55,11 +55,6 @@ char const *regex_arch_string(void) ;
  * It may return NULL on error.
  */
 char const *regex_version(void) ;
-/**
- * This constructor function allocates a buffer for a regex_data structure.
- * The buffer is being initialized with zeroes.
- */
-struct regex_data *regex_data_create(void) ;
 /**
  * This complementary destructor function frees the a given regex_data buffer.
  * It also frees any non NULL member pointers with the appropriate pcreX_X_free
-- 
2.51.0

