Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2C9C433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B0464E46
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhBCIhO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232644AbhBCIhO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612341348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdCXAWxYdwhtJDROJS/ZAw21ZEnBBTkJjtt0VroDlTk=;
        b=JQsX8aRZmk5m8hkynU11yzfXRxKx0hqHM3XneC1EreqtFq5kkFQPc03oQZRfKJ8HXHzDuy
        Pc3TyZW3NhC8MuI6mdQ9vr1812256JAIwu2mpSIDAS11mM/Kr3BCD/GYCCTqIJ7krXCXrA
        wlO68ec/aeBkuXjRxa2ojiM1j8nGS14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-N1i2tsTyPnWtA55qadwsQg-1; Wed, 03 Feb 2021 03:35:46 -0500
X-MC-Unique: N1i2tsTyPnWtA55qadwsQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E709D107ACF8;
        Wed,  3 Feb 2021 08:35:44 +0000 (UTC)
Received: from localhost (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80D9A1001281;
        Wed,  3 Feb 2021 08:35:44 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/1] libsepol/cil: unlink blockinherit->block link when
 destroying a block
In-Reply-To: <CAP+JOzROBnb0fRSFM3NVHbqxSk5n7tmvx6pqc7FgzPj0qadFFQ@mail.gmail.com>
References: <20210201221758.13349-1-nicolas.iooss@m4x.org>
 <CAP+JOzROBnb0fRSFM3NVHbqxSk5n7tmvx6pqc7FgzPj0qadFFQ@mail.gmail.com>
Date:   Wed, 03 Feb 2021 09:35:43 +0100
Message-ID: <87v9b9mtuo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Mon, Feb 1, 2021 at 5:20 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> The following CIL policy triggers a heap use-after-free in secilc
>> because when the blockinherit node is destroyed, the block node was
>> already destroyed:
>>
>>     (block b2a)
>>     (blockinherit b2a)
>>
>> Fix this by setting blockinherit->block to NULL when destroying block.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!


>> ---
>>  libsepol/cil/src/cil_build_ast.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
>> index 02481558ad11..c6edcde6bc5d 100644
>> --- a/libsepol/cil/src/cil_build_ast.c
>> +++ b/libsepol/cil/src/cil_build_ast.c
>> @@ -231,13 +231,30 @@ exit:
>>
>>  void cil_destroy_block(struct cil_block *block)
>>  {
>> +       struct cil_list_item *item;
>> +       struct cil_tree_node *bi_node;
>> +       struct cil_blockinherit *inherit;
>> +
>>         if (block == NULL) {
>>                 return;
>>         }
>>
>>         cil_symtab_datum_destroy(&block->datum);
>>         cil_symtab_array_destroy(block->symtab);
>> -       cil_list_destroy(&block->bi_nodes, CIL_FALSE);
>> +       if (block->bi_nodes != NULL) {
>> +               /* unlink blockinherit->block */
>> +               cil_list_for_each(item, block->bi_nodes) {
>> +                       bi_node = item->data;
>> +                       /* the conditions should always be true, but better be sure */
>> +                       if (bi_node->flavor == CIL_BLOCKINHERIT) {
>> +                               inherit = bi_node->data;
>> +                               if (inherit->block == block) {
>> +                                       inherit->block = NULL;
>> +                               }
>> +                       }
>> +               }
>> +               cil_list_destroy(&block->bi_nodes, CIL_FALSE);
>> +       }
>>
>>         free(block);
>>  }
>> --
>> 2.30.0
>>

