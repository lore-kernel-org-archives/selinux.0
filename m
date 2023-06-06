Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E0C7EE2F
	for <selinux@archiver.kernel.org>; Tue,  6 Jun 2023 09:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjFFJkp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jun 2023 05:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjFFJkD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jun 2023 05:40:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E414126
        for <selinux@vger.kernel.org>; Tue,  6 Jun 2023 02:40:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb7aaa605so8903346276.3
        for <selinux@vger.kernel.org>; Tue, 06 Jun 2023 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686044401; x=1688636401;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wogCD7rA1VihyKkXqb4tCWeHwtcMlnUVui/jzF3rpwg=;
        b=vAGa7NHMWULeNKPjn4HL/FZePFkO1gnoGdWcckY2IuMcwZpmd30ADvQwhQaw3Uzr/j
         ZmZ04rPYcB8H9A9OmRSBZ62LYVE/iXRmyOQafUcIGAGGnLu43FYdbz9JM+y8pvSzkule
         gm85us+ujJTVHIbROT/2Pdd9bWbHYYaZjIwaLWtxqCPFC/kDedAAwoOlo46JZHRY85+T
         2C3hS7Evc6F098YNoG7qXOI+Oto48qvNo1hCfpViKhYZ47EbO4QotnpbqkRFmB/BepKw
         gNI2FIneLB8GUQ5OB12GwreB8apg9YNRRdh13QU8cJJA5RMZs/W30liuecUZ4GrE4aYu
         hV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044401; x=1688636401;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wogCD7rA1VihyKkXqb4tCWeHwtcMlnUVui/jzF3rpwg=;
        b=BPZj6x9WwSCy20PszFLTXVVXjONFfIIVBkGSMvKjH0oLLDgxqGqQOmuJ03L1pW4Tho
         grOt94tgFk0rEot1KoUtSFPENUfVf7eOWk5NE9Qi50GqYfarNClnwkdR1e1+mYGUr7Gp
         8fW5GRuDbPdt6ceEyaUV1pbs0wlT1OX1KjwZocoMbn1iBEhDUBFzye7ORJatLaLLFH+w
         i15kHfv05h6GL+vxmy+GCYQANNr9Hikn1RKqkpLytHjiR6k1mf3GOwpM3Ffwb/qp5n/P
         VzTCA0lRyckf2n3cEBjbXEy0AczX16y2Rs/8oo2nb7UUOJmbpdCFAYM2dIBLVuYEuQYO
         l5IA==
X-Gm-Message-State: AC+VfDy+Pv48dNndcudrQ0UoTOpzsYHfBK+eAxf206Pm77xKYKacpOoI
        96u0gg+x7ziY0fyyAKaaIH4M/bbf01deHyKYpCtBTtVxS5BqX/uYKSvK4ruEvi81SkEn7M/ogG1
        W76NCfZsuV6cUeAuse+SpL+Rym5n8ww/Wyv65VOdKAbtcleeLbGY17IvfNn1PvH5uC3b9+EaoeA
        ==
X-Google-Smtp-Source: ACHHUZ7/hX7IfZEyfOc+n016Lh4lneOhfMGxal51JFbiHRY/ZGvweqQNBff5q76H1b6Vt6TGlVKD09wpbkSfUqou
X-Received: from chungsheng-work.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:2ab])
 (user=chungsheng job=sendgmr) by 2002:a05:6902:1006:b0:bac:3439:4f59 with
 SMTP id w6-20020a056902100600b00bac34394f59mr810083ybt.2.1686044401279; Tue,
 06 Jun 2023 02:40:01 -0700 (PDT)
Date:   Tue,  6 Jun 2023 09:39:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230606093957.2264516-1-chungsheng@google.com>
Subject: [PATCH] libselinux: Add CPPFLAGS to Makefile
From:   ChungSheng Wu <chungsheng@google.com>
To:     selinux@vger.kernel.org
Cc:     Chung-Sheng Wu <chungsheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Chung-Sheng Wu <chungsheng@google.com>

Add CPPFLAGS to Makefile to allow users change the flags of
preprocessor.
We offen use CFLAGS for compiler flags and use CPPFLAGS for
preprocessor.

Signed-off-by: Chung-Sheng Wu <chungsheng@google.com>
---
 libselinux/src/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index f9a1e5f5..4e4640f0 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -149,10 +149,10 @@ pywrap: all selinuxswig_python_exception.i
 rubywrap: all $(SWIGRUBYSO)
 
 $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
-	$(CC) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
-	$(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(RUBYLIBS)
 
 $(LIBA): $(OBJS)
 	$(AR) rcs $@ $^
@@ -169,10 +169,10 @@ selinuxswig_python_exception.i: exception.sh ../include/selinux/selinux.h
 	bash -e exception.sh > $@ || (rm -f $@ ; false)
 
 %.o:  %.c policy.h
-	$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
 
 %.lo:  %.c policy.h
-	$(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
+	$(CC) $(CPPFLAGS) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
 
 $(SWIGRUBYCOUT): $(SWIGRUBYIF)
 	$(SWIGRUBY) $<
-- 
2.41.0.rc0.172.g3f132b7071-goog

