Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB52C433F5
	for <selinux@archiver.kernel.org>; Wed,  4 May 2022 07:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbiEDHpG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 May 2022 03:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiEDHpF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 May 2022 03:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DB9B1277C
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 00:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651650088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZaN4Zw3GppZGlgznel6M7VHt1vIIGMiwaBDd+H0k8M=;
        b=GmlUSzEpV1Bm45Hg1nBCB+FyS5h8dt2hwE/vvcRjKaW2HFfYRHh59nbYObtzYyo7Fp77vo
        m2cpwEJim71Fn1opy2PgPOf5dTTduhBKxDhGVY7hGyTBoSf2sOt59T2ruPJSJ2/IUPMfz6
        Upl41jlZPPb2qOAn+LH9q33YbsF3AlQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-MW6UTFu3P0-Ky0cwPjaDOA-1; Wed, 04 May 2022 03:41:25 -0400
X-MC-Unique: MW6UTFu3P0-Ky0cwPjaDOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F61E1C05AE4;
        Wed,  4 May 2022 07:41:25 +0000 (UTC)
Received: from localhost (unknown [10.40.194.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE67B40D2820;
        Wed,  4 May 2022 07:41:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] Update missing sandbox translations
In-Reply-To: <CAP+JOzQndjcqLA2=QNC-9u4C_Tj04Gd+1xaZfodp43WUYqUf8A@mail.gmail.com>
References: <20220428162358.396459-1-plautrba@redhat.com>
 <CAP+JOzQndjcqLA2=QNC-9u4C_Tj04Gd+1xaZfodp43WUYqUf8A@mail.gmail.com>
Date:   Wed, 04 May 2022 09:41:23 +0200
Message-ID: <87tua5923g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Sat, Apr 30, 2022 at 4:19 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Source https://translate.fedoraproject.org/projects/selinux/
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks.


>> ---
>>
>> Available at https://github.com/bachradsusi/SELinuxProject-selinux/commit/d108226d3fc6ac2b83d7de61fe9c626877df7870
>>
>>
>>  sandbox/po/cs.po       | 154 +++++++++++++++++++++++++++++++++
>>  sandbox/po/da.po       | 176 +++++++++++++++++++++++++++++++++++++
>>  sandbox/po/de.po       | 175 +++++++++++++++++++++++++++++++++++++
>>  sandbox/po/es.po       | 178 ++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/fi.po       | 181 ++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/fr.po       | 183 +++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/hu.po       | 158 +++++++++++++++++++++++++++++++++
>>  sandbox/po/it.po       | 192 +++++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/ja.po       | 178 ++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/ko.po       | 171 ++++++++++++++++++++++++++++++++++++
>>  sandbox/po/nl.po       | 177 +++++++++++++++++++++++++++++++++++++
>>  sandbox/po/pl.po       | 178 ++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/pt_BR.po    | 174 +++++++++++++++++++++++++++++++++++++
>>  sandbox/po/ru.po       | 176 +++++++++++++++++++++++++++++++++++++
>>  sandbox/po/sandbox.pot |   6 +-
>>  sandbox/po/si.po       | 156 +++++++++++++++++++++++++++++++++
>>  sandbox/po/sv.po       | 176 +++++++++++++++++++++++++++++++++++++
>>  sandbox/po/tr.po       | 182 ++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/uk.po       | 178 ++++++++++++++++++++++++++++++++++++++
>>  sandbox/po/zh_CN.po    | 171 ++++++++++++++++++++++++++++++++++++
>>  sandbox/po/zh_TW.po    | 169 ++++++++++++++++++++++++++++++++++++
>>  21 files changed, 3486 insertions(+), 3 deletions(-)
>>  create mode 100644 sandbox/po/cs.po
>>  create mode 100644 sandbox/po/da.po
>>  create mode 100644 sandbox/po/de.po
>>  create mode 100644 sandbox/po/es.po
>>  create mode 100644 sandbox/po/fi.po
>>  create mode 100644 sandbox/po/fr.po
>>  create mode 100644 sandbox/po/hu.po
>>  create mode 100644 sandbox/po/it.po
>>  create mode 100644 sandbox/po/ja.po
>>  create mode 100644 sandbox/po/ko.po
>>  create mode 100644 sandbox/po/nl.po
>>  create mode 100644 sandbox/po/pl.po
>>  create mode 100644 sandbox/po/pt_BR.po
>>  create mode 100644 sandbox/po/ru.po
>>  create mode 100644 sandbox/po/si.po
>>  create mode 100644 sandbox/po/sv.po
>>  create mode 100644 sandbox/po/tr.po
>>  create mode 100644 sandbox/po/uk.po
>>  create mode 100644 sandbox/po/zh_CN.po
>>  create mode 100644 sandbox/po/zh_TW.po
>>

