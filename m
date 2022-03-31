Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D38C433EF
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 11:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiCaLnB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiCaLmy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 07:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A9E9154712
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648726866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9cuaP0CBNYKYptXS1NwoGCd0+90Cz1s+q1Ojzcw2nw=;
        b=hU6uOfU+Rp+oZCIQQ/xkA3n1HzE2WIg0wK0x7PAf7evLmR915UmJ4FSUpf9wxFpYJUvwzt
        hhx/7R+V3k35kPvGvR0SEWOLOITlw9SA+AYdauohdN4hrPBz03kVF87QdUjIwh4tfwdQeB
        kP/G3EJrrkP0TWElE0primUsutACGos=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-XL2c00WVOWmhDXjgQE50dg-1; Thu, 31 Mar 2022 07:41:03 -0400
X-MC-Unique: XL2c00WVOWmhDXjgQE50dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE27228035F9;
        Thu, 31 Mar 2022 11:41:02 +0000 (UTC)
Received: from localhost (unknown [10.40.195.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67E26400E42D;
        Thu, 31 Mar 2022 11:41:02 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: Lets start with 3.4 userspace release
In-Reply-To: <CAP+JOzTnOW9A7iyDeysC6pNcZA9sAqJxP1UhMYJx3-Umk6R3Ag@mail.gmail.com>
References: <87pmm43dfc.fsf@redhat.com>
 <CAP+JOzTnOW9A7iyDeysC6pNcZA9sAqJxP1UhMYJx3-Umk6R3Ag@mail.gmail.com>
Date:   Thu, 31 Mar 2022 13:41:01 +0200
Message-ID: <87o81mbb8y.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Mar 29, 2022 at 3:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Hello,
>>
>> after 142 commits and 5 months since last SELinux userspace release,
>> it's time to think about another release.
>>
>> The current backlog of patches is bellow. Please take a look.
>>
>> This time, I'd like to release rcX every 14 days -
>> rc1 - 04-06-2022
>> rc2 - 04-20-2022
>> ...
>>
>> I'll try send patches with the release number change on Mondays before every
>> release.
>>
>>
>> Also when rc1 is out, please consider postponing non-bugfix patches
>> after the release or provide a comment that the change is not necessary
>> for this release.
>>
>>
>>
>> * https://patchwork.kernel.org/patch/12617693/ New [v2] Support static-only builds
>>
>> - v2 of https://lore.kernel.org/selinux/87lf1scgd6.fsf@alyssa.is/
>> - waits for another review
>>
>> * https://patchwork.kernel.org/patch/12639767/ New libsepol: free ebitmap on end of function
>>
> This is part of the notself patches which will not be ready for this release.
>
>> * https://patchwork.kernel.org/project/selinux/list/?series=590259 add not-self neverallow support
>>
> Still working, but not for this release.
>
>> * https://patchwork.kernel.org/patch/12672523/ New [v2] secilc: kernel policy language is infix
>>
> This one fell off my radar. I can ack and merge it.
>
>> * https://patchwork.kernel.org/project/selinux/list/?series=604679  libsepol: Adding support for not-self rules
>>
> Still working, but not for this release.
>
>> * https://patchwork.kernel.org/patch/12718352/ New [libselinux] libselinux: make threadsafe for discover_class_cache
>>
>> * https://patchwork.kernel.org/patch/12726783/ New libselinux: Prevent cached context giving wrong results
>>
>> * https://patchwork.kernel.org/project/selinux/list/?series=616731 libsepol: add sepol_av_perm_to_string |
>>
>> """
>> Since most of these functions are used in either checkpolicy or
>> audit2why (or both), it is probably fine to export these, but I would
>> appreciate any thoughts that Chris and others might have.
>> """
>>
> I need to think about this one.
>
>> * https://patchwork.kernel.org/patch/12775701/ New libsepol/cil: Write a message when a log message is truncated
>>
> I will merge this.
>
>> * https://patchwork.kernel.org/patch/12780657/ New libsepol: Use calloc when initializing bool_val_to_struct array
>>
> I will merge this.
>
>> * https://patchwork.kernel.org/patch/12783189/ New libsepol: Validate conditional expressions
>>
> I will merge this.
>
>> * https://patchwork.kernel.org/patch/12790631/ New [v3] libsemanage: Fall back to semanage_copy_dir when rename() fails
>>
> I don't know if Ondrej was planning on ack'ing it, but it seems like
> he is satisfied.
>

Thank You!


>
>>
>>
>> Petr
>>

