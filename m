Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EBCC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EC4320781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JftU4Ib9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgHDBdT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBdT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:33:19 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB55C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:33:19 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b25so29805144qto.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WpkBF1/IaE0FtLbqvyjw704eUzkjgl31yFW0QaV2S8w=;
        b=JftU4Ib9RkTSdiA+CA28mR7wwytCfO33oTBg1PqosSAi91HqC3ZJjJ4Eku2M3ErPGN
         JziSnppeN4M/lGk50IZ/qkj43m0P3GxzANRBDqWcqrK4hhRyxaTh6mfA1h14w8FNzq//
         4J9duIA5NtWtg9VNgw+Hf/Aj4TXSy1xtvvlPWo5QL02bsKgfONJcyuuNydxHmg8q+aRM
         dxVPLX3j66hgOXbMt5TiXO+2CtiAMFuOmWmZc0eCFSOsv1R5+9ONO+vRzWkSHoUJHKel
         wSaIRv7V3Cuv5uc33GX8ssxrrbvnc2eevOkDBwANDRrsMfGekP69Em4dWXq41oQqPozO
         TY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=WpkBF1/IaE0FtLbqvyjw704eUzkjgl31yFW0QaV2S8w=;
        b=nV71LvmkTO6aqR6ugPjb/bY96wrzSKi17OOVY+uWpQ2UqPWBKg9a8iFniitQ/GPAO7
         m6HXJC4u0JLF2tjL+A7Nrl/CEyiZKBMb21ckU3WTKWSU0Jjqzo57ydmPCSPbCFLZLQj1
         WYJexXhAYezFmeECddM6mWzNUhyeq7KOn7hYyHiAiZ1Prip6UY66i9qXesbclCRZcJos
         e8yuR3EyPcBMvhDK7R5M4/XY2M8dAdP3fjXtGhMFRI7CDh9chzg+97ZddHLCaYSq6Ihd
         4cYOfqayp+lOrjzt9fyjp7pQ87wPMAE0j7QrL3IYkQ4EcjFIuT1XQ6wHGyhL1tIsY4fu
         rkfg==
X-Gm-Message-State: AOAM532ezzDHN8jWSE7MZIWBtK3yRpr/EFIOUkT8XBcI8/mGGXajPqFW
        JKVggoBZpFFJkBCjooku3oGgm4rfLr38
X-Google-Smtp-Source: ABdhPJyOMq+kymEpMW4UF5L4+1PgRrBJ2isrbnHqThAarF+tK8LQ/X8g681jcB28YFsmvLShJ1Mdaw==
X-Received: by 2002:aed:3c1c:: with SMTP id t28mr13793058qte.74.1596504797876;
        Mon, 03 Aug 2020 18:33:17 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id h13sm22666412qtu.7.2020.08.03.18.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:33:17 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 00/18] markdown conversions and cleanups
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:33:16 -0400
Message-ID: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patchset helps to get us a little closer to finishing the work
of converting The SELinux Notebook to markdown.  I believe this is
a worthwhile goal for two main reasons: it makes the raw markdown
much easier to read (the HTML tables are painful in source form),
and it makes it easier to render the markdown into different formats
(currently HTML and PDF).

My original goal for this patchset was to complete the markdown
conversion before posting the series, but I now realize that was
neither a practical or good idea.  While this patchset may miss my
original goal, I do believe it is a step forward both in terms of the
raw markdown and the rendered formats, and I would suggest we merge
these changes assuming no strong objections.

For those who want to quickly check the markdown on GitHub or the
rendered HTML and PDF formats, I've included the links below:

* https://drop.paul-moore.com/21.HGW6/SELinux_Notebook.pdf
* https://drop.paul-moore.com/21.HGW6/SELinux_Notebook.html
* https://github.com/pcmoore/misc-selinux_notebook/tree/working-md_full

---

