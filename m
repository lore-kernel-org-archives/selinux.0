Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19701C4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 19:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjKFTTB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFTTA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 14:19:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F87DBF
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 11:18:57 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507b96095abso6150581e87.3
        for <selinux@vger.kernel.org>; Mon, 06 Nov 2023 11:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699298336; x=1699903136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA/vtV74eLldZGHuWcmvAF5xkAnM1+IA4n8ySuq5waQ=;
        b=HjwZcFhwpeqJTNmqcpT0gtCc+i0p29CqKVGutv5DIyHLK+WbPDSCb66YD+e5uFLP+J
         3qdLH1gwvw0q3eCkounO0zgGacr2CPdauRMZspdsUvIkOJJK8DmymyXP9eQPJupJpmN6
         PCE3YQojZp4jcnN0syWp0xRdK17uaIAhFwQxhRBvhf22FE7fO4zEMr0HKMD3j4rwDfRd
         YR9wfIi5HLM7DyJ/nX3EoNYbSczfIUY3MGuJ1/bKuZ8AGfgE2Nve+mqfkMwRQcFtJtek
         F0O5sz3i2kXwSM0N8gbw8JoFLzeAIhXfplRtP0k+g+1HlaAsNI8vSDSiPjOSpelLpUY8
         YrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298336; x=1699903136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA/vtV74eLldZGHuWcmvAF5xkAnM1+IA4n8ySuq5waQ=;
        b=aYv0o4nj8oHghikFH055rEK+uXYV5LtfhJuBfamjaoC3YsNHx9u8rR/okbbH5YzaJm
         fsqLp+gXqwndwQLtlIhWkExYdZKY8zslcnolzZNeIjEXU5JJ2Z1p9CjfstFiqom4nzjK
         g8NgKLd7LTQccjKVczYeAO/8Tc45AusCkZ1rEQCUJhbZA3maMh6fdkr6QBqdTwBYdksS
         MgadXgtRqOtmFt7rPEEme6PIKGZqDnqhTs4dmi/VPd41aGsEUe4RyiHf6sWf8aAFJllc
         28WEA4zJzsikGkOAFMkQ7QTSbu5LqbvyyAuEz+T6dw5aze62sJSLy5F2jyeldwTF9R9f
         1A2A==
X-Gm-Message-State: AOJu0YykxdV35XPGAHl8VQI749za2+uVRjykfLDKUnIdjU8uLhUzABHz
        Dsfqsh67lI0NziF/yvFsc0u/6LxwjdZWRQ9PkKgKqCRlK08=
X-Google-Smtp-Source: AGHT+IHHiZ1uSq8sf2tVSzJcET5Wjv6nli5X/BLDw52sK/ZbcWaYfkBryQDNNTuA3emjVPJgwwSKNmqTWNJN6Ec3MmU=
X-Received: by 2002:ac2:5a11:0:b0:507:b19e:90cc with SMTP id
 q17-20020ac25a11000000b00507b19e90ccmr22128365lfn.40.1699298335516; Mon, 06
 Nov 2023 11:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20231106172857.233804-2-lautrbach@redhat.com>
In-Reply-To: <20231106172857.233804-2-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 6 Nov 2023 14:18:43 -0500
Message-ID: <CAP+JOzSBbwqcZVoNtOGFt4UYzZ1iR1Thktu4n5v24gPkKQ0y6w@mail.gmail.com>
Subject: Re: [PATCH] Update translations
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 6, 2023 at 12:31=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Source: https://translate.fedoraproject.org/projects/selinux/
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>

Acked-by: James Carter <jwcart2@gmail.com>

