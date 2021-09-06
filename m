Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB9C433F5
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 18:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72276069E
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 18:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbhIFSlC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 14:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230263AbhIFSlB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Sep 2021 14:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630953596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYT4EJVKVo9i5Q/lnkisrqNE9PmfbNp9mJjpjm6GzQE=;
        b=Du0oQxiq6I2aYkboMMXiQK24S/Pim+AqwkqqNBk0040gmRPazWaJnZ+O0l8CjuhCRs5baD
        puNfth23SI+P94/fxsBHjFfOuv47wrBvxQzMQLutb7vt2zKZae97BwAX0nT4jRognR/unj
        UUIzXwNzHVHW6Q3EZQbwMg+GBHB8quU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-3cVUAFv6NxmbbzvuLrf-Zw-1; Mon, 06 Sep 2021 14:39:55 -0400
X-MC-Unique: 3cVUAFv6NxmbbzvuLrf-Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8185A1883525
        for <selinux@vger.kernel.org>; Mon,  6 Sep 2021 18:39:54 +0000 (UTC)
Received: from localhost (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BDB710074E1
        for <selinux@vger.kernel.org>; Mon,  6 Sep 2021 18:39:53 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: lets think about 3.3 - 3.3-rc1 release release notes draft
In-Reply-To: <87pmtpa2wt.fsf@redhat.com>
References: <87fsvmu2xa.fsf@redhat.com> <87zgsu9j9c.fsf@redhat.com>
 <87pmtpa2wt.fsf@redhat.com>
Date:   Mon, 06 Sep 2021 20:39:53 +0200
Message-ID: <87k0jta6py.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


I tried to pick only important things as there's a lot of fixes related
to static analysis and compiler warnings.

Please take a look and if you miss something or want improve message
let me know.

My plan is to announce 3.3-rc1 on Wed morning (CEST)




RELEASE 3.3-rc1
======================

User-visible changes
--------------------

* When reading a binary policy by checkpolicy, do not automatically change the version
  to the max policy version supported by libsepol or, if specified, the value given
  using the "-c" flag.

* `fixfiles -C` doesn't exclude /dev and /run anymore

* CIL: Lists are allowed in constraint expressions

* CIL: Improved situation with duplicate macro and block declarations

* Added the new `secilc2tree` program to write out CIL AST.

* Improved documentation

* A lot of Static code analyse issues and compiler warnings fixed

* Bug fixes


Development-relevant changes
----------------------------

* CIFuzz is turned on in CI
  https://google.github.io/oss-fuzz/getting-started/continuous-integration/

* Fedora 34 image is used in CI


Issues fixed
------------

* https://github.com/SELinuxProject/selinux/issues/293

