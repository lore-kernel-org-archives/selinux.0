Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33056C04A94
	for <selinux@archiver.kernel.org>; Tue,  8 Aug 2023 20:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjHHU7Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjHHU7P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Aug 2023 16:59:15 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645AC6606
        for <selinux@vger.kernel.org>; Tue,  8 Aug 2023 13:54:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-583fe10bb3cso70100507b3.2
        for <selinux@vger.kernel.org>; Tue, 08 Aug 2023 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691528052; x=1692132852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTpvtVjL7acBExmq8NjgKbPf1G3TUPJqq5N6nrKb1NA=;
        b=fzZAXmeStuq9zaKugIfPX0TY2WcCiK7pYDC0U8YIMnxHN/c4J0cstVDBQIZEDNOLLj
         /LONMdDhFKr7Clw3K1yfWS7oji3avlv/+bA3D6TL5gO5GdMAyF0/lLzEQ7OO0NcmxjgK
         eH19B8kXca159LEdc1W1tAfN2/2uUbvCrige+N8ib8EM+/AYOJdjiKBnoCNFYQa8p1lJ
         EqbFsEMtwgvVATMAzm22eJzsqmV/8z1H15KPJ2I/om3Pd2ywvCBJAzUimy1NO7L1GD/M
         s9o9g9BR+N/oD4kefs6WvDx/kM/K4OdYZLEYobyCqcYnS+DY2rwZbKVsH4Xh9MiLJCqs
         9ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528052; x=1692132852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTpvtVjL7acBExmq8NjgKbPf1G3TUPJqq5N6nrKb1NA=;
        b=aDxaP+9C1RNwnl2/RD8xYvAYxZNasjKmXtCUhAV/QR1iBTpCB996CHIkJy98fMiGaS
         LMe5lxPfKPK415qPIE8I55GxDInwyZVYJxHGRGI6GLFmwjmJSkzVMDc42JSGT3krZ5JU
         y7eKeWQrRfpRg79HLMN9+M1pznRs/ALSVP6tyy0H1ZPXOZo3gkrglP2mjYoB/MGGjwXl
         gROUVPEjrq0IHN3Mtfq0H/inYSMrAgaxMeeOsZ/ZcUaBejPfKBWw+hYyQYa8FoEJI3op
         wyMIsHk14SyMFbvpPznJtiBoxpJ4+bjRd3Vst5hvV+70G4eRFMmMXZu+W1cv2/34YP1H
         1hCg==
X-Gm-Message-State: AOJu0YxZOUEaBq9XHuEPDj+5QgzESSxayZXPDXTZthMjAUooRMmFQuzq
        9eazRgHHGp/cthuIaSFmuQCQFPUYOf0I02v7MGLL
X-Google-Smtp-Source: AGHT+IEa3DMNDpLFNtN23FCRsGJC6mZlj5dBNDRepJ2bvxVAAbzED1a+O2OHzj3V40Dcv2LrhA4TMwjH5v5K73cZ7dU=
X-Received: by 2002:a0d:c945:0:b0:579:e318:4c01 with SMTP id
 l66-20020a0dc945000000b00579e3184c01mr921680ywd.19.1691528052624; Tue, 08 Aug
 2023 13:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230807180518.223481-1-cgzones@googlemail.com> <CAEjxPJ7=zm2_Bky=M9VwFPA70c6HO5bOuc3a01E_UbTmwHwpuQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7=zm2_Bky=M9VwFPA70c6HO5bOuc3a01E_UbTmwHwpuQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Aug 2023 16:54:01 -0400
Message-ID: <CAHC9VhSrJveO=AytX7zj8vKKRphk6WEhrv-X1BGT9axaapADDA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use GFP_KERNEL while reading binary policy
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 8, 2023 at 4:45=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 7, 2023 at 2:42=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use GFP_KERNEL instead of GFP_ATOMIC while reading a binary policy in
> > sens_read() and cat_read(), similar to surrounding code.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Congrats, you found something that appears to have been present since
> before SELinux went into mainline Linux 2.6.0-test3 ...

Fun fact, Linux v2.6.0-test3 was released 20 years ago today :)

--=20
paul-moore.com
