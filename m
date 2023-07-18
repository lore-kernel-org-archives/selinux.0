Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5611EB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGRWBV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGRWBR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2CE1992
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:15 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76714caf466so573165085a.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717675; x=1692309675;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IjGZohETdjPHZY0jgJlCHUZfh0j2caOQw0qpHSDuUs=;
        b=Egpx/3mU8nHxuwS90A737HBe/wb3ru2UpMAjRsdRg9x1/YlYYqSuZOJs+qkRF2LX9f
         YnkAfHqW1XPrto0fHK1qxXzbMpu58JZdDGrdc+s4CTzQIQQKNWgcKcakX8XMoFRKaTiX
         BlyhT1kHQUFzvAnf4k4k/AyINf+zgCYrjlrpQ5ydvWHpSIZYTtjhPWdrzdiJ3IUNC/7o
         4Hl8r2coMYHVxZSxZV6T3aXjKAysyTfXXdPPygaRznbVGAWof4nWIR3ydae0j5kkF2K3
         Fot99/HlntMXPJURhaijWrRIb4NjvX8B5jsSrXBUcCHuW7bJJR1Oeku9yRcX3ZyqbrwP
         jU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717675; x=1692309675;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IjGZohETdjPHZY0jgJlCHUZfh0j2caOQw0qpHSDuUs=;
        b=EIk/9X1VHP3GW8mff2Jlx8R7bwiDReLVQjRczCDHbP9akUx1laYAoJf5eM1Y+Lm9Cw
         QixVAanzIWdGGZecKa6jRoex3q66fjHBPMq2yigVv8qNsBCfwRdOa34+6NFTs+FYl9fb
         g3SpPOSSIJqIAlgErNbUpqGBJDWDHuIJI5N0q5I9505hNMSOKuXq7gkwyhqo9MzLybvj
         ETPwhlgqCQup8VRq+cXwpBH1L5kJgFumtXcGOCKCQWNKxyz6zCtJkuOpqvaadoCuH0ju
         U4/jRQt5rJ3DX9ARaMt6jhjBnqiWBlddglPUR59s6/ZJrSkghcpJUZ6TYisUyGqHo1UH
         uKlA==
X-Gm-Message-State: ABy/qLbkDSvtLEjZ5M8/niJCqKF6Xd8BO71bdQ2uOKQWWyIAx4GzwlsP
        d7fgUiXHjW7OSimXo86jgsWzyzGfkahq1fNxCA==
X-Google-Smtp-Source: APBJJlGx4IU9+zM6kx05Ik9M0KN19dtlnJCgZkzHF+W/3Owaw+2ZzuGTFIJ7zOhdg0y+Y/xBZFJgDQ==
X-Received: by 2002:a37:5802:0:b0:768:2193:6023 with SMTP id m2-20020a375802000000b0076821936023mr5935731qkb.58.1689717674926;
        Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a103a00b00767b24f68edsm890832qkk.62.2023.07.18.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:14 -0400
Message-ID: <04dcd1f6040e03c5533b3259629988f7.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/20] selinux: avoid avtab overflows
References: <20230706132337.15924-3-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-3-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Prevent inserting more than the supported U32_MAX number of entries.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
