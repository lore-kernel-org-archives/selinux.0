Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D875CC352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B044B20732
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTWdCtTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395396AbgDPPoO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405656AbgDPPoM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417FFC0610D5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id r14so617689pfg.2
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LCHADiUGK83p/IY6cD7pVPCbs2oe3Hvj02tNShqMew=;
        b=lTWdCtTyo2fdPGaA5j0HEAR0aB0Xn1MyUM6qUzGE0rU9eRtMcP2W3SP7EmdxiqtJgL
         JgbXTUD3utQ3sZBveJ8hUC/eP4q/fFGECGIL1XPZtG7B+k3mu7ybvtRylZPCf8SN1DVn
         lJ3TJWwx3XvJD12TIofkS924AGqIXBxYGMAL42kpZGfKgpmxCvrHNY6hBN59chTYQasI
         d2r3ZlU9rfCJRntINsa56iP6PcHWNDOxXQvt1KloO88H+g03aJy7hRpsKzXkHC4NzkoI
         IQDENA1jk2amLPwEFELyeGOy3sPWhz9qsGWpWdnnDcNVdk3ZOa5JoWEiBS/aBLCfuUYH
         VbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LCHADiUGK83p/IY6cD7pVPCbs2oe3Hvj02tNShqMew=;
        b=rAuMlr7BXA+klLbJejng9UgO3MiJHOys3xU/lV/hRe0UFta/vTBEBV+9ah33QWCUow
         OdL/09BfT7KqDQxCZaEf/OWlbMJ+26RanHrwLHcWQdBEYbJeUgi9EU1ZfMybIPA6h4hx
         adUBsiS1GNxsJhK8yEJGdB0rEKpFNfa4zAIkD0bsxArwCgFjATQpUd2DSbOxtbqI1Ce0
         FwXGjUEP862344HxIM+CNGivgyG6KRgqVjwOBLeHH8ZRWFihzy0IQCEVbXNFrLXVJmVZ
         5eW/Ez4yYJ4J2VY4mRuKEcGlPzHrcM2M3uAcB+fOCAv8DazpeSYTmRqO3irdk79o2u2x
         ZKnA==
X-Gm-Message-State: AGi0PuYaGyNsMh0rjKsXE+2yLuLt7qhf1IZyS4j4uP/Clgwb3G8l+D20
        FORnhIhYdAhEfJWceL30j4Q=
X-Google-Smtp-Source: APiQypJ+pnEdxVQ+dnMdAQAWGvPtJvQfTYhYd2zDZHtunPBvOWawR29TspIAMMpFt4QdGQJLp5Zv+Q==
X-Received: by 2002:a63:6543:: with SMTP id z64mr32701420pgb.260.1587051851747;
        Thu, 16 Apr 2020 08:44:11 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:11 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v2 03/18] selinux_booleans_path: annotate deprecated
Date:   Thu, 16 Apr 2020 10:43:37 -0500
Message-Id: <20200416154352.21619-4-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200416154352.21619-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 38030fa8802e..454d3772ec38 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -575,7 +575,7 @@ extern const char *selinux_contexts_path(void);
 extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_subs_path(void);
 /* Deprecated as local policy booleans no longer supported. */
-extern const char *selinux_booleans_path(void);
+extern const char *selinux_booleans_path(void) __attribute__ ((deprecated));
 extern const char *selinux_customizable_types_path(void);
 /* Deprecated as policy ./users no longer supported. */
 extern const char *selinux_users_path(void);
-- 
2.17.1

