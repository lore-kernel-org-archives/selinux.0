Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F043F8DF
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662010; cv=none; b=M0FUEamh4xzUTHNxK/4TlbokzzkBewGzqXHc5YWuXReHQxlTNkXMwkiqmdQhkFxjeTXUgtT4lcObO2TMU7qCwGngmkp9x91bHPimqa0iXZu+CeWeIzo6C3yf/sqGuJpA9hy/Rdv2MUfIBRg48wnmS/ow+4+UJTqN28AchClskUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662010; c=relaxed/simple;
	bh=apeRM5BvMURyusAyI9OwGMhajD+nnnvoJTFtXbkawkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBCjwzUL2aUYx5sbhLpjJcV+nmlxFiErg4qLER1MZAr6pxTBx/JmSxo6MTRw3wqzg6e1eEA8nPyT3yFUI+xjc6S1C+ngzGGBiCSluqEH8ZZD/Q6/lKlvi0GRP/PqCM28hTVxKo+R4s84Oyp8LZqKe241h/lK4YN8YqqEZx+e6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwP6Ryjk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwP6Ryjk"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-936cda0e3fbso338276785a.3
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787662005; x=1788266805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+aCkOww8/ksNA9aGsDt8EtkPekXNbYFYCYxFpy1Xq8=;
        b=mwP6Ryjkqk5SLTjSnYcH/nzzT/crWzehIZLyRQW0mkP4zBm+4ydDPzkXyPr0eU+AAs
         RToTOQ+Hc2V1U/Vdi3WBABBFnLkbgViPEGvbxpB5xY2n9RyZ4s7qPQC/UWb2zim6TXAE
         8SlhYvKeOoXqbMx9Fe6hvKQVyI/tNmlX9mUTY4obm89P4Ob+SE/iP8LGrM8e6kXGoPSV
         Kh6lKyrKqgA7A6NeL/DnFQjOPhE4f8xml8XMbbolNhr2bVw1skv3OQp+QfrOrQ9pEohV
         J84CHZ+itrOHDS3+pDx8tJr7uuogg3vzo35iufz6ypfZJSyHPuGtz1eQ9nxYdtTEtW6K
         CmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787662005; x=1788266805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+aCkOww8/ksNA9aGsDt8EtkPekXNbYFYCYxFpy1Xq8=;
        b=R4GLakdlemu0IqVwOS8Gq24Yj33N4pvL5ccShgcTHHH2k5MmSQM6U3HXqJWH4LLlHd
         sl4TShUpBUDbDKorUjiGZ0hPZraLm121oKVQGExaFH9UWiF6zTVMCOLEaNgwPJye55M5
         N9vkihY3CIkAejajqk/BSS1Pew7GD/mUahTPvJBBVlWC/ytuMpfVYU7mlsotZXujeAxj
         hDvxEZvSwz/6FY5sRh+KzGwl1HJdpIpUQHP1iMBzqLN+ZVREqv8d/Jr7xY5yV0wx2gwP
         zfSWMPTaJlMsKTH2EkvwRekdCmanozj2eYgA+vscRq0esAVwtvYrDgiNmZKdgDJcmBFC
         leJA==
X-Gm-Message-State: AFuF++nYFLQI5BticxLDERxDz8gqki84UB5OVP3XeRrRRorFMLk4+OsN
	I7ICpTRTBrrvoh+gAcXeka/+wIyqCz1tqqG67wX88T/GiIj9A2pwj8mbdSv6iA==
