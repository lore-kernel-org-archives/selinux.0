Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FIkhXd0C"
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F33AB
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:00:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so518005066b.1
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306838; x=1702911638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UjZTySHNB2P+vNE/4xggV9jecsPUDSn2PqnFhrTosc=;
        b=FIkhXd0CSrSgRVGWrI/enaACttL5XR4WdzreeqstetBQhsJKfFbuQ3YzGtKoY4xsRb
         Nx+soyItwGOzbo+Q2cH5bI3Z3vPFhENUjWxI9WHAyiC59XXncjK49imt014bNEUP5qy2
         qS2IY+u2CDRg8bUs4+cu0EnweMRHaAuVHpugw1QcnyKAHz7qe/JSJ7kpFrmoGpdUaiSH
         mLkKhsDUM07lBJWdr9ku62qsCBOPTbNGWX9c5ps5KnuqwCQJHKcvBjOfgrgWB9x0aJFw
         4LMyksbc58rYcfPG5S48X1HLDNdr1mQZkGJvw0VhOfAGjDcINAYThB4q9r0WmCiyxqt0
         mwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306838; x=1702911638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UjZTySHNB2P+vNE/4xggV9jecsPUDSn2PqnFhrTosc=;
        b=eT6KYpDwdiiSIm1DpCz+u6JmcJzvER948iA/xnwCsvK1rj3ZpNhQLc8jnpa0vOyGxv
         0LWP+dRnWUswxIVUkWx/Ko94zLswiTUhh+HD/I6oPqbbe7ZCLZzW+kzN524ujCdIUCDR
         vt4pC6psK7cvushlOkTbDSXG/3w2+sYE7kEct45slZ6HZTsFWkeWkmPEqTdJEIqMBWiB
         /1RO31xFM9qDnaWwHZMlmvuX77D/WmZEVLST8oZNn+vbuXutxp3Z6xHZCgCReetSsIQL
         OVWjm1VbJMcxGGdzxcsipwHqCdxwSlXSp1TVvX81MbW9aT5COrWpuCah5QKEXVAOaI9k
         /yWw==
X-Gm-Message-State: AOJu0Yyrk9+gj6IYhUEAwcfVSstmvOEGrdFV/IZIs0H2yvOAnC595jWd
	3sa3/MAIertobk4oJLdLf6soAvosYik=
X-Google-Smtp-Source: AGHT+IEKS70E8YqJLTTz4ILYDq7LqZiwF/KbyrJR6aYFjDHYYRsLSJdAWbven17CPBgilathRiYW6w==
X-Received: by 2002:a17:906:7489:b0:a19:a19a:eab3 with SMTP id e9-20020a170906748900b00a19a19aeab3mr2096975ejl.108.1702306837510;
        Mon, 11 Dec 2023 07:00:37 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a19b7362dcfsm4983559ejc.139.2023.12.11.07.00.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:00:37 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/3] libselinux: always set errno on context translation failure
Date: Mon, 11 Dec 2023 16:00:30 +0100
Message-ID: <20231211150031.127850-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211150031.127850-1-cgzones@googlemail.com>
References: <20231211150031.127850-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow callers to expect errno is set on failure, e.g. other exported
libselinux functions like setexecfilecon(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/setrans_client.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index 920f9032..d7dbc0ca 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -92,8 +92,10 @@ send_request(int fd, uint32_t function, const char *data1, const char *data2)
 	ssize_t count, expected;
 	unsigned int i;
 
-	if (fd < 0)
+	if (fd < 0) {
+		errno = EINVAL;
 		return -1;
+	}
 
 	if (!data1)
 		data1 = "";
@@ -123,8 +125,12 @@ send_request(int fd, uint32_t function, const char *data1, const char *data2)
 
 	while (((count = sendmsg(fd, &msgh, MSG_NOSIGNAL)) < 0)
 	       && (errno == EINTR)) ;
-	if (count < 0 || count != expected)
+	if (count < 0)
+		return -1;
+	if (count != expected) {
+		errno = EBADMSG;
 		return -1;
+	}
 
 	return 0;
 }
@@ -140,8 +146,10 @@ receive_response(int fd, uint32_t function, char **outdata, int32_t * ret_val)
 	struct iovec resp_data;
 	ssize_t count;
 
-	if (fd < 0)
+	if (fd < 0) {
+		errno = EINVAL;
 		return -1;
+	}
 
 	resp_hdr[0].iov_base = &func;
 	resp_hdr[0].iov_len = sizeof(func);
@@ -151,11 +159,17 @@ receive_response(int fd, uint32_t function, char **outdata, int32_t * ret_val)
 	resp_hdr[2].iov_len = sizeof(*ret_val);
 
 	while (((count = readv(fd, resp_hdr, 3)) < 0) && (errno == EINTR)) ;
+	if (count < 0) {
+		return -1;
+	}
+
 	if (count != (sizeof(func) + sizeof(data_size) + sizeof(*ret_val))) {
+		errno = EBADMSG;
 		return -1;
 	}
 
 	if (func != function || !data_size || data_size > MAX_DATA_BUF) {
+		errno = EBADMSG;
 		return -1;
 	}
 
@@ -172,6 +186,8 @@ receive_response(int fd, uint32_t function, char **outdata, int32_t * ret_val)
 	if (count < 0 || (uint32_t) count != data_size ||
 	    data[data_size - 1] != '\0') {
 		free(data);
+		if (count >= 0)
+			errno = EBADMSG;
 		return -1;
 	}
 	*outdata = data;
-- 
2.43.0

