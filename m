Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC421B9F6
	for <selinux@vger.kernel.org>; Wed, 11 Mar 2026 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203116; cv=none; b=JdocURtkGIadyST1fDR0BLRRykUun0BLH88/5Xqclau6OjlSH1q1EfwvN3TmUqtRTHP6iaI7CIQy2nUsJTJ+UHsojCQzYiyk96SqYqNNdLjvWKPf+Pkzp5HRLPt3fnp28s5BO/iYFcwpU5wUa/OZFo3yKpUrUzjHpJiPVOCLbFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203116; c=relaxed/simple;
	bh=LDwXeok2R4y8961r1+KozcjtVxPkX1TWMzdq5ywp8vA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j8qzMY4Rz1dYveBD+q3AHZR5/XdrtttW3dYWMPEG0H5MW28EA0g344ucxddzXdOJlaqMbpNFfY0UO9nLGWvBZJ6kH6lBUSukaYbFPBMcfo52U5dSgLfGoAujRjQW61DkuW6ZLfgXYlZ+WJVlAK89an2Y0JJ1MexyyN70NfsVJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3rBH572; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3rBH572"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae669a8ff1so416313765ad.3
        for <selinux@vger.kernel.org>; Tue, 10 Mar 2026 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773203115; x=1773807915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXdJ/L2drDMXA7VwUYjwMsDKEx0vHsWEN9Rh19hGd24=;
        b=v3rBH572ePnvBFAmwKNPThcjlzBO+erRzeT9E0+TxZomrNp7dFyYH5EqjkSWUFpNcO
         kCkoGWrNhn65rNZ72e8abPlqzQJQst7yM+SwZvAPUHMXKWibyOU7yIx/fDntO71W0tRd
         0BKKUHUD/BOHxByMYJ4DAORKb8BFL8hODAtBfz9XIvTQJAR6ZaZe6sXTQOJN48/IIk/B
         g+AkRH3/ylCLFcIfNp+viHzSHtFpSiXru16JxKzP4JIvybFn9rtgFXmdSfVCjdPkhe8H
         l54ZbXCxfeQTPviS4XlqQKo7HoZG+wYxxZlYqZZe4UE0EmDK8YctYmqAwc+ADFD4A1fq
         vNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773203115; x=1773807915;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXdJ/L2drDMXA7VwUYjwMsDKEx0vHsWEN9Rh19hGd24=;
        b=ZGqb7U/n1rAvrxIpKn5I9XQrvSpLazF8oh28ZsiN6GXzM1Kqneey+K6pzJWWkQIeF3
         eEEugAL7hWKi9gUepiRLnQyNQxOUHKqPvpWw3OomD0JUnKPPyA0XXITdsjIL4UuIYdjz
         exGn6YLfjz9I7XG5v80mO9jvHl6P76bQPj8aZkhRxHSLO1kHnnI+KzzYooTdnrGCB6tJ
         +7nbXkBcQvaQW83VqLCgFKXclyhQWyh8ifijTfVF2Imb14wteQnFYD5LRgnfJRRefITb
         /9NvwuqzwHnkDs2kbHCOjotwWALwB4q8ovtFONmPSRmwJVvLH/YYtRH+NCM1TPFus/Rt
         tvBQ==
X-Gm-Message-State: AOJu0Yz8INm/HeXqHkizy8XduIImO0M6/q+4FautE35ewgPvsnO9Nj8X
	lqY52Obg4c16600pBuBBMZVuttJP2hIo+pgPJHVT4vrNVdszJbVK63/PxeeUQEAMT2NQggZKc4U
	vLIcYgmda9H93zT/BR4YbOMgJZYcRxUyLQh6DC4hdGtmac2Xb1/bn3juaKkd5bnqNVKdS3qfVO2
	xX7kR7wX6YuBLWnM2VKRdheAPfVj/PNUtS
X-Received: from plww2.prod.google.com ([2002:a17:902:d102:b0:2a0:c21d:f768])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea0f:b0:2ae:51bb:9809
 with SMTP id d9443c01a7336-2aeae85a668mr11736525ad.36.1773203114452; Tue, 10
 Mar 2026 21:25:14 -0700 (PDT)
Date: Wed, 11 Mar 2026 15:25:11 +1100
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311042511.2975567-1-tweek@google.com>
Subject: [PATCH] libselinux: do not log on unexpected escaped character
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: selinux@vger.kernel.org
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeffrey Vander Stoep <jeffv@google.com>, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For file_contexts entries relying on PCRE2, there are multiple escaped
characters that are valid (e.g., \d). If such a character is identified,
a log message is emitted. While this may have been useful for debugging,
there is nothing actionable from that info message. Remove it.

Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 libselinux/src/label_file.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 8fcf74e3..13451680 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -231,7 +231,7 @@ static inline const char* file_kind_to_string(uint8_t f=
ile_kind)
  * Determine whether the regular expression specification has any meta cha=
racters
  * or any unsupported escape sequence.
  */
-static bool regex_has_meta_chars(const char *regex, size_t *prefix_len, co=
nst char *path, unsigned int lineno)
+static bool regex_has_meta_chars(const char *regex, size_t *prefix_len)
 {
 	const char *p =3D regex;
 	size_t plen =3D 0;
@@ -275,8 +275,7 @@ static bool regex_has_meta_chars(const char *regex, siz=
e_t *prefix_len, const ch
 			case ',':
 				continue;
 			default:
-				COMPAT_LOG(SELINUX_INFO, "%s:  line %u has unsupported escaped charact=
er %c (%#x) for literal matching, continuing using regex\n",
-					   path, lineno, isprint((unsigned char)*p) ? *p : '?', *p);
+				/* Unsupported escaped character, continuing using regex */
 				*prefix_len =3D plen;
 				return true;
 			}
@@ -343,7 +342,6 @@ static int regex_simplify(const char *regex, size_t len=
, char **out, const char
 				*p++ =3D regex[i++];
 				break;
 			default:
-				/* regex_has_meta_chars() reported already the notable occurrences */
 				free(result);
 				return 0;
 			}
@@ -523,7 +521,7 @@ static int insert_spec(const struct selabel_handle *rec=
, struct saved_data *data
 		return -1;
 	}
=20
-	has_meta =3D regex_has_meta_chars(regex, &prefix_len, path, lineno);
+	has_meta =3D regex_has_meta_chars(regex, &prefix_len);
=20
 	/* Ensured by read_spec_entry() */
 	assert(prefix_len < UINT16_MAX);
--=20
2.53.0.473.g4a7958ca14-goog

