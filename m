Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4B3F0A8A
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931908; cv=none; b=mhKnaQOrQ733maNY4WZTdG81C7ss+2SJAbmo26C+8er4vgMrwcf4OnXHfrfu7qZYTTViX+6v3Vk+xEm+zSsjLyfkC5awyXLt2x2YrTzqEMPx/6POGR5ZwM+CtQbQwlofRoNKcs8AnqwXsjcAwVhvhJvWi0uj3Qn11T2Fkj8o16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931908; c=relaxed/simple;
	bh=nWGMP2kftLIN82Kyq5Q5rE065Q9chRztlsP7VImydTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Azi/keaVeffHtHXP2eDl3PIodF5TVvaNWQ8IeNiPyu+Y/5wC+/RoR1VUoC437B6SZf+Pe0z+I4902hABKj8wf3OMfWdOtL0fQxT7TRIw9v1l+QHQSV/JB5jSqhUr3Ffz9v+BhL85PGxBiRHbYNs3UD2fHiiHPqGeJJpuuLS0UJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeJu0qFE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeJu0qFE"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cce8873b56so38956556d6.1
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780931906; x=1781536706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXR3CsWa6CY3OBRGaTm+2E8R+I4LTpwgHLTm92mGwUo=;
        b=DeJu0qFECLvgCeY7tEi/n+CuwwLenEO2v4ygdfMH+IsnXJdUhw37TEkt0jyPvww8Vm
         B4DDTG1uC5KU4g04KCHEU1e8Zlq1DUJqoZ1zyAuGJ/Dk7w9n5vb97oU/D2+AZA1haLgS
         qJGQwiZnlYfhzSN/kEJhbCfwG5TI0fhujTJZTXKmQx9iAWo6paYY1+rGWZUTqkaico1S
         DV+6lrxpoRiI8bEYVI8HByqtBvEaCz+GTcYhlcWvaZ9YRtc4jculsqWKW1khk3YJmbMY
         cecIF9KU5IDgNGlpwOaGRAO7OOL3+wrZDroJEDBGezHZypQWWc4+++mfKs/Hb3L+1mNc
         XxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931906; x=1781536706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXR3CsWa6CY3OBRGaTm+2E8R+I4LTpwgHLTm92mGwUo=;
        b=QyWqNKP9wY/hTb+TvbZe0BPWtTgarTVN3uc6UkjFTVOj0TPBBa1PI7i1qoN1+wUxfU
         C7EsU+rW1oIepT7+BcwJbaVfuIxQMTq2ZTihHc0f2tk5mxWo4SNKvHxb5cq8wos3QfA4
         6dDdEUjBGZ1s/C6cATOjL6/S5T0mAL4Y9L0/x1sRvZSW+UmUHStI/N2lQr59SgMrhjJe
         +sKaQvBtBixM/qEETEflVMofgLBywabamOzqXHciGwWAP8+6z3S8CIFH6aLmlj6DdDI8
         p89S00j1g6ZwSDHPTEaEuhNmlB0jghx35puPGkrWFqV5APfSnjs0HIXQ97R4hj71p9Ze
         9uKQ==
X-Gm-Message-State: AOJu0YyV8wVq1QCfc0sL7biY8U/o7qtYyw4nGxGrLLig323qgTtROg9o
	waUwtkMBwqwZwJWBKqzXnUJ9MY7XKVQaJJZW8TOjX+LTLTxUdtG93hP2Cjd+gw==
X-Gm-Gg: Acq92OHURoEIXh1pssdlCI96bOrpUilfbux3mx6QXb5GS7IJVH3mtAs08lIzvr9j3YQ
	9SrBSnFWn0fQm7z2MnKg24saOdMzqLu9u3cfbj8nNUTgS8tx7HCUZX/5Sf6q9YNP/O02J3mfONV
	ktsYsS3nVDQ31mpNZxeDEtm9iMTMFgthK3ZaWUXyP89ob4KwrQXKuNT+JNuAVq4a4RJY/NDboik
	VjmvZoPkCsZAX8DoaYhDNpGVc4InJxKo9JfE3+KdTpprPJCTDxLhvjzRWNcaWg56Ho4YYbggFe6
	mxABSoCupXJEI8bLw/zjAv35Yy8OHKjfhyLmZeOgynP1bwIvNkP+LyLvxPe4CKzicuftLo68BF/
	U7hYAsS9YYxUJiPP6WtA5SkObOFux+/vLVu2ZROOUVHBnuw46Oe8CWRT7tWWeC3z3gku03bJt4v
	lyNdoViJPBUrPXUN85Z3hERc0pQ3IP5kyJQE1ymQemSTlM0alDqr9UIpVztQtVhzZwA8iqenN2s
	79DNKS1FKiw+/U1iFV9oV96mWlPPzN+yQc+qw==
X-Received: by 2002:a05:6214:21e4:b0:8cc:f159:7b70 with SMTP id 6a1803df08f44-8cee8c8148emr4645796d6.32.1780931904757;
        Mon, 08 Jun 2026 08:18:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb915csm169630406d6.14.2026.06.08.08.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:18:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: bunzip: guard against size overflow
Date: Mon,  8 Jun 2026 11:18:06 -0400
Message-ID: <20260608151806.311513-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bunzip() grows the output buffer by doubling "size" with no
overflow check. The function also returns ssize_t and
assigns ret = total without bounding total. Add appropriate
guards to prevent overflows.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/compressed_file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index 03eba117..6af81bb5 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -20,6 +20,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <limits.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdint.h>
@@ -140,7 +141,15 @@ static ssize_t bunzip(semanage_handle_t *sh, FILE *f, void **data)
 	while (bzerror == BZ_OK) {
 		nBuf = BZ2_bzRead(&bzerror, b, buf, bufsize);
 		if ((bzerror == BZ_OK) || (bzerror == BZ_STREAM_END)) {
+			if (nBuf > (size_t)SSIZE_MAX - total) {
+				ERR(sh, "Decompressed data too large.");
+				goto exit;
+			}
 			if (total + nBuf > size) {
+				if (size > SIZE_MAX / 2) {
+					ERR(sh, "Decompressed data too large.");
+					goto exit;
+				}
 				size *= 2;
 				tmpalloc = realloc(uncompress, size);
 				if (tmpalloc == NULL) {
-- 
2.54.0

