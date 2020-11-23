Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31205C56202
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC52D206FA
	for <selinux@archiver.kernel.org>; Mon, 23 Nov 2020 11:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjtPj0q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgKWLzX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:55:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729090AbgKWLzV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Nov 2020 06:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606132521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FDiS3SVz0pLQbPbIdLjk5oNhmoxpqZy1ucIp3A5Xrmo=;
        b=SjtPj0q+Vmv1OguXYGwmEu3fwB2EcIdoGFs+0/40VxFJGpXUWj2rESO1IqzxAv5j2LUpnP
        +wdFdY/qPM+spvfBepUSQcQ9sxUxT0PYPmAiTNu1RVR24RUvKcSHFSlOMMIg02hDTdYQO7
        dCFpNGxkeBTAYhjRrWF0uvRxx0da5lE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-Ajh3tE_JMr-Hp65aiFy8Xg-1; Mon, 23 Nov 2020 06:55:17 -0500
X-MC-Unique: Ajh3tE_JMr-Hp65aiFy8Xg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA49B8015C3;
        Mon, 23 Nov 2020 11:55:15 +0000 (UTC)
Received: from localhost (unknown [10.40.195.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 257815C1C5;
        Mon, 23 Nov 2020 11:55:14 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Cc:     hukeping <hukeping@huawei.com>,
        "Zhengjunling (JRing, Task Force)" <zhengjunling@huawei.com>,
        zhuangbiaowei <zhuangbiaowei@huawei.com>
Subject: Re: [RFC] Introduce  MAJOR.MINOR.PATCH version for the whole project
In-Reply-To: <f80deaf6f99c47f8a5a2bf88540c27c0@huawei.com>
References: <f80deaf6f99c47f8a5a2bf88540c27c0@huawei.com>
Date:   Mon, 23 Nov 2020 12:55:13 +0100
Message-ID: <87d004wan2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

hukeping <hukeping@huawei.com> writes:

> The current release tag for the whole project is 20200710<https://github.com/SELinuxProject/selinux/tree/20200710> ,  and for components is major.minor, for example: selinux-sandbox-3.1, libselinux-3.1
>
> Can we use the same type of version for the whole project for convenience?

I've no problem with this change. We would need to be update in
`scripts/release`.

If there's no objection from others I'll prepare a
patch so we can start with this starting 3.2.

Btw it's not relly MAJOR.MINOR, it's just X.Y. There were some big
changes in 2.3 and also the next release 3.2 will contain API/ABI
incompatible changes.


Petr

