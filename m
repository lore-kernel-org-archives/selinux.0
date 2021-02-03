Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A609C433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2902964F67
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbhBCIfD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232590AbhBCIe7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612341213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZvlUMl0vxvTCKB5xx/4oRJUCwGdc7f+VGtXjGfPMxlE=;
        b=gnP7y525TdYazg1LokanRGfBgojoRF7LusaU36d8/npW03S1Su4KAnvWoNJcC0oYcrVYiC
        FQ6qVKCpI4jZcQYb1D/q1LxbAXztT5kW5d+/5cd/tbS4BjkGDJVKxr7kR8+unxUZuu5HK9
        /RkKqHrGVAOTBiu96FmB5IYO/KqbuKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-EC9vFVofP6SYYh8waHHvSA-1; Wed, 03 Feb 2021 03:33:30 -0500
X-MC-Unique: EC9vFVofP6SYYh8waHHvSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA9411800D50;
        Wed,  3 Feb 2021 08:33:29 +0000 (UTC)
Received: from localhost (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E84160C6B;
        Wed,  3 Feb 2021 08:33:29 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] libsepol/cil: fix memory leak when a constraint
 expression is too deep
In-Reply-To: <CAP+JOzTXhkddEpQE4TuEFFid_Pfu-FEfHcrFiHYsTbxRxg11NA@mail.gmail.com>
References: <20210131231255.58909-1-nicolas.iooss@m4x.org>
 <CAP+JOzTXhkddEpQE4TuEFFid_Pfu-FEfHcrFiHYsTbxRxg11NA@mail.gmail.com>
Date:   Wed, 03 Feb 2021 09:33:28 +0100
Message-ID: <8735ydo8iv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Sun, Jan 31, 2021 at 6:14 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>>
>> When __cil_validate_constrain_expr() fails,
>> cil_constrain_to_policydb_helper() does not destroy the constraint
>> expression. This leads to a memory leak reported by OSS-Fuzz with the
>> following CIL policy:
>>
>>     (class CLASS (PERM))
>>     (classorder (CLASS))
>>     (sid SID)
>>     (sidorder (SID))
>>     (user USER)
>>     (role ROLE)
>>     (type TYPE)
>>     (category CAT)
>>     (categoryorder (CAT))
>>     (sensitivity SENS)
>>     (sensitivityorder (SENS))
>>     (sensitivitycategory SENS (CAT))
>>     (allow TYPE self (CLASS (PERM)))
>>     (roletype ROLE TYPE)
>>     (userrole USER ROLE)
>>     (userlevel USER (SENS))
>>     (userrange USER ((SENS)(SENS (CAT))))
>>     (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>>
>>     (constrain
>>         (CLASS (PERM))
>>         (or
>>             (eq t1 TYPE)
>>             (or
>>                 (eq t1 TYPE)
>>                 (or
>>                     (eq t1 TYPE)
>>                     (or
>>                         (eq t1 TYPE)
>>                         (or
>>                             (eq t1 TYPE)
>>                             (eq t1 TYPE)
>>                         )
>>                     )
>>                 )
>>             )
>>         )
>>     )
>>
>> Add constraint_expr_destroy(sepol_expr) to destroy the expression.
>>
>> Moreover constraint_expr_destroy() was not freeing all items of an
>> expression. Code in libsepol/src and checkpolicy contained while loop to
>> free all the items of a constraint expression, but not the one in
>> libsepol/cil. As freeing only the first item of an expression is
>> misleading, change the semantic of constraint_expr_destroy() to iterate
>> the list of constraint_expr_t and to free all items.
>>
>> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28938
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Looks good.
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!

>
>> ---
>>  checkpolicy/policy_define.c   |  7 +------
>>  libsepol/cil/src/cil_binary.c |  1 +
>>  libsepol/src/constraint.c     |  6 +++++-
>>  libsepol/src/policydb.c       | 15 ++-------------
>>  4 files changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
>> index bf6c3e68bef3..c9286f7733c5 100644
>> --- a/checkpolicy/policy_define.c
>> +++ b/checkpolicy/policy_define.c
>> @@ -3479,12 +3479,7 @@ static constraint_expr_t *constraint_expr_clone(constraint_expr_t * expr)
>>
>>         return h;
>>        oom:
>> -       e = h;
>> -       while (e) {
>> -               l = e;
>> -               e = e->next;
>> -               constraint_expr_destroy(l);
>> -       }
>> +       constraint_expr_destroy(h);
>>         return NULL;
>>  }
>>
>> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>> index 3b01ade146c5..7ba2098b61ea 100644
>> --- a/libsepol/cil/src/cil_binary.c
>> +++ b/libsepol/cil/src/cil_binary.c
>> @@ -2841,6 +2841,7 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
>>         return SEPOL_OK;
>>
>>  exit:
>> +       constraint_expr_destroy(sepol_expr);
>>         free(sepol_constrain);
>>         return rc;
>>  }
>> diff --git a/libsepol/src/constraint.c b/libsepol/src/constraint.c
>> index 71540195d633..58eb6da7940f 100644
>> --- a/libsepol/src/constraint.c
>> +++ b/libsepol/src/constraint.c
>> @@ -38,10 +38,14 @@ int constraint_expr_init(constraint_expr_t * expr)
>>
>>  void constraint_expr_destroy(constraint_expr_t * expr)
>>  {
>> -       if (expr != NULL) {
>> +       constraint_expr_t *next;
>> +
>> +       while (expr != NULL) {
>> +               next = expr->next;
>>                 ebitmap_destroy(&expr->names);
>>                 type_set_destroy(expr->type_names);
>>                 free(expr->type_names);
>>                 free(expr);
>> +               expr = next;
>>         }
>>  }
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index 71ada42ca609..f45d28c764ba 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>> @@ -1359,7 +1359,6 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>>  {
>>         class_datum_t *cladatum;
>>         constraint_node_t *constraint, *ctemp;
>> -       constraint_expr_t *e, *etmp;
>>
>>         if (key)
>>                 free(key);
>> @@ -1371,12 +1370,7 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>>         hashtab_destroy(cladatum->permissions.table);
>>         constraint = cladatum->constraints;
>>         while (constraint) {
>> -               e = constraint->expr;
>> -               while (e) {
>> -                       etmp = e;
>> -                       e = e->next;
>> -                       constraint_expr_destroy(etmp);
>> -               }
>> +               constraint_expr_destroy(constraint->expr);
>>                 ctemp = constraint;
>>                 constraint = constraint->next;
>>                 free(ctemp);
>> @@ -1384,12 +1378,7 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>>
>>         constraint = cladatum->validatetrans;
>>         while (constraint) {
>> -               e = constraint->expr;
>> -               while (e) {
>> -                       etmp = e;
>> -                       e = e->next;
>> -                       constraint_expr_destroy(etmp);
>> -               }
>> +               constraint_expr_destroy(constraint->expr);
>>                 ctemp = constraint;
>>                 constraint = constraint->next;
>>                 free(ctemp);
>> --
>> 2.30.0
>>

