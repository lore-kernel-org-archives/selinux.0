Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE2C433FE
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 13:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiDFNB7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiDFNBl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 09:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AA4A5BE11B
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649237186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wGJnNFmggKQl+vpsdvM/TCwBCkWW0Nz8Fc+bLwtrQo=;
        b=QU9ZcMqd/AwlEIX51We03Uc3MFt6NHn/A45sJmzhaRz6YpBuohQItVtkfy5hFuyK4FHvio
        cIwZ5AmoGw4yJW1Y/B98Wj7NUboZZoG0kjklcU/i5gRJZA4eWVxXMWg4aZIbiupGzY6JGt
        i+Q+hxqiBAOaM2Qkg3uviwwl9jxbeW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-dIGrUNHEOhCJs-c8bvp-Ww-1; Wed, 06 Apr 2022 05:26:23 -0400
X-MC-Unique: dIGrUNHEOhCJs-c8bvp-Ww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A862A800B28;
        Wed,  6 Apr 2022 09:26:22 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F16B401E65;
        Wed,  6 Apr 2022 09:26:22 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH] libsepol: add missing oom checks
In-Reply-To: <CAP+JOzSXbEZuEy_oMgWPbu_mcTZo_HBb6-YVR1ULKpY36z2nkQ@mail.gmail.com>
References: <20220331144452.30869-1-cgzones@googlemail.com>
 <CAP+JOzSXbEZuEy_oMgWPbu_mcTZo_HBb6-YVR1ULKpY36z2nkQ@mail.gmail.com>
Date:   Wed, 06 Apr 2022 11:26:21 +0200
Message-ID: <87k0c2pnpe.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Thu, Mar 31, 2022 at 11:34 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> Check return values of memory allocation functions and propagate their
>> failure.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>> ---
>>  libsepol/src/kernel_to_cil.c  |  9 +++++++++
>>  libsepol/src/kernel_to_conf.c |  4 ++++
>>  libsepol/src/module_to_cil.c  | 11 +++++++++++
>>  libsepol/src/policydb.c       |  3 ++-
>>  4 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
>> index 869f6940..9128ac55 100644
>> --- a/libsepol/src/kernel_to_cil.c
>> +++ b/libsepol/src/kernel_to_cil.c
>> @@ -190,6 +190,10 @@ static char *constraint_expr_to_str(struct policydb=
 *pdb, struct constraint_expr
>>                                 }
>>                                 if (!names) {
>>                                         names =3D strdup("NO_IDENTIFIER"=
);
>> +                                       if (!names) {
>> +                                               sepol_log_err("Out of me=
mory");
>> +                                               goto exit;
>> +                                       }
>>                                 }
>>                                 if (strchr(names, ' ')) {
>>                                         new_val =3D create_str("(%s %s (=
%s))", 3, op, attr1, names);
>> @@ -568,6 +572,11 @@ static int write_sids_to_cil(FILE *out, const char =
*const *sid_to_str,
>>                 } else {
>>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
>>                         sid =3D strdup(unknown);
>> +                       if (!sid) {
>> +                               sepol_log_err("Out of memory");
>> +                               rc =3D -1;
>> +                               goto exit;
>> +                       }
>>                 }
>>                 rc =3D strs_add_at_index(strs, sid, i);
>>                 if (rc !=3D 0) {
>> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf=
.c
>> index 3544f73d..63dffd9b 100644
>> --- a/libsepol/src/kernel_to_conf.c
>> +++ b/libsepol/src/kernel_to_conf.c
>> @@ -187,6 +187,10 @@ static char *constraint_expr_to_str(struct policydb=
 *pdb, struct constraint_expr
>>                                 }
>>                                 if (!names) {
>>                                         names =3D strdup("NO_IDENTIFIER"=
);
>> +                                       if (!names) {
>> +                                               sepol_log_err("Out of me=
mory");
>> +                                               goto exit;
>> +                                       }
>>                                 }
>>                                 if (strchr(names, ' ')) {
>>                                         new_val =3D create_str("%s %s { =
%s }", 3, attr1, op, names);
>> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>> index c9e88f1e..f2e8aff0 100644
>> --- a/libsepol/src/module_to_cil.c
>> +++ b/libsepol/src/module_to_cil.c
>> @@ -393,6 +393,8 @@ static int typealias_list_create(struct policydb *pd=
b)
>>         }
>>
>>         typealias_lists =3D calloc(max_decl_id + 1, sizeof(*typealias_li=
sts));
>> +       if (!typealias_lists)
>> +               goto exit;
>>         typealias_lists_len =3D max_decl_id + 1;
>>
>>         rc =3D hashtab_map(pdb->p_types.table, typealiases_gather_map, p=
db);
>> @@ -1792,6 +1794,10 @@ static int constraint_expr_to_string(struct polic=
ydb *pdb, struct constraint_exp
>>                                 }
>>                                 if (num_names =3D=3D 0) {
>>                                         names =3D strdup("NO_IDENTIFIER"=
);
>> +                                       if (!names) {
>> +                                               rc =3D -1;
>> +                                               goto exit;
>> +                                       }
>>                                 } else {
>>                                         rc =3D name_list_to_string(name_=
list, num_names, &names);
>>                                         if (rc !=3D 0) {
>> @@ -2556,6 +2562,11 @@ static int ocontext_isid_to_cil(struct policydb *=
pdb, const char *const *sid_to_
>>                         goto exit;
>>                 }
>>                 item->sid_key =3D strdup(sid);
>> +               if (!item->sid_key) {
>> +                       log_err("Out of memory");
>> +                       rc =3D -1;
>> +                       goto exit;
>> +               }
>>                 item->next =3D head;
>>                 head =3D item;
>>         }
>> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
>> index fc71463e..5c7e35e8 100644
>> --- a/libsepol/src/policydb.c
>> +++ b/libsepol/src/policydb.c
>> @@ -1252,7 +1252,8 @@ int policydb_index_others(sepol_handle_t * handle,
>>         if (!p->type_val_to_struct)
>>                 return -1;
>>
>> -       cond_init_bool_indexes(p);
>> +       if (cond_init_bool_indexes(p))
>> +               return -1;
>>
>>         for (i =3D SYM_ROLES; i < SYM_NUM; i++) {
>>                 free(p->sym_val_to_name[i]);
>> --
>> 2.35.1
>>

