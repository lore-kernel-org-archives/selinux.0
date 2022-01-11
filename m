Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DE6C433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345429AbiAKVzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiAKVy6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:54:58 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7208C06173F
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:57 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h4so812872qth.11
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ki72/6YAKoVF7gNojeEpthdFU5ESKm5d77bZpGErSfA=;
        b=ecunGWUL1lrzEdqK+LRBozns5kHH3CMKbwfFHTIl+s258o5a9XFe/nz9qKQEno3Ldg
         +Ajy6QNamgs95inIROpUgCAmODFmR26id7eIizuGHuCI+ZQAlBych+LnT8+NYBEHVmF8
         +FMijw7k8Qk6XBytyurB6VvztjDhSONSo35cQdoXdAOZO4rDBUV17ymEW74R9lR1ijaR
         Pz3BOHfj2gL3ixp+Ayii6+6FHbCy1HQCZAgIYDW2KFoNpzSEsLUl90uJ/ziTXmkDM4ad
         pQeuP4V516vSumJDkCGUHtY2NG9sI3Gmo+9qVJiFuSKpeKgoEAimzqak3yZBTXV719VD
         ktkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ki72/6YAKoVF7gNojeEpthdFU5ESKm5d77bZpGErSfA=;
        b=hiJ5eBE89UFxBMo2GyI5cZB6bQx0VN9jh/r9dsOp4a0ncbCnTj/4APpq9EvUg6bv9z
         sZQzYM4z+tudpiGXsjhd3XFBHGoZGZHQzh+13LSBH2uk3fMve9DzJehBtwceKh0JXURc
         mUiT5xcK7SRdK6yE5OUxw+vn2jED4Xjbdjg0oJCaOylODdvlBm25JBAJbf0s12KkMelN
         ilS4I7O4UxDK00uvGetx6j29+wZUNqNdZ8XV6NEo7lp90W/hVNOUkhGPUgdNwO9VwvLy
         bJ7C9y3o6SKdNDPRpmkI82J95EyvWbAOP7fL0b+7RTYFqvEUIiNHCkQlgMxKvQ4qdJL1
         GevQ==
X-Gm-Message-State: AOAM531ajTSqn7dmvKDUetXcaX1YziwOIQa1sAsI1Wsat3+NTs50lyAh
        xT6HGT5UBMi+GqPcj49ZhBW1vfzc6+A=
X-Google-Smtp-Source: ABdhPJz4bYvW6dVGrHpd3gxpBnkGqP5aPRlxf2WPYxL2KdVQyDQrfry9MceoWggdMp+t81MKoCyMVA==
X-Received: by 2002:ac8:5dd0:: with SMTP id e16mr5371510qtx.563.1641938096994;
        Tue, 11 Jan 2022 13:54:56 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:56 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 00/16 v2] Refactor and fix assertion checking
Date:   Tue, 11 Jan 2022 16:54:30 -0500
Message-Id: <20220111215446.595516-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The first 13 patches refactor and cleanup the neverallow and
neverallowxperm checking code to make it easier to understand.

The last 3 patches fixes errors in the assertion checking code.

This series is to prepare for adding not-self support to assertion
checking.

The only change for version 2 is in patch 7 where target_type should
have been used instead of source_type.

James Carter (16):
  libsepol: Return an error if check_assertion() returns an error.
  libsepol: Change label in check_assertion_avtab_match()
  libsepol: Remove uneeded error messages in assertion checking
  libsepol: Check for error from check_assertion_extended_permissions()
  libsepol: Use consistent return checking style
  libsepol: Move check of target types to before check for self
  libsepol: Create function check_assertion_self_match() and use it
  libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
  libsepol: Remove unnessesary check for matching class
  libsepol: Move assigning outer loop index out of inner loop
  libsepol: Make use of previously created ebitmap when checking self
  libsepol: Refactor match_any_class_permissions() to be clearer
  libsepol: Make return value clearer when reporting neverallowx errors
  libsepol: The src and tgt must be the same if neverallow uses self
  libsepol: Set args avtab pointer when reporting assertion violations
  libsepol: Fix two problems with neverallowxperm reporting

 libsepol/src/assertion.c | 193 +++++++++++++++++++++------------------
 1 file changed, 102 insertions(+), 91 deletions(-)

-- 
2.31.1

