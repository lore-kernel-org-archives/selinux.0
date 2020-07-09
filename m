Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B07DC433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 09:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC332074B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 09:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="dJdKkaxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGIJEF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:04:05 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:57506 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgGIJEE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 9 Jul 2020 05:04:04 -0400
Received: from localhost.localdomain (brutus [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id BE9CA2A1007;
        Thu,  9 Jul 2020 11:04:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl BE9CA2A1007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594285443;
        bh=JeE3CjGJa6i0ovgAQyMewMYnht8q6g7hybg0at/+W0w=;
        h=From:To:Cc:Subject:Date:From;
        b=dJdKkaxl8NmzdjPJ3RuZVqGY04fn1x7Yod7msMeTY6lths5BRdFV+PLezjGyRj4Gi
         mwfp2dejgCAzf3s5vR9nhgtLNPKxZ9Vpck4wVzoHwAF/p8vTXPbHooGJjbFr5rQJi3
         xkJBkd9GOfRqTGlhMPShmO66CimntOKWaqWPptZI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Cc:     Dominick Grift <dominick.grift@defensec.nl>
Subject: [SELinux-notebook PATCH] avc_rules.md: mention secilc with the neverallow statement
Date:   Thu,  9 Jul 2020 11:03:52 +0200
Message-Id: <20200709090352.1681563-1-dominick.grift@defensec.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I was unable to determine whether checkpolicy can be told to disable
neverallow checking.

Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
---
 src/avc_rules.md | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/avc_rules.md b/src/avc_rules.md
index a9dead5..7e62d04 100644
--- a/src/avc_rules.md
+++ b/src/avc_rules.md
@@ -182,8 +182,9 @@ auditallow ada_t self:process execstack;
 
 This rule specifies that an `allow` rule must not be generated for the
 operation, even if it has been previously allowed. The `neverallow`
-statement is a compiler enforced action, where the ***checkpolicy**(8)* or
+statement is a compiler enforced action, where the ***checkpolicy**(8)*,
 ***checkmodule**(8)* <a href="#fna1" class="footnote-ref" id="fnavc1"><sup>1</sup></a>
+or ***secilc**(8)* <a href="#fna2" class="footnote-ref" id="fnavc2"><sup>2</sup></a>
 compiler checks if any allow rules have been generated in the policy source,
 if so it will issue a warning and stop.
 
@@ -211,6 +212,7 @@ neverallow { domain -mmap_low_domain_type } self:memprotect mmap_zero;
 <section class="footnotes">
 <ol>
 <li id="fna1"><p><code>neverallow</code> statements are allowed in modules, however to detect these the <em>semanage.conf</em> file must have the 'expand-check=1' entry present.<a href="#fnavc1" class="footnote-back">↩</a></p></li>
+<li id="fna2"><p>The `--disable-neverallow` option can be used with ***secilc**(8)* to disable <code>neverallow</code> rule checking.<a href="#fnavc2" class="footnote-back">↩</a></p></li>
 </ol>
 </section>
 
-- 
2.27.0

