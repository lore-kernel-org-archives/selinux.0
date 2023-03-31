Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D36DC76196
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 18:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCaSPX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCaSPW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 14:15:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9D0DBF8
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 11:15:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ja10so22036953plb.5
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680286521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VedPNtZbSXDqqBb6d5W5oDafkL0l0anKpCjF6pvc5nc=;
        b=HpPd4QGhFu0rHlT2o2pmTk08+2Wc73nqz85TE1RvY707DPl6Ar0mxPDoXbJAAJWEYx
         hiMCaAws3XED8wEQn8eQ6qPcORnFOuXQ25EPTmiol3dUHOh+4OBefngHGsVH3APZSM5w
         NTQODxyjH4aDv3BlRIif5b52IhbyR45t8uFErOW+Rufs+Pjgyx3dRkeoRWaffTRDMMMQ
         x0Z5Wd4xeEgVv+uGFcP0tJ/O7ULP0NCzothrFiPLlc++AOnzrRhuOMPYh6JhfcJ8zTTn
         2e6RF7Zs8V3vYlXwzG7uTBIIiVvy9nou7frodYDdA9k9KNXTW6MeSKPmU/wP4pNWq+LW
         3G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VedPNtZbSXDqqBb6d5W5oDafkL0l0anKpCjF6pvc5nc=;
        b=WviZZ+rwxPCbzFKxagUaHrFe7rTPkr12TY5w0Ca6+ZfizqJ+YEXpsxdnqd8puDy0Et
         BNLdDT8QuX/6K5/9mBWKq61WBq/7IUQRW2Ge3d34mpw3PikW3l422tKZ769b7/Lk/e/G
         QFJMKZXPxGjZLEyQ5cltLKMjqGdTw/dVRw38AdSdmAL0Q9nm178mWa0unhBeSnwqYnY9
         Z4Nhj145gnl2GyOx5xifKAosppmgO04vm9FNBLv2s4ZmGo2k6H7GhjUMkcY8jZiqNVlA
         9VtVQcfXKHMTfWWqkbHC/aHi0ltce5/7dFT1G6MgB9FXopEOHgnEvFVvFxBnRz4dHtpr
         w2oQ==
X-Gm-Message-State: AAQBX9d5vSXX+aDYaSpPwomUOr6HqgWt5f8hIuQTt6gu9fgfS4gLBsq9
        B924kDNmQqRAHlMp/2fXs618S9zjZDMK4SD9jthWtDOU
X-Google-Smtp-Source: AKy350ZLlOSL/2B+JXmvNNegQ7Mp3QgC+sioHCcgb60MsKlT1wVLQ4DGtw8qNyJ51TYPfvCX7R9dfzIX9dgH7QVLM/Q=
X-Received: by 2002:a17:90a:600c:b0:240:9d66:cd54 with SMTP id
 y12-20020a17090a600c00b002409d66cd54mr4717085pji.8.1680286521522; Fri, 31 Mar
 2023 11:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <87ileh5ckg.fsf@redhat.com>
In-Reply-To: <87ileh5ckg.fsf@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 31 Mar 2023 14:15:10 -0400
Message-ID: <CAEjxPJ675EhOoKXHzXKaVOoSXfqkqKudPzCL=F4aAG0vbd+Cdg@mail.gmail.com>
Subject: Re: sesearch --neverallow
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 8:37=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hi,
>
> I've got a question what is `sesearch --neverallow` good for and how to
> make it work. I wasn't able to get any output from this command.
>
> Is it supposed to work with current userspace and policies? How?

I don't see how it could work. neverallow rules aren't preserved in
the kernel policies.
It would only make sense if sesearch could be run on source policies or mod=
ules.
