Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0651BC433F5
	for <selinux@archiver.kernel.org>; Thu, 28 Apr 2022 16:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349959AbiD1Q1q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Apr 2022 12:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbiD1Q1o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Apr 2022 12:27:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AFAD6D979
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651163068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v6dEH2Is1dsv2aKSnWcn6aar4lCC+P8+XqL0CnaG4Lo=;
        b=Y15lDzNygD/1kZd+/EduYm8tZ8N9BcWqDjeSl/9jACVkvJ/8MRAUlCclE9qUqCTOpARZvz
        xQT5QBKVdqJ7YIes9rXtOe8hd3RCgVBp0AeqIqWZV0+euSLG4l+lgvoI+n5+4jdA0VssNC
        +dli5GyWWyIpIyuceFUSORHqq/zjWn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-J8RuA-5UNQ2ThMJx303P7w-1; Thu, 28 Apr 2022 12:24:26 -0400
X-MC-Unique: J8RuA-5UNQ2ThMJx303P7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 751A180231F
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 16:24:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C543540D2821;
        Thu, 28 Apr 2022 16:24:25 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] Update missing sandbox translations
Date:   Thu, 28 Apr 2022 18:23:59 +0200
Message-Id: <20220428162358.396459-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Source https://translate.fedoraproject.org/projects/selinux/

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

Available at https://github.com/bachradsusi/SELinuxProject-selinux/commit/d108226d3fc6ac2b83d7de61fe9c626877df7870


 sandbox/po/cs.po       | 154 +++++++++++++++++++++++++++++++++
 sandbox/po/da.po       | 176 +++++++++++++++++++++++++++++++++++++
 sandbox/po/de.po       | 175 +++++++++++++++++++++++++++++++++++++
 sandbox/po/es.po       | 178 ++++++++++++++++++++++++++++++++++++++
 sandbox/po/fi.po       | 181 ++++++++++++++++++++++++++++++++++++++
 sandbox/po/fr.po       | 183 +++++++++++++++++++++++++++++++++++++++
 sandbox/po/hu.po       | 158 +++++++++++++++++++++++++++++++++
 sandbox/po/it.po       | 192 +++++++++++++++++++++++++++++++++++++++++
 sandbox/po/ja.po       | 178 ++++++++++++++++++++++++++++++++++++++
 sandbox/po/ko.po       | 171 ++++++++++++++++++++++++++++++++++++
 sandbox/po/nl.po       | 177 +++++++++++++++++++++++++++++++++++++
 sandbox/po/pl.po       | 178 ++++++++++++++++++++++++++++++++++++++
 sandbox/po/pt_BR.po    | 174 +++++++++++++++++++++++++++++++++++++
 sandbox/po/ru.po       | 176 +++++++++++++++++++++++++++++++++++++
 sandbox/po/sandbox.pot |   6 +-
 sandbox/po/si.po       | 156 +++++++++++++++++++++++++++++++++
 sandbox/po/sv.po       | 176 +++++++++++++++++++++++++++++++++++++
 sandbox/po/tr.po       | 182 ++++++++++++++++++++++++++++++++++++++
 sandbox/po/uk.po       | 178 ++++++++++++++++++++++++++++++++++++++
 sandbox/po/zh_CN.po    | 171 ++++++++++++++++++++++++++++++++++++
 sandbox/po/zh_TW.po    | 169 ++++++++++++++++++++++++++++++++++++
 21 files changed, 3486 insertions(+), 3 deletions(-)
 create mode 100644 sandbox/po/cs.po
 create mode 100644 sandbox/po/da.po
 create mode 100644 sandbox/po/de.po
 create mode 100644 sandbox/po/es.po
 create mode 100644 sandbox/po/fi.po
 create mode 100644 sandbox/po/fr.po
 create mode 100644 sandbox/po/hu.po
 create mode 100644 sandbox/po/it.po
 create mode 100644 sandbox/po/ja.po
 create mode 100644 sandbox/po/ko.po
 create mode 100644 sandbox/po/nl.po
 create mode 100644 sandbox/po/pl.po
 create mode 100644 sandbox/po/pt_BR.po
 create mode 100644 sandbox/po/ru.po
 create mode 100644 sandbox/po/si.po
 create mode 100644 sandbox/po/sv.po
 create mode 100644 sandbox/po/tr.po
 create mode 100644 sandbox/po/uk.po
 create mode 100644 sandbox/po/zh_CN.po
 create mode 100644 sandbox/po/zh_TW.po

