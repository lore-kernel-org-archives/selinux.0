Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC68C43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 21:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7918320830
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 21:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tYk7hYa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfCYV6V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:58:21 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:58135
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728912AbfCYV6V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 17:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553551099; bh=G0kqvuo1j5mExs5ds4YsByQlZuLfZvkls1R7Fe2U150=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=tYk7hYa5U0ow7APa1Jkf+6M6rdbCH/GVHEKQN/XIKuy81NV7CEisT+1DWz74Sxqh3FMgJUpBvuPYHBmGQsJYwkuqgyuxrloKuFnmiFHmp4wOMkyxBf6SHky8pw6Qgky3RKRtqF4j4XhZvx5lVcpCug4GJPNekRX7Y6qifIflQ9y7OU01VaZY+XK6L7mKXJaUVO9lc6l1CGRuePIGlw9MKCruDvdrha/QTTEbrH7/aCK+WFiDbkJ0zYINsQ3A/tZrNO0DrXQwyYRybnAUrOtK0vkD0HsnG+lJopYeYD12nhsNdVGkv8vuVrG5d5qBCfkTt37+ClaUPVmunGtxlR9Nsw==
X-YMail-OSG: NJytgyEVM1nc22uKgt8nfI8Upvw11_bCm2_xrvjvIjzgsH3r_2zDWpX7ZJPGXIz
 B0HlWJVTOhj5F304rle.jD1AZWQ6Qb.dcRgrK0dC2VPtdB2o1ay.sHRl118yWZ6xLvakSS_yDMlj
 v_fta3uW8UA5ZVQtlXzW5mP.cF669qxSIAW4CrHUmA6ml5dkPK3Gw8FgqytQl.IcOESqDem7RTrF
 ws41v0XFNtKRsXX6j856OqXNRwInOk6JWn7TWpcavN8pytCXu5D7pv62cDV5sP2cZQ8_ACHnli_b
 cRDs.HoNfKkzVcl1Fgp30UfMcALe0BSLeuStb1bEln_jfK2up3e452Tckzm1SMne0IdcVSeHLB7v
 vWMFuPIoQGepad.JGvzUUYKTbQPSNntsWmNTMvnYK9ilV8lW7JRTh9vYP2zT24T0E7Azko0ol7yO
 iR7swBlsUl30oMZwFZdnmEe.kjogSqXOAhm.H9xvuHhRYfsbfDICHwYr0iw6fImDs2WtMHSg1W55
 wCHQeWPaBnp6Jo4U514hILpgVKNKQxxlyq7nAIzYDbo3IYHhKARUZR7dDYcmh6xa8.4erWjkxq9f
 WDk3euw7w2gHVkidxftRr9v6mCXASQo2Cn85vwEcIgPYkrO7fELulmQkHoY6Ffx6iHwIH02YayXY
 DWyk4t0jTD3cbqZA86BMQ9xtS.xg_ZfRufdu5wgV7R6cxK6f_Mvo2lYwL6vRlrC8IV3M6RyUN4e7
 tzgVTcfELQUOTJoyEyinvtGGv.bLA2h9VCdd4mL9WqKa4yOUvuSuHPmPaICEkshEUjVcWHdTQxsI
 FWdP4bH7IOZsabVe12bqESUO0BfFVViPKLs7PV0dPwKwJdtGxQAWjmcTSbLOUoz0R1kbEFPzOW.H
 kqBlZrW06c5uNOs4dsKS1hkEZBtW6.R5Jssur1wi3iYrxp4MlwyAeVerN1a72.Bz9komod9EKfsi
 5_CHxuayPXCkLhpoIvBjCzdDfh2_On8nwMJ0YAkHe4PilQMkJyA6BfQhGvvohneLrIu61UUpgOu2
 GqVf0BMYPdXcE49qewCX5sb08Elf.BKJ1q8jhdzcSEgDRNGFYBePb6DlKTNoUx5SCb._v66gRX3B
 dL7jN5YzqojlIRS6nkuZfzA.StItAvksEHg8zqKNyRuZV84xpXqxDxZw4Ak0608dPsHtLrDd7heJ
 jngFAfJ0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Mar 2019 21:58:19 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e1c08cecb60dd1bba4a93a62587618a7;
          Mon, 25 Mar 2019 21:58:17 +0000 (UTC)
Subject: [PATCH] Bad file pattern in MAINTAINERS section 'SELINUX SECURITY
 MODULE'
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212756.27603-1-joe@perches.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a0847fd8-0b9b-69f5-e9b8-1e1cd3b5052d@schaufler-ca.com>
Date:   Mon, 25 Mar 2019 14:58:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325212756.27603-1-joe@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The include/linux/selinux.h file has been removed.
Remove the entry from the MAINTAINERS file.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
  MAINTAINERS | 1 -
  1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..1039c34dff3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13947,7 +13947,6 @@ W:	https://selinuxproject.org
  W:	https://github.com/SELinuxProject
  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
  S:	Supported
-F:	include/linux/selinux*
  F:	security/selinux/
  F:	scripts/selinux/
  F:	Documentation/admin-guide/LSM/SELinux.rst

