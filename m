Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E5CC433E6
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C84464F7E
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 12:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhBCMIw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 07:08:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234415AbhBCMIv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 07:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612354043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LjKU429qKoYydMpqlmptcp2Jb2hexIsgpLdWySyfW08=;
        b=Oa1E/ZjGLs68mBPPBOjgunMkML7yFm+yuMRkbsskbvlAT2TOfgqPAaQ30aDxAnN9FIKS0I
        KRdkpyjMJQY8Y4HkbCDBI3HkA1oMIMnmQCYGxZ/gmSEe/5uWWPAPSRceFoavyCReVDeH4Q
        Hyt14qd2s3F4IMIAaT4H+fbn2CZunWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-JYjUm-ypPEeu-xDHMOoQ6Q-1; Wed, 03 Feb 2021 07:07:20 -0500
X-MC-Unique: JYjUm-ypPEeu-xDHMOoQ6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FF83CC636;
        Wed,  3 Feb 2021 12:07:18 +0000 (UTC)
Received: from localhost (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABBC45D9E3;
        Wed,  3 Feb 2021 12:07:17 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH V2] libsepol/cil: Fix heap-use-after-free when using
 optional blockinherit
In-Reply-To: <CAJfZ7=nOmd6roSTLupt44VpiseEViHQKFi-eWZNhT3tzRefLbw@mail.gmail.com>
References: <20210202205417.120630-1-jwcart2@gmail.com>
 <CAJfZ7=nOmd6roSTLupt44VpiseEViHQKFi-eWZNhT3tzRefLbw@mail.gmail.com>
Date:   Wed, 03 Feb 2021 13:07:16 +0100
Message-ID: <87im79mk23.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Tue, Feb 2, 2021 at 9:54 PM James Carter <jwcart2@gmail.com> wrote:
>>
>> This is based on a patch by Nicolas Iooss. He writes:
>>     When secilc compiles the following policy:
>>
>>         (block b1
>>             (optional o1
>>                 (blockinherit b1)
>>                 (blockinherit x)
>>             )
>>         )
>>
>>     it disables the optional block at pass 3 (CIL_PASS_BLKIN_LINK)
>>     because the block "x" does not exist.
>>     __cil_resolve_ast_last_child_helper() calls
>>     cil_tree_children_destroy() on the optional block, which destroys
>>     the two blockinherit statements. But the (blockinherit b1) node
>>     was referenced inside (block b1) node, in its block->bi_nodes list.
>>     Therefore, when this list is used at pass 4 (CIL_PASS_BLKIN_COPY),
>>     it contains a node which was freed: this triggers a use-after-free
>>     issue
>>
>>     Fix this issue by removing blockinherit nodes from their lists of
>>     nodes block->bi_nodes when they are being destroyed. As
>>     cil_destroy_blockinherit() does not have a reference to the node
>>     containing the blockinherit data, implement this new logic in
>>     cil_tree_node_destroy().
>>
>>     This issue was found while investigating a testcase from an OSS-Fuzz
>>     issue which seems unrelated (a Null-dereference READ in
>>     cil_symtab_get_datum,
>>     https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29861).
>>
>> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> Signed-off-by: James Carter <jwcart2@gmail.com>
>
> I tested the patch and confirm it fixes the issue.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged and released in 3.2-rc2

Thanks!


>> ---
>>  libsepol/cil/src/cil_build_ast.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
>> index 02481558..ab0efd53 100644
>> --- a/libsepol/cil/src/cil_build_ast.c
>> +++ b/libsepol/cil/src/cil_build_ast.c
>> @@ -283,6 +283,19 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
>>                 return;
>>         }
>>
>> +       if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
>> +               struct cil_tree_node *node;
>> +               struct cil_list_item *item;
>> +
>> +               cil_list_for_each(item, inherit->block->bi_nodes) {
>> +                       node = item->data;
>> +                       if (node->data == inherit) {
>> +                               cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +
>>         free(inherit);
>>  }
>>
>> --
>> 2.26.2
>>

