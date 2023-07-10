Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF290EB64D9
	for <selinux@archiver.kernel.org>; Mon, 10 Jul 2023 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGJS1N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Jul 2023 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjGJS1M (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Jul 2023 14:27:12 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A518C
        for <selinux@vger.kernel.org>; Mon, 10 Jul 2023 11:27:05 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-576a9507a9bso86916667b3.1
        for <selinux@vger.kernel.org>; Mon, 10 Jul 2023 11:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689013624; x=1691605624;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oy4lK8CzDdtqbHuSGAF17DmX8m83NWsHS5QtzlnP2U=;
        b=VY3iGpnE8Ikrlh/lcRhiD3w2wVp4o61OAW7tr3rbgy00eqwi8SzWG2zirCTqJ4XrGO
         LuFykgMl9TSnesLpyGJ9DAyT+s6Vk+RnxCp2uv7oQBx1dCKvUnGywCmklfGAbYdON4uc
         3/AgttCVT4I0srXEsYtPDqt3xAZHNqbgem7bg/458nACDUZjZG7Kid/gCD5tIpdiSe20
         HTgkXrVDs4IQv1BMlWTGogfJBz+32KPQTTmnfFfSelr23GjHl5tn4ChbYQ5kZghYLcSi
         SMmqAO8YpsFzQVIzLuM3RQX456bKL1y0+2VZanccPnH7QHqcxFWG2+nMShOyiThHK64z
         Sj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689013624; x=1691605624;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oy4lK8CzDdtqbHuSGAF17DmX8m83NWsHS5QtzlnP2U=;
        b=X1VnP6qO4ROvNEScZqpFh7jOZfLfHYLOd5GKQhJpT0up5OzQruSWfzCjoSCEISpr7V
         iN/PnXEERusoKjkh679E3OgjzwGdd5I9jmVuwMzq/AwbzLYSXkC6aeA0PeZBJK2hdSRL
         8+Z1u2O97atuNWHRZ7wU1YwQ8N3Ovccf0wXOp2TZGrEkvZjojR3WdsoQhkvce4p7apvf
         Q4qIUVoew3ePishJ8szAOwy4SCccDOV8AYYuRI/IQcxeE5VDZyD9OB27jr95OK6yuIC0
         H9Hm69Hkl6hNHP8Gp3jfzbB44CZExPvpmNCtBDb6sGc50ltgBrj8VANjYYNF2410BQ9e
         S+Rw==
X-Gm-Message-State: ABy/qLbAbwJrHDYD/nuAJ4mpIgLmIId3O11MDeiHZ+I30JPb11gnVK0R
        JDKXhVQkehahfTrahullEuDnB2DvYUW368mTIvadsEBX7u4YgPQ=
X-Google-Smtp-Source: APBJJlHaoOs+L7uOxyi56GDkWHr37TuBLXgRj6XcFXKU2a46ncj8CmGY6TEqkH0wpp5kG9MXgdy4lTs1pvfOXZwRLFs=
X-Received: by 2002:a0d:e6c6:0:b0:57a:8ba5:224b with SMTP id
 p189-20020a0de6c6000000b0057a8ba5224bmr2270936ywe.9.1689013624152; Mon, 10
 Jul 2023 11:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230616220242.340763-2-paul@paul-moore.com>
In-Reply-To: <20230616220242.340763-2-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Jul 2023 14:26:52 -0400
Message-ID: <CAHC9VhQJeaeaBmWHrhjLbqchZVZ4HBxXs=DgL-++nHea12nL8A@mail.gmail.com>
Subject: Re: [PATCH] selinux: cleanup the policycap accessor functions
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 16, 2023 at 6:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> In the process of reverting back to directly accessing the global
> selinux_state pointer we left behind some artifacts in the
> selinux_policycap_XXX() helper functions.  This patch cleans up
> some of that left-behind cruft.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/include/security.h | 35 +++++++++--------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)

Merged into selinux/next.

--=20
paul-moore.com
