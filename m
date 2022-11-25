Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4926C4332F
	for <selinux@archiver.kernel.org>; Fri, 25 Nov 2022 15:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKYPuC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 10:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKYPuB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Nov 2022 10:50:01 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08BA22B1C
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:49:59 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id vv4so11246734ejc.2
        for <selinux@vger.kernel.org>; Fri, 25 Nov 2022 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+YlTI+KPOrx4zypcMevF7/1WNGEqOxjaEeTqS390cM=;
        b=PF+eIklDddsENAIvuy0f0gKurznEmGh99w8hOWC8zTBPZRRXsaxYL+NMva0vMZZvhd
         sz08KyfScvDTPUUrq2hz22ClplEYyd5srsXiyfwy27jEXRWRemPySGYlTi7SHptOTDTd
         +dPfX7JpYW6SBtH//rboHtnMmvohKmRsEtEeQhhg4FWc67p7+mxfDJ+hyqHEE6aJ14S9
         8ynWOB4S7ovi9eFybWcR3ILSsohH+WMMfBJAikNvMSEUwmaMogG1tcDd3+Gb2O+iswEt
         o7Itn30AsOOnUt1doy8c7F7dY0PTIZ7T8t+aaG7/xkUYK1yihO4XIpYGSEeLeLgNhq/h
         jYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+YlTI+KPOrx4zypcMevF7/1WNGEqOxjaEeTqS390cM=;
        b=uZ/bGueGAMPIgtM8eU+eDBVB6gYG2zfRRL5rNVLDydZSbS3+DywzHf3O81H5JROetT
         mMsIAkmXQQomT+9vnmINocVoNPflMkfK62k2e1n4ryYaKzRn9PwhYcTd5YQcC8bsCi3F
         /6fjHEDZjhHgoHuqNH1elozcU70TtWgoOA0uLpWnMTU1NeRLmqM1f8+mrBeYp/VfLHR3
         vw/3+XaNQ4dkIA13/CC24QanHNVOk3zdp7f9gMCzvJmKQbcX+Bv/yOaSPdWXq+TQA89m
         w/m2R/ScBqnoBtSZA/fgAaoH8YlXmZwzRiIqPVg9iTtLmi0rnCIKBI0RHxvU18tZaEtF
         4W1g==
X-Gm-Message-State: ANoB5pnrQwzG/9AFr7WZ+P4Ev7oXltpqT867GHeX4S7ottIopQxGflbs
        UVMMMQP8z5T9BHPX5mp0VBL1NyvUWcM=
X-Google-Smtp-Source: AA0mqf7hg6K46C0vv8imRsiVYLwzaV4gEWkdHkJrrGLOfDkDcb0dAeYs2Ij+koyKucaVIK5D/mwygA==
X-Received: by 2002:a17:906:43c7:b0:7bb:c1e6:c4ac with SMTP id j7-20020a17090643c700b007bbc1e6c4acmr2427537ejn.757.1669391398434;
        Fri, 25 Nov 2022 07:49:58 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-154-194.77.3.pool.telefonica.de. [77.3.154.194])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090630ce00b0078df26efb7dsm1677136ejb.107.2022.11.25.07.49.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:49:57 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v4 0/6] not-self neverallow support
Date:   Fri, 25 Nov 2022 16:49:46 +0100
Message-Id: <20221125154952.20910-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support for using negated or complemented self in the target type of
neverallow rules.

Some Refpolicy examples:

    neverallow * ~self:{ capability cap_userns capability2 cap2_userns } *;
    neverallow domain { domain -self -dockerc_t }:dir create;
    # no violations

    neverallow domain { domain -dockerc_t }:file ~{ append read_file_perms write };

    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink link rename };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow spc_t spc_t:file { create };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow container_t container_t:file { create };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow chromium_t chromium_t:file { create };
    libsepol.report_failure: neverallow on line 584 of policy/modules/kernel/kernel.te (or line 31357 of policy.conf) violated by allow spc_user_t spc_user_t:file { create };
    libsepol.report_failure: neverallow on line 582 of policy/modules/kernel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:dir { create };

    neverallow domain { domain -self -dockerc_t }:file ~{ append read_file_perms write };

    libsepol.report_failure: neverallow on line 583 of policy/modules/kernel/kernel.te (or line 31356 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:file { create setattr relabelfrom relabelto unlink link rename };
    libsepol.report_failure: neverallow on line 582 of policy/modules/kernel/kernel.te (or line 31355 of policy.conf) violated by allow sysadm_t httpd_bugzilla_script_t:dir { create };

Using negated self in a complement, `~{ domain -self }`, is not supported.

Initial CIL support in the form of

    (allow TYPE1 notself (CLASS (PERM)))
    (allow TYPE1 minusself (CLASS (PERM)))

is included from a patchset by James Carter.

More complex targets are not yet supported in CIL and generating a CIL
policy file from modular policies including such rules will fail with an
appropriate message.


RFC v3: https://lore.kernel.org/selinux/20211204103516.17375-2-cgzones@googlemail.com/
Improved rebase and initial CIL work by James Carter: https://lore.kernel.org/selinux/20220111220823.596065-1-jwcart2@gmail.com/

Christian Göttsche (5):
  libsepol: Add not self support for neverallow rules
  checkpolicy: add not-self neverallow support
  libsepol/tests: add tests for not self neverallow rules
  libsepol/tests: add tests for minus self neverallow rules
  libsepol: update CIL generation for trivial not-self rules

James Carter (1):
  libsepol/cil: Add notself and minusself support to CIL

 checkpolicy/policy_define.c                   |  46 ++-
 checkpolicy/test/dismod.c                     |   6 +-
 libsepol/cil/src/cil.c                        |  12 +
 libsepol/cil/src/cil_binary.c                 |  91 ++++-
 libsepol/cil/src/cil_build_ast.c              |  10 +-
 libsepol/cil/src/cil_find.c                   | 206 ++++++++--
 libsepol/cil/src/cil_internal.h               |   4 +
 libsepol/cil/src/cil_resolve_ast.c            |   4 +
 libsepol/cil/src/cil_verify.c                 |   3 +-
 libsepol/include/sepol/policydb/policydb.h    |   3 +-
 libsepol/src/assertion.c                      | 144 +++++--
 libsepol/src/module_to_cil.c                  |  30 +-
 libsepol/src/policydb_validate.c              |   9 +
 .../test-neverallow/policy_minus_self.conf    | 369 +++++++++++++++++
 .../test-neverallow/policy_not_self.conf      | 370 ++++++++++++++++++
 libsepol/tests/test-neverallow.c              | 149 +++++++
 16 files changed, 1388 insertions(+), 68 deletions(-)
 create mode 100644 libsepol/tests/policies/test-neverallow/policy_minus_self.conf
 create mode 100644 libsepol/tests/policies/test-neverallow/policy_not_self.conf

-- 
2.38.1

