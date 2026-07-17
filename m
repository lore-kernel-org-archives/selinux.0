Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34037AA7D
	for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313296; cv=none; b=QQK/xik7RZY5Yvo762YNUS4LkJ6B2mhTMD3mtqZHHZXU26QDEIUFyDSdG61J4q3scmQmDqGoRBr9meDSuZNK49B8oEwtfSer+l0PUWEJNsR7PSDpPWI+bhN4ygthdqxh76k6gPmHPdhcozx1PN/iV3AlFlV3U29g5W1IzWv9XIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313296; c=relaxed/simple;
	bh=Ioz7B4FaQHe7gGJcmcCkAD8dWyKPn5yxEd/BMEmuCIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdoRI2gOm6sx03bBMXKgiNZCNxEcr81A03teFGgu33Vl1x90lSvEVTZ7o8tTq+WdCh4eKuC0uJBJYVKLM31BfOllDKVre1Ok/qsJup7Q0/ihVij27F6iMFjEnyBO2WmRX5aL8v/5vlEc6KlAxfIz+ZaehO8X84dL9UT7GBytiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lptTsNth; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lptTsNth"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2a818fc4so68104121cf.2
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2026 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313292; x=1784918092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FFAKsszcbEu9WBmU7F4De8HjXr80x5PUnJIpfhdTtAA=;
        b=lptTsNthIwtnM+iNXSgU7s9K+2IqsCB2DdLXkyzuBKxYix3u5L+ORincILzPqYS9c4
         K+k+rTt+LoacIjXGpDfSPFm3wa9I7MHKQMXESAnWmhMYFY5ExTBe+8SD4CXBIe9tKkvO
         nACfTin7bkch8fun+yL1/AFwrR2gbSdPBmTF4OL+G7zyJ6la7vDcRqHc5rkKMbOXa834
         bFnRYqKbGx9EBK+b7xTDiybUicmNAXYojBTQDc93iTI6mQPTJQ7lMNMLCvbrERGO9DAs
         pOb3ociuCz8f/pzQK6K/YZpfJtbzgip2SQabIWCTjCLCvHDzDeEUeYOqH/2+0TRmKsCU
         raaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313292; x=1784918092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFAKsszcbEu9WBmU7F4De8HjXr80x5PUnJIpfhdTtAA=;
        b=O/2juq4M9oWppHzNoLENv/Iawtadv53IsUfy3lYBUH69vnhjU0rD+nVAopFsogXVdU
         i19jpYYLM+UsINMXMW+kDm8v7afMnALRwJckOdTVYIyY5aZAezCR+5Mck6dXDVz899B8
         Y/1tLAJhFuCzYVyCm0LSgpHZit2nxxEB9vmM3yknoOHBmQqjjzHsdqOJ74Me3h8yx7V7
         JzCPNl2STTnH+ZpMLcM+WC4qh+CCp6utdi+g7jBSlw5uBqptsAikE4XpCRYaA2ywHUIt
         UDMKns8CIAonIlSdeXQdEGx9exRJM9leKACkg4OSvSKeQ09SPCwu2jfsZfwCgBVAj03Q
         cDtg==
X-Gm-Message-State: AOJu0YyLS3BxxyZhIr4W3Yuyv3NmM6zavLr1AEbb0QCbm9eBTGqg74JE
	S4XdM7Y68MXM4vmTPzxqb2tYgFYHuay4RgKdJCnUQ9vrN0+dvr5O5DKP0RIwjg==
X-Gm-Gg: AfdE7clE432mH5J2t/zUCipJDs/65lp0C4+8ebo6Ja8NH2ckIKe4USQ6edvjlZHxyho
	J1Y/udfmoAwuiVn66DI3mqB+flR7NtpgOxs54R4uf6zpiWZTOjmO7O+kP+lHmoIfaulN0yKfedX
	xhXQ37egTkZS3CKgMytau6DSz/xYtdiuALJiZ7CzYzhLQl7TYtYLUJCTQ65o4sCrku+Wt0ER2zl
	0LxRzoPjD+fiZkGJeR1qn69yOcsSdPt9TeTxEJuwa9kfhrbQntOC3fyaSyxj8ohE4h8xmT24Oiz
	Pwh+isBglDOI+TW6bxddQ7y/bJbTWsncznt+/H8nk3zVYWfnXHYT6y4ZIc8ELUhxQiC9nY8BsYA
	4nmvgwdZayOfXrFH+fYcPNF+VLojoHaB+xHqY83pz9PN3HkXIVTOpnfAh+bPCQDY82W5BYW+Glz
	lO3i1lrXN0E10rb35rl9Yf3dy5X+4OlpFtaI/rkDdVaPaXwsryawSFcmY5SalOw+5VZueZzGY3f
	njn8A==
X-Received: by 2002:ac8:7d0e:0:b0:51b:e991:92b7 with SMTP id d75a77b69052e-5213c2018d4mr35679101cf.29.1784313292441;
        Fri, 17 Jul 2026 11:34:52 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786b539bsm22756576d6.30.2026.07.17.11.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:34:52 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 01/10] sandbox/seunshare: free glob on error path
Date: Fri, 17 Jul 2026 14:34:15 -0400
Message-ID: <20260717183424.20324-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free the glob on the error path for a failed calloc.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index f2d637e1..0c32d03f 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -448,6 +448,7 @@ static int rsynccmd(const char *src, const char *dst, char ***cmd)
 	*cmd = calloc(3 + fglob.gl_pathc + 2, sizeof(char *));
 	if (!*cmd) {
 		fprintf(stderr, _("Out of memory\n"));
+		globfree(&fglob);
 		return -1;
 	}
 
-- 
2.55.0

