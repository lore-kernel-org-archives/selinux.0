Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85256C433FE
	for <selinux@archiver.kernel.org>; Fri, 25 Mar 2022 11:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353412AbiCYLDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353356AbiCYLDn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Mar 2022 07:03:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B052D0AA1
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 04:02:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so14588887ejc.7
        for <selinux@vger.kernel.org>; Fri, 25 Mar 2022 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:in-reply-to;
        bh=0sU49Qn/ULUU8j1SeL39Iuenz7n14QMmEpvv6BRFE48=;
        b=oCBZvdYXhfbMyHnPwSOjsv3H9DnbkhfYlhAVfgdV5NKoMeH7Zwv0zeXD1RgBmzOGjs
         xZg0bNa8V9DCV1D77fUSyqGh3+zs2agY+7q5FF8O2f9tXa6SsIHX1eono4PzCH8+5mh4
         NbfUhSTBuXv6GdiT8GaOvEDRd39qg0QKDrr3PS/b2SswF2h7f33+1JbY+XuuA8dAYzWh
         aIoFpeoVwl9hatV7HvjIuDkZ1Fy+AgBxAyNPLU2cAdpKzUCo8hU4d/H/u7RrQjeMVJir
         uK6mG07ZmPKfqulMCtev9f75JIn73OHoxQ+sFf0FfF5GzFQCQRT/3o1XZ0blU6XrHZSB
         SjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:in-reply-to;
        bh=0sU49Qn/ULUU8j1SeL39Iuenz7n14QMmEpvv6BRFE48=;
        b=Tv1BrNsjAYpqkDwu3+KIz8priilCq6pky+N+3pUYbFNlVyEaYRoB56pBCw7Yo70Xgg
         D/Z4lLMn/lWOkxR5+dMzGekgbQvoQHE1wYGTNoLzO1Zh1jgDsfJSAuZrmvi2H90mziXI
         dYUH3YKtkPc1kGVCPmsD5Qj9WtZqWIH6Fjq01qPCUO1Ab+qd48XWIhG+/9VdIzajg+YN
         4d6WGdwXwgEG/B95qAx62NvPYT61p1kxTld0oyB4BWS60d0ouSN30Zllfja3DxqhP0VO
         wYD+8PX5+6vvqI6dhsDNtHE6s/UgHLNVhPJ/yHaKIjUZERR85JZiDmPgTX+hngofget7
         KGzg==
X-Gm-Message-State: AOAM533eC0OgJWT6rys9fBsIltHRAF3sMsWVNOkGuq0gzUW0FNaCTDZv
        Uis6gN14WTpabA5+wA4ZAx0l/w==
X-Google-Smtp-Source: ABdhPJzP6mkhIuV1yLeKOLlJouj/OJgm3LgLVbahYZyJgrA1mgTfai4dO7C860RHTP2kMmtBW82dqw==
X-Received: by 2002:a17:906:e28a:b0:6d6:e2e9:d39d with SMTP id gg10-20020a170906e28a00b006d6e2e9d39dmr10848821ejb.2.1648206127884;
        Fri, 25 Mar 2022 04:02:07 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709067a0400b006d6e3ca9f71sm2183995ejo.198.2022.03.25.04.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 04:02:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Mar 2022 12:02:06 +0100
Message-Id: <CISWB5OO4TSD.1YIUVDSVYSIF0@otso>
Cc:     <Luca.Boccassi@microsoft.com>, <darrick.wong@oracle.com>,
        <dsterba@suse.com>, <hubcap@omnibond.com>, <jack@suse.cz>,
        <jlayton@kernel.org>, <kernel-team@android.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-unionfs@vger.kernel.org>, <paulmoore@microsoft.com>,
        <salyzyn@android.com>, <sds@tycho.nsa.gov>,
        <selinux@vger.kernel.org>
Subject: Re: [PATCH v19 1/4] Add flags option to get xattr method paired to
 __vfs_getxattr
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     <dvander@google.com>
In-Reply-To: <20211117015806.2192263-2-dvander@google.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi David,

this patch doesn't compile with CONFIG_SECURITY=3Dn:

./include/linux/security.h: In function 'security_inode_need_killpriv':
./include/linux/security.h:893:40: error: passing argument 1 of 'cap_inode_=
need_killpriv' from incompatible pointer type [-Werror=3Dincompatible-point=
er-types]
  893 |         return cap_inode_need_killpriv(dentry);
      |                                        ^~~~~~
      |                                        |
      |                                        struct dentry *
./include/linux/security.h:153:52: note: expected 'struct user_namespace *'=
 but argument is of type 'struct dentry *'
  153 | int cap_inode_need_killpriv(struct user_namespace *mnt_userns,
      |                             ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~

I applied the patch on linux-next tag next-20220318, but the relevant part
doesn't seem to have changed lately.

Regards
Luca
