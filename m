Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361A6E7F140
	for <selinux@archiver.kernel.org>; Tue, 26 Sep 2023 22:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjIZWfw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Sep 2023 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjIZWdu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Sep 2023 18:33:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62058158AD
        for <selinux@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d868d8363e6so7178135276.2
        for <selinux@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695763939; x=1696368739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=JevHIhiYqEti5uTChAjUeDs+BEKCL2g/TRyKpHJ/sKw/h9kJ+4HCHHueL9YgowiXeH
         y+mmV6LB+UES6nnIE0g9mcDow3/ZHPCPRA5pmeJtKaqszxJpl0NT7ay2th4isuwERWRd
         6ifB8qXrbjG6XHh86W6nYjbJ42MprekK2a0jDJyRYz6wdUkKZDcVRoJbS8W75zZJ/ol/
         wjRxHQwuiELIsm0pgootgzP3h4C5nRtHxDOpGShBY4KEdcX1nWkWGPR50zOC0aZH70pv
         bM2ZAeX1I+fDiPw6Kc3dDttcv550is1BDPyTfxuXeB+7xXzhCZYRvFSfU+WatkBxmaVl
         Tq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763939; x=1696368739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=ctK58sfDapLmmA92qbc3kjDilg6vdgJEpB/OL5yyDyx5JqDafOyrdCfRL2FzbGMUx3
         O5I61Is3kIbi0/eQd0N+1slTVR000X/puPApe/RjsF/OAnPNidtqTOmXPbVOUdil4uSr
         bdwesP6wdlHzMB3jntvKtklXWoj0uNMW03FdbfYE5eoT+MUjpkRqofKb3VgfF6IpXHUI
         TXkgUIe1FjjU5DbtZt8yaH1reHXhZKXLbIEV0L8HXyjD2hqcVCztcniE3o1lK3liALNh
         SQUcJIAt9qkkBI0FAmShDKAlLFrvFBfaYXQ2YTTzEr3Vr6X1WiU69Avud0CBPHTyWVS/
         h6qw==
X-Gm-Message-State: AOJu0Yydt2zh6Qgdaf9xo+lL3R2L4a/e3SKoKKtsJmXrdWBnvBwh5Sq0
        APx7cHHTA8w2gQn6x06Ytes49ExkSVp5VSXEfk6K
X-Google-Smtp-Source: AGHT+IFCtQ0lRQAQtAczfLsb2sztHe5JKNKH8brd6I1PKgoiFWprOSxrLQWdFdj8Jz71vraPlw9N0n534XJeETDCyZI=
X-Received: by 2002:a25:d308:0:b0:d85:e4c4:4778 with SMTP id
 e8-20020a25d308000000b00d85e4c44778mr183132ybf.0.1695763939574; Tue, 26 Sep
 2023 14:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
 <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
 <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com> <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Sep 2023 17:32:08 -0400
Message-ID: <CAHC9VhTLnT6HmkvJBXVCApHG4sCFdgXxJykPQ8oYLaVa8vXWkQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 22, 2023 at 6:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> No worries, lots of conferences are happening right now, so I expected
> people to be unavailable.

Just a quick note to let you know that my network access is still
limited, but I appreciate the understanding and the detail in your
reply; I'll get you a proper response next week.

--=20
paul-moore.com
