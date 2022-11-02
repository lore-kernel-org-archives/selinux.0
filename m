Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE8C433FE
	for <selinux@archiver.kernel.org>; Wed,  2 Nov 2022 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiKBOBm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiKBOBK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Nov 2022 10:01:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830C9FD21
        for <selinux@vger.kernel.org>; Wed,  2 Nov 2022 07:00:47 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h21so6332553qtu.2
        for <selinux@vger.kernel.org>; Wed, 02 Nov 2022 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGtzrxIutUYob6LwzVdL1wyAuWgx7uTaMGUCm6wkCiU=;
        b=AqrEYBOcS6CU429Lb0M5cqOYb5TvZ+AuhKtn0d3QFquJvALKiedTKUlbYUw7OWnHCg
         bwz3aRrULnQazBe1IJNQnqKPCzH+1QJfDSOJh1QMFJWaDPTriWNWv1RrEXHy5Rrzq4Jq
         kyHI8l/DyFQ/+oKi0TBgDaw5yCCY8oJdsCV7+pR/OhmJQQ5W8Oymwv2WgY2z2OvZ0+Qo
         Kvr/RpOpWLdn0O1/VPh9aYzcHtQx3QCKFJQWDoiYesFCXodOUw72Cg6ejXDgI4JptdYR
         3IxeujucyuHEDVFUvftK9NJUf4rTXGwFh/lz6gSOlLj/PdKx33Ls8Nm+mueJZF8hphHT
         rwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGtzrxIutUYob6LwzVdL1wyAuWgx7uTaMGUCm6wkCiU=;
        b=7/9MWjqTDOoXNdq8CWYHfkB2MhPueOXPKW0NE1CH30hAIfZexy62zNG9nERu4RQmjU
         oGODQIiJTxsNzRZdB7JdO/hQQ7hsAFfoLOffHlCMaLj8bvPRZ1eqipW6rioSBiUBn2dS
         Ku6BBOZN6yRM7R/rk392obSoan0qUt00urIS+dNRY26VZxLUwWCiJX084zvaKIugY+da
         BhLXMz0oyEfEAn/YyZx4jqroBrQFq+kdkySCnw0iUNSbojRs3wUw0cKNs/V4DKJa5s1d
         wTJpERYaGY2lL9OFAFMKagTDvQDAl4wjCWSLt7NRl4pKjiwFQj8EIb/TtJp9KAOzs2fF
         LpkA==
X-Gm-Message-State: ACrzQf2gHyaYBaK4MGrNg7Q6xXyBjXpbq5r+drKzZ66RLYP/HFIKPnHu
        aJm9BK23Z4MYSFS1yB66MtfAMNQAMCc=
X-Google-Smtp-Source: AMsMyM4ZP3VGMEyKJeczVy4AwEi6N/3fmkwYVRBTF1YM7vONQQIx3SnE2z8Za3BM1RbiiPGZ/PKi1w==
X-Received: by 2002:ac8:58c2:0:b0:398:f5c4:9bed with SMTP id u2-20020ac858c2000000b00398f5c49bedmr19489607qta.367.1667397646557;
        Wed, 02 Nov 2022 07:00:46 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id q6-20020a37f706000000b006ce0733caebsm8449846qkj.14.2022.11.02.07.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:00:45 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/5 v2] scripts: Remove dependency on the Python module distutils
Date:   Wed,  2 Nov 2022 10:00:38 -0400
Message-Id: <20221102140039.914518-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102140039.914518-1-jwcart2@gmail.com>
References: <20221102140039.914518-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The distutils package is deprecated and scheduled to be removed in
Python 3.12. Use the sysconfig module instead.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 scripts/env_use_destdir | 2 +-
 scripts/run-scan-build  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
index 8274013e..89d989a2 100755
--- a/scripts/env_use_destdir
+++ b/scripts/env_use_destdir
@@ -43,7 +43,7 @@ if [ -n "${SBINDIR:-}" ] ; then
     PATH="$DESTDIR$SBINDIR:$PATH"
 fi
 
-NEW_PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(plat_specific=1, prefix='/usr'))"):$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
+NEW_PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '/usr', 'base': '/usr'}))"):$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))")"
 if [ -n "${PYTHONPATH:-}" ] ; then
     # Prefix the PYTHONPATH with the new directories
     export PYTHONPATH="$NEW_PYTHONPATH:$PYTHONPATH"
diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index 77e02ca9..931ffd2a 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -21,7 +21,7 @@ fi
 # Make sure to use the newly-installed libraries when running tests
 export LD_LIBRARY_PATH="$DESTDIR/usr/lib:$DESTDIR/lib"
 export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH"
-export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
+export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "import sysconfig; print(sysconfig.get_path('purelib', vars={'platbase': '/usr', 'base': '/usr'}))")"
 export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
 if [ -f /etc/debian_version ] && [ -z "${IS_CIRCLE_CI:-}" ] ; then
-- 
2.38.1

