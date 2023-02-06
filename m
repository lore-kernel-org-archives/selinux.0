Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ABDC61DA4
	for <selinux@archiver.kernel.org>; Mon,  6 Feb 2023 14:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjBFOli (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjBFOli (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Feb 2023 09:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5719F3D
        for <selinux@vger.kernel.org>; Mon,  6 Feb 2023 06:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675694449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RXdjLx3rtcqidOxnMLGlNgY5mV2L3M1SdTs9NZRetL4=;
        b=MbKcITyYWRRpxiJdag4PLPMflC/d2tlK/58g38ychmZRvYdbbKYVr+ZOGuZxB5z+l8/gGE
        iHiIVcYB3T3HsiIqPktjRtSBZ1meT+EzqEbHZyFPi5ZvCVP9uSQehQSIfOX114aRncp447
        KprjU5QdV3mPKIGu1e0TAGmTxdSjPfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-QfmbQkSyO3u2L92-w3TAzg-1; Mon, 06 Feb 2023 09:40:46 -0500
X-MC-Unique: QfmbQkSyO3u2L92-w3TAzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4663E85A5B1;
        Mon,  6 Feb 2023 14:40:46 +0000 (UTC)
Received: from localhost (ovpn-194-116.brq.redhat.com [10.40.194.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F007E1121315;
        Mon,  6 Feb 2023 14:40:45 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Update translations
In-Reply-To: <CAP+JOzQ2Q6gw7jjmEB_5570rNPzcCWpcRBgF89f2L7Evq=qFFA@mail.gmail.com>
References: <20230127134401.1065787-1-lautrbach@redhat.com>
 <CAP+JOzQ2Q6gw7jjmEB_5570rNPzcCWpcRBgF89f2L7Evq=qFFA@mail.gmail.com>
Date:   Mon, 06 Feb 2023 15:40:45 +0100
Message-ID: <87edr2eu1e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Jan 27, 2023 at 8:59 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>>
>> Source: https://translate.fedoraproject.org/projects/selinux/
>>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

This is merged now. Thanks!

>> ---
>>
>> The patch is too big for the mailing list - it's available at https://github.com/bachradsusi/SELinuxProject-selinux/commit/6ff74136e9ac5aa0f7406db6ae040a89c0e3d93d
>> or https://github.com/bachradsusi/SELinuxProject-selinux/commit/6ff74136e9ac5aa0f7406db6ae040a89c0e3d93d.patch
>>
>>
>>  gui/po/de.po             |   10 +-
>>  gui/po/ja.po             |    8 +-
>>  gui/po/ka.po             |   16 +-
>>  gui/po/tr.po             |   10 +-
>>  policycoreutils/po/ar.po |   15 +-
>>  policycoreutils/po/de.po |   15 +-
>>  policycoreutils/po/fr.po |   10 +-
>>  policycoreutils/po/ko.po |    8 +-
>>  policycoreutils/po/sv.po |   15 +-
>>  policycoreutils/po/tr.po |   10 +-
>>  python/po/af.po          |  943 ++++++++++++++++----------------
>>  python/po/am.po          |  943 ++++++++++++++++----------------
>>  python/po/ar.po          |  947 ++++++++++++++++----------------
>>  python/po/as.po          |  947 ++++++++++++++++----------------
>>  python/po/ast.po         |  943 ++++++++++++++++----------------
>>  python/po/bal.po         |  943 ++++++++++++++++----------------
>>  python/po/be.po          |  943 ++++++++++++++++----------------
>>  python/po/bg.po          |  947 ++++++++++++++++----------------
>>  python/po/bn.po          |  943 ++++++++++++++++----------------
>>  python/po/bn_IN.po       |  947 ++++++++++++++++----------------
>>  python/po/br.po          |  943 ++++++++++++++++----------------
>>  python/po/brx.po         |  943 ++++++++++++++++----------------
>>  python/po/bs.po          |  947 ++++++++++++++++----------------
>>  python/po/ca.po          |  947 ++++++++++++++++----------------
>>  python/po/cs.po          |  947 ++++++++++++++++----------------
>>  python/po/cy.po          |  943 ++++++++++++++++----------------
>>  python/po/da.po          |  947 ++++++++++++++++----------------
>>  python/po/de.po          |  964 ++++++++++++++++-----------------
>>  python/po/de_CH.po       |  943 ++++++++++++++++----------------
>>  python/po/el.po          |  943 ++++++++++++++++----------------
>>  python/po/en_GB.po       |  947 ++++++++++++++++----------------
>>  python/po/eo.po          |  943 ++++++++++++++++----------------
>>  python/po/es.po          |  947 ++++++++++++++++----------------
>>  python/po/et.po          |  943 ++++++++++++++++----------------
>>  python/po/eu.po          |  943 ++++++++++++++++----------------
>>  python/po/fa.po          |  943 ++++++++++++++++----------------
>>  python/po/fi.po          |  951 ++++++++++++++++----------------
>>  python/po/fil.po         |  943 ++++++++++++++++----------------
>>  python/po/fr.po          |  953 +++++++++++++++++----------------
>>  python/po/fur.po         |  943 ++++++++++++++++----------------
>>  python/po/ga.po          |  943 ++++++++++++++++----------------
>>  python/po/gl.po          |  943 ++++++++++++++++----------------
>>  python/po/gu.po          |  947 ++++++++++++++++----------------
>>  python/po/he.po          |  943 ++++++++++++++++----------------
>>  python/po/hi.po          |  947 ++++++++++++++++----------------
>>  python/po/hr.po          |  947 ++++++++++++++++----------------
>>  python/po/hu.po          |  947 ++++++++++++++++----------------
>>  python/po/ia.po          |  943 ++++++++++++++++----------------
>>  python/po/id.po          |  943 ++++++++++++++++----------------
>>  python/po/ilo.po         |  943 ++++++++++++++++----------------
>>  python/po/is.po          |  943 ++++++++++++++++----------------
>>  python/po/it.po          |  947 ++++++++++++++++----------------
>>  python/po/ja.po          |  953 +++++++++++++++++----------------
>>  python/po/ka.po          | 1101 +++++++++++++++++++-------------------
>>  python/po/kk.po          |  943 ++++++++++++++++----------------
>>  python/po/km.po          |  943 ++++++++++++++++----------------
>>  python/po/kn.po          |  947 ++++++++++++++++----------------
>>  python/po/ko.po          |  951 ++++++++++++++++----------------
>>  python/po/ky.po          |  943 ++++++++++++++++----------------
>>  python/po/lt.po          |  943 ++++++++++++++++----------------
>>  python/po/lv.po          |  943 ++++++++++++++++----------------
>>  python/po/mai.po         |  947 ++++++++++++++++----------------
>>  python/po/mk.po          |  947 ++++++++++++++++----------------
>>  python/po/ml.po          |  947 ++++++++++++++++----------------
>>  python/po/mn.po          |  943 ++++++++++++++++----------------
>>  python/po/mr.po          |  947 ++++++++++++++++----------------
>>  python/po/ms.po          |  947 ++++++++++++++++----------------
>>  python/po/my.po          |  943 ++++++++++++++++----------------
>>  python/po/nb.po          |  943 ++++++++++++++++----------------
>>  python/po/nds.po         |  943 ++++++++++++++++----------------
>>  python/po/ne.po          |  943 ++++++++++++++++----------------
>>  python/po/nl.po          |  947 ++++++++++++++++----------------
>>  python/po/nn.po          |  943 ++++++++++++++++----------------
>>  python/po/nso.po         |  943 ++++++++++++++++----------------
>>  python/po/or.po          |  947 ++++++++++++++++----------------
>>  python/po/pa.po          |  947 ++++++++++++++++----------------
>>  python/po/pl.po          |  951 ++++++++++++++++----------------
>>  python/po/pt.po          |  947 ++++++++++++++++----------------
>>  python/po/pt_BR.po       |  947 ++++++++++++++++----------------
>>  python/po/python.pot     |  943 ++++++++++++++++----------------
>>  python/po/ro.po          |  943 ++++++++++++++++----------------
>>  python/po/ru.po          |  947 ++++++++++++++++----------------
>>  python/po/si.po          |  943 ++++++++++++++++----------------
>>  python/po/sk.po          |  947 ++++++++++++++++----------------
>>  python/po/sl.po          |  943 ++++++++++++++++----------------
>>  python/po/sq.po          |  943 ++++++++++++++++----------------
>>  python/po/sr.po          |  947 ++++++++++++++++----------------
>>  python/po/sr@latin.po    |  947 ++++++++++++++++----------------
>>  python/po/sv.po          |  955 +++++++++++++++++----------------
>>  python/po/ta.po          |  947 ++++++++++++++++----------------
>>  python/po/te.po          |  947 ++++++++++++++++----------------
>>  python/po/tg.po          |  943 ++++++++++++++++----------------
>>  python/po/th.po          |  943 ++++++++++++++++----------------
>>  python/po/tr.po          |  943 ++++++++++++++++----------------
>>  python/po/uk.po          |  955 +++++++++++++++++----------------
>>  python/po/ur.po          |  943 ++++++++++++++++----------------
>>  python/po/vi.po          |  943 ++++++++++++++++----------------
>>  python/po/zh_CN.po       |  957 +++++++++++++++++----------------
>>  python/po/zh_HK.po       |  943 ++++++++++++++++----------------
>>  python/po/zh_TW.po       |  947 ++++++++++++++++----------------
>>  python/po/zu.po          |  943 ++++++++++++++++----------------
>>  sandbox/po/cs.po         |   51 +-
>>  sandbox/po/da.po         |   53 +-
>>  sandbox/po/de.po         |   53 +-
>>  sandbox/po/es.po         |   53 +-
>>  sandbox/po/fi.po         |   57 +-
>>  sandbox/po/fr.po         |   59 +-
>>  sandbox/po/hu.po         |   53 +-
>>  sandbox/po/ja.po         |   57 +-
>>  sandbox/po/ka.po         |   83 +--
>>  sandbox/po/ko.po         |   57 +-
>>  sandbox/po/nl.po         |   53 +-
>>  sandbox/po/pl.po         |   57 +-
>>  sandbox/po/pt_BR.po      |   53 +-
>>  sandbox/po/ru.po         |   53 +-
>>  sandbox/po/sandbox.pot   |   51 +-
>>  sandbox/po/si.po         |   51 +-
>>  sandbox/po/sv.po         |   53 +-
>>  sandbox/po/tr.po         |   53 +-
>>  sandbox/po/uk.po         |   61 ++-
>>  sandbox/po/zh_CN.po      |   57 +-
>>  sandbox/po/zh_TW.po      |   53 +-
>>  122 files changed, 44044 insertions(+), 43450 deletions(-)
>>

