Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9CEB64D9
	for <selinux@archiver.kernel.org>; Thu,  6 Jul 2023 13:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGFNYv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjGFNY3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jul 2023 09:24:29 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012C1FFE
        for <selinux@vger.kernel.org>; Thu,  6 Jul 2023 06:24:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e278e344bso994995a12.0
        for <selinux@vger.kernel.org>; Thu, 06 Jul 2023 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649845; x=1691241845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzvXFSCF9KljaGfjOzEbY1a8bJgSlIMuMFtuBQF2RF4=;
        b=iGwaheogfjd6fH/XsTkfQAUeDaGFP2oT5ZrbAS1VqPJdB7IiqlX7p22mjmB6ttfXqP
         f6TG8w6tu69JMg1j9DhNyyDSjR5+LBZOde2rrzGTbRGL6a2hcu9Fk5i3pMKk7q92kfvO
         qHp03z8lrm7JbTYEEtLfQjzVKKVrRGslZ0Zttx0M1F+PskFuScQPRvCyJzoMA2hQpGKL
         dTdgCD3lhUOHQ5tCOpUuglpIa+Bsnzp/+psw8enK0h/snQ2S8hRgTNm7u8U8cWZP7RkI
         ilGkABov/hAwZS/B1wwQkVzdugonJM97KKFjhPN1gEuI/SQ75zqYL/DsvCvUEX9eQPTm
         9JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649845; x=1691241845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzvXFSCF9KljaGfjOzEbY1a8bJgSlIMuMFtuBQF2RF4=;
        b=NXnbjpbOpuFWrDx3yYfasEklzAj1dg8u8ZsJudjYxI6olxooc/o2YDeL/+TSSYVLxp
         ZnnJi8k5a7H4sIB2iz95p7lpT6hvTtzRyWqzASoqMa8MawAzomZAWpgtGXAw09kdjOs1
         Kn72GqZoREHUHWzBMga3R5AKXbo0SawoW/YOuuMD7gdCnyLhvfnCphJFbX+Zc+5pIs4r
         rc+HJG9STfWFXKwJGmhHAZOCftWpFg5bz7G6v9O4Fr5lSaa0J1WcZ2zb8qO3wXxOIQem
         yOcaleRRhfaX9XA2XYxO8OvMTK9ozL7oV2a2VFMZrxT/xBVL9C/aFGCLFvp2Tu2EjDvc
         LE3w==
X-Gm-Message-State: ABy/qLaC8eXAbQD2UBRk/eq/OSuCFq+NiU/7fQJA54bj6fK0VYmJfkEO
        gke6lQ6dAgRnqp8nRXMGqZYA0pgA26xsW1/T
X-Google-Smtp-Source: APBJJlG6+ggT7stbFRLF8OoJv48ph5YrRQ7ATlFHkxIg+Zis9R87/aO/JJhEUV8AcUOwi23b3AVzpg==
X-Received: by 2002:a17:906:fd55:b0:991:e458:d04 with SMTP id wi21-20020a170906fd5500b00991e4580d04mr1261066ejb.51.1688649844930;
        Thu, 06 Jul 2023 06:24:04 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.24.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:24:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 00/20] selinux: be more strict about integer conversions
Date:   Thu,  6 Jul 2023 15:23:36 +0200
Message-Id: <20230706132337.15924-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The C language allows implicit conversions between distinct integer types.
These conversions can lead to unintended truncations or sign extensions.
Be more strict about integer types by using identical types where
applicable.

This patches utilizes the C99 feature of declaring loop iterators inside
for loops, supported since Linux 5.18.

Not all implicit conversions are removed, there are still many in the
selinuxfs code related to foreign interfaces, error-pointer related ones,
and some truncations around reading class, type and other identifiers from
binary policies (which might be subject for future work).

A possible instance of a integer conversion related issue might have been
reported at [1].


[1]: https://lore.kernel.org/selinux/0fad7bb5f511433ca59140a813e2d200@quicinc.com/


Christian Göttsche (20):
  selinux: check for multiplication overflow in put_entry()
  selinux: avtab: avoid implicit conversions
  selinux: avoid avtab overflows
  selinux: ebitmap: use u32 as bit type
  selinux: hashtab: use identical iterator type
  selinux: mls: avoid implicit conversions
  selinux: services: update type for umber of class permissions
  selinux: services: avoid implicit conversions
  selinux: status: consistently use u32 as sequence number type
  selinux: netif: avoid implicit conversions
  selinux: avc: avoid implicit conversions
  selinux: hooks: avoid implicit conversions
  selinux: selinuxfs: avoid implicit conversions
  selinux: use consistent type for AV rule specifier
  selinux: policydb: implicit conversions
  selinux: symtab: implicit conversion
  selinux: services: implicit conversions
  selinux: nlmsgtab: implicit conversion
  selinux: status: avoid implicit conversions regarding enforcing status
  selinux: selinuxfs: avoid implicit conversions

 security/selinux/avc.c              |  15 ++--
 security/selinux/hooks.c            |  26 +++----
 security/selinux/include/security.h |   8 +-
 security/selinux/netif.c            |   4 +-
 security/selinux/nlmsgtab.c         |   4 +-
 security/selinux/selinuxfs.c        |  33 ++++----
 security/selinux/ss/avtab.c         |  44 ++++++-----
 security/selinux/ss/avtab.h         |   2 +-
 security/selinux/ss/ebitmap.c       |  32 ++++----
 security/selinux/ss/ebitmap.h       |  32 ++++----
 security/selinux/ss/hashtab.c       |   6 +-
 security/selinux/ss/mls.c           |  11 +--
 security/selinux/ss/policydb.c      | 112 ++++++++++++++++------------
 security/selinux/ss/policydb.h      |   7 +-
 security/selinux/ss/services.c      |  36 ++++-----
 security/selinux/ss/services.h      |   2 +-
 security/selinux/ss/symtab.c        |   2 +-
 security/selinux/ss/symtab.h        |   2 +-
 security/selinux/status.c           |   6 +-
 19 files changed, 195 insertions(+), 189 deletions(-)

-- 
2.40.1