X-Gm-Gg: AR+sD1056SivEzADlp7n4EUGdK8EhndkCTf2Rh5K2NXg3aiNl7TP5Tq/rIzzs6RQG5h
	A3QXJM+76iKWg2ZfdXz6sM1OpIQa0ZcCrTXRb1QmYfXVUkAKRMXTDrHV6iSxG+V5z9eoyL5N8/N
	1OsPQy2UAaUmer9Rwe9HgsP9h7urVMfJDQ066+Ea83uxtvwld/gX1021qeiK5wT9H+dQHIjvBo5
	sAPYX28aJlXyXfllUW395a9wGkU1lAk4F9OESRSq3MPboJpF3TbWB9BaHb12Srvg5tUz5r+le8A
	lky8ygbh31atqJc3cfd5qNY5ZTu9dC/zv4u/c6Bb8wzr2VdK79PqBV1zrKak2SJHUYQXj1LZUPt
	gurijsRTWWJb8UXMIzf5/BPFmDqrfuiJCohEGb/xJm1/oVG5QgrhxdLhxlq/siRbc7kz7zT7jYx
	R4co2aIKvqN5MOyOG3FRtyuqa24hXg1AorE/+pyd+q7hmoxgwRZ9s98NbZkx8vw2D4a9yWXQ20J
	fopCNacBOVZSL2mLSQqau/OOKJw6nJa5wzk0K6YI5/uUCxmNKzfoqO/vHvsLqCJ
X-Received: by 2002:a05:620a:700a:b0:930:f35d:41ba with SMTP id af79cd13be357-93746999cfemr2463882085a.36.1787662005433;
        Tue, 25 Aug 2026 05:46:45 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749d9538csm721659285a.30.2026.08.25.05.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:46:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: do not infer name-based bounds for attributes
Date: Tue, 25 Aug 2026 08:46:29 -0400
Message-ID: <20260825124629.84128-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hierarchy_add_bounds() infers an implicit parent from a dotted name
for every entry in the type, role, and user symbol tables and stores
it in ->bounds. Type and role attributes live in the same symbol
tables as simple types, so an attribute with a dotted name whose
prefix names any existing entry has ->bounds set on it. For types this
produces a policydb that fails policydb_validate() on a TYPE_ATTRIB
with a non-zero bounds, which oss-fuzz hits via the checkpolicy
fuzzer's explicit call to hierarchy_check_constraints(). A minimal
reproducer is any policy containing:

attribute A;
    attribute A.b;

or:

    type T;
    attribute T.b;

Skip attributes when inferring name-based bounds, and treat an
attribute-named parent like a missing parent, mirroring the flavor
checks the explicit typebounds code path already does.

Fixes: https://issues.oss-fuzz.com/issues/550672317
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/hierarchy.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index 0499bdfa..b87471ec 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -617,6 +617,10 @@ int bounds_check_users(sepol_handle_t *handle, policydb_t *p)
 	return 0;
 }
 
+#define type_datum_is_attr(d) ((d)->flavor == TYPE_ATTRIB)
+#define role_datum_is_attr(d) ((d)->flavor == ROLE_ATTRIB)
+#define user_datum_is_attr(d) (0)
+
 #define add_hierarchy_callback_template(prefix)                                  \
 	int hierarchy_add_##prefix##_callback(hashtab_key_t k                    \
 					      __attribute__((unused)),           \
@@ -629,6 +633,9 @@ int bounds_check_users(sepol_handle_t *handle, policydb_t *p)
 		prefix##_datum_t *parent;                                        \
 		char *parent_name, *datum_name, *tmp;                            \
                                                                                  \
+		if (prefix##_datum_is_attr(datum))                               \
+			return 0;                                                \
+                                                                                 \
 		if (!datum->bounds) {                                            \
 			datum_name =                                             \
 				p->p_##prefix##_val_to_name[datum->s.value -     \
@@ -661,6 +668,16 @@ int bounds_check_users(sepol_handle_t *handle, policydb_t *p)
 				a->numbad++;                                     \
 				return 0;                                        \
 			}                                                        \
+			if (prefix##_datum_is_attr(parent)) {                    \
+				ERR(handle,                                      \
+				    "%s is an attribute, %s is an orphan",       \
+				    parent_name,                                 \
+				    p->p_##prefix##_val_to_name[datum->s.value - \
+								1]);             \
+				free(parent_name);                               \
+				a->numbad++;                                     \
+				return 0;                                        \
+			}                                                        \
 			datum->bounds = parent->s.value;                         \
 			free(parent_name);                                       \
 		}                                                                \
-- 
2.55.0

