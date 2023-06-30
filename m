Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46688EB64D7
	for <selinux@archiver.kernel.org>; Fri, 30 Jun 2023 10:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjF3KAO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 06:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjF3KAN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Jun 2023 06:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449A2122
        for <selinux@vger.kernel.org>; Fri, 30 Jun 2023 02:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688119162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aul/P+Lg/9WD6r6Hs3p27II8UPcTYKptDskjfVh371c=;
        b=QQEsinE6k36OG2Xa7i/Pvw2jhFlMB/ocLtz23NktTMr9wP0y7SFQ7m+NNpeFIO2R8wffmn
        mb4cCEwBaSnYBbgOjb481EC/qwS+oD1YmzENkBbcal14DC39dy5pYISBxVdOWoWRq+p8lB
        Vi1okSytHHdZtxIO/BppaA2EVeKKT3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-XEjjUD2LPi2PotZLGW_ICg-1; Fri, 30 Jun 2023 05:59:17 -0400
X-MC-Unique: XEjjUD2LPi2PotZLGW_ICg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A978D10113D4;
        Fri, 30 Jun 2023 09:59:16 +0000 (UTC)
Received: from localhost (unknown [10.45.224.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68E1C4087C6A;
        Fri, 30 Jun 2023 09:59:16 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2] checkpolicy/dismod: misc improvements
In-Reply-To: <CAP+JOzQdRXvEBwYVGoGy+Pmbzwr0jCF6OzSb42CRkYYU_OZ56g@mail.gmail.com>
References: <20230331173442.101678-3-cgzones@googlemail.com>
 <20230512100845.63558-1-cgzones@googlemail.com>
 <CAP+JOzQdRXvEBwYVGoGy+Pmbzwr0jCF6OzSb42CRkYYU_OZ56g@mail.gmail.com>
Date:   Fri, 30 Jun 2023 11:59:15 +0200
Message-ID: <87a5wh1dak.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, May 12, 2023 at 6:12=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> * fix minus self formatting in neverallow rules, avoiding `~ - self`
>>
>> * show neverallow and neverallowxperm rules
>>
>> * whitespace improvements in output
>>   - avoid duplicate whitespaces before permission list, since
>>     sepol_av_to_string() already adds a trailing one
>>   - avoid duplicate whitespace after wildcard type
>>   - unify indentation for xperm rules
>>
>> * drop unused global variables
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

merged, thanks

>> ---
>> v2:
>>    drop extra whitespace in between ~ and { for type sets
>>    (there are still some minor spacing issues like
>>        neverallow  test1_t ~ self : file { read };
>>    but they would need an overhaul of the common display_id() function)
>> ---
>>  checkpolicy/test/dismod.c | 33 +++++++++++++++++++--------------
>>  1 file changed, 19 insertions(+), 14 deletions(-)
>>
>> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
>> index 929ee308..5ec33860 100644
>> --- a/checkpolicy/test/dismod.c
>> +++ b/checkpolicy/test/dismod.c
>> @@ -54,11 +54,8 @@
>>  #define DISPLAY_AVBLOCK_FILENAME_TRANS 7
>>
>>  static policydb_t policydb;
>> -extern unsigned int ss_initialized;
>>
>> -int policyvers =3D MOD_POLICYDB_VERSION_BASE;
>> -
>> -static const char *symbol_labels[9] =3D {
>> +static const char *const symbol_labels[9] =3D {
>>         "commons",
>>         "classes", "roles  ", "types  ", "users  ", "bools  ",
>>         "levels ", "cats   ", "attribs"
>> @@ -86,12 +83,12 @@ static void render_access_bitmap(ebitmap_t * map, ui=
nt32_t class,
>>  {
>>         unsigned int i;
>>         char *perm;
>> -       fprintf(fp, "{");
>> +       fprintf(fp, " {");
>>         for (i =3D ebitmap_startbit(map); i < ebitmap_length(map); i++) {
>>                 if (ebitmap_get_bit(map, i)) {
>>                         perm =3D sepol_av_to_string(p, class, UINT32_C(1=
) << i);
>>                         if (perm)
>> -                               fprintf(fp, " %s", perm);
>> +                               fprintf(fp, "%s", perm);
>>                 }
>>         }
>>         fprintf(fp, " }");
>> @@ -117,10 +114,12 @@ static int display_type_set(type_set_t * set, uint=
32_t flags, policydb_t * polic
>>         unsigned int i, num_types;
>>
>>         if (set->flags & TYPE_STAR) {
>> -               fprintf(fp, " * ");
>> +               fprintf(fp, " *");
>>                 return 0;
>>         } else if (set->flags & TYPE_COMP) {
>>                 fprintf(fp, " ~");
>> +       } else {
>> +               fprintf(fp, " ");
>>         }
>>
>>         num_types =3D 0;
>> @@ -170,7 +169,10 @@ static int display_type_set(type_set_t * set, uint3=
2_t flags, policydb_t * polic
>>         }
>>
>>         if (flags & RULE_NOTSELF) {
>> -               fprintf(fp, " -self");
>> +               if (set->flags & TYPE_COMP)
>> +                       fprintf(fp, " self");
>> +               else
>> +                       fprintf(fp, " -self");
>>         }
>>
>>         if (num_types > 1)
>> @@ -234,6 +236,9 @@ static int display_avrule(avrule_t * avrule, policyd=
b_t * policy,
>>                 if (avrule->specified & AVRULE_DONTAUDIT) {
>>                         fprintf(fp, "  dontaudit");
>>                 }
>> +               if (avrule->specified & AVRULE_NEVERALLOW) {
>> +                       fprintf(fp, "  neverallow");
>> +               }
>>         } else if (avrule->specified & AVRULE_TYPE) {
>>                 if (avrule->specified & AVRULE_TRANSITION) {
>>                         fprintf(fp, "  type_transition");
>> @@ -244,15 +249,15 @@ static int display_avrule(avrule_t * avrule, polic=
ydb_t * policy,
>>                 if (avrule->specified & AVRULE_CHANGE) {
>>                         fprintf(fp, "  type_change");
>>                 }
>> -       } else if (avrule->specified & AVRULE_NEVERALLOW) {
>> -               fprintf(fp, "  neverallow");
>>         } else if (avrule->specified & AVRULE_XPERMS) {
>>                 if (avrule->specified & AVRULE_XPERMS_ALLOWED)
>> -                       fprintf(fp, "allowxperm ");
>> +                       fprintf(fp, "  allowxperm");
>>                 else if (avrule->specified & AVRULE_XPERMS_AUDITALLOW)
>> -                       fprintf(fp, "auditallowxperm ");
>> +                       fprintf(fp, "  auditallowxperm");
>>                 else if (avrule->specified & AVRULE_XPERMS_DONTAUDIT)
>> -                       fprintf(fp, "dontauditxperm ");
>> +                       fprintf(fp, "  dontauditxperm");
>> +               else if (avrule->specified & AVRULE_XPERMS_NEVERALLOW)
>> +                       fprintf(fp, "  neverallowxperm");
>>         } else {
>>                 fprintf(fp, "     ERROR: no valid rule type specified\n"=
);
>>                 return -1;
>> @@ -560,7 +565,7 @@ static int display_scope_index(scope_index_t * indic=
es, policydb_t * p,
>>                                                                      p, =
out_fp);
>>                                         } else {
>>                                                 fprintf(out_fp,
>> -                                                       "<no perms known=
>");
>> +                                                       " <no perms know=
n>");
>>                                         }
>>                                 }
>>                         }
>> --
>> 2.40.1
>>

