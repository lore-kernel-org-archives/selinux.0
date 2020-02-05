Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15579C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA64E20702
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VZ34h7vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBERXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:23:51 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:34034 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBERXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 12:23:51 -0500
Received: by mail-vk1-f175.google.com with SMTP id w67so782091vkf.1
        for <selinux@vger.kernel.org>; Wed, 05 Feb 2020 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FrYua1WCSYYqUntKrfPC0JZcDriROk/Dt6xg35qtsoU=;
        b=VZ34h7vqR8lQ6XlsKlYPICm9lwnjWo/JIChKoW1X1vE2isMo0j8ZITInsToqNkRm5R
         pFtUKVRX8lDTwvsnV0KVkByEZlbayOWGJ6NKZ28enmBizZGa3X4aNoyKrtfROOOMVhoR
         B89D+jDbg5vtJi3oYfS7f/Mogy/9JshsjTs3G/YYpUx8Dw9YZ1nrMvWeK3ZW1QeUnlXa
         xXBK31wG9VJC08SWsJg4NHk06k5PP/1wTevRRZWVs/HjL/DsPagJ3JCSpxfEHCC9VPwm
         2PU7xrvhFm2uXRZ4x0sK+mraVYvslROo4KdP4NQpiG+PRuTxapneWCJazC7TYRPx8sct
         UDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FrYua1WCSYYqUntKrfPC0JZcDriROk/Dt6xg35qtsoU=;
        b=UVOfh50STv6Rx+ZwvdocrTIUPGWQJclvTAfytylWI0VNZZazl12nYSf8SkAoGEUZC0
         roZyoaG2lNW12aLcEubT8weHLjM67sO+cVqFB83OAtBvqM22t03DOPnvzzbfAPdV+3hS
         ULIlmZmHk2+DZMya17sm3oE8Zwr+QP5OWlRi9tgAImeKiYO9ngXgLJU3Rx6HYL+M02Bb
         QYLpR3dOnSHmQbED2WDsuA99YkjJpB3XOpRgVOP0NQAGvE3OZOheSbTvEUYG1O4bhmGM
         Oo93QMf1Ra778E+7nS018GWZCLPNmOcV6tH0DunaZP1V4iu+NmyXQQF73WAAk0rOYI8L
         DV/Q==
X-Gm-Message-State: APjAAAVWUTz4XuaP2MTmp59ueqk0rJsP3ZEHwEEW9vkJBtvrw5ecdi+M
        OKuopgyQi0aj2XNotJN2wtTqFX9J1LXMN4poMIJ+sIZ1YcQ=
X-Google-Smtp-Source: APXvYqyxfuCOrSur3ahjvJxJUieseyvC7GTXHnpzD1+4fi13iJdKFGwSjBZaYUlKa+e58E5w8vb5kKQ22GPagcbSVzo=
X-Received: by 2002:a05:6122:1185:: with SMTP id x5mr2325678vkn.38.1580923429899;
 Wed, 05 Feb 2020 09:23:49 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 5 Feb 2020 18:23:39 +0100
Message-ID: <CAJ2a_DeHkT3i2dW=A_3MywTK+pqcEmYfRg4BLRHSKiUxiqjLZg@mail.gmail.com>
Subject: IPv6 netmask in nodecon statement
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

what is the correct way of specifying an ipv6 netmask in the nodecon statement?
I am searching for a valid netmask for localhost (::1).
'fe80::/10' should be one, but since the syntax does not support any
prefix-length, this is not compiling.
Using 'fe80::' seems to work fine, but setools is complaining [1].
Or should I use the full netmask: 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff' ?


[1]: https://github.com/SELinuxProject/setools/issues/40
