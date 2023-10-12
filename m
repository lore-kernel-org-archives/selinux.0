Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85002CDB46E
	for <selinux@archiver.kernel.org>; Thu, 12 Oct 2023 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441922AbjJLRy2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441906AbjJLRy1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Oct 2023 13:54:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D001B8
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:54:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50433d8385cso1795413e87.0
        for <selinux@vger.kernel.org>; Thu, 12 Oct 2023 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133264; x=1697738064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7BNTxtJ6jMoD8h8sRO/RNRv3/qH0G5CQpbzBh0OkjA=;
        b=iZcrxjXIDfYromVQU1kr1rdiksSIpXp+bieUigjuDpz9qqLxgvDYoYtXmt7DKhx7ca
         9GXl09HRdBMgusL8R4g4Fxn2FAPknWXJM38TfB5x/MqMZ6BZnDmM3P/OJ07pwBMuAmbz
         MpOrhJcli1x/j+C9ELfdg5P+YbHDbT1nq8AAsheylOLfSbxKka+/czjnXKLQcC/QVuX0
         kCxducXaOJApFiwX0FDRdEYaQsVkx0Q8gsfLGc6xlgWYIaDxMKGxXC88Nc0Cwz/yUlGs
         Bc9Qcu3KCuiNSKOmH3dKtj61TZWvDY81+yMPMU62SCHA1DwWfGuXcJTXhZ9FrZO+H9Io
         ig3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133264; x=1697738064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7BNTxtJ6jMoD8h8sRO/RNRv3/qH0G5CQpbzBh0OkjA=;
        b=d3hZ9ADm6t2ZJVhlI7Y92JCXdSLpkMxH3sjzqdDPXRutu8NC/iXr64uhjTSglj27rZ
         0FG6QVbz6z2Iv0w4YaeXkDXx/lpm607Pf1c2//Imhh7O0MJ7/n8UjajnyffnfK6NygRo
         rMzHYBEUWZ+Jn7VlBq1ne9Rqa4gjD8hNoChaKF8nKmMAg+vhw5Jo9/zhty1ZP9NBeEJF
         3SDN6emSYsqurq1Jz2ChMwIRhvMD52flEysRYmvjH+yezAh1FLTok4gFiFHyLJPvtB9r
         /QpPnTaNPU4yxptvQj496e8/s7efV/tKlfSy8daelaUDiqsgxwlnRz+rsKicBz5zKHrp
         S95g==
X-Gm-Message-State: AOJu0YxMDRqyKrLWO6/DQMcQRiAorE5QRoeXuKv7mZ3sTVGp0+2k9p1k
        75ad+0aChP/4HQ2g9TZI/ZeW0kUD97ZOPFdoCeHJcKk3p7M=
X-Google-Smtp-Source: AGHT+IH1MVgZNgqXZ6ZF1K24Y5LSQcMNMPHfvWllQXAKDgpf12HY7wJS9D0Qzk3D1D2ofm14Qca+K6zYDwqSsFreBD0=
X-Received: by 2002:a05:6512:531:b0:4fd:fabf:b6ee with SMTP id
 o17-20020a056512053100b004fdfabfb6eemr20067304lfc.9.1697133264357; Thu, 12
 Oct 2023 10:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230814132025.45364-1-cgzones@googlemail.com>
 <20230814132025.45364-12-cgzones@googlemail.com> <CAP+JOzR24hdHpKtgVsfWHN0jLaE6O9YrKLvP7zcOwi3Y8sotYg@mail.gmail.com>
In-Reply-To: <CAP+JOzR24hdHpKtgVsfWHN0jLaE6O9YrKLvP7zcOwi3Y8sotYg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Oct 2023 13:54:13 -0400
Message-ID: <CAP+JOzSga=Hn-ZECUZNgm9bMNOyTxyMxdTGtsLsp4Cw8JCd6Ug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/27] libselinux/utils: use type safe union assignment
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 5, 2023 at 10:02=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 9:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> >     selinux_check_access.c:43:10: warning: cast to union type is a GNU =
extension [-Wgnu-union-cast]
> >        43 |                                      (union selinux_callbac=
k)cb_auditinfo);
> >           |                                      ^                     =
  ~~~~~~~~~~~~
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/selinux_check_access.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/utils/selinux_check_access.c b/libselinux/utils=
/selinux_check_access.c
> > index 6cea40e9..f7b27a85 100644
> > --- a/libselinux/utils/selinux_check_access.c
> > +++ b/libselinux/utils/selinux_check_access.c
> > @@ -40,7 +40,7 @@ int main(int argc, char **argv)
> >
> >         if (audit_msg)
> >                 selinux_set_callback(SELINUX_CB_AUDIT,
> > -                                    (union selinux_callback)cb_auditin=
fo);
> > +                                    (union selinux_callback) { .func_a=
udit =3D cb_auditinfo });
> >
> >         rc =3D selinux_check_access(argv[optind], argv[optind + 1],
> >                                   argv[optind + 2], argv[optind + 3],
> > --
> > 2.40.1
> >
