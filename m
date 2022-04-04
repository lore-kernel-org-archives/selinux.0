Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F175DC41535
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382568AbiDDVbT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380327AbiDDTer (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 15:34:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453182124E
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 12:32:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so22100350ejc.7
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VgO6d6lm0OOGvRr20KO7FvSUCyunHGQ0dxV3M5k2OoQ=;
        b=2bSfLduqOf9N4UfXpHNZdsaDD+XyuSZ5J8vz8j5+p8xi1SYGc7n/s/aPZOcFYrgFvc
         aUyo5kHyGm99X07FpLh/0Ai8QoOSTFHLSrirz89twpYswHSZMveFLgqOEuYBH9XdLOl3
         B7CLDra9Q8wn9CWqcToLjHntuivXWxOHUFWYrwnVhCJUyfBBsTzvyNbbaSx7/Tfu06wD
         d6pojF+pMiY3XLmZV96L44We0CQfDAQ9njb8PyY2TNohBO8+4b7uygqC9u6dC07vklCy
         ypeBfXYzw1mtuVlKk3BiLwJx6fOlooGLOlGWqGLUSL0cIbl6AjVQfyaDC309hj3ujywM
         CBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VgO6d6lm0OOGvRr20KO7FvSUCyunHGQ0dxV3M5k2OoQ=;
        b=L02rGOBRHqlEQ0JyU+r56qRlR/ZKmSzitQbwKnU/byT3LJNWLJLAcxa18Or1PnOINe
         urrlC1VNHoSsUbV972fLs4Wxvt8zWTkshySSgKR6EZJdq6iZ6E8vsVR7auwVw1Ig7643
         /wtozBLDL7Jqcb23faM8yqbKcY2d0OF/CGQtOZIesFLiTQ82ihNchzYVQqEPnEBCQchr
         oF2monG0yc0gFgZGBRzcZglUlrbgqzGY2120ReApHGXCaoKHtSYGLcyZaw82irQy4HbJ
         zNKfA31crpXbN/Ffb53oDodGIdGyOJQQycZD2T2nPm4XfpRvnScKPR6nIl8rYrxmFzwA
         eLqg==
X-Gm-Message-State: AOAM532BaGxWiUhHdISk4Y4akvaGCnyGSfKttwu9Fu5NchTk21dCG8Uh
        FEbCFxP4b1j0i/jHAURvxpkLb7xvpnIKIDHvnQOg
X-Google-Smtp-Source: ABdhPJxsTLUB7w9oB2hOLTKtDzWQmCZzgKHHd60hUfhlNmpWM9jqkS5JAcqO23xLdTBrptJbOzcirYLGRutmY6LBE6I=
X-Received: by 2002:a17:907:7202:b0:6df:83a9:67d2 with SMTP id
 dr2-20020a170907720200b006df83a967d2mr1593177ejc.327.1649100763379; Mon, 04
 Apr 2022 12:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220325173013.448231-1-jwcart2@gmail.com> <87v8vy30xz.fsf@redhat.com>
 <CAP+JOzQQ16Up41MjBKe2xpz6FMR0mhLzDhLpwu8oSahiptuN0g@mail.gmail.com>
In-Reply-To: <CAP+JOzQQ16Up41MjBKe2xpz6FMR0mhLzDhLpwu8oSahiptuN0g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 15:32:32 -0400
Message-ID: <CAHC9VhR5f6CpfXZOHMgVK21npaVXzvCDJhTrxKmr=WfuEY_Qog@mail.gmail.com>
Subject: Re: [PATCH] Add a file describing the security vulnerability handling process
To:     James Carter <jwcart2@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 30, 2022 at 3:07 PM James Carter <jwcart2@gmail.com> wrote:
> On Mon, Mar 28, 2022 at 5:01 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > James Carter <jwcart2@gmail.com> writes:
> >
> > > Add the file SECURITY.md which describes the SELinux userspace
> > > security vulnerability handling process including who to contact.
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Merged.
> Jim

Thanks everyone :)

-- 
paul-moore.com
