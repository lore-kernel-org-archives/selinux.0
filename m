Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B01C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 10:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A62460EE3
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 10:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbhJFKaA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229824AbhJFKaA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Oct 2021 06:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633516088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dw68RAthxeR61QXg2RT/7M9DIQqRYnp+iOPJRbcbBs=;
        b=eIsfhBjdGS0TgaAKIOcDoxbYpJ6zDGMMTx5U/zX4LZ/W7Fhe7o1dukpOFKD+v4dftU5wyS
        sbLCATQrQ0PA2Me4z6ANgiNoGjsqnO++yMPTibOr1pp9eUucixLpEKfPAaHKsI9kZw53ij
        1Acw3PzxDMZYM+Dqe3dVbV+Hi5uwClE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-VxQ8Xi6_PeWmGG3qM7bUWg-1; Wed, 06 Oct 2021 06:28:06 -0400
X-MC-Unique: VxQ8Xi6_PeWmGG3qM7bUWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2E78015C7;
        Wed,  6 Oct 2021 10:28:05 +0000 (UTC)
Received: from localhost (unknown [10.40.192.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C75E5F4E7;
        Wed,  6 Oct 2021 10:28:05 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] libsepol/cil: Limit the amount of reporting for bounds
 failures
In-Reply-To: <CAJfZ7=kLPLT=jsqL7rMFEP=+LW6jHX_5icxjFp9u9j5h0qyDpg@mail.gmail.com>
References: <20210928175521.79432-1-jwcart2@gmail.com>
 <CAJfZ7=kLPLT=jsqL7rMFEP=+LW6jHX_5icxjFp9u9j5h0qyDpg@mail.gmail.com>
Date:   Wed, 06 Oct 2021 12:28:04 +0200
Message-ID: <87tuhuzbuz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Tue, Sep 28, 2021 at 7:55 PM James Carter <jwcart2@gmail.com> wrote:
>>
>> Type bounds are checked when creating the CIL binary using libsepol
>> functions on the binary policy db. The bad rule is reported and, to
>> provide better error reporting, a search is made for matching rules
>> in the CIL policy. These matching rules as well as their parents are
>> written out with their locations to make it easier to find the rules
>> that violate the type bounds.
>>
>> It is possible to craft CIL policies where there are many rules
>> that violate a bounds check each with many matching rules as well.
>> This can make the error messages very difficult to deal with. For
>> example, if there are 100 rules in the binary policy db that violate
>> a type bounds and each of these rules has 100 matches, then 10,000
>> matching rules along with their parents will be written out as part
>> of the error message.
>>
>> Limit the error reporting to two rules for each type bounds violation
>> along with two matches for each of those rules.
>>
>> This problem was found with the secilc-fuzzer.
>>
>> Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Hello,
> I confirm this fixes the issue reported in
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36246&q=selinux&can=2
> which can be reproduced with this CIL policy:
>
> (class CLASS (PERM))
> (classorder (CLASS))
> (sid SID)
> (sidorder (SID))
> (user USER)
> (role ROLE)
> (type TYPE)
> (category CAT)
> (categoryorder (CAT))
> (sensitivity SENS)
> (sensitivityorder (SENS))
> (sensitivitycategory SENS (CAT))
> (allow TYPE self (CLASS (PERM)))
> (roletype ROLE TYPE)
> (userrole USER ROLE)
> (userlevel USER (SENS))
> (userrange USER ((SENS)(SENS (CAT))))
> (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
> (boolean BOOL false)
> (type TYPE_2)
> (typeattribute TYPEATTR)
> (block B0
> (blockinherit B1)(block B1
> (blockinherit B2)(block B2
> (blockinherit B3)(block B3
> (blockinherit B4)(block B4
> (blockinherit B5)(block B5
> (blockinherit B6)(block B6
> (blockinherit B7)(block B7
> (type TYPE_3)
> (typebounds TYPE_2 TYPE_3)
> (typeattributeset TYPEATTR TYPE_3)
> (booleanif BOOL(true(allow TYPEATTR TYPE (CLASS (PERM)))))
> ))))))))
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

It's merged now. Thanks!


> By the way, even though the patch looks good to me, my personal
> preference would have been to use "unsigned int" types (or size_t) to
> count rules, instead of signed int.
>
> Thanks,
> Nicolas
>
>> ---
>>  libsepol/cil/src/cil_binary.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>> index 4a80cb56..ec5f01e5 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -4825,6 +4825,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>>                         avtab_ptr_t cur;
>>                         struct cil_avrule target;
>>                         struct cil_tree_node *n1 = NULL;
>> +                       int count_bad = 0;
>>
>>                         *violation = CIL_TRUE;
>>
>> @@ -4838,6 +4839,8 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>>                         for (cur = bad; cur; cur = cur->next) {
>>                                 struct cil_list_item *i2;
>>                                 struct cil_list *matching;
>> +                               int num_matching = 0;
>> +                               int count_matching = 0;
>>
>>                                 rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
>>                                 if (rc != SEPOL_OK) {
>> @@ -4855,6 +4858,9 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>>                                         bounds_destroy_bad(bad);
>>                                         goto exit;
>>                                 }
>> +                               cil_list_for_each(i2, matching) {
>> +                                       num_matching++;
>> +                               }
>>                                 cil_list_for_each(i2, matching) {
>>                                         struct cil_tree_node *n2 = i2->data;
>>                                         struct cil_avrule *r2 = n2->data;
>> @@ -4865,9 +4871,19 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
>>                                                 __cil_print_parents("    ", n2);
>>                                                 __cil_print_rule("      ", "allow", r2);
>>                                         }
>> +                                       count_matching++;
>> +                                       if (count_matching >= 2) {
>> +                                               cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
>> +                                               break;
>> +                                       }
>>                                 }
>>                                 cil_list_destroy(&matching, CIL_FALSE);
>>                                 cil_list_destroy(&target.perms.classperms, CIL_TRUE);
>> +                               count_bad++;
>> +                               if (count_bad >= 2) {
>> +                                       cil_log(CIL_ERR, "  Only first 2 of %d bad rules shown\n", numbad);
>> +                                       break;
>> +                               }
>>                         }
>>                         bounds_destroy_bad(bad);
>>                 }
>> --
>> 2.31.1
>>

