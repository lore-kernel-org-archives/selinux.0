Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662B28CF77
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070341; cv=none; b=FQxP9z7xnZL602IRrVX18CBuqMd2RgWjm8aa09JIs9f1TpRLiawfsBrgt2Cn1avO0wnfKdp14b77SAe+6lEnQiEcaMbfqwTKnUmMA5Ru/R7w/piXDTaxaZsu6JGdiuHkD2dmbJQDO1/9Q4+EkoqBsolsJxNfXBNDelDyA7Eos7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070341; c=relaxed/simple;
	bh=dyyd5QyTCjSDYUmHDgY+Yv/B8R7+f1Q8w8xNLiFajYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFkOu3p+jYT7ddspaFkwVw3jY8yf22wCoJfTi4wXXtn8enZ+wHAiT+2PhIZ50HsckAI5olGp3qkQ8aLPCmjV68vCqaPYjF6puym5sp0NxJMWxM+u2egPMarMy7CkkGX8UFS4W2fTQhy9zZS2tLNuqBhh3Umu+sypnnWrxMKqXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvlkfj0z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvlkfj0z"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so18490665e9.0
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 10:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754070337; x=1754675137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8Xgc7wAh3AQD4jw99aJvo3qk4m68HjFouMy1TWzTKI=;
        b=Vvlkfj0zojLq1CUepjM0pYasCU7jpR0LVdp/HjyoWWUq4wpVyWJb1yx4DphwLGe6NW
         VnVMOBnkiHU2w9epZUf1F3GyTpMAyI9Xs0ZJyv01JIZ73tWzlEX0zzDt3gjlSnWG/ZJ+
         rIJRGa63CKKaAQtCjTwDwPUfkyyUfXOiwlRY5g4ysnwSXv7uF5s8MJcsh6DMVEMZX10h
         A5GQlh1cADX2+P4C/UfQvPspVBzACH2VVNOv38GYt9oB22GGzsz8rhoQPUnuWBxiw/WH
         OpAJHn6ZG4LtzNmAAYaWpg2/HQxoOw7KZZFBpjjoRXH6HMmq3u59gLSzUiIDLgg4xqY6
         cGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070337; x=1754675137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8Xgc7wAh3AQD4jw99aJvo3qk4m68HjFouMy1TWzTKI=;
        b=cLT2o08sXiIybRNzSpp23kKR6wKFP9EeRqCrtWqkTlO2H6aZY5rhCp8+a3uQ8NuVYo
         cUBHEvjzjbttr/q7cnFE/ew7VReQG4tfT4nuzPoCKJm0TlNm1NjTX+qdnXlAyGmJiTMw
         CxOqBfX7yBfW+3fpbFXaqbzn3fhy3rH0vNEYUXJYO6WkiBI0esZfrHVPEbWc+SMoRegS
         yOMwo/yjm1R0BrfF+ThlJYxrhpAkPAxb7kQgSzwIJYSzT3fRID3o5zPRb6AwGEX0QTjP
         9gLZoQP9tC9OhgQGvUjTwRaYdZh/cgDG+mZeN71gzR/SOZZTiszaWA6Jdw6BTHSwi695
         ZtVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzr+NdIwUCvEH2VgQk2/g0euOS2fvI0KsExJxXSwmu3l8bi62aWU8LXFERbgHcnAP1NVH+K/8L@vger.kernel.org
X-Gm-Message-State: AOJu0YymJXN0cUNx0y9x71qypKID79I9CaSG9Qd+WEzpabcjNQgy/oNb
	+uxgfla0PAv+Aib/TV+4OFuszZyAMPuqGsogX6pHL/dLguFRHd0Fl86Q
