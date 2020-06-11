Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A045EC433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D5720842
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsM38tPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgFKOGP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFKOGO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 10:06:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899C8C08C5C1
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 07:06:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg4so2369447plb.3
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lAbkb/Ju57jDnQU0Pl0WyBe38PQHFxDeTES3Un/JWOA=;
        b=IsM38tPDe85NPi3Db/lU++dTA2bqbfKktdt8FfMOr0J7s7A1pUJA8XVcpq+PXUgG0A
         GT8H8ZsmROKcBQ+SkxLET6CWEhER7mFM8yIREKGtBY1xDpFaXE/KokVLNbtTB9C8WSJt
         th0EiRoSxndbhqgNAJ8E/OjT8DPfJlOjVQyJUTk8MFiGnSakqJD+V2IBA+xuB+cfM1Q7
         5Trq+8jLCy45SDKTW/SCcnlZ7K4GFS2D1PPtALHaYoic9lWf4S8zRhW1corVxjxxQL7y
         vGO2u+hO5a+0kOWBP6QT8+Sq32bIYhFnsE0QwoudHxjiW/VFzKvpdzm0n/sKyFw2G85g
         fW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lAbkb/Ju57jDnQU0Pl0WyBe38PQHFxDeTES3Un/JWOA=;
        b=hECTQPzLhLmJ/+jYqPx3v6bIOqoGwZY+LZ0pwOazsGt683Gy2FSLmhOIV/eFrByRzs
         lwgNRUv8BshxIBxtNwgqlKk1rY5nd4LpLCz5RKdgDJ5KoWvbFiyprPO/NIoow3Wj/KYH
         Rx54koq8Clk+rDTcc0HFhkfLaDRik+KwCe4m/shvuyuQX29NQ8JDLgo2VTp8z7qUxp8y
         EFEn4/eYdz9LyUFNYfWDErM94P4uvRyvKnTqOm2ALPFWy2wZUGImjKSci6bL3EWbAM8a
         RpeQiTPfQIldELr0d/tAqu34AhWb4TU+9sRi8nSp26C6VguYhz31wU1LxRhHO2kWrcoX
         LKKA==
X-Gm-Message-State: AOAM532d/z/KvaHyDAJd7MFqJNgck4S9PPYHSRQARerGloIg1R1enTG5
        pAb5pa3MxAKZU53CPlfkrXk=
X-Google-Smtp-Source: ABdhPJxLpGREFySPzK7rmHjdQSd+mOOdhzqhKNNT3NZFYqBoU+xnBReCllSExCjYWv8bMV30qAPMww==
X-Received: by 2002:a17:90a:30a9:: with SMTP id h38mr7748010pjb.7.1591884373175;
        Thu, 11 Jun 2020 07:06:13 -0700 (PDT)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id 71sm3519810pfb.20.2020.06.11.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:06:12 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     paul@paul-moore.com, plautrba@redhat.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: [PATCH] ci: dont use hardcoded project name
Date:   Thu, 11 Jun 2020 09:05:57 -0500
Message-Id: <20200611140557.6359-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFftDdqrAhkkeVpm9vExEL8ecnTEz5yeqVj27Zs7PC5_1NVxdg@mail.gmail.com>
References: <CAFftDdqrAhkkeVpm9vExEL8ecnTEz5yeqVj27Zs7PC5_1NVxdg@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Not everyone's github project is "selinux" so use the projects
name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
the absolute path to the project checkout on disk, so the
basename should be sufficient.

Tested on Travis CI here:
  - https://travis-ci.org/github/williamcroberts/selinux/jobs/697201376

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 scripts/ci/travis-kvm-setup.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup.sh
index 864dbac96a46..ceedaa6f4e27 100755
--- a/scripts/ci/travis-kvm-setup.sh
+++ b/scripts/ci/travis-kvm-setup.sh
@@ -120,6 +120,7 @@ fi
 # we don't get blocked on asking to add the servers key to
 # our known_hosts.
 #
-ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/selinux/$TEST_RUNNER"
+project_dir="$(basename "$TRAVIS_BUILD_DIR")"
+ssh -tt -o StrictHostKeyChecking=no -o LogLevel=QUIET "root@$ipaddy" "/root/$project_dir/$TEST_RUNNER"
 
 exit 0
-- 
2.17.1

