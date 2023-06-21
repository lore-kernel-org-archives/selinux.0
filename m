Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EFAEB64D7
	for <selinux@archiver.kernel.org>; Wed, 21 Jun 2023 13:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjFUNK3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjFUNKR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jun 2023 09:10:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF472E57
        for <selinux@vger.kernel.org>; Wed, 21 Jun 2023 06:10:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98bcc5338d8so100495266b.1
        for <selinux@vger.kernel.org>; Wed, 21 Jun 2023 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1687353013; x=1689945013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z32SJbarkWMkTaNDlnB+SWPWI4ufvkQcoBHaRTW82+4=;
        b=cQU3Vto/CNQ4u3xpSTie0BrTnO1OYs/IQ+nF3JsxhBu66a+VLXboIkMuEF3gjMSQTa
         yWrukz4nxFPgo/SOULbSVxsqNklmc6qWUBrmyhFPOe97PwTjXBRFn1QNR2ai/5MiV+15
         Qx9hG0gGUnNlwVC8B11j/4FsCt68JRP6ItRMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687353013; x=1689945013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z32SJbarkWMkTaNDlnB+SWPWI4ufvkQcoBHaRTW82+4=;
        b=MThIvHkIPlaKBItRYEorlOYFpGpRjXOC1Rmgcm2aoNAJ0EQzz2vjTB7dTsEjyV2go5
         X5FezITrdGnZp8IjFIRLrAcSyFYlv5VQ6WcZ2bLN9sBmaMyRkww83uvGEDB2VObz5eQ9
         OHz2USdTu7jfRquyX1eXvZn0fj5cjsuhobvF5A76aIcvMccHiU9B0+yCb6ZrE5Ehxgii
         MNUsiInRJ7Qzh6KQwTEOo7i+EmAssVSHi9GCuW/kW0UOR02W4Q6OWNjb5WQ+JvLQfetF
         H+1tpP5nIat3X9FIWQzMJ8hnCvoxHsHS/2t8mZDlz/83v8eU7eBNed12eN13iD70VaUi
         wltw==
X-Gm-Message-State: AC+VfDx5maID7Ttjo60hyAd3VYUbpW4I5X1qz4i9AJddVwlbG7/MaEI6
        sQJlJ6HnbeaC6ZxiZWkVDJnwtIc1q8eiUY2820cMSsOLLjDni6RN68Y=
X-Google-Smtp-Source: ACHHUZ4EaGLyF3a1FHjpnoS/YbaRQBCswt9piexernzG7SG6dbN+XR6+IKOahFU6c+ez6j5GSGYh+B4y4EgN0FBxdtY=
X-Received: by 2002:a17:907:a412:b0:988:6e18:3f8e with SMTP id
 sg18-20020a170907a41200b009886e183f8emr8612644ejc.5.1687353013401; Wed, 21
 Jun 2023 06:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ7P5XQUx4-ENXt4WGGhnegxKmDD0V-4Ffab6AY8PL-O2A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7P5XQUx4-ENXt4WGGhnegxKmDD0V-4Ffab6AY8PL-O2A@mail.gmail.com>
From:   "Christopher J. PeBenito" <pebenito@ieee.org>
Date:   Wed, 21 Jun 2023 09:10:01 -0400
Message-ID: <CAPVbxr1fjwEv=yqbn1ykbekBH7wUOjRU58HBS2C2b0JU+KuN-w@mail.gmail.com>
Subject: Re: multiple inconsistent perm_map files
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 6, 2023 at 1:05=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Hi,
>
> There appear to be two separate copies of the permission mapping
> (perm_map) file, one in selinux/python/sepolgen/src/share/perm_map and
> one in setools/setools/perm_map. The first one in selinux hasn't been
> updated since 2016 (just a move) or 2011 (last actual content change).
> The second one in setools has been getting regular updates but the
> seinfoflow man page refers to the location where the first one from
> selinux is installed.

SETools ships with its own perm_map so that it is usable on
non-SELinux systems. I'll remove the sepolgen reference from the
seinfoflow man page. I don't know how sepolgen uses perm_map.

> Also guessing that no one has written a perm_map for Android userspace
> classes/permissions.

I don't have one for SETools.

--=20
Chris PeBenito
