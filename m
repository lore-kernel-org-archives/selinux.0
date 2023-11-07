Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D825FC4332F
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjKGVk3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjKGVk2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:40:28 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE010E5
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:40:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507cee17b00so7992715e87.2
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393224; x=1699998024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/Jw8FmuFfIpjTPJav2NUcDoZuMdVsQa8L1d/u17PD4=;
        b=E3iH3hVSFOvfi8tvhv+FSUcM9W9AS8fdE41u2dP/QT0yTI+ZkB2el0T+Tf4WGYbkjD
         DjhpuZ4VU0+m3/H3ZcmRynjWagYX/SdmYjWAQSDJM/vbY7hzWKuL5SRGJvcqgvXPGoAz
         +eK5X0jUnZco8M8jACz6AaIbBnVcgfFXwu1CVBWM1w5zz0C/xnBN0mIInXLYU29eUUnA
         lw+h7rDI0zC/JPx+bYJfd16Dh8sy/GTRr9IuzArQl8X40nfHux2tyXnLi29m3btqEx/w
         jIE2LKkJfIcLmky5BlaOqORPUlpYnY7lXb6mzFedkRTKGdjq/3pEbCjwVUlIJONVNFDT
         ngLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393224; x=1699998024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/Jw8FmuFfIpjTPJav2NUcDoZuMdVsQa8L1d/u17PD4=;
        b=MTJXU1dbppcZ9EgkDHS6f5guolrzEh7x1ZsB31EGNkGBWLNgyR7ky2zJCfv4jNG12t
         jowizBQXcjq4wpM5H9/yLOZOp5IRuYyUhdIiSNJaajeTHwtsPmNTcGQMdby2s/UUXxmc
         vJkOr8tAaaPL6kr9P6pKzo+RgGOgyBN/+QFvonrhbV2Recv/en1p+1vv8/gROvwEFfqX
         vhlAWAKEk8MPrToHIMa9PipZjAFyCHOy9+qFEuN6z/EO/CUJqD880PRUzvEjOUXfe7uE
         vPm7np80kJwuGdvt8+VcO88lvCCa05cOtQYBP31S0XWNwykpSmU+p6ihziGzdv/FKe3Y
         tUxA==
X-Gm-Message-State: AOJu0YwJSkwqcOZDxhcNSYKz49MbpNDZHQQJ/+FaSrdCM7DiOAImn3Ba
        UhpQMqv2l8gpVrD25RASLAQ8VdhmbZT+FOdpeUE=
X-Google-Smtp-Source: AGHT+IFlcKIcojheSJ/j/oBKIhKlMYPRQvB1VjG3uSZpKnD3g8/SgAD8Ag8lNON0OC6GGwxj3OOKkxdz9TUxkB4gJAE=
X-Received: by 2002:a05:6512:b24:b0:509:471c:7fd2 with SMTP id
 w36-20020a0565120b2400b00509471c7fd2mr14542522lfu.42.1699393224434; Tue, 07
 Nov 2023 13:40:24 -0800 (PST)
MIME-Version: 1.0
References: <20230818181905.560882-1-dominick.grift@defensec.nl> <87il6mhct7.fsf@redhat.com>
In-Reply-To: <87il6mhct7.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:40:13 -0500
Message-ID: <CAP+JOzSpbXopU8pH5YfVF2wGcCsfA=vFDRY18ScmcM=jv0K1mA@mail.gmail.com>
Subject: Re: [PATCH] secilc/docs: fixes filecon example
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 31, 2023 at 2:23=E2=80=AFPM Petr Lautrbach <plautrba@redhat.com=
> wrote:
>
> Dominick Grift <dominick.grift@defensec.nl> writes:
>
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>
>

Merged.
Thanks,
Jim

>
> > ---
> >  secilc/docs/cil_file_labeling_statements.md | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/secilc/docs/cil_file_labeling_statements.md b/secilc/docs/=
cil_file_labeling_statements.md
> > index 73f73885..9e4e877d 100644
> > --- a/secilc/docs/cil_file_labeling_statements.md
> > +++ b/secilc/docs/cil_file_labeling_statements.md
> > @@ -97,7 +97,7 @@ These examples use one named, one anonymous and one e=
mpty context definition:
> >      (context runas_exec_context (u object_r exec low_low))
> >
> >      (filecon "/system/bin/run-as" file runas_exec_context)
> > -    (filecon "/dev/socket/wpa_wlan[0-9]" any u:object_r:wpa.socket:s0-=
s0)
> > +    (filecon "/dev/socket/wpa_wlan[0-9]" any (u object_r wpa.socket ((=
s0)(s0))))
> >      (filecon "/data/local/mine" dir ())
> >  ```
> >
> > --
> > 2.40.1
>