Paul Moore (16):
      build: explicitly enable pandoc pipe_tables
      css: identify table layout hacks
      css: style improvements
      x_windows: fully convert to markdown
      xperm_rules: fully convert to markdown
      xen_statements: fully convert to markdown
      vm_support: fully convert to markdown
      user_statements: fully convert to markdown
      userspace_libraries: fully convert to markdown
      type_statements: fully convert to markdown
      all: remove all the <br> tags we haven't gotten to yet
      all: unify example formatting (scripts, code, policy, etc) in markdown
      all: don't use "`" for formatting text, use "*" instead
      all: consolidate multiple blank lines into one
      kernel_policy_language: convert the footnotes to markdown
      title: assorted updates

Richard Haines (2):
      postgresql: update PostgreSQL SELinux Support section
      x_windows: don't call table 12 a table


 src/apache_support.md              |  53 +--
 src/auditing.md                    |  36 +-
 src/avc_rules.md                   |  48 +--
 src/bounds_rules.md                |  18 +-
 src/cil_overview.md                |  43 +-
 src/class_permission_statements.md |  44 +-
 src/computing_access_decisions.md  |   2 -
 src/computing_security_contexts.md | 224 +++++-----
 src/conditional_statements.md      |  36 +-
 src/configuration_files.md         |  10 +-
 src/constraint_statements.md       |  52 +--
 src/core_components.md             |  10 -
 src/debug_policy_hints.md          |   5 -
 src/default_rules.md               |  40 +-
 src/domain_object_transitions.md   | 138 +++---
 src/file_labeling_statements.md    |  58 ++-
 src/global_config_files.md         |  16 +-
 src/images/24-database-table.png   | Bin 44747 -> 0 bytes
 src/implementing_seaware_apps.md   |  28 +-
 src/infiniband_statements.md       |  36 +-
 src/kernel_policy_language.md      |  59 ++-
 src/libselinux_functions.md        |   4 +-
 src/lsm_selinux.md                 | 161 ++++---
 src/mac.md                         |   5 -
 src/mls_mcs.md                     |  45 +-
 src/mls_statements.md              |  84 ++--
 src/modes.md                       |   7 +-
 src/modular_policy_statements.md   |  28 +-
 src/network_statements.md          |  80 ++--
 src/network_support.md             |  78 ++--
 src/object_classes_permissions.md  | 255 +++++------
 src/objects.md                     |  40 +-
 src/pam_login.md                   |   7 +-
 src/policy_config_files.md         | 182 ++++----
 src/policy_config_statements.md    |  10 +-
 src/policy_languages.md            |   2 -
 src/policy_store_config_files.md   | 137 +++---
 src/policy_validation_example.md   |  14 +-
 src/polyinstantiation.md           |  31 +-
 src/postgresql.md                  | 145 +++----
 src/rbac.md                        |   9 +-
 src/reference_policy.md            | 321 ++++++--------
 src/role_statements.md             |  82 ++--
 src/seandroid.md                   |  91 ++--
 src/security_context.md            |  10 +-
 src/selinux_cmds.md                |   3 -
 src/selinux_overview.md            |   4 -
 src/sid_statement.md               |  24 +-
 src/styles_html.css                |  16 +-
 src/styles_pdf.css                 |  24 +-
 src/subjects.md                    |   7 +-
 src/terminology.md                 |   5 -
 src/title.md                       |  16 +-
 src/toc.md                         |   4 +-
 src/type_enforcement.md            |  55 ++-
 src/type_statements.md             | 672 ++++++++++++-----------------
 src/types_of_policy.md             |  31 +-
 src/user_statements.md             | 121 +++---
 src/users.md                       |  15 +-
 src/userspace_libraries.md         | 169 ++++----
 src/vm_support.md                  | 147 ++-----
 src/x_windows.md                   | 374 ++++++++--------
 src/xen_statements.md              | 370 ++++++----------
 src/xperm_rules.md                 | 146 +++----
 64 files changed, 2157 insertions(+), 2830 deletions(-)
 delete mode 100644 src/images/24-database-table.png

--
paul moore
www.paul-moore.com
