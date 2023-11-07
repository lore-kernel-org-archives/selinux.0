Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F91BC4167D
	for <selinux@archiver.kernel.org>; Tue,  7 Nov 2023 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjKGVoK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 16:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjKGVoK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Nov 2023 16:44:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB4610D0
        for <selinux@vger.kernel.org>; Tue,  7 Nov 2023 13:44:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507bd644a96so8902508e87.3
        for <selinux@vger.kernel.org>; Tue, 07 Nov 2023 13:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699393446; x=1699998246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DTlyYAMVwnBzfSQeTFURbcAMNdBCdcYMOE3QL/QKMc=;
        b=N5mu4Qelll2ggxdnduPalEq6umWLLBnvBnD68NLpQOw1lCWR4MdiNyW0cmWtfF5eCb
         q1Fp040YaiDnhFgS0bNQXyryFTbPcZfPfw/SfnOPOMSdXdVNPJ9HX+hyXt/AoaBBEHo1
         SH4yfTz0Fp6ibmO0wsD+8HaMBm6RWXj7sihwWN1HsuZn4drp0mam2RuWhwCFDb9alOsu
         kvLseJrIyETPuO/cew1ncE2pfLk1s5A8odWfafeGSGi6OgXyqvB0y2Y7XwHBmLx3z8Ee
         8kcjDsEKp3gxPV43RD5UlTYN13oda2cCtEb3FIq7OYYE9Bg0SRWl/K44m6SnVNDYcba2
         GjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393446; x=1699998246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DTlyYAMVwnBzfSQeTFURbcAMNdBCdcYMOE3QL/QKMc=;
        b=LiH1Cs/LIIpSFaseE13W551VyCm1hdGtY2AuVxVUnH7RPxO3uBoa53n+5yozw4Dtg0
         z1tUWag4jT7TaTym/MtFAJAQpbxDj0hRAfuY/CvDGNjOWc5CZ2WfDsWaNfo02p516uoJ
         llvGBGS7Vcebnf2yjta01D9PocTM95RO6FerWeEnWap67BufkkfTSgTaJeKkDTOYmVY1
         rX8CuGcUDVB0XGVU9Mcl0f0OmoeZBPmF4dRP18ZQ01sIn7NNzinqhj90w3jiaNF+Hq8t
         lGYC5fxNHNmZKLLHp6HX1xiRVyUGmHw9hnKmtHbJs3oAtr/ze8aPbHm96VIUX+/z8e/m
         oqKw==
X-Gm-Message-State: AOJu0YygFCo6Fo6H8xNLmffx63nfc9oM9tR0pXLmsLx/t2k8rf9Y1k2c
        ruGbn894ntScBNbyZO07ouKhumLm019ZyVDdnHI=
X-Google-Smtp-Source: AGHT+IFZgynm80ygjPc2tO5EcED27Sm/JDtDZEBdqppbbFTVfD+qVjXoBCe1JZ5zBepjpPQ2Dq+BcQ2Uzq5YcoMPTXQ=
X-Received: by 2002:a05:6512:acf:b0:507:9d3c:c655 with SMTP id
 n15-20020a0565120acf00b005079d3cc655mr31845508lfu.61.1699393446032; Tue, 07
 Nov 2023 13:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20231106172857.233804-2-lautrbach@redhat.com> <CAP+JOzSBbwqcZVoNtOGFt4UYzZ1iR1Thktu4n5v24gPkKQ0y6w@mail.gmail.com>
