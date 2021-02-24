Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB005C433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 10:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D0C60C41
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 10:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhBXK7Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 05:59:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232678AbhBXK7P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 05:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614164269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+VXwBDPZ620nCwArVHFowFwEJXgOc+YQChINsN6fNBY=;
        b=WWxLoCpNp2fkrB+1PGpTyaVu0NulkfdJr4a/nNS1+WF2vvSOQVZIuEvjyMy99ZfOJFEJDt
        unWQxujNyiZULOyRReOZo1yxoTAQASwvbPXfaVkhJcyAGSnVDFMa2KDA9gAAw8EyYnrnEi
        uHJ56yHek5LrnOnzbKqJHOC53JKA038=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-Axhs8_vcOTyVPq6imitqSg-1; Wed, 24 Feb 2021 05:57:47 -0500
X-MC-Unique: Axhs8_vcOTyVPq6imitqSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DF9E835E20;
        Wed, 24 Feb 2021 10:57:46 +0000 (UTC)
Received: from localhost (unknown [10.40.193.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBBBC2D035;
        Wed, 24 Feb 2021 10:57:45 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        bauen1 <j2468h@googlemail.com>
Subject: Re: [PATCH v3] policycoreutils: sestatus belongs to bin not sbin
In-Reply-To: <CAJfZ7=kC2LWD7CFPebVmcVSRC7sijROxp9R4UWdyg2xfBH1e2A@mail.gmail.com>
References: <4f80b938-fb3d-ba0a-0c13-bfcfd76176f4@gmail.com>
 <CAJfZ7=kC2LWD7CFPebVmcVSRC7sijROxp9R4UWdyg2xfBH1e2A@mail.gmail.com>
Date:   Wed, 24 Feb 2021 11:57:44 +0100
Message-ID: <87a6rt3f87.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Sun, Feb 21, 2021 at 5:04 PM bauen1 <j2468h@googlemail.com> wrote:
>>
>> It is quite useful even to non-privileged users and doesn't require any
>> privileges to work, except for maybe -v.
>>
>> Some tools hard code the old path, so a compatibility symlink is also
>> created.
>>
>> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged, thanks!

> Thanks!
> Nicolas
>
>> ---
>>  policycoreutils/sestatus/Makefile | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
>> index 8c4f45f8..3dbb792b 100644
>> --- a/policycoreutils/sestatus/Makefile
>> +++ b/policycoreutils/sestatus/Makefile
>> @@ -1,6 +1,7 @@
>>  # Installation directories.
>>  LINGUAS ?= ru
>>  PREFIX ?= /usr
>> +BINDIR ?= $(PREFIX)/bin
>>  SBINDIR ?= $(PREFIX)/sbin
>>  MANDIR = $(PREFIX)/share/man
>>  ETCDIR ?= /etc
>> @@ -16,8 +17,13 @@ sestatus: sestatus.o
>>  install: all
>>         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
>>         [ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
>> +       -mkdir -p $(DESTDIR)$(BINDIR)
>>         -mkdir -p $(DESTDIR)$(SBINDIR)
>> -       install -m 755 sestatus $(DESTDIR)$(SBINDIR)
>> +       # Some tools hard code /usr/sbin/sestatus ; add a compatibility symlink
>> +       # install will overwrite a symlink, so create the symlink before calling
>> +       # install to allow distributions with BINDIR == SBINDIR
>> +       ln -sf --relative $(DESTDIR)$(BINDIR)/sestatus $(DESTDIR)$(SBINDIR)
>> +       install -m 755 sestatus $(DESTDIR)$(BINDIR)
>>         install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
>>         install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
>>         for lang in $(LINGUAS) ; do \
>> --
>> 2.30.1
>>

