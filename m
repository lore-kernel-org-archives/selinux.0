Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61061C4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Nov 2023 17:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjKFRbO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Nov 2023 12:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjKFRbN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Nov 2023 12:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F02D42
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699291827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E0Lz6mNK+2XGCfhqoHlQh5mdlIoRAMZS/ZkY0EShdQs=;
        b=AzIUG10V6GU9UntoKtOLgck2luwGjXDu4vXi2uIPVY8nk6Iuh7ZyINt84UsiXRH6ePODiy
        sosnXXN7FLNaibYs/B+MS92Kj+h/VT3wSmxQfMd0oOHI/S+n8uKrymhMCdachzmW0GwjsJ
        7+c/8iWwOhERWMKc/ewrn+V5OPc39wA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-V6t9QHRkPzyJ_Ox9XJ1D7g-1; Mon,
 06 Nov 2023 12:30:25 -0500
X-MC-Unique: V6t9QHRkPzyJ_Ox9XJ1D7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 720861C0CCBC
        for <selinux@vger.kernel.org>; Mon,  6 Nov 2023 17:30:25 +0000 (UTC)
Received: from P1.redhat.com (unknown [10.45.224.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E379B1C060B0;
        Mon,  6 Nov 2023 17:30:24 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] Update translations
Date:   Mon,  6 Nov 2023 18:28:50 +0100
Message-ID: <20231106172857.233804-2-lautrbach@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Source: https://translate.fedoraproject.org/projects/selinux/

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

The patch is too big and is available at https://github.com/SELinuxProject/selinux/pull/413
---
 gui/po/de.po                |   14 +-
 gui/po/en_GB.po             |  117 ++--
 gui/po/fr.po                |    8 +-
 gui/po/gui.pot              |   32 +-
 gui/po/he.po                |   18 +-
 gui/po/hu.po                |   19 +-
 gui/po/ja.po                |    8 +-
 gui/po/ko.po                |   12 +-
 gui/po/sl.po                |  400 ++++++-----
 gui/po/zh_CN.po             |   12 +-
 gui/po/zh_TW.po             |   94 ++-
 policycoreutils/po/en_GB.po |   25 +-
 policycoreutils/po/es.po    |   17 +-
 policycoreutils/po/it.po    |   15 +-
 policycoreutils/po/ka.po    |   12 +-
 policycoreutils/po/pt_BR.po |   15 +-
 policycoreutils/po/ro.po    |  140 ++--
 policycoreutils/po/ru.po    |   17 +-
 policycoreutils/po/zh_TW.po |   15 +-
 python/po/af.po             |  963 +++++++++++++--------------
 python/po/am.po             |  963 +++++++++++++--------------
 python/po/ar.po             | 1078 ++++++++++++++++--------------
 python/po/as.po             | 1078 ++++++++++++++++--------------
 python/po/ast.po            |  963 +++++++++++++--------------
 python/po/bal.po            |  963 +++++++++++++--------------
 python/po/be.po             |  967 +++++++++++++--------------
 python/po/bg.po             | 1077 ++++++++++++++++--------------
 python/po/bn.po             |  963 +++++++++++++--------------
 python/po/bn_IN.po          | 1078 ++++++++++++++++--------------
 python/po/br.po             |  963 +++++++++++++--------------
 python/po/brx.po            |  963 +++++++++++++--------------
 python/po/bs.po             | 1073 ++++++++++++++++--------------
 python/po/ca.po             | 1077 ++++++++++++++++--------------
 python/po/cs.po             | 1097 +++++++++++++++++--------------
 python/po/cy.po             |  963 +++++++++++++--------------
 python/po/da.po             | 1108 +++++++++++++++++--------------
 python/po/de.po             | 1112 +++++++++++++++++--------------
 python/po/de_CH.po          |  963 +++++++++++++--------------
 python/po/el.po             | 1005 ++++++++++++++--------------
 python/po/en_GB.po          | 1105 ++++++++++++++++---------------
 python/po/eo.po             |  963 +++++++++++++--------------
 python/po/es.po             | 1106 +++++++++++++++++--------------
 python/po/et.po             |  963 +++++++++++++--------------
 python/po/eu.po             |  977 +++++++++++++--------------
 python/po/fa.po             |  963 +++++++++++++--------------
 python/po/fi.po             | 1179 +++++++++++++++++----------------
 python/po/fil.po            |  963 +++++++++++++--------------
 python/po/fr.po             | 1193 +++++++++++++++++----------------
 python/po/fur.po            |  963 +++++++++++++--------------
 python/po/ga.po             |  963 +++++++++++++--------------
 python/po/gl.po             |  963 +++++++++++++--------------
 python/po/gu.po             | 1078 ++++++++++++++++--------------
 python/po/he.po             |  963 +++++++++++++--------------
 python/po/hi.po             | 1078 ++++++++++++++++--------------
 python/po/hr.po             | 1084 ++++++++++++++++--------------
 python/po/hu.po             | 1107 ++++++++++++++++---------------
 python/po/ia.po             |  963 +++++++++++++--------------
 python/po/id.po             |  963 +++++++++++++--------------
 python/po/ilo.po            |  963 +++++++++++++--------------
 python/po/is.po             |  963 +++++++++++++--------------
 python/po/it.po             | 1224 +++++++++++++++++-----------------
 python/po/ja.po             | 1181 +++++++++++++++++----------------
 python/po/ka.po             | 1006 ++++++++++++++--------------
 python/po/kk.po             |  978 +++++++++++++--------------
 python/po/km.po             |  963 +++++++++++++--------------
 python/po/kn.po             | 1078 ++++++++++++++++--------------
 python/po/ko.po             | 1239 ++++++++++++++++++-----------------
 python/po/ky.po             |  963 +++++++++++++--------------
 python/po/lt.po             |  967 +++++++++++++--------------
 python/po/lv.po             |  963 +++++++++++++--------------
 python/po/mai.po            | 1077 ++++++++++++++++--------------
 python/po/mk.po             | 1069 ++++++++++++++++--------------
 python/po/ml.po             | 1106 ++++++++++++++++---------------
 python/po/mn.po             |  963 +++++++++++++--------------
 python/po/mr.po             | 1078 ++++++++++++++++--------------
 python/po/ms.po             | 1058 ++++++++++++++++--------------
 python/po/my.po             |  963 +++++++++++++--------------
 python/po/nb.po             |  975 +++++++++++++--------------
 python/po/nds.po            |  963 +++++++++++++--------------
 python/po/ne.po             |  963 +++++++++++++--------------
 python/po/nl.po             | 1111 +++++++++++++++++--------------
 python/po/nn.po             |  963 +++++++++++++--------------
 python/po/nso.po            |  963 +++++++++++++--------------
 python/po/or.po             | 1078 ++++++++++++++++--------------
 python/po/pa.po             | 1078 ++++++++++++++++--------------
 python/po/pl.po             | 1175 +++++++++++++++++----------------
 python/po/pt.po             | 1078 ++++++++++++++++--------------
 python/po/pt_BR.po          | 1122 ++++++++++++++++---------------
 python/po/ro.po             |  963 +++++++++++++--------------
 python/po/ru.po             | 1123 ++++++++++++++++---------------
 python/po/si.po             |  963 +++++++++++++--------------
 python/po/sk.po             | 1069 ++++++++++++++++--------------
 python/po/sl.po             | 1018 ++++++++++++++--------------
 python/po/sq.po             |  963 +++++++++++++--------------
 python/po/sr.po             | 1082 ++++++++++++++++--------------
 python/po/sr@latin.po       | 1082 ++++++++++++++++--------------
 python/po/sv.po             | 1167 +++++++++++++++++----------------
 python/po/ta.po             | 1082 ++++++++++++++++--------------
 python/po/te.po             | 1078 ++++++++++++++++--------------
 python/po/tg.po             |  963 +++++++++++++--------------
 python/po/th.po             |  963 +++++++++++++--------------
 python/po/tr.po             | 1008 ++++++++++++++--------------
 python/po/uk.po             | 1172 +++++++++++++++++----------------
 python/po/ur.po             |  963 +++++++++++++--------------
 python/po/vi.po             |  963 +++++++++++++--------------
 python/po/zh_CN.po          | 1156 ++++++++++++++++----------------
 python/po/zh_HK.po          |  963 +++++++++++++--------------
 python/po/zh_TW.po          | 1102 +++++++++++++++++--------------
 python/po/zu.po             |  963 +++++++++++++--------------
 sandbox/po/de.po            |   12 +-
 sandbox/po/it.po            |   52 +-
 sandbox/po/ja.po            |    5 +-
 sandbox/po/ka.po            |    5 +-
 sandbox/po/ko.po            |   10 +-
 sandbox/po/sv.po            |   16 +-
 sandbox/po/tr.po            |   14 +-
 sandbox/po/uk.po            |    6 +-
 sandbox/po/zh_CN.po         |    6 +-
 sandbox/po/zh_TW.po         |   17 +-
 119 files changed, 48906 insertions(+), 45258 deletions(-)

