Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBAEC43603
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4975E23442
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 02:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbhANCEk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:04:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729362AbhAMWbM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 17:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610576938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NWdqVI1/3MnwCCDnqdeZ9B3ZwxAB9GwImvGJjBPC0CE=;
        b=aiQeYxdNAzZCpa/v/UtGk2/tO9H0eqoGeZNy0iKHr81UVseV/nQKOMffheokHGHGFz9EgA
        h3Snd3tbkmZ4ohTZZ9TCDMCkGZPMxoQSWGpiiawayARS8KEPdUtXkQeqn/AebR0R7rKfwy
        5HIq+S3KS/ruShP+8roVPApqa4nzgB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-lBML_QNzOFKCQfl_oRpi3Q-1; Wed, 13 Jan 2021 17:28:54 -0500
X-MC-Unique: lBML_QNzOFKCQfl_oRpi3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF9D0801FC4;
        Wed, 13 Jan 2021 22:28:52 +0000 (UTC)
Received: from localhost (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1725D9C0;
        Wed, 13 Jan 2021 22:28:51 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <bill.c.roberts@gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: fix NULL pointer dereference when
 parsing an improper integer
In-Reply-To: <CAP+JOzQ_UcpR-LHaed+DAAhAL9VeCpg9aG=DEo+y4s-cwvMb5g@mail.gmail.com>
References: <20210106081319.379572-1-nicolas.iooss@m4x.org>
 <CAP+JOzQ_UcpR-LHaed+DAAhAL9VeCpg9aG=DEo+y4s-cwvMb5g@mail.gmail.com>
Date:   Wed, 13 Jan 2021 23:28:51 +0100
Message-ID: <87turka2u4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Wed, Jan 6, 2021 at 3:13 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> OSS-Fuzz found a NULL pointer dereference when the CIL compiler tries to
>> compile a policy with an invalid integer:
>>
>>     $ echo '(ioportcon(2())n)' > tmp.cil
>>     $ secilc tmp.cil
>>     Segmentation fault (core dumped)
>>
>> This is because strtol() is called with a NULL pointer, in
>> cil_fill_integer().
>>
>> Fix this by checking that int_node->data is not NULL. While at it, use
>> strtoul() instead of strtol() to parse an unsigned integer.
>>
>> When using "val > UINT32_MAX" with "unsigned long val;", it is expected
>> that some compilers emit a warning when the size of "unsigned long" is
>> 32 bits. In theory gcc could be such a compiler (with warning
>> -Wtype-limits, which is included in -Wextra). Nevertheless this is
>> currently broken, according to
>> https://gcc.gnu.org/pipermail/gcc-help/2021-January/139755.html and
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89126 (this bug was
>> opened in January 2019).
>>
>> In order to prevent this warning from appearing, introduce some
>> preprocessor macros around the bound check.
>>
>> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28456
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!


>> ---
>>  libsepol/cil/src/cil_build_ast.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
>> index be10d61b1314..02481558ad11 100644
>> --- a/libsepol/cil/src/cil_build_ast.c
>> +++ b/libsepol/cil/src/cil_build_ast.c
>> @@ -5570,19 +5570,27 @@ int cil_fill_integer(struct cil_tree_node *int_node, uint32_t *integer, int base
>>  {
>>         int rc = SEPOL_ERR;
>>         char *endptr = NULL;
>> -       int val;
>> +       unsigned long val;
>>
>> -       if (int_node == NULL || integer == NULL) {
>> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>>                 goto exit;
>>         }
>>
>>         errno = 0;
>> -       val = strtol(int_node->data, &endptr, base);
>> +       val = strtoul(int_node->data, &endptr, base);
>>         if (errno != 0 || endptr == int_node->data || *endptr != '\0') {
>>                 rc = SEPOL_ERR;
>>                 goto exit;
>>         }
>>
>> +       /* Ensure that the value fits a 32-bit integer without triggering -Wtype-limits */
>> +#if ULONG_MAX > UINT32_MAX
>> +       if (val > UINT32_MAX) {
>> +               rc = SEPOL_ERR;
>> +               goto exit;
>> +       }
>> +#endif
>> +
>>         *integer = val;
>>
>>         return SEPOL_OK;
>> @@ -5598,7 +5606,7 @@ int cil_fill_integer64(struct cil_tree_node *int_node, uint64_t *integer, int ba
>>         char *endptr = NULL;
>>         uint64_t val;
>>
>> -       if (int_node == NULL || integer == NULL) {
>> +       if (int_node == NULL || int_node->data == NULL || integer == NULL) {
>>                 goto exit;
>>         }
>>
>> --
>> 2.30.0
>>

