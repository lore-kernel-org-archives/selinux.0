Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FDEC433E0
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF8E22BEA
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403956AbhARPCo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:02:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26690 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393233AbhARPBL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jan 2021 10:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610981984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+S6HHaGn/cXNmRDhiDAqS9N+dvaiSUrimY19mybyoQ=;
        b=LuSQ5nVcKpZ6hhTdgjfsQbclbaww5gzzEs1M+fx2kSL8rOsEEEtbkBogHJJLpIdgCZd0fW
        68PsrCD+4JL7TJGPnFBS+fLOTDAcGt9mhaoE9S4zEv1lBvMCw838W6n9MKG9bqNCDtt/wL
        rRB7H2eESlURQ2Ncpaa6doovGQ6I3uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-9s349rE5Pxq71WUf8mdP2A-1; Mon, 18 Jan 2021 09:59:41 -0500
X-MC-Unique: 9s349rE5Pxq71WUf8mdP2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC627802B40
        for <selinux@vger.kernel.org>; Mon, 18 Jan 2021 14:59:40 +0000 (UTC)
Received: from localhost (unknown [10.40.193.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 406B360C75
        for <selinux@vger.kernel.org>; Mon, 18 Jan 2021 14:59:40 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: Intent to release 3.2-rc1
In-Reply-To: <87h7nka15c.fsf@redhat.com>
References: <87ft3fhdju.fsf@redhat.com> <87h7nka15c.fsf@redhat.com>
Date:   Mon, 18 Jan 2021 15:59:39 +0100
Message-ID: <874kjeffz8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Petr Lautrbach <plautrba@redhat.com> writes:
>
>> Hello,
>>
>> It's more than half a year since 3.1-rc1 and more than a year since
>> 3.0-rc1 so I'd like to start with 3.2 release process. If there's no
>> objection  and no unexpected issues I'd announce 3.2-rc1 release on the
>> next Wednesday, January 13.
>>
>> According to patchwork there are several patches not accepted:
>>
>> https://patchwork.kernel.org/patch/11436955/ New [RFC] libsepol,secilc,policycoreutils: add unprivileged sandboxing capability
>>
>> without any reaction for a long time
>>
>>
>> https://patchwork.kernel.org/patch/11668455/ New selinux: make use of variables when defining libdir and includedir
>>
>> Nicolas raised some concerns and asked for a reproducer, without any
>> other response.
>>
>>
>> https://patchwork.kernel.org/patch/11993081/ New [1/6] libsepol: do not decode out-of-bound rolebounds
>> https://patchwork.kernel.org/patch/11993085/ New [2/6] libsepol: ensure that hashtab_search is not called with a NULL key
>>
>> I read it as there are some changes requested and therefore need to be updated.
>>
>>
>> https://patchwork.kernel.org/patch/11993087/ New [3/6] libsepol/cil: constify some strings
>> https://patchwork.kernel.org/patch/11993089/ New [4/6] libsepol/cil: fix NULL pointer dereference when parsing an improper integer
>> https://patchwork.kernel.org/patch/11993083/ New [5/6] libsepol/cil: fix out-of-bound read in cil_print_recursive_blockinherit
>> https://patchwork.kernel.org/patch/11993091/ New [6/6] libsepol/cil: destroy perm_datums when __cil_resolve_perms fails
>>
>> Ack-ed, probably could be merged.
>>
>>
>> https://patchwork.kernel.org/patch/11940309
>> https://github.com/SELinuxProject/selinux/pull/273
>>
>> The patch on the mailing list is not up to date with the PR and needs to
>> be resent.
>>
>>
>
> The current situation:
>
> https://patchwork.kernel.org/patch/11993081/ New [1/6] libsepol: do not decode out-of-bound rolebounds
> https://patchwork.kernel.org/patch/12001639/ New newrole: preserve environment variable XDG_RUNTIME_DIR
> https://patchwork.kernel.org/patch/12002081/ New [1/2] libsepol/cil: Update symtab nprim field when adding or removing datums
> https://patchwork.kernel.org/patch/12002083/ New [2/2] libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
> https://patchwork.kernel.org/patch/12006921/ New [1/2] libselinux: accept const fromcon in get_context API
> https://patchwork.kernel.org/patch/12006923/ New [2/2] libselinux: update getseuser
> https://patchwork.kernel.org/patch/12011663/ New python/sepolgen: allow any policy statement in ifndef
> https://patchwork.kernel.org/patch/12017871/ New [v2,1/2] setfiles: Do not abort on labeling error
>
> I'd like to defer rc1 for few days due to the lack of time and number
> of unmerged patches.
>
> Sorry for the inconveniences.

Lets do -rc1 on this wednesday and in case not all open changes are
reviewed merge them to 3.2-rc2


Release notes draft is available at
https://plautrba.fedorapeople.org/selinux/20210118/RELEASE-3.2-rc1.txt

Please review and tell me whether you're missing something.


Petr

