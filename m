Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB2C38142
	for <selinux@archiver.kernel.org>; Wed,  1 Feb 2023 16:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBAQey (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Feb 2023 11:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjBAQex (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Feb 2023 11:34:53 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31054690
        for <selinux@vger.kernel.org>; Wed,  1 Feb 2023 08:34:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id k4so47623593eje.1
        for <selinux@vger.kernel.org>; Wed, 01 Feb 2023 08:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oBt4DomwCv8j4VkoehxaMgmpfNhLBFqHKddDELjv8KI=;
        b=aMDnURT9nEu2jjiFQuuQ+rOKtlE4vlzvoTjBz/eMLP7YIYUG//Q9ofxPUq/HnGo+43
         vjNAWIbpQ4qTILtrVz2az7i6P+lfO+dOGFagOi3yfnGd0Pzn6kYqSU5CAFTVjfLMmQq3
         j4rBmpxXw35hEmrY5JN6/XlVpL/KS8zEgdG59PLmnkQdn752wkVEaLn5BleH7ZyDGo+q
         V/+cGA8wVDeGSKN8WZEgauSPcXJQGyUpZ0DSf3eUlhpdI55LOdzehvktA1NpUY4TSAMk
         DbAMHqsZjzHsf9v67344DjaG+G+vDalum4QlMaDyUW6Wp5q6uCdozh1i7eFG+EWDg0mj
         6EYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBt4DomwCv8j4VkoehxaMgmpfNhLBFqHKddDELjv8KI=;
        b=kTNs21xeqrT80L+bAoQoXTZcvvm3OgKoD/MG5E2b8rroMcMl0TjRrqil+bBr+YgB7b
         /tv28DHPjX/GI/E3bqNg64UU0esaFuOYFq6eC8TemEpRXsas+/5IBaiG0q4o0BVo0GRu
         zO7YKe+IEozI08OcezWukB0SHLzzLwaqr7MFw+odRqRyFvtvZ+sWrqFgI6iFnPLZrf2S
         3VUZX3dyrFy3hMY2Hxm009TcG5acJWq+z+/Id1OuxAYxZJ7T9duF9P4nVENsIK+qp5KH
         1aUF9XfHDSmjlDqbktRGqAgf/HGKOu8XUwXjHNjXbXnO3SKseQY0Aqj9SMcmGPBzXC+U
         gR+Q==
X-Gm-Message-State: AO0yUKWtCiBV9UmFWeOFPDs2UevHYL7kpZggXw4w4ZC7Ii/TvJGoAL7H
        QgdQOBQ5xrKOY+nSiZlQ9byjUxA9oN76/0UuLaiUDcqL35k=
X-Google-Smtp-Source: AK7set+IDtUU8pVYPur/S3Nd5apFKcZ1FdxU2Q/v1AAnaYKv5uTsE5PCZlK6wQsfrXoImkKVbJPHueebiemBzAeVtLk=
X-Received: by 2002:a17:906:5390:b0:888:1f21:4424 with SMTP id
 g16-20020a170906539000b008881f214424mr985684ejo.141.1675269290248; Wed, 01
 Feb 2023 08:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20230127134401.1065787-1-lautrbach@redhat.com>
In-Reply-To: <20230127134401.1065787-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 1 Feb 2023 11:34:39 -0500
Message-ID: <CAP+JOzQ2Q6gw7jjmEB_5570rNPzcCWpcRBgF89f2L7Evq=qFFA@mail.gmail.com>
Subject: Re: [PATCH] Update translations
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 27, 2023 at 8:59 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Source: https://translate.fedoraproject.org/projects/selinux/
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> The patch is too big for the mailing list - it's available at https://github.com/bachradsusi/SELinuxProject-selinux/commit/6ff74136e9ac5aa0f7406db6ae040a89c0e3d93d
> or https://github.com/bachradsusi/SELinuxProject-selinux/commit/6ff74136e9ac5aa0f7406db6ae040a89c0e3d93d.patch
>
>
>  gui/po/de.po             |   10 +-
>  gui/po/ja.po             |    8 +-
>  gui/po/ka.po             |   16 +-
>  gui/po/tr.po             |   10 +-
>  policycoreutils/po/ar.po |   15 +-
>  policycoreutils/po/de.po |   15 +-
>  policycoreutils/po/fr.po |   10 +-
>  policycoreutils/po/ko.po |    8 +-
>  policycoreutils/po/sv.po |   15 +-
>  policycoreutils/po/tr.po |   10 +-
>  python/po/af.po          |  943 ++++++++++++++++----------------
>  python/po/am.po          |  943 ++++++++++++++++----------------
>  python/po/ar.po          |  947 ++++++++++++++++----------------
>  python/po/as.po          |  947 ++++++++++++++++----------------
>  python/po/ast.po         |  943 ++++++++++++++++----------------
>  python/po/bal.po         |  943 ++++++++++++++++----------------
>  python/po/be.po          |  943 ++++++++++++++++----------------
>  python/po/bg.po          |  947 ++++++++++++++++----------------
>  python/po/bn.po          |  943 ++++++++++++++++----------------
>  python/po/bn_IN.po       |  947 ++++++++++++++++----------------
>  python/po/br.po          |  943 ++++++++++++++++----------------
>  python/po/brx.po         |  943 ++++++++++++++++----------------
>  python/po/bs.po          |  947 ++++++++++++++++----------------
>  python/po/ca.po          |  947 ++++++++++++++++----------------
>  python/po/cs.po          |  947 ++++++++++++++++----------------
>  python/po/cy.po          |  943 ++++++++++++++++----------------
>  python/po/da.po          |  947 ++++++++++++++++----------------
>  python/po/de.po          |  964 ++++++++++++++++-----------------
>  python/po/de_CH.po       |  943 ++++++++++++++++----------------
>  python/po/el.po          |  943 ++++++++++++++++----------------
>  python/po/en_GB.po       |  947 ++++++++++++++++----------------
>  python/po/eo.po          |  943 ++++++++++++++++----------------
>  python/po/es.po          |  947 ++++++++++++++++----------------
>  python/po/et.po          |  943 ++++++++++++++++----------------
>  python/po/eu.po          |  943 ++++++++++++++++----------------
>  python/po/fa.po          |  943 ++++++++++++++++----------------
>  python/po/fi.po          |  951 ++++++++++++++++----------------
>  python/po/fil.po         |  943 ++++++++++++++++----------------
>  python/po/fr.po          |  953 +++++++++++++++++----------------
>  python/po/fur.po         |  943 ++++++++++++++++----------------
>  python/po/ga.po          |  943 ++++++++++++++++----------------
>  python/po/gl.po          |  943 ++++++++++++++++----------------
>  python/po/gu.po          |  947 ++++++++++++++++----------------
>  python/po/he.po          |  943 ++++++++++++++++----------------
>  python/po/hi.po          |  947 ++++++++++++++++----------------
>  python/po/hr.po          |  947 ++++++++++++++++----------------
>  python/po/hu.po          |  947 ++++++++++++++++----------------
>  python/po/ia.po          |  943 ++++++++++++++++----------------
>  python/po/id.po          |  943 ++++++++++++++++----------------
>  python/po/ilo.po         |  943 ++++++++++++++++----------------
>  python/po/is.po          |  943 ++++++++++++++++----------------
>  python/po/it.po          |  947 ++++++++++++++++----------------
>  python/po/ja.po          |  953 +++++++++++++++++----------------
>  python/po/ka.po          | 1101 +++++++++++++++++++-------------------
>  python/po/kk.po          |  943 ++++++++++++++++----------------
>  python/po/km.po          |  943 ++++++++++++++++----------------
>  python/po/kn.po          |  947 ++++++++++++++++----------------
>  python/po/ko.po          |  951 ++++++++++++++++----------------
>  python/po/ky.po          |  943 ++++++++++++++++----------------
>  python/po/lt.po          |  943 ++++++++++++++++----------------
>  python/po/lv.po          |  943 ++++++++++++++++----------------
>  python/po/mai.po         |  947 ++++++++++++++++----------------
>  python/po/mk.po          |  947 ++++++++++++++++----------------
>  python/po/ml.po          |  947 ++++++++++++++++----------------
>  python/po/mn.po          |  943 ++++++++++++++++----------------
>  python/po/mr.po          |  947 ++++++++++++++++----------------
>  python/po/ms.po          |  947 ++++++++++++++++----------------
>  python/po/my.po          |  943 ++++++++++++++++----------------
>  python/po/nb.po          |  943 ++++++++++++++++----------------
>  python/po/nds.po         |  943 ++++++++++++++++----------------
>  python/po/ne.po          |  943 ++++++++++++++++----------------
>  python/po/nl.po          |  947 ++++++++++++++++----------------
>  python/po/nn.po          |  943 ++++++++++++++++----------------
>  python/po/nso.po         |  943 ++++++++++++++++----------------
>  python/po/or.po          |  947 ++++++++++++++++----------------
>  python/po/pa.po          |  947 ++++++++++++++++----------------
>  python/po/pl.po          |  951 ++++++++++++++++----------------
>  python/po/pt.po          |  947 ++++++++++++++++----------------
>  python/po/pt_BR.po       |  947 ++++++++++++++++----------------
>  python/po/python.pot     |  943 ++++++++++++++++----------------
>  python/po/ro.po          |  943 ++++++++++++++++----------------
>  python/po/ru.po          |  947 ++++++++++++++++----------------
>  python/po/si.po          |  943 ++++++++++++++++----------------
>  python/po/sk.po          |  947 ++++++++++++++++----------------
>  python/po/sl.po          |  943 ++++++++++++++++----------------
>  python/po/sq.po          |  943 ++++++++++++++++----------------
>  python/po/sr.po          |  947 ++++++++++++++++----------------
>  python/po/sr@latin.po    |  947 ++++++++++++++++----------------
>  python/po/sv.po          |  955 +++++++++++++++++----------------
>  python/po/ta.po          |  947 ++++++++++++++++----------------
>  python/po/te.po          |  947 ++++++++++++++++----------------
>  python/po/tg.po          |  943 ++++++++++++++++----------------
>  python/po/th.po          |  943 ++++++++++++++++----------------
>  python/po/tr.po          |  943 ++++++++++++++++----------------
>  python/po/uk.po          |  955 +++++++++++++++++----------------
>  python/po/ur.po          |  943 ++++++++++++++++----------------
>  python/po/vi.po          |  943 ++++++++++++++++----------------
>  python/po/zh_CN.po       |  957 +++++++++++++++++----------------
>  python/po/zh_HK.po       |  943 ++++++++++++++++----------------
>  python/po/zh_TW.po       |  947 ++++++++++++++++----------------
>  python/po/zu.po          |  943 ++++++++++++++++----------------
>  sandbox/po/cs.po         |   51 +-
>  sandbox/po/da.po         |   53 +-
>  sandbox/po/de.po         |   53 +-
>  sandbox/po/es.po         |   53 +-
>  sandbox/po/fi.po         |   57 +-
>  sandbox/po/fr.po         |   59 +-
>  sandbox/po/hu.po         |   53 +-
>  sandbox/po/ja.po         |   57 +-
>  sandbox/po/ka.po         |   83 +--
>  sandbox/po/ko.po         |   57 +-
>  sandbox/po/nl.po         |   53 +-
>  sandbox/po/pl.po         |   57 +-
>  sandbox/po/pt_BR.po      |   53 +-
>  sandbox/po/ru.po         |   53 +-
>  sandbox/po/sandbox.pot   |   51 +-
>  sandbox/po/si.po         |   51 +-
>  sandbox/po/sv.po         |   53 +-
>  sandbox/po/tr.po         |   53 +-
>  sandbox/po/uk.po         |   61 ++-
>  sandbox/po/zh_CN.po      |   57 +-
>  sandbox/po/zh_TW.po      |   53 +-
>  122 files changed, 44044 insertions(+), 43450 deletions(-)
>
