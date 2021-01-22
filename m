Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E2CC43381
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 10:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B045723A03
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 10:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbhAVKff (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbhAVK3Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 05:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611311273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHeRqgqyCnffTmUm5xvoDE1yPkAi8tJ29QZAJ4vb2SQ=;
        b=To0uByn0/1BAKHnLlH3eEy8y9mzXS1VZe0hSrKQDTFtki0XjaPA4NVj/oN9ucslOuQrnCe
        /mmq5YdnEquaJicxTjxD+LrqQD1N47GVxxWTa7Mi1HDETIRkHUrX/Si5r038z3kv093OMq
        9jpPiFcO+TOL3mlYs47EQg46Zjf8/0o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-ewZOAWBXNLG4C1ByvrVjNw-1; Fri, 22 Jan 2021 05:27:50 -0500
X-MC-Unique: ewZOAWBXNLG4C1ByvrVjNw-1
Received: by mail-ej1-f69.google.com with SMTP id n25so1772627ejd.5
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 02:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JHeRqgqyCnffTmUm5xvoDE1yPkAi8tJ29QZAJ4vb2SQ=;
        b=i6PFfrPCrH9NKnm+cpMMDnL7q7ZSbogjOND/3WweHGnxChrRRINbHZzgm0ZZaJVP8u
         SPl9Po0MOA3GFilLn0q38QYZMZof/+3o0uiEV2NWE0LAsUViyhl4KA+pvJotCYRtww66
         eFkz3vHaMiz+A9pjWcG6GiUNXz/Iw5+IgS1iOTUeQyawg5txakGFQaejruweSMTqKHB4
         j5LlmcXuCtlTes53rn5KD2Swb+Yu9XImUXfLD6FUgp5QAca7JaMXW8F0+kCGcUOnPS7g
         bA0ohMTX5KdongX62+RP8MiKUDjtNs5X4Gat4kI6+vYHTp4hDpYkw5uUfw+1S9prnt80
         BmAQ==
X-Gm-Message-State: AOAM533dmXGNv34Q26mcHiPQkjTB6nfkotl+wfCU4QMANRS9N5CwSQYL
        h5MHMBVQfG+fOYaoSkRrazHd8S/WXEEW6UTdFG15TNcatAZtlOOVFM35JPr3s8AivZFxJOxV3Ib
        Sf1dNyNUzZXaGpv5gCznoLy3hRsq9zd2Hf7Lpb+IGDJZuC2FrjqRk4nSfP7XBBR7YgyOmoQ==
X-Received: by 2002:a50:8757:: with SMTP id 23mr2629541edv.294.1611311269639;
        Fri, 22 Jan 2021 02:27:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3yTMXOc5kmwz66MtJCeM5vHuuxCWSX+uwKG7I9+rsUnpQchR+T3yB2uAwM2f7NRHh+ak5Bw==
X-Received: by 2002:a50:8757:: with SMTP id 23mr2629532edv.294.1611311269472;
        Fri, 22 Jan 2021 02:27:49 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id z1sm5047556edm.89.2021.01.22.02.27.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 02:27:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/2] check-syntax: use 'command -v' instead of 'which'
Date:   Fri, 22 Jan 2021 11:27:47 +0100
Message-Id: <20210122102748.38776-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122102748.38776-1-omosnace@redhat.com>
References: <20210122102748.38776-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In minimal environments (e.g. Fedora container image) 'which' is not
installed by default. To avoid the need to install an additional
dependency, use 'command -v', which also does the trick and is a shell
builtin.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tools/check-syntax | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/check-syntax b/tools/check-syntax
index 0ca79e2..2115a79 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -27,7 +27,7 @@ CHK_PERL_EXCLUDE=""
 #
 function verify_deps() {
 	[[ -z "$1" ]] && return
-	if ! which "$1" >& /dev/null; then
+	if ! command -v "$1" >& /dev/null; then
 		echo "error: install \"$1\" and include it in your \$PATH"
 		exit 1
 	fi
-- 
2.29.2