> The patch is too big and is available at https://github.com/SELinuxProjec=
t/selinux/pull/413
> ---
>  gui/po/de.po                |   14 +-
>  gui/po/en_GB.po             |  117 ++--
>  gui/po/fr.po                |    8 +-
>  gui/po/gui.pot              |   32 +-
>  gui/po/he.po                |   18 +-
>  gui/po/hu.po                |   19 +-
>  gui/po/ja.po                |    8 +-
>  gui/po/ko.po                |   12 +-
>  gui/po/sl.po                |  400 ++++++-----
>  gui/po/zh_CN.po             |   12 +-
>  gui/po/zh_TW.po             |   94 ++-
>  policycoreutils/po/en_GB.po |   25 +-
>  policycoreutils/po/es.po    |   17 +-
>  policycoreutils/po/it.po    |   15 +-
>  policycoreutils/po/ka.po    |   12 +-
>  policycoreutils/po/pt_BR.po |   15 +-
>  policycoreutils/po/ro.po    |  140 ++--
>  policycoreutils/po/ru.po    |   17 +-
>  policycoreutils/po/zh_TW.po |   15 +-
>  python/po/af.po             |  963 +++++++++++++--------------
>  python/po/am.po             |  963 +++++++++++++--------------
>  python/po/ar.po             | 1078 ++++++++++++++++--------------
>  python/po/as.po             | 1078 ++++++++++++++++--------------
>  python/po/ast.po            |  963 +++++++++++++--------------
>  python/po/bal.po            |  963 +++++++++++++--------------
>  python/po/be.po             |  967 +++++++++++++--------------
>  python/po/bg.po             | 1077 ++++++++++++++++--------------
>  python/po/bn.po             |  963 +++++++++++++--------------
>  python/po/bn_IN.po          | 1078 ++++++++++++++++--------------
>  python/po/br.po             |  963 +++++++++++++--------------
>  python/po/brx.po            |  963 +++++++++++++--------------
>  python/po/bs.po             | 1073 ++++++++++++++++--------------
>  python/po/ca.po             | 1077 ++++++++++++++++--------------
>  python/po/cs.po             | 1097 +++++++++++++++++--------------
>  python/po/cy.po             |  963 +++++++++++++--------------
>  python/po/da.po             | 1108 +++++++++++++++++--------------
>  python/po/de.po             | 1112 +++++++++++++++++--------------
>  python/po/de_CH.po          |  963 +++++++++++++--------------
>  python/po/el.po             | 1005 ++++++++++++++--------------
>  python/po/en_GB.po          | 1105 ++++++++++++++++---------------
>  python/po/eo.po             |  963 +++++++++++++--------------
>  python/po/es.po             | 1106 +++++++++++++++++--------------
>  python/po/et.po             |  963 +++++++++++++--------------
>  python/po/eu.po             |  977 +++++++++++++--------------
>  python/po/fa.po             |  963 +++++++++++++--------------
>  python/po/fi.po             | 1179 +++++++++++++++++----------------
>  python/po/fil.po            |  963 +++++++++++++--------------
>  python/po/fr.po             | 1193 +++++++++++++++++----------------
>  python/po/fur.po            |  963 +++++++++++++--------------
>  python/po/ga.po             |  963 +++++++++++++--------------
>  python/po/gl.po             |  963 +++++++++++++--------------
>  python/po/gu.po             | 1078 ++++++++++++++++--------------
>  python/po/he.po             |  963 +++++++++++++--------------
>  python/po/hi.po             | 1078 ++++++++++++++++--------------
>  python/po/hr.po             | 1084 ++++++++++++++++--------------
>  python/po/hu.po             | 1107 ++++++++++++++++---------------
>  python/po/ia.po             |  963 +++++++++++++--------------
>  python/po/id.po             |  963 +++++++++++++--------------
>  python/po/ilo.po            |  963 +++++++++++++--------------
>  python/po/is.po             |  963 +++++++++++++--------------
>  python/po/it.po             | 1224 +++++++++++++++++-----------------
>  python/po/ja.po             | 1181 +++++++++++++++++----------------
>  python/po/ka.po             | 1006 ++++++++++++++--------------
>  python/po/kk.po             |  978 +++++++++++++--------------
>  python/po/km.po             |  963 +++++++++++++--------------
>  python/po/kn.po             | 1078 ++++++++++++++++--------------
>  python/po/ko.po             | 1239 ++++++++++++++++++-----------------
>  python/po/ky.po             |  963 +++++++++++++--------------
>  python/po/lt.po             |  967 +++++++++++++--------------
>  python/po/lv.po             |  963 +++++++++++++--------------
>  python/po/mai.po            | 1077 ++++++++++++++++--------------
>  python/po/mk.po             | 1069 ++++++++++++++++--------------
>  python/po/ml.po             | 1106 ++++++++++++++++---------------
>  python/po/mn.po             |  963 +++++++++++++--------------
>  python/po/mr.po             | 1078 ++++++++++++++++--------------
>  python/po/ms.po             | 1058 ++++++++++++++++--------------
>  python/po/my.po             |  963 +++++++++++++--------------
>  python/po/nb.po             |  975 +++++++++++++--------------
>  python/po/nds.po            |  963 +++++++++++++--------------
>  python/po/ne.po             |  963 +++++++++++++--------------
>  python/po/nl.po             | 1111 +++++++++++++++++--------------
>  python/po/nn.po             |  963 +++++++++++++--------------
>  python/po/nso.po            |  963 +++++++++++++--------------
>  python/po/or.po             | 1078 ++++++++++++++++--------------
>  python/po/pa.po             | 1078 ++++++++++++++++--------------
>  python/po/pl.po             | 1175 +++++++++++++++++----------------
>  python/po/pt.po             | 1078 ++++++++++++++++--------------
>  python/po/pt_BR.po          | 1122 ++++++++++++++++---------------
>  python/po/ro.po             |  963 +++++++++++++--------------
>  python/po/ru.po             | 1123 ++++++++++++++++---------------
>  python/po/si.po             |  963 +++++++++++++--------------
>  python/po/sk.po             | 1069 ++++++++++++++++--------------
>  python/po/sl.po             | 1018 ++++++++++++++--------------
>  python/po/sq.po             |  963 +++++++++++++--------------
>  python/po/sr.po             | 1082 ++++++++++++++++--------------
>  python/po/sr@latin.po       | 1082 ++++++++++++++++--------------
>  python/po/sv.po             | 1167 +++++++++++++++++----------------
>  python/po/ta.po             | 1082 ++++++++++++++++--------------
>  python/po/te.po             | 1078 ++++++++++++++++--------------
>  python/po/tg.po             |  963 +++++++++++++--------------
>  python/po/th.po             |  963 +++++++++++++--------------
>  python/po/tr.po             | 1008 ++++++++++++++--------------
>  python/po/uk.po             | 1172 +++++++++++++++++----------------
>  python/po/ur.po             |  963 +++++++++++++--------------
>  python/po/vi.po             |  963 +++++++++++++--------------
>  python/po/zh_CN.po          | 1156 ++++++++++++++++----------------
>  python/po/zh_HK.po          |  963 +++++++++++++--------------
>  python/po/zh_TW.po          | 1102 +++++++++++++++++--------------
>  python/po/zu.po             |  963 +++++++++++++--------------
>  sandbox/po/de.po            |   12 +-
>  sandbox/po/it.po            |   52 +-
>  sandbox/po/ja.po            |    5 +-
>  sandbox/po/ka.po            |    5 +-
>  sandbox/po/ko.po            |   10 +-
>  sandbox/po/sv.po            |   16 +-
>  sandbox/po/tr.po            |   14 +-
>  sandbox/po/uk.po            |    6 +-
>  sandbox/po/zh_CN.po         |    6 +-
>  sandbox/po/zh_TW.po         |   17 +-
>  119 files changed, 48906 insertions(+), 45258 deletions(-)
>
