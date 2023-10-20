Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D8CDB474
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 15:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377578AbjJTPLq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 11:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbjJTPLp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 11:11:45 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C68FA
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 08:11:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a877e0f0d8so17284427b3.1
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697814700; x=1698419500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAOLUotvPHOQBj62037j4NITFZ8+kQCCyzFg2X77nBA=;
        b=ZhbSEpxlWSYefZziGzh7dj9+MQAJLwEDQ2RY6DGrZBcUNY6O8wtXl6ba/jUxEZvNg3
         6yYlupHrD4AwydFyXDqW3qdbxnHUc+5NxS45vwkolisHm901u4JUFATuith6TWUUr60K
         ctq2bs0bYVnw/TltkvsgRt4FcW33lbQmwUgsfpz4rSiWeIZRvVMXGwWjs7EpIuiwYxu0
         9wi9km/P9syibY9dLTkSw5hdp/2XYK0V1BICH/HEMSECV3I+fiOdduZXXcDhu2PLYbJ4
         nlRVHdPQUgkOjXWNGulfB4VYxYY+LYAqToTYVJ4uRA3UsgEl6ASIxO4YdfkdDie7YZWm
         PM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697814700; x=1698419500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAOLUotvPHOQBj62037j4NITFZ8+kQCCyzFg2X77nBA=;
        b=irlfFh6jJ9JYkegk7whOekXKyYi5NprKBrnyl3VH5KTPXFAyum2BfJ62mnCdK8yMr7
         sTBxtk1cGsw2vIgqvQ9d1mQdJvo8x/1AxSn3B9aZcPRJJH9coLvwN09JS9VhdSNA4qWa
         eu73RgIvQrfGea+4BC697TihfRkerlPUYMLkUWddl6mIajDgUhrRwaVghGlwQm/7KIK1
         1RDkr787OMzRFONdvswfP5ujFxkY8+Pj7kCZaH+blLVA5iZj+Y9AR1eaDSTlLpOQk3So
         fU0XaNTWsApMzyi5vtblqH321tRUrYSEiUNEOiVEzDk9wqU5689LsciCHkQCW6CuPTka
         lMGA==
X-Gm-Message-State: AOJu0YzTFKcijwciE51U0vnldtOf+4MAUPf85anyY1O6MJ1DIz0n1erR
        eUrbAm4r4UQgfP3Y/sotpXmXwcTUCf4naMQUusNR
X-Google-Smtp-Source: AGHT+IFZZS/k7wcp5je9mBUog5aD0v5oRQUDOUZvhvY6v04bWmVNOACqIpzXseDcXLUK65MWC+fXMNNBp+aTuowyPMk=
X-Received: by 2002:a0d:d993:0:b0:5a8:1bc6:352 with SMTP id
 b141-20020a0dd993000000b005a81bc60352mr3541897ywe.20.1697814700004; Fri, 20
 Oct 2023 08:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090145.1059245-1-omosnace@redhat.com> <CAHC9VhSyN-0QYmNRKn0qSUC_1sRp5zih6=f8hc=jf-Sdw9b2fA@mail.gmail.com>
 <CAFqZXNsmjWJUX5rx+49W_SX+tO62Xoq9x9LzPy_VHCQuHyRNWw@mail.gmail.com>
In-Reply-To: <CAFqZXNsmjWJUX5rx+49W_SX+tO62Xoq9x9LzPy_VHCQuHyRNWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 20 Oct 2023 11:11:29 -0400
Message-ID: <CAHC9VhRZRVqtBCJZoWGSm9-6AGws1pNzpUMx-+GYisg-njJy1g@mail.gmail.com>
Subject: Re: [PATCH] selinux: introduce an initial SID for early boot processes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, scodar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 20, 2023 at 10:55=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> On Wed, Oct 18, 2023 at 10:13=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Unfortunately we had to revert this due to compatibility issues, but I
> > was hoping there might be a new, fixed version by now; any updates
> > Ondrej?
>
> Not yet, sorry... Haven't had time to sit down to it yet, but it's one
> of my top priorities this quarter and I hope to have a patch posted
> around early November (at worst).

No worries, we all understand how busy things can get, I was just
curious where things were at with the patchset.  I'll look forward to
seeing the next revision.

--=20
paul-moore.com