In-Reply-To: <CAP+JOzSBbwqcZVoNtOGFt4UYzZ1iR1Thktu4n5v24gPkKQ0y6w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Nov 2023 16:43:54 -0500
Message-ID: <CAP+JOzQ6ZJmAGHmGoG057Ubb8f32P6G-N4hH3wc1fMnz=mc5fA@mail.gmail.com>
Subject: Re: [PATCH] Update translations
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 6, 2023 at 2:18=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Mon, Nov 6, 2023 at 12:31=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Source: https://translate.fedoraproject.org/projects/selinux/
> >
> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> >
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > The patch is too big and is available at https://github.com/SELinuxProj=
ect/selinux/pull/413
> > ---
> >  gui/po/de.po                |   14 +-
> >  gui/po/en_GB.po             |  117 ++--
> >  gui/po/fr.po                |    8 +-
> >  gui/po/gui.pot              |   32 +-
> >  gui/po/he.po                |   18 +-
> >  gui/po/hu.po                |   19 +-
> >  gui/po/ja.po                |    8 +-
> >  gui/po/ko.po                |   12 +-
> >  gui/po/sl.po                |  400 ++++++-----
> >  gui/po/zh_CN.po             |   12 +-
> >  gui/po/zh_TW.po             |   94 ++-
> >  policycoreutils/po/en_GB.po |   25 +-
> >  policycoreutils/po/es.po    |   17 +-
> >  policycoreutils/po/it.po    |   15 +-
> >  policycoreutils/po/ka.po    |   12 +-
> >  policycoreutils/po/pt_BR.po |   15 +-
> >  policycoreutils/po/ro.po    |  140 ++--
> >  policycoreutils/po/ru.po    |   17 +-
> >  policycoreutils/po/zh_TW.po |   15 +-
> >  python/po/af.po             |  963 +++++++++++++--------------
> >  python/po/am.po             |  963 +++++++++++++--------------
> >  python/po/ar.po             | 1078 ++++++++++++++++--------------
> >  python/po/as.po             | 1078 ++++++++++++++++--------------
> >  python/po/ast.po            |  963 +++++++++++++--------------
> >  python/po/bal.po            |  963 +++++++++++++--------------
> >  python/po/be.po             |  967 +++++++++++++--------------
> >  python/po/bg.po             | 1077 ++++++++++++++++--------------
> >  python/po/bn.po             |  963 +++++++++++++--------------
> >  python/po/bn_IN.po          | 1078 ++++++++++++++++--------------
> >  python/po/br.po             |  963 +++++++++++++--------------
> >  python/po/brx.po            |  963 +++++++++++++--------------
> >  python/po/bs.po             | 1073 ++++++++++++++++--------------
> >  python/po/ca.po             | 1077 ++++++++++++++++--------------
> >  python/po/cs.po             | 1097 +++++++++++++++++--------------
> >  python/po/cy.po             |  963 +++++++++++++--------------
> >  python/po/da.po             | 1108 +++++++++++++++++--------------
> >  python/po/de.po             | 1112 +++++++++++++++++--------------
> >  python/po/de_CH.po          |  963 +++++++++++++--------------
> >  python/po/el.po             | 1005 ++++++++++++++--------------
> >  python/po/en_GB.po          | 1105 ++++++++++++++++---------------
> >  python/po/eo.po             |  963 +++++++++++++--------------
> >  python/po/es.po             | 1106 +++++++++++++++++--------------
> >  python/po/et.po             |  963 +++++++++++++--------------
> >  python/po/eu.po             |  977 +++++++++++++--------------
> >  python/po/fa.po             |  963 +++++++++++++--------------
> >  python/po/fi.po             | 1179 +++++++++++++++++----------------
> >  python/po/fil.po            |  963 +++++++++++++--------------
> >  python/po/fr.po             | 1193 +++++++++++++++++----------------
> >  python/po/fur.po            |  963 +++++++++++++--------------
> >  python/po/ga.po             |  963 +++++++++++++--------------
> >  python/po/gl.po             |  963 +++++++++++++--------------
> >  python/po/gu.po             | 1078 ++++++++++++++++--------------
> >  python/po/he.po             |  963 +++++++++++++--------------
> >  python/po/hi.po             | 1078 ++++++++++++++++--------------
> >  python/po/hr.po             | 1084 ++++++++++++++++--------------
> >  python/po/hu.po             | 1107 ++++++++++++++++---------------
> >  python/po/ia.po             |  963 +++++++++++++--------------
> >  python/po/id.po             |  963 +++++++++++++--------------
> >  python/po/ilo.po            |  963 +++++++++++++--------------
> >  python/po/is.po             |  963 +++++++++++++--------------
> >  python/po/it.po             | 1224 +++++++++++++++++-----------------
> >  python/po/ja.po             | 1181 +++++++++++++++++----------------
> >  python/po/ka.po             | 1006 ++++++++++++++--------------
> >  python/po/kk.po             |  978 +++++++++++++--------------
> >  python/po/km.po             |  963 +++++++++++++--------------
> >  python/po/kn.po             | 1078 ++++++++++++++++--------------
> >  python/po/ko.po             | 1239 ++++++++++++++++++-----------------
> >  python/po/ky.po             |  963 +++++++++++++--------------
> >  python/po/lt.po             |  967 +++++++++++++--------------
> >  python/po/lv.po             |  963 +++++++++++++--------------
> >  python/po/mai.po            | 1077 ++++++++++++++++--------------
> >  python/po/mk.po             | 1069 ++++++++++++++++--------------
> >  python/po/ml.po             | 1106 ++++++++++++++++---------------
> >  python/po/mn.po             |  963 +++++++++++++--------------
> >  python/po/mr.po             | 1078 ++++++++++++++++--------------
> >  python/po/ms.po             | 1058 ++++++++++++++++--------------
> >  python/po/my.po             |  963 +++++++++++++--------------
> >  python/po/nb.po             |  975 +++++++++++++--------------
> >  python/po/nds.po            |  963 +++++++++++++--------------
> >  python/po/ne.po             |  963 +++++++++++++--------------
> >  python/po/nl.po             | 1111 +++++++++++++++++--------------
> >  python/po/nn.po             |  963 +++++++++++++--------------
> >  python/po/nso.po            |  963 +++++++++++++--------------
> >  python/po/or.po             | 1078 ++++++++++++++++--------------
> >  python/po/pa.po             | 1078 ++++++++++++++++--------------
> >  python/po/pl.po             | 1175 +++++++++++++++++----------------
> >  python/po/pt.po             | 1078 ++++++++++++++++--------------
> >  python/po/pt_BR.po          | 1122 ++++++++++++++++---------------
> >  python/po/ro.po             |  963 +++++++++++++--------------
> >  python/po/ru.po             | 1123 ++++++++++++++++---------------
> >  python/po/si.po             |  963 +++++++++++++--------------
> >  python/po/sk.po             | 1069 ++++++++++++++++--------------
> >  python/po/sl.po             | 1018 ++++++++++++++--------------
> >  python/po/sq.po             |  963 +++++++++++++--------------
> >  python/po/sr.po             | 1082 ++++++++++++++++--------------
> >  python/po/sr@latin.po       | 1082 ++++++++++++++++--------------
> >  python/po/sv.po             | 1167 +++++++++++++++++----------------
> >  python/po/ta.po             | 1082 ++++++++++++++++--------------
> >  python/po/te.po             | 1078 ++++++++++++++++--------------
> >  python/po/tg.po             |  963 +++++++++++++--------------
> >  python/po/th.po             |  963 +++++++++++++--------------
> >  python/po/tr.po             | 1008 ++++++++++++++--------------
> >  python/po/uk.po             | 1172 +++++++++++++++++----------------
> >  python/po/ur.po             |  963 +++++++++++++--------------
> >  python/po/vi.po             |  963 +++++++++++++--------------
> >  python/po/zh_CN.po          | 1156 ++++++++++++++++----------------
> >  python/po/zh_HK.po          |  963 +++++++++++++--------------
> >  python/po/zh_TW.po          | 1102 +++++++++++++++++--------------
> >  python/po/zu.po             |  963 +++++++++++++--------------
> >  sandbox/po/de.po            |   12 +-
> >  sandbox/po/it.po            |   52 +-
> >  sandbox/po/ja.po            |    5 +-
> >  sandbox/po/ka.po            |    5 +-
> >  sandbox/po/ko.po            |   10 +-
> >  sandbox/po/sv.po            |   16 +-
> >  sandbox/po/tr.po            |   14 +-
> >  sandbox/po/uk.po            |    6 +-
> >  sandbox/po/zh_CN.po         |    6 +-
> >  sandbox/po/zh_TW.po         |   17 +-
> >  119 files changed, 48906 insertions(+), 45258 deletions(-)
> >
