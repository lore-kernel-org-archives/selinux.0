Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57E1C433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 10:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E3F61052
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 10:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbhJFKio (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237836AbhJFKio (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Oct 2021 06:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633516611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dk41ruJMzVXpNyXqpRp8sC4ixornknFWlLYzNaawnhE=;
        b=GuCwrtKPB/Y4+bWmXawpG2U4JhHihPIb5xxvU45Mj8DpacfxpGTlKkGGvmF/TNhp6ncgn8
        ZsLV4Z8wk9RlavrvGq1zxOuyi57czHMSI2kzUagVH8goPiQ5qJeKbkfA+Y9fX+EflKQjkx
        ls6aXJTXcQF6OoKzc13++oLd7D0krmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-CNFCkFk5NyK1RFMHlQLR8g-1; Wed, 06 Oct 2021 06:36:48 -0400
X-MC-Unique: CNFCkFk5NyK1RFMHlQLR8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DD91006AA2;
        Wed,  6 Oct 2021 10:36:47 +0000 (UTC)
Received: from localhost (unknown [10.40.192.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56C805D9C6;
        Wed,  6 Oct 2021 10:36:47 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] libsepol/cil: Do not skip macros when resolving until
 later passes
In-Reply-To: <CAJfZ7=mKjv_MYAqWmUFMCD8aDJgsnXzj1YmyuDPhfta87RTjRQ@mail.gmail.com>
References: <20210929202454.136401-1-jwcart2@gmail.com>
 <CAJfZ7=mKjv_MYAqWmUFMCD8aDJgsnXzj1YmyuDPhfta87RTjRQ@mail.gmail.com>
Date:   Wed, 06 Oct 2021 12:36:46 +0200
Message-ID: <87r1cyzbgh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Wed, Sep 29, 2021 at 10:25 PM James Carter <jwcart2@gmail.com> wrote:
>>
>> Since only tunableifs need to be resolved in a macro before the macro
>> is copied for each call, macros were being skipped after resolving
>> tunableifs. Statments not allowed to be in macros would be found during
>> the pass that resolved tunableifs. Unfortunately, in-statments are
>> resolved after tunableifs and they can be used to add statements to
>> macros that are not allowed.
>>
>> Instead, do not skip macros until after the pass that resolves in-
>> statements that are to be resolved after block inheritance. This
>> allows blocks, blockinherits, blockabstracts, and macros that were
>> added by an in-statement to be found and an error reported.
>>
>> This bug was found by the secilc-fuzzer.
>>
>> Signed-off-by: James Carter <jwcart2@gmail.com>
>
> I confirm this fixes the issue reported in
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36466&q=selinux&can=2
> which can be reproduced by the following policy:
>
> (macro MACRO ())
> (in MACRO (blockinherit BLOCK)) (call MACRO)
> (in MACRO (blockinherit BLOCK)) (call MACRO)
> (in MACRO (blockinherit BLOCK)) (call MACRO)
> (in MACRO (blockinherit BLOCK)) (call MACRO)
> (in MACRO (blockinherit BLOCK)) (call MACRO)
> (in MACRO (blockinherit BLOCK)) (call MACRO)
> ...
> repeated at least 4000 times
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged. Thanks!



>> ---
>>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
>> index 2cf94368..e97a9f46 100644
>> --- a/libsepol/cil/src/cil_resolve_ast.c
>> +++ b/libsepol/cil/src/cil_resolve_ast.c
>> @@ -3946,7 +3946,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
>>         }
>>
>>         if (node->flavor == CIL_MACRO) {
>> -               if (pass != CIL_PASS_TIF) {
>> +               if (pass > CIL_PASS_IN_AFTER) {
>>                         *finished = CIL_TREE_SKIP_HEAD;
>>                         rc = SEPOL_OK;
>>                         goto exit;
>> --
>> 2.31.1
>>

