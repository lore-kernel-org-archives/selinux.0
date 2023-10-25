Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7275C0032E
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 22:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJYWHK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 18:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJYWHI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 18:07:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568313D
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 15:07:04 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so156789276.1
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698271624; x=1698876424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUioPHtCD+GhMNXucMG177Y8Q3dpoJ6Bay8xoyRzUVw=;
        b=bA4YggGAdgrdDyX4ZbjSDbMGaMh3M0YWZaU9glCxWiEXaasWUh+fcbSJ4yra5eGL19
         k/7UJum6yIY/fQ6xtO7sHKLdl6ERJHJ9rMO+8968OauOwmJa3pvvM43+vpGoOLQOHgXh
         bDTVeD1f6y2VLKxPtFMBwlN0cfEl5c7j6V9k5KG1l6X7H2WjbAjtL0RuKmrnOI5Ao83M
         X/qUh+Omr3q1SwQfxXigMUsPM3A+PjhBxLF7qC8/imAinegGALBxc4oUPWrh1Ctm2cYd
         /C8wcidKv2wiHSeBmYw2/YtgajCeBLfB0F37gcSrkb1mcDU4Pwt4LyoCgcCjuJrRP3jB
         NBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698271624; x=1698876424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUioPHtCD+GhMNXucMG177Y8Q3dpoJ6Bay8xoyRzUVw=;
        b=UwFTFiAwZThm9bx0p/J42M33tPXcV2VkwZu4UHpYBucdaeqUXFk61egpigcoLh5EUf
         ExJ/FQg3MP4SHhEPPzbC6zC+kpxekZAw0K3fjFhfstIOPdCcEUS0KjCk3mPF7fucf3jr
         1IbZMDcub7kGE40HdOEqKPpVHG4trQX86npsUGkHfqTpYvqM168P20sQQWeXSy7Q4Ci+
         C7+dMkcvePnVDk7/xnZiHeUO0XQldL2q3ktbDGZFuiT37BJRFBUBlvqaFXui3bx4ceYS
         WVNXoW2WkPGbr446FZR+HbDYZ1LNQjlw4SzQiogrxyID9n22azm59tz0ayACcc9Lu2GQ
         GnZA==
X-Gm-Message-State: AOJu0Yx1pLYyRerejOqw0ljU1z69CkVfgr2etyyvVwfUxWJse7NR1Www
        FaZd+RIWMMnVTvOdUYMRJ2loprQ/qhHhJ/kWx0Uk
X-Google-Smtp-Source: AGHT+IGx8kZidlFgJjBuh+BEh8qpWqCQMxmGbONYbFMp2QVG0aW6B0iaxHb0dx/RZeXtEfbkKg05S6HSG9iqNUeeMEQ=
X-Received: by 2002:a25:a2d2:0:b0:d9c:66d1:958f with SMTP id
 c18-20020a25a2d2000000b00d9c66d1958fmr16300026ybn.55.1698271623612; Wed, 25
 Oct 2023 15:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com> <20231024213525.361332-5-paul@paul-moore.com>
 <8fcaab11-6340-4056-b9e0-4650be05b270@schaufler-ca.com> <CAHC9VhR_Mm0aZKafhhaQHnasU_30Uvy9zUvEMs9COzh22QSNWw@mail.gmail.com>
 <5df43557-7261-47a1-9066-b7ba42145af0@schaufler-ca.com>
In-Reply-To: <5df43557-7261-47a1-9066-b7ba42145af0@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Oct 2023 18:06:52 -0400
Message-ID: <CAHC9VhTXV+TmfmWy+ysZ8eoLhSVKC8ycnM-MBFL3UHyRbXPaEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] lsm: cleanup the size counters in security_getselfattr()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 25, 2023 at 11:19=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/24/2023 6:43 PM, Paul Moore wrote:
> > On Tue, Oct 24, 2023 at 6:23=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 10/24/2023 2:35 PM, Paul Moore wrote:
> >>> Zero out all of the size counters in the -E2BIG case (buffer too
> >>> small) to help make the current code a bit more robust in the face of
> >>> future code changes.
> >> I don't see how this change would have the described effect.
> >> What it looks like it would do is change the return from -E2BIG
> >> to 0, which would not have the desired result.
> > When @toobig is true, which it will be when one of the individual LSMs
> > return -E2BIG, the return value of security_getselfattr() is fixed to
> > -E2BIG (check the if-statements at the end of the function).  Setting
> > @rc to zero as in this patch simply preserves some sanity in the
> > @count variable as we are no longer subtracting the E2BIG errno from
> > the @count value.  Granted, in the @toobig case, @count doesn't do
> > anything meaningful, but I believe this does harden the code against
> > future changes.
> >
> > Look at the discussion between Micka=C3=ABl and I in the v15 04/11 patc=
h
> > for more background.
> >
> > https://lore.kernel.org/linux-security-module/20230912205658.3432-5-cas=
ey@schaufler-ca.com
>
> OK. My bad for not looking beyond the patch.

No problem, we all get caught out from time to time, thanks for the review/=
ACK.

--=20
paul-moore.com
