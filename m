Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAEC10F00
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjHNNVU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjHNNVA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E0A171F
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcfe28909so559406566b.3
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019249; x=1692624049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhEgKOukXoe4fbpEkAYVhQZTs/qWaEAxjlXCbbr7rtY=;
        b=KhjLHXN3hspGz/IiLbYwuaj2N0uGPCUXKPNcVHopI79tHApYKUEvyjf2fQe0GN+Bvx
         vIcrt5Mx4z1RJA7BKQ+l7hnhZ4zppRU2aadVHY5CW6fRM3F4mZC9Y+t4fjpKpY6QYJER
         tO1JfB9x/JA5Ag7fhXBP0iIVvX1eE1WpgDUB7dP/DqaKSfkwmAJrEs0Mtt9tqYKrZqXt
         Op6FJchyiEL+9iWQs3RsYt+oc6qLa7sRH0ywQ3vp3BO66mM/o3/gfu33uxcBop0O4b44
         6OXA0zagdI4QSwmR00jA3k0iaTK/L0JqyskoVkFo5tgNGyoBmxuJKyjIIfW+U4FYVqiW
         silg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019249; x=1692624049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhEgKOukXoe4fbpEkAYVhQZTs/qWaEAxjlXCbbr7rtY=;
        b=jaxnwqFMMuXeXFhU+4w7t8p4SaWizDVzDQ1ZRRuHfuM59RprsNbXD/ZNtt8E9644xH
         rFjwd3XQcpvAZXo245TLjeZeOjjZ/7Hvug//8u96/9sWEecBuOXxyYoLJybt3lMO8C5I
         JpHl9hzoZQ1dzHXzTl4KzK3j2gVdQByEn2nqPVaLjm/ETYLXRHuAuHHX8hfq4Pj7gZA6
         iZxoFemFGgVongedwT9ldRqIQRqGrEQU697d+3izXZGOj+1gVZfqlqcjAJlfPHEHXaFG
         c+R7adVgLFG//NGlTexGP2YfkmsxbRlAWR5Z6lZCNoW9N23vdw2wfXIDZYRMPxD54Q6W
         IgTQ==
X-Gm-Message-State: AOJu0YxmPlWEfSBpc+tEetCuH1WzsGj6t2Q8BTnUybQTlUam4Qig3TtY
        Uexeaw8wkNe1w0aucExniyXOMf7+q2Zlz0i06Zc=
X-Google-Smtp-Source: AGHT+IGAWhunf0geHzIIssYzd0TGJBXBbBINn4SW9d1VDZBVzIcOR90C2ggNuaox3+ZFBhogPu7MsQ==
X-Received: by 2002:a17:906:51d7:b0:97c:64bd:50a5 with SMTP id v23-20020a17090651d700b0097c64bd50a5mr7625476ejk.53.1692019249325;
        Mon, 14 Aug 2023 06:20:49 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 16/27] libselinux: update string_to_mode()
Date:   Mon, 14 Aug 2023 15:20:14 +0200
Message-Id: <20230814132025.45364-17-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Drop parameter NULL check since the only caller does a NULL check on the
argument.

Avoid strlen(3) call by comparing by hand.

Drop unreachable return statement.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 190bc175..1363c83c 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -97,15 +97,10 @@ struct saved_data {
 	struct selabel_sub *subs;
 };
 
-static inline mode_t string_to_mode(char *mode)
+static inline mode_t string_to_mode(const char *mode)
 {
-	size_t len;
-
-	if (!mode)
-		return 0;
-	len = strlen(mode);
-	if (mode[0] != '-' || len != 2)
-		return -1;
+	if (mode[0] != '-' || mode[1] == '\0' || mode[2] != '\0')
+		return (mode_t)-1;
 	switch (mode[1]) {
 	case 'b':
 		return S_IFBLK;
@@ -122,10 +117,8 @@ static inline mode_t string_to_mode(char *mode)
 	case '-':
 		return S_IFREG;
 	default:
-		return -1;
+		return (mode_t)-1;
 	}
-	/* impossible to get here */
-	return 0;
 }
 
 static inline int grow_specs(struct saved_data *data)
-- 
2.40.1

