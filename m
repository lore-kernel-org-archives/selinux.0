Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EB37C93F
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409731; cv=none; b=U8um4TOiN7aScGb1rGua/aK/ZJDkvUJCiMtsCByZsCJ0+lOA4gD/1WNPnTBffPwlRP9y7HJXELPtCx3Gif7YCJNHmgkioweE9QonLXmByUZ04IvCS86atWOY4cv1cqgK/E6ASZIN6kznVHBpLFc4rIn4q3QFt2dNUjNmhn5Em5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409731; c=relaxed/simple;
	bh=it9d4ouU1tlzYfRrVxOKjxM16zqdbxpkydekfe/FeTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aac1s4n/O/595WtEOB1zOZrenX6Y+XUB4q0rR+V2Q9g1QgpC+06K4STc8fPfIITxdE2J5/mK+EhuCd/BfLBaJ0SpdVUYXEI9W4NzHByGnYwS04zqZO/LMFAY4IaDEncqbqhS+UGSgx0Fh3sPg4Q1JsKBtHUouoD7B0kkaAI9G7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDqPOBrU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDqPOBrU"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530de0bab75so27466731cf.3
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789409729; x=1790014529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2i/2Lb/1gzrPtcDoSAka1m8Scc6XL2qDt71i5g9iWw=;
        b=iDqPOBrUUGtHv5qQQy9BmB+FfaB+/YOFs9NMZyX/6NPnu7qc3DNPTrMr0LYaVDiX7P
         zrJZJL17X/f7UEKbFdr7JgWafSK+DmydrqPoIR7/ZYWdzMnbVg7En6xUd4DuXvGPDM+P
         tKjbyj4b/uzzyGc5fcRTPYxydXdmfKepnT7RZatmEWyEFqkOowcpe9K6JiTxtNPPVsq9
         2aqHBfBDZvnC3z+B+uM4qFQkY4uasMqbxmpuBD+kqNzKczOlFj3yyqTIrjCjGdAIz3ha
         0NLvYk1XDHrjbkqCDLojtvKfVlIaVKjFgzRhCtT7klp2hOt9EhRPkvBP0xSE/s9l+scz
         98Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789409729; x=1790014529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2i/2Lb/1gzrPtcDoSAka1m8Scc6XL2qDt71i5g9iWw=;
        b=ml1OYWtsqAwghsNTp1sqXSkrOWWRr8Chh0h0b4bYGBDM5usoYB6RFtIB5/eEoek4v6
         8CC4k5CzCa1F4JG2Rs7TdkrJ0EbwT1lV/BbQ1WDRLBO6hvVKUFRwys4/W1C7Ci9KUOhS
         51fJh3vfXUC7xgfnab+5AYBvqYL/gMY5UwUmGIKvWlrh7q7i9u6HVWCXPk8KPOQTA9a7
         G321J1oj4UXpxoPXK7p73uHBtzdQHIOyZYPD/Jr721ULQ6ISLFSkTnDhK3CpDXHBuDYl
         r0ED1bka2yZQGj/8IXNIWYKMQqDCzWTjgO3MZK1UzVMNrrVnNw45SYRCDO9lnvTpExU2
         vo6w==
X-Gm-Message-State: AFuF++kebVUm3K/k8gaRPJG3tBkwvUvJzxTdCe0m3D8W3BuFoCO9oAMR
	GQHBFSDwxpqXNe222f38yjdBPjj5vujmNK6PPxkAT8TmftbbdH1U2LQNBYYCNw==
X-Gm-Gg: AYBFou1S6JRGeYWocTQIOYaFVfUWJt6m3C3qaTVGxOoBcG5PibuUzXhthyYiTbLlaq9
	UbPN6WasPio94Zvx5jImg0nw6O6l/pixv4RytflrfDACq7p+9SallPnAtNnOVbl2U5+WRbLFGH8
	k0IxTRYgGsetmPbuifpyrpzG+dD9FpcXXUUNU8kN63tdUAsjsrv6arGq7vMcagprYcHcQA4xee8
	DNMtPiqtbpeGFx0dIYfqHSVXtdd/ZWjizh/5ya2V0LfiDKNr6PzjsjlLx9Z8EQBpiOhYO2/GZxI
	EvyTZkbD8DhMwVyNj7k82FWkP/ClRRImY1/08ys2ZoRw05hEgv3evsa2rzKmRufTIgPVcrGl5Hf
	bdjACQDQ1aDYt02s8+ExU99cmLoM77nHqg8zC1bUagSWIOns6yfSnuwAcSxY4/yTzDl7z4v2P4W
	6cM8NH3m7vjQfzRcMUFfw3b/BQlhNiVm/BftJN0iwg6q+RG57GAgIzqnX8aeX85AhLIylAadMST
	IM3A6FB2aJJbsvqqeFwj4ZEGw5fpb2SeJYQufMlRDencLJK1BK1VW/QmGixCNmZlnrLCXLL74Q=
X-Received: by 2002:a05:622a:11cf:b0:530:e343:b664 with SMTP id d75a77b69052e-5310d09fe5dmr52635031cf.58.1789409728318;
        Mon, 14 Sep 2026 11:15:28 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d3a50sm101105696d6.40.2026.09.14.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:15:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] libsepol/fuzz/Makefile: drop -I../cil/include from CFLAGS
Date: Mon, 14 Sep 2026 14:15:11 -0400
Message-ID: <20260914181511.31960-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914181511.31960-1-stephen.smalley.work@gmail.com>
References: <20260914181511.31960-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing under libsepol/fuzz includes <cil/*.h> directly and since
commit efd1aa51 ("libsepol: add include/sepol/cil symlink for in-tree
builds"), the existing include <sepol/cil/cil.h> resolves via the
../include/sepol/cil symlink to the in-tree copy. Hence, we can drop
the -I../cil/include flag from CFLAGS when building the fuzzers.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/fuzz/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/fuzz/Makefile b/libsepol/fuzz/Makefile
index 4c8820ae..b406c737 100644
--- a/libsepol/fuzz/Makefile
+++ b/libsepol/fuzz/Makefile
@@ -10,7 +10,7 @@ TARGETS := binpolicy-fuzzer secilc-fuzzer module-package-fuzzer
 LIBSEPOLA := ../src/libsepol.a
 
 CFLAGS ?= -g -O0 -Wall
-override CFLAGS += -I../include -I../cil/include -D_GNU_SOURCE \
+override CFLAGS += -I../include -D_GNU_SOURCE \
 	-DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION -DDEFINEMAIN -DVERBOSE=1
 
 all: $(TARGETS)
-- 
2.55.0

