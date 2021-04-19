Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD29C433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 16:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A693861077
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 16:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhDSQUk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 12:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233071AbhDSQUh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 12:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618849207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUvCmNt3PVDuOVhb8oF2SNUHoUuzkd8wP1IAmDRC7GA=;
        b=Uv7YYSKU7hIBt1wlelJXZzbWwyDhTaz/AyJoyJCRfo8jhZVBiusHtGROSMvdOgLRRv0mNq
        cMp08LPIH6mxG8EqRKiWHRzNrc5AKWA4Q64R2Gy9pIPmoJXYzabmv5lymjFUNTcFfejDgB
        e1ctcKgDbSritCKH6nwWrhTbVSktQNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-X5E6jdGEOuav6GI1VixchQ-1; Mon, 19 Apr 2021 12:20:05 -0400
X-MC-Unique: X5E6jdGEOuav6GI1VixchQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E2925B39A;
        Mon, 19 Apr 2021 16:20:04 +0000 (UTC)
Received: from localhost (unknown [10.40.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C441C19726;
        Mon, 19 Apr 2021 16:20:03 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH 00/11] Various CIL patches
In-Reply-To: <CAP+JOzQo6qA9cd8a_KgDTLF3m0qip=WZaH482fG74BD6imQCCA@mail.gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
 <CAP+JOzQo6qA9cd8a_KgDTLF3m0qip=WZaH482fG74BD6imQCCA@mail.gmail.com>
Date:   Mon, 19 Apr 2021 18:20:02 +0200
Message-ID: <87lf9e9rgt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Thu, Apr 8, 2021 at 3:16 PM James Carter <jwcart2@gmail.com> wrote:
>>
>> All of these patches (except the first) have been sent to the list in the
>> last month. The first patch is a slight modification of an earlier patch
>> sent by Nicolas Iooss. I also corrected a couple of whitespace errors and
>> updated one patch that would not apply cleanly with one of the earlier
>> patches applied.
>>
>> James Carter (11):
>>   libsepol/cil: Fix out-of-bound read of file context pattern ending
>>     with "\"
>>   libsepol/cil: Destroy classperms list when resetting classpermission
>>   libsepol/cil: Destroy classperm list when resetting map perms
>>   libsepol/cil: cil_reset_classperms_set() should not reset
>>     classpermission
>>   libsepol/cil: Set class field to NULL when resetting struct
>>     cil_classperms
>>   libsepol/cil: More strict verification of constraint leaf expressions
>>   libsepol/cil: Exit with an error if declaration name is a reserved
>>     word
>>   libsepol/cil: Allow permission expressions when using map classes
>>   libsepol/cil: Refactor helper function for cil_gen_node()
>>   libsepol/cil: Create function cil_add_decl_to_symtab() and refactor
>>   libsepol/cil: Move check for the shadowing of macro parameters
>>
>>  libsepol/cil/src/cil_build_ast.c | 132 ++++++++++++-------------------
>>  libsepol/cil/src/cil_build_ast.h |   2 +
>>  libsepol/cil/src/cil_copy_ast.c  |  26 +++---
>>  libsepol/cil/src/cil_post.c      |  11 +++
>>  libsepol/cil/src/cil_reset_ast.c |  11 ++-
>>  libsepol/cil/src/cil_verify.c    |  78 +++++++++++++++++-
>>  libsepol/cil/src/cil_verify.h    |   3 +-
>>  7 files changed, 160 insertions(+), 103 deletions(-)
>>
>> --
>> 2.26.3
>>
>
> Most of these patches were sent out almost a month ago. I am planning
> on merging them next week.
> Jim

I didn't check the content of the changes, but I ran a regression test
suite we use in Red Hat on this and "Update checks for invalid rules in
blocks" patchsets and it didn't discover any problem (just a minor
trailing whitespace I reported last week)

Acked-by: Petr Lautrbach <plautrba@redhat.com>

I believe you can merge it/

Thanks!


Petr

