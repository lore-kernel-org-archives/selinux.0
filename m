Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C0DC77B7F
	for <selinux@archiver.kernel.org>; Mon,  8 May 2023 20:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjEHUz0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 May 2023 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbjEHUzX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 May 2023 16:55:23 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD488685
        for <selinux@vger.kernel.org>; Mon,  8 May 2023 13:54:54 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b9246a5f3feso7807721276.1
        for <selinux@vger.kernel.org>; Mon, 08 May 2023 13:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683579291; x=1686171291;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/f8w9vZTY/u60jY1WmmECHwpOTY4fCe1NILqBO9Yqg=;
        b=fmi3nNch4jWyAeB+592jt3yCwMMidS85VbG1AJQ2dn1mH84FYWFzM2tBUwkAgLQmg1
         LlMmFC2j9Sbmz/JyctnJLf+sCQl6KQtlMO6DbShywpGZvtPeBXkHwQ8UA8cTd9SuScGF
         UAsFnE8Fo6Tut6puD1Di4D7EMbfnNtN3zz4S0v03B1qyDzlI8ZRSWoLglw7KHjBe9ID7
         ad2e7CV6BFVBpQgJKFVuEJ2uZuk2SQ9vxf6nbhZVUa0MDAwkWftc7U11yktVOxuthi5l
         h1GhPG/8zHQfltSp/2hUm5R0imE+6twH/2E/0kG0kynn+HY8trW5UXtI3//RFMaPvxfd
         TmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579291; x=1686171291;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/f8w9vZTY/u60jY1WmmECHwpOTY4fCe1NILqBO9Yqg=;
        b=Xr0r5Sr9aJlRLIhwP1oIIR4ejv87tZMUU8ub1Qy9Y13OHIw1cyDQORoTARC7+9lLAw
         lILqIFOBibvxJjnEfhA2nq+2bVb3/v8d5i1nRTE63zHxVuao5a31cxKEpsltu+ldnzGA
         GCIn7HnHr/6u4FsfLCuprpF2pEh0cElX1rvsTuGUl3uRzlF8rwgKQvAlpLOyyw5j+u0o
         v2FRm9Y8s/rzT4UxUo/jHwVBIFbEYqLnryZufGo/Q6VDc+icOs1/o10pGjnK0yf3hP3L
         kABB3tWQ3DlLwwgWHHwerpE/1rVcbpK5W6FH1GZkVAQhUx1FaQsy1/djdzkPT1ouhB6o
         gCeA==
X-Gm-Message-State: AC+VfDyWKAU8vdebiARNIGukF2UwF2bncRsMrX3O1EWxMGCIqUz4plQ4
        IU1+ZepvMoGwbEBFMaB6maRsDfc4zj5dH7YbwTzXT1ulOD3Q1Qc=
X-Google-Smtp-Source: ACHHUZ4xFMt0DakYV/nLBdUss21BuKJCxzi0lN9WDmvpxAgRrUdS4ZYhEpsxOv0Ixll9+uQjyQlYN+yKoFAIBWx1MMI=
X-Received: by 2002:a25:6801:0:b0:b9e:453e:d0c4 with SMTP id
 d1-20020a256801000000b00b9e453ed0c4mr12484616ybc.28.1683579291627; Mon, 08
 May 2023 13:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230505224944.645203-1-paul@paul-moore.com>
In-Reply-To: <20230505224944.645203-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 16:54:41 -0400
Message-ID: <CAHC9VhRf-hScJFLNSLR+Fa4GuoTz3XFe0aBOk5ocY2ER056s3Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: small cleanups in selinux_audit_rule_init()
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 5, 2023 at 6:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> A few small tweaks to selinux_audit_rule_init():
>
> - Adjust how we use the @rc variable so we are not doing any extra
>   work in the common/success case.
>
> - Related to the above, rework the 'out' jump label so that the
>   success and error paths are different, simplifying both.
>
> - Cleanup some of the vertical whitespace while we are making the
>   other changes.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/ss/services.c | 38 ++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)

Merged into selinux/next.

--=20
paul-moore.com
