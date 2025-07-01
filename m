Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09A277808
	for <selinux@vger.kernel.org>; Tue,  1 Jul 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379650; cv=none; b=PClKz2eh20yQMIjBxgR6VaZJz1YZ682mKEGZjzd+YzlRX1Sz+LxZ5DN/Bj+jZXGSI7RYnMH/sY/RyNzHHFai2AVHONXjTAQNhYN4tV3ypAh33mi0m2J8NrMo0o6LoEN1Kf6zk+4kParBygRuRb1hlW/9Q8brl/IItEyMXT26xA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379650; c=relaxed/simple;
	bh=TzSSrdJi1RvGbB+bxJ3njYCFoTSJV4zg88Zafjl4GH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcjN5mTHfm83Umyzsp/801p+WpEy7sEB0qPQFVIOInm79g+kfPil8DJLwFEeJj3VN2MavPjJZW4pFAm/EXkxt87GelIWQ1wuFDhrMEWAozECtT6T8DD6lCbAQ9WCoGVbWczKX+psrVgbwSjx/oGFFkZvexPVNKU5aHro10rU+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF2TzFOH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF2TzFOH"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6facba680a1so40693016d6.3
        for <selinux@vger.kernel.org>; Tue, 01 Jul 2025 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751379648; x=1751984448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErnlURAqJ2k/8YMQvVqhCA+zYXWvT+so6jnRzyINOHw=;
        b=bF2TzFOHaI0dRLwOTELjuyes+5OB+B7eZ7FJDnIYK5gEfAGnbNHuk+3pNgY5pyUsry
         +TQoxbchLEJQ6rOU8RWTY5Do7xXu1M3TfhiKzxIDlzeJGn0PkVuIUFdwrTITKscsbWqT
         66/e/6VikykiwCG2N45ibt6siaH0txIgoPPNqgnpL44IcLi9gev6H/sjjJqg8Xm/ujAy
         7KZ9h/UoFja5LLzrab1J9sABcHPmlzI76O8fPZ6yzu2V0TdGFqnPqf1OFTibcPmOAXb+
         3ldtS4LF4Q4TLrwD4wKnhZ9n8iLUpQ0Ik4J/EiHGMp2cBHdxSXKbmNg+hbmu74XHUSX3
         CP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379648; x=1751984448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ErnlURAqJ2k/8YMQvVqhCA+zYXWvT+so6jnRzyINOHw=;
        b=s5Lq6vs4plGs8FrOq18D0mEABMj3VBjHPx3EKGBra/syNWrKy0/bG5bqO3lAbrCGN4
         aw7fPVu0rye5fmkqtdbRaYTeAv6zRDk0eG//VNc7L9zgeDctTBad30R3II4tTPDW2k5s
         nJUjqcl2ZayylZW+S6BnpEJoOeLuYqKps42AzLgWC9K7InMl4geYquNPl3HpjWR/GBYX
         cbugLzzgLbh3FGjq91zX59VjeenhKwgHl9XC/NUbote7jVsdtbJzTpMyeWvjyUMOHitH
         EnUE1hS90dseo/MoGXvFTZS7if3XAQkQo2jLQW2alM67sOJ4Gbffu/lu/CFpTpc5pARj
         eFYg==
X-Gm-Message-State: AOJu0Yz2Jl8g7aTrsEGRgBU0b+QqLv5+0sX555zZvJmIfHBzhyBuhvWF
	hc6UWM4qHqWEqW+LiIRS8Whhux2P0YIPt+G8gsl45U2wtb3XWdih3kkPX0jhSQ==
X-Gm-Gg: ASbGncvXVfbBB8Qph25KuVf1LdeTP/vvh5R6P6YR1Uto3cpC4Xkpkjyl7bOcurtD4CM
	9s4LYmGc+TRbEp/vasZWNnVmpTmGjAaFkefwBSHcFy29pb17LTvZyHHXgjE9BjG6x9yZIERzC/P
	FrHV3yxyb9KhIjShcN0+KJZdO/wMdIOZIXPuZ4Nb09FwGChchkh32+kJ6GsNIpPHR+wVxjwLiBq
	cHfFldGFay2D2aGi+Cyl0lU/4pwDdogZhAeZWaMt2AS6nSzCRVLhdew35kaTBG6PqfesJXg3zME
	oMi+2UorDAitgAvl8J9Ioq7Z73OAh00Z/j2V3MUJsFfskAkt6Vk+T7VpIzblh+PMPSvJdH0=
X-Google-Smtp-Source: AGHT+IEJot/H3NiByv0SIcElac1noLiU5+2hoibegA+H38uYGCnNabeIbrS5azBgR6LnDehiemkS9Q==
X-Received: by 2002:a05:6214:620b:b0:700:c3fd:af74 with SMTP id 6a1803df08f44-700c3fdb223mr144808186d6.45.1751379645790;
        Tue, 01 Jul 2025 07:20:45 -0700 (PDT)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e3ca8sm84607656d6.71.2025.07.01.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:20:45 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Expand class-permissions in deny rules
Date: Tue,  1 Jul 2025 08:13:53 -0400
Message-ID: <20250701121353.259016-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The classperms list of deny rules is not being expanded. This causes
an invalid read if "all" is used in the permissions.

Evaluate the classperms list of deny rules.

Reported-by: oss-fuzz (issue 398075935)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 70e5b734..2b6dad73 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2265,6 +2265,14 @@ static int __cil_post_db_classperms_helper(struct cil_tree_node *node, uint32_t
 		}
 		break;
 	}
+	case CIL_DENY_RULE: {
+		struct cil_deny_rule *deny = node->data;
+		rc = __evaluate_classperms_list(deny->classperms, db);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
+		break;
+	}
 	case CIL_CONSTRAIN:
 	case CIL_MLSCONSTRAIN: {
 		struct cil_constrain *constrain = node->data;
-- 
2.50.0

