Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D043FC433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8025364E60
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 15:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBSPub (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:50:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhBSPu0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 10:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613749738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tPG1UITjAzt4LSUIfi/ZUAbnt5EfObNxxsCJrKOLN4=;
        b=gGhjURM4WGqbijX2erNK1QfQMqjR3jQPcpHnUAcky/oOMsWLfb4EzLMOI3z+87vJqd2A8V
        ccJDlOjVUfm+mX/zcRZ1WdHgBlegJdZsFoEkuE1llLih28T9KWTenz3qlVylU1Fs94FZG0
        mmrTxDvdBWNEi6wkHWQvKG2rWgo+3mI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-QIfrOd_yPN2NkGvXU1QfNA-1; Fri, 19 Feb 2021 10:48:56 -0500
X-MC-Unique: QIfrOd_yPN2NkGvXU1QfNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A423107ACE6;
        Fri, 19 Feb 2021 15:48:55 +0000 (UTC)
Received: from localhost (unknown [10.40.194.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D45060BE5;
        Fri, 19 Feb 2021 15:48:54 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH 0/2] libsepol: Validate policydb values when reading binary
In-Reply-To: <CAJfZ7=kqX0xrHWkCcWMjB7m7VOFiScdcSff+ZWBDHNxy_iGMuw@mail.gmail.com>
References: <20210205140800.275993-1-jwcart2@gmail.com>
 <CAJfZ7=kqX0xrHWkCcWMjB7m7VOFiScdcSff+ZWBDHNxy_iGMuw@mail.gmail.com>
Date:   Fri, 19 Feb 2021 16:48:53 +0100
Message-ID: <87a6s0oy6y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Fri, Feb 5, 2021 at 3:08 PM James Carter <jwcart2@gmail.com> wrote:
>>
>> Nicolas Iooss reports that fuzzing /usr/libexec/hll/pp with the
>> American Fuzzy Lop revealed that inconsistent policy modules could be
>> created that caused NULL dereferences and other problems.
>>
>> This patch validates the policydb when reading in the binary policy. See
>> the description of the second patch for more details.
>>
>> The validation requires a negligible amount of time to complete.
>>
>> James Carter (2):
>>   libsepol: Create function ebitmap_highest_set_bit()
>>   libsepol: Validate policydb values when reading binary policy
>>
>>  libsepol/include/sepol/policydb/ebitmap.h |   1 +
>>  libsepol/src/ebitmap.c                    |  20 +
>>  libsepol/src/policydb.c                   |  35 +-
>>  libsepol/src/policydb_validate.c          | 764 ++++++++++++++++++++++
>>  libsepol/src/policydb_validate.h          |   7 +
>>  5 files changed, 815 insertions(+), 12 deletions(-)
>>  create mode 100644 libsepol/src/policydb_validate.c
>>  create mode 100644 libsepol/src/policydb_validate.h
>>
>> --
>> 2.26.2
>>
>
> Hello,
> Thanks for these patches! I tested them and the fuzzer I am using
> (which consists in running AFL on "pp") no longer crashed :) So I
> confirm they fixed the issues I was experiencing, and the code looks
> good.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Nicolas

Merged using --whitespace=fix
Thanks!

^&^ git am --whitespace=fix 2-2-libsepol-Validate-policydb-values-when-reading-binary-policy.patch                                                      
Applying: libsepol: Validate policydb values when reading binary policy
.git/rebase-apply/patch:331: trailing whitespace.
        return -1;
.git/rebase-apply/patch:590: trailing whitespace.
        return 0;
.git/rebase-apply/patch:747: trailing whitespace.
        return -1;
.git/rebase-apply/patch:763: trailing whitespace.
        return -1;
.git/rebase-apply/patch:886: trailing whitespace.
        return -1;

