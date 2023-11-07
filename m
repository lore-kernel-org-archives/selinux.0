Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF2C4332F
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjKGVkF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKGVkE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:40:04 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A110E4
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:40:02 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a55302e0so8397895e87.0
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393200; x=1699998000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP0CVUCWHhDwXLmwoKn18wq2SmWz1Az4coekMX1ikYA=;
        b=TQ6M5Tc0iYbN2jYK+fQmPD/7WE3bLrAbA4jfag+pVHMrU2KmBotNPSxQsbQi5X4cab
         R+QR0A6rfOkkRQ1UCVqS/JPumoHe4qXgPokSsRitBFUa44ewuTbprecge9WZ74xp3mAU
         fDouonyK0ejdyoMj+DSlZAMhMjyg0Cd3hXjvSJG0I+qkaoJTOUYg7yHH9T5xClAmoJ2Y
         IyW16W2fUNIFMS+Y8kmE5emJ4F5LNVx5bnUvHjd/FMkn7KjHoRXwsLnkA+vP42NAzzQ5
         VeQ9tyzUTdRRdXcaqN62dZen/T4H2ieGbT4UmxibULxil2Ar/LBRUR74PU3aLSj6hKVG
         zjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393200; x=1699998000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP0CVUCWHhDwXLmwoKn18wq2SmWz1Az4coekMX1ikYA=;
        b=saPbX2GPDnGCJvfSJgO/MSnqRm82Jmb2AhgQLARPmPPQfJnYSA3Y+zkpmvPhzD7NVF
         +wxnol3gquNk183/pl8rr4S+lPCDxBj99wvGjVmffvJaiWgdYxWOTAFbzbsy54BymVJc
         um8lBI3Khdj5yEoCTI/GTsVgGuoHAICvStCQlQRAObJvVBUbgD9YJyhao76KzyYs+6N2
         Aix3TcX7oMVSRFzCyg5p9wRqKhKYLRMCNFzgaf0lCVAr0cTvbVsR579ZTxPxE22oga29
         9HQFMN0bQbc0SwsxnVOoPIHbd4uve0bA9GSKR6JOVJI0a2AoXFnq0ppc87wXVwsYZxL0
         XNDQ==
X-Gm-Message-State: AOJu0YzunE0khFlGv7GKsEt6FMZk2KDayKvX5Pd4Ha7hwYIF8aHIR6fs
        h/XRZen3/JSdU3N553ZLQ3x5WpUxYu0q3ACJHTc=
X-Google-Smtp-Source: AGHT+IHm8QHQ7FjOyhTOGie5Q2uLBwvEeNqE2yIaIb6BFGL9KItgTEXm+CJdmOph52V+u7gpcVROLlEnyV+a78VJxew=
X-Received: by 2002:a19:c515:0:b0:509:44cd:241c with SMTP id
 w21-20020a19c515000000b0050944cd241cmr14013937lfe.32.1699393200495; Tue, 07
 Nov 2023 13:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20230805070650.197744-1-wanghuizhao1@huawei.com> <87lebihgi2.fsf@redhat.com>
In-Reply-To: <87lebihgi2.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:39:49 -0500
Message-ID: <CAP+JOzQX5BYsYoiB_nh5RxuxbhtUk=e=qodEEFMkhCgiytv6=w@mail.gmail.com>
Subject: Re: [PATCH] restorecond: compatible with the use of EUID
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     Huizhao Wang <wanghuizhao1@huawei.com>, selinux@vger.kernel.org,
        weiyuchen3@huawei.com, dongxinhua@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 31, 2023 at 1:04=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Huizhao Wang <wanghuizhao1@huawei.com> writes:
>
> > The `EUID` does not exist in some shell environments. To ensure compati=
bility,
> > use `id -u` instead of `EUID` when `EUID` does not exist.
> >
> > Signed-off-by: Huizhao Wang <wanghuizhao1@huawei.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

> > ---
> >  restorecond/restorecond.init | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/restorecond/restorecond.init b/restorecond/restorecond.ini=
t
> > index c1cbb247..4e71a2c6 100644
> > --- a/restorecond/restorecond.init
> > +++ b/restorecond/restorecond.init
> > @@ -29,7 +29,11 @@ PATH=3D/sbin:/bin:/usr/bin:/usr/sbin
> >  [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled || exit 7
> >
> >  # Check that we are root ... so non-root users stop here
> > -test $EUID =3D 0  || exit 4
> > +if [ $EUID  ]; then
> > +     test $EUID =3D 0  || exit 4
> > +else
> > +     test `id -u` =3D 0  || exit 4
> > +fi
> >
> >  test -x /usr/sbin/restorecond  || exit 5
> >  test -f /etc/selinux/restorecond.conf  || exit 6
> > --
> > 2.12.3
>