X-Gm-Gg: ASbGncuDP+/V5larwrCsT2FOkyqES40Z27FcDNTFnWs8nHDUR1vXychU1Wnj1rt2ph9
	Yu8ECSaLKi95OEQ+FIaQiMDku2hhSqtMDjjsJOImv3/vqX9qs1ODjrx/kc2dvPF5BUjijrk3KmS
	6CLQCByxrJG3XWD8vInOPpMl3G3JQctLaIjPRjXnhTBQ1sc9d/Nj0M3TvFuTWOLRipZwKogy/75
	FL/I04kn13avI+fxpmwDnuVDi5lM0PD/J5Se33yfXvWktgtXoo3P9wj2lpBLi7JAplpm98YQYdO
	B2z4VJrrx7kHTxJk/SgdgNHoaFZ90sfDIojKxEfvg27KecOC6jw/Y+KlNAR9wTICQKaiD6uKa/2
	k1aIE1lh5kswS
X-Google-Smtp-Source: AGHT+IEQVmJ1sUuQjbpJr42ATniV0xBSZlpcAt3BTSkDlmnZkgTYHwWnUp8yh4vw2dyRrSr9BIQ7TQ==
X-Received: by 2002:a05:600c:1c90:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-458b591e348mr5307415e9.0.1754070337029;
        Fri, 01 Aug 2025 10:45:37 -0700 (PDT)
Received: from sierra ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458981d0b06sm117826385e9.5.2025.08.01.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:45:36 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: stephen.smalley.work@gmail.com
Cc: nvraxn@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH v3] libselinux: refactor selinux_check_securetty_context
Date: Fri,  1 Aug 2025 18:45:27 +0100
Message-ID: <20250801174527.1203687-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ60msaQXmD3kWOPoLb-=Fx1WK2TdGObpg+Vq40-yJEfTw@mail.gmail.com>
References: <CAEjxPJ60msaQXmD3kWOPoLb-=Fx1WK2TdGObpg+Vq40-yJEfTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invert the checks for fp and con.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 .../src/selinux_check_securetty_context.c     | 69 ++++++++++---------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/libselinux/src/selinux_check_securetty_context.c b/libselinux/src/selinux_check_securetty_context.c
index 7609752e..bf61f53d 100644
--- a/libselinux/src/selinux_check_securetty_context.c
+++ b/libselinux/src/selinux_check_securetty_context.c
@@ -8,45 +8,48 @@
 
 int selinux_check_securetty_context(const char * tty_context)
 {
+	FILE *fp = fopen(selinux_securetty_types_path(), "re");
+	if (!fp)
+		return -1;
+
+	context_t con = context_new(tty_context);
+	if (!con) {
+		fclose(fp);
+		return -1;
+	}
+
+	const char *type = context_type_get(con);
+
 	char *line = NULL;
 	char *start, *end = NULL;
 	size_t line_len = 0;
-	ssize_t len;
 	int found = -1;
-	FILE *fp;
-	fp = fopen(selinux_securetty_types_path(), "re");
-	if (fp) {
-		context_t con = context_new(tty_context);
-		if (con) {
-			const char *type = context_type_get(con);
-			while ((len = getline(&line, &line_len, fp)) != -1) {
-
-				if (line[len - 1] == '\n')
-					line[len - 1] = 0;
-
-				/* Skip leading whitespace. */
-				start = line;
-				while (*start && isspace((unsigned char)*start))
-					start++;
-				if (!(*start))
-					continue;
-
-				end = start;
-				while (*end && !isspace((unsigned char)*end))
-					end++;
-				if (*end)
-					*end++ = 0;
-				if (!strcmp(type, start)) {
-					found = 0;
-					break;
-				}
-			}
-			free(line);
-			context_free(con);
+	ssize_t len;
+	while ((len = getline(&line, &line_len, fp)) != -1) {
+		if (line[len - 1] == '\n')
+			line[len - 1] = 0;
+
+		/* Skip leading whitespace. */
+		start = line;
+		while (*start && isspace((unsigned char)*start))
+			start++;
+		if (!(*start))
+			continue;
+
+		end = start;
+		while (*end && !isspace((unsigned char)*end))
+			end++;
+		if (*end)
+			*end++ = 0;
+		if (!strcmp(type, start)) {
+			found = 0;
+			break;
 		}
-		fclose(fp);
 	}
 
+	free(line);
+	context_free(con);
+	fclose(fp);
+
 	return found;
 }
-
-- 
2.50.1

