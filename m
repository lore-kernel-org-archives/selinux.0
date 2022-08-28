Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0479EC0502A
	for <selinux@archiver.kernel.org>; Sun, 28 Aug 2022 12:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiH1MOP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Aug 2022 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH1MOO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Aug 2022 08:14:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACD31C116
        for <selinux@vger.kernel.org>; Sun, 28 Aug 2022 05:14:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bq11so6973747wrb.12
        for <selinux@vger.kernel.org>; Sun, 28 Aug 2022 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:from:to:cc;
        bh=rWhaO3ylTxUS6kzVQnM+E5FOc4XZHBdjwlTD85IcsvM=;
        b=CCzoO1JoYcsTT77gttyWGADIc//nwqguRbARGTr6oS67ac1uklje7B1FoYrYu5zsfo
         ORAjpMyK4ULK+iA/qM/TgNHjdayKjDsIheKjSvm1L8f/JWL308hDbyoUp6oEaY+s1Epd
         8nvzqXolhQNr3JPVtU4WSIPwZ7xnPvrLDYLpsuVYaPkFb4rXwv/JK66C67NJlOiPJLXa
         BUYIdv9js+8UxH5DIzXpeTb6hlf5DX1nCSu+gb9U4JkPgd674G/eiex1jiGg3EdA4aZH
         l7/pkjbT9QAxmDyHg8204yWc76ytbdkls2N/RgL1M0QQyqrYR0Heaa+2TBL3DMYs2ANZ
         9XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc;
        bh=rWhaO3ylTxUS6kzVQnM+E5FOc4XZHBdjwlTD85IcsvM=;
        b=iKkSkLNLOr392jstAi+zm+uuwK/FEkyEI5iXV2b8rFSTcpBQ03RPUtwFvZLnkQRPAF
         uCkH+oJFKPc/fac2GuFYiyCC5d/2lhD/uPlfQ+Tu9ksz2pJIlF8aer8y8r3s4MuPT6tm
         83AbcyW6mw9JpBn3bu4EM5nbUw67rNKw06YP0wcvLDmgMb0L2mdAUWFJkNBuwUcbUgcq
         ovt8ONDJYp6VlPC14/p8dPnb0j8NGq9NkjvPyNyRkOygkgqq7KvbZSml4pCd7Pi5/Bpr
         6w4IjFdTUr74w0PbnNBowqpGYNTCC+RewjDhZQOx3THgu+v2sUpfl0Kqs1B739UvOgxG
         JI9g==
X-Gm-Message-State: ACgBeo31qi43vQ/jFJrGOqiylFsHR+C96W6iE61hkJFkXIl1Mq0o98i9
        hjV2fPQgQafd6PTFPqAfNjMgn4EDKtc=
X-Google-Smtp-Source: AA6agR5DDyR4etTeg099Orwya3i/ywBDN/jRCUPj7GUc8W8aCVCx8QvXBCYJZdcqhvlfl131W4V1+w==
X-Received: by 2002:a05:6000:1561:b0:225:337b:454b with SMTP id 1-20020a056000156100b00225337b454bmr3877975wrz.660.1661688849774;
        Sun, 28 Aug 2022 05:14:09 -0700 (PDT)
Received: from ?IPV6:2001:a61:3450:ee01:9da9:8337:59d2:c8c4? ([2001:a61:3450:ee01:9da9:8337:59d2:c8c4])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003a8418ee646sm2549674wmq.12.2022.08.28.05.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:14:09 -0700 (PDT)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <4ad30dd7-ec19-e88a-848e-98de8af7a16b@gmail.com>
Date:   Sun, 28 Aug 2022 14:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: [PATCH 1/3] secilc/docs: selinuxuser actually takes a string not
 identifier
To:     selinux@vger.kernel.org
Cc:     bauen1 <j2468h@googlemail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Update parameter table and add note to example.
This can very easily lead to confusion, because secilc does not reject
e.g. (selinuxuser "admin_1" admin low_low).

Signed-off-by: Jonathan Hettwer (bauen1) <j2468h@gmail.com>
---
  secilc/docs/cil_user_statements.md | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/secilc/docs/cil_user_statements.md b/secilc/docs/cil_user_statements.md
index d5674f12..45a52140 100644
--- a/secilc/docs/cil_user_statements.md
+++ b/secilc/docs/cil_user_statements.md
@@ -429,7 +429,7 @@ Associates a GNU/Linux user to a previously declared [`user`](cil_user_statement
  </tr>
  <tr class="odd">
  <td align="left"><p><code>user_id</code></p></td>
-<td align="left"><p>A previously declared SELinux <code>user</code> identifier.</p></td>
+<td align="left"><p>A <b>string</b> referencing a previously declared SELinux <code>user</code> identifier.</p></td>
  </tr>
  <tr class="even">
  <td align="left"><p><code>userrange_id</code></p></td>
@@ -445,7 +445,8 @@ This example will associate `unconfined.admin` user with a GNU / Linux user "`ad
  ```secil
      (block unconfined
          (user admin)
-        (selinuxuser admin_1 admin low_low)
+        ; XXX: Because the user_id is a string, the fully qualified identifier needs to be used here:
+        (selinuxuser "admin_1" "unconfined.admin" low_low)
      )
  ```
  
-- 
2.36.1

