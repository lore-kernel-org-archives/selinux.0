Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E6C433E6
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 16:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E8164DFF
	for <selinux@archiver.kernel.org>; Wed, 17 Feb 2021 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhBQQel (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Feb 2021 11:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234278AbhBQQeX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Feb 2021 11:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613579576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwVa9E0MuYQFH+ngDVkn8ZnaJCyyMEv0z0XL3Qgg66Q=;
        b=f/sevb8nAiUVwmPKO0qf7gFxQ8+/4bIQV9KNhtuNThErOfxGjAqjnEC3JuaT7Bvs+6GnBn
        W1h4A2TYw7F3J6qa5Z2eN6I64gBHCkjWF6snavH8RtTliIu4FB8IiO6HoGGNRCrhaWL5dZ
        ur1W0CzAp5t+7JXLnI2DPoOpg9Zhrus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-iuqVta4QOeu-A_IDtj9RUw-1; Wed, 17 Feb 2021 11:32:52 -0500
X-MC-Unique: iuqVta4QOeu-A_IDtj9RUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 414BA192AB7A;
        Wed, 17 Feb 2021 16:32:51 +0000 (UTC)
Received: from localhost (unknown [10.40.194.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A537360853;
        Wed, 17 Feb 2021 16:32:50 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        bauen1 <j2468h@googlemail.com>
Subject: Re: [PATCH] policycoretuils: sestatus belongs to bin not sbin
In-Reply-To: <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
References: <65111b4f-23b9-6758-9cd6-d2f8429916fb@gmail.com>
 <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
Date:   Wed, 17 Feb 2021 17:32:49 +0100
Message-ID: <877dn6hcy6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Sat, Feb 13, 2021 at 9:44 PM bauen1 <j2468h@googlemail.com> wrote:
>>
>> It is quite useful even to non-privileged users and doesn't require any
>> privileges to work, except for maybe -v.
>>
>> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
>
> I agree with the reasoning, but changing the location of an existing
> tool has the potential to break software which depends on the precise
> location of sestatus (like
> https://github.com/openstack/cookbook-openstack-dashboard/blob/86127240974041b456086b5fff6f8f525c9cf555/spec/spec_helper.rb#L82
> and https://github.com/rapid7/metasploit-framework/blob/4a380771d3a18011af153e47e1d08a4a83feb452/lib/msf/core/post/linux/kernel.rb#L276
> and https://github.com/RedHatInsights/insights-core/blob/6fd58aeab11232a62ea97ba576220abca808c660/insights/specs/default.py#L815
> and ...).
>
> On the other hand, if you have a clear use-case of non-privileged
> users refusing to add /usr/sbin to their $PATH but willing to use
> sestatus, and that supporting this use-case seems more important than
> not breaking programs which rely on sestatus being in /usr/sbin, this
> patch will be acceptable. Do you know of such a use-case?
>
> (By the way, there is a misspelling in the patch subject: you wrote
> "policycoretuils" instead of "policycoreutils")
>

Could a symlink /usr/bin/sestatus -> ../sbin/sestatus solve this? 


> Thanks,
> Nicolas
>
>> ---
>>
>>  Only tested by running `make DESTDIR="$PWD" install` and checking that
>>  sestatus ends up at /usr/bin/sestatus
>>
>>  policycoreutils/sestatus/Makefile | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
>> index 8c4f45f8..ac113814 100644
>> --- a/policycoreutils/sestatus/Makefile
>> +++ b/policycoreutils/sestatus/Makefile
>> @@ -1,7 +1,7 @@
>>  # Installation directories.
>>  LINGUAS ?= ru
>>  PREFIX ?= /usr
>> -SBINDIR ?= $(PREFIX)/sbin
>> +BINDIR ?= $(PREFIX)/bin
>>  MANDIR = $(PREFIX)/share/man
>>  ETCDIR ?= /etc
>>
>> @@ -16,8 +16,8 @@ sestatus: sestatus.o
>>  install: all
>>         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
>>         [ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
>> -       -mkdir -p $(DESTDIR)$(SBINDIR)
>> -       install -m 755 sestatus $(DESTDIR)$(SBINDIR)
>> +       -mkdir -p $(DESTDIR)$(BINDIR)
>> +       install -m 755 sestatus $(DESTDIR)$(BINDIR)
>>         install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
>>         install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
>>         for lang in $(LINGUAS) ; do \
>> --
>> 2.30.0
>>

