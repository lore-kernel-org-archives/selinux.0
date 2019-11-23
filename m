Return-Path: <SRS0=YAEg=ZP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42515C432C3
	for <selinux@archiver.kernel.org>; Sat, 23 Nov 2019 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E9E20726
	for <selinux@archiver.kernel.org>; Sat, 23 Nov 2019 14:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNvv1thM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfKWOmy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 23 Nov 2019 09:42:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38060 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfKWOmy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 23 Nov 2019 09:42:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so10936527wmk.3
        for <selinux@vger.kernel.org>; Sat, 23 Nov 2019 06:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XQLf3bmfmWTZrIVZY6yW4Ym/te8lHnG3rc1k22eFYM=;
        b=rNvv1thMHpcmwBVskOrB9TWR6fPIddDKQp0vTdGQiFX995xIy/5j+Oy5PhBA+bz3lr
         IDZiGvfFyZvFRp1KRZNdusRr53u4M7mw2BRMKuWeo7145E87U3jefsw1KE/E+2RBe3kX
         BogiX2eKOa8noxPyDm6baUCN96aHSRJzlbaCpSS4DnL+mS/+EPycaX2Og1rudIhTX5RN
         wEbjbRFDT8epiy3HGkY8g/AQMvliyrNH76AYDYIjXJlk8WwMg59HYYM+/GkjwSjy80JJ
         bc8YMJtMGhY2tVa/ZD2TXOgs3UAKuQv1AS5L5J+2kMhvlYZwC8TirFpHoVccbCsUeTpj
         luiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XQLf3bmfmWTZrIVZY6yW4Ym/te8lHnG3rc1k22eFYM=;
        b=KrGU03TVlESOjNJdH9mhBU5W+xNuPaK+k0kUxHE6MQcFwsAqOvN6lo6d1qNTmr22uM
         4I2C7HVRK5/7fqUZL+qc0V6rRSU/5L8nuiYIB/85HOkPeIXpqBIcjCZVsowlgwio4SDZ
         vTyDsCsTY/5zwcqfeOD/s4y0IrfBjgvAZe8JgcxWW6U543pdDe8lTLzQ+bVVluBEwwyn
         Bz4psaWtnnAQF+Kzke6c0rOV9XDtjKtHJATae8SiPD02MThtfyuvNDOR3H5V3kg373kA
         P/FiRtgomH6tZpFuq72/BVEWaW8yA9B3YX32NWp7hc1WE48taiJhn2DMzd5L8Yke8qvn
         JyJw==
X-Gm-Message-State: APjAAAVXfuQdR1jXtR3FItVxCPVcRFAug2Dm6+nxT/i22qtUzsCRivb0
        oPNPg0vszDRXmsM/9rEjriO3Cp5i
X-Google-Smtp-Source: APXvYqwTpjRzIghlMmk00MBwEdJhj2FUjus/cfgZmES7e/S+geRN5CBjN3h+t/RFDdWKhcrMLaZwIQ==
X-Received: by 2002:a05:600c:305:: with SMTP id q5mr15874942wmd.167.1574520171105;
        Sat, 23 Nov 2019 06:42:51 -0800 (PST)
Received: from brutus.lan (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id o187sm2112090wmo.20.2019.11.23.06.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 06:42:50 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dac.override@gmail.com>
Subject: [RFC 0/3] Second phase of UserPrefix to UserRBACSEPRole transition
Date:   Sat, 23 Nov 2019 15:42:42 +0100
Message-Id: <20191123144245.3079306-1-dac.override@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In 2008 support for UserPrefix was removed from Reference policy.
The code to support this functionality in libsepol and libsemanage however remained albeit slightly modified.
I am not sure why it was not fully removed.

DefaultRole replaces UserPrefix functionality but the code in libsepol and libsemanage was only slighty adjusted to accomodate my use-case.
This was done in 88e334f1923396d5ace56b8439c731dcde0d1f3b (2016).
I do not use semanage and I do not mind using the old UserPrefix statement, but there is some confusion.
For example there was a report recently about how semanage does not document UserPrefix.
The documentation was likely removed from view because UserPrefix is no longer supported as such.

I want to make the situation better and this proposal is the next phase.
This proposal causes some disruption as Reference policy based policy often calls the gen_user() macro with the "user" prefix.

Example: gen_user(user_u, user, user_r, s0, s0)

This will no longer be valid, and the userprefix parameter in gen_user() can be left empty (or needs a valid role if RBACSEP DefaultRole is leveraged).

Example: gen_user(user_u,, user_r, s0, s0)

UserPrefix will now default to object_r. This should not affect common policy implementations.

The next phases will be:

Renaming the UserPrefix statement to UserRBACSEPRole, and renaming references to (user)?prefix to (user)?rbacseprole.
Adjusting semanage to expose UserRBACSEPRole.
Removing legacy UserPrefix (ROLE/USER_TEMPLATE) references from libsemanage.

After this the UserPrefix to UserRBACSEPRole transition should be completed.

This should get us by until someone decides to rewrite libsemanage to take advantage of CIL, simplify the code, and to make the code more robust.

Dominick Grift (3):
  libsemanage: fall back to valid "object_r" role instead of "user"
    prefix string
  semanage: do not default prefix to "user"
  cil: qualify roles from symtable when resolving userprefix

 libsemanage/src/genhomedircon.c    |  2 +-
 libsemanage/src/user_record.c      |  4 ++--
 libsepol/cil/src/cil.c             |  7 +++++--
 libsepol/cil/src/cil_internal.h    |  1 +
 libsepol/cil/src/cil_resolve_ast.c | 10 ++++------
 python/semanage/semanage           |  2 +-
 6 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.24.0

