Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E4DC433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 13:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiDFNDU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiDFNCg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 09:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6C575C016B
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649237241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cbf0tEz+uCzrDAwWgMlKQK3n7VcgU+3uKXIcfF2DR4g=;
        b=hNkbZaMKq09E2KZnxUyAt+rr1RlYTHkhpS+//Ad7aoMcxzFKSzLgagc3aIajUwtaILqNaT
        5tbzAbeE25XvxWeuWDZrqYLXTflj9H74CEI/zQLysAudowGAMkkHpnIysVl8xPU+cxPdaj
        rf/8onWq6MhG9ln+Ob+rteBI6C79gSc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-J3-wI3VxMaySviv6brqKXQ-1; Wed, 06 Apr 2022 05:27:12 -0400
X-MC-Unique: J3-wI3VxMaySviv6brqKXQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92E07101A52C;
        Wed,  6 Apr 2022 09:27:12 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3614DC27DB7;
        Wed,  6 Apr 2022 09:27:12 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH 1/2] libsepol: mark immutable mls and context parameter
 const
In-Reply-To: <CAP+JOzSVU+mGXv5Z36xTxy7U=FJbW2+oCC7S6cQzi9ssLo8LZg@mail.gmail.com>
References: <20220331144610.31056-1-cgzones@googlemail.com>
 <CAP+JOzSVU+mGXv5Z36xTxy7U=FJbW2+oCC7S6cQzi9ssLo8LZg@mail.gmail.com>
Date:   Wed, 06 Apr 2022 11:27:11 +0200
Message-ID: <87h776pno0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Apr 1, 2022 at 9:49 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> Make it more obvious which parameters are read-only and not being
>> modified and allow callers to pass const pointers.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Both merged, thanks!


>> ---
>>  libsepol/include/sepol/policydb/context.h   | 14 +++++++-------
>>  libsepol/include/sepol/policydb/mls_types.h | 12 ++++++------
>>  libsepol/src/mls.c                          | 17 +++++++++--------
>>  libsepol/src/mls.h                          |  4 ++--
>>  4 files changed, 24 insertions(+), 23 deletions(-)
>>
>> diff --git a/libsepol/include/sepol/policydb/context.h b/libsepol/includ=
e/sepol/policydb/context.h
>> index 37cdc591..025c894f 100644
>> --- a/libsepol/include/sepol/policydb/context.h
>> +++ b/libsepol/include/sepol/policydb/context.h
>> @@ -43,7 +43,7 @@ static inline void mls_context_init(context_struct_t *=
 c)
>>  }
>>
>>  static inline int mls_context_cpy(context_struct_t * dst,
>> -                                 context_struct_t * src)
>> +                                 const context_struct_t * src)
>>  {
>>
>>         if (mls_range_cpy(&dst->range, &src->range) < 0)
>> @@ -55,7 +55,7 @@ static inline int mls_context_cpy(context_struct_t * d=
st,
>>  /*
>>   * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
>>   */
>> -static inline int mls_context_cpy_low(context_struct_t *dst, context_st=
ruct_t *src)
>> +static inline int mls_context_cpy_low(context_struct_t *dst, const cont=
ext_struct_t *src)
>>  {
>>         int rc;
>>
>> @@ -75,7 +75,7 @@ out:
>>  /*
>>   * Sets both levels in the MLS range of 'dst' to the high level of 'src=
'.
>>   */
>> -static inline int mls_context_cpy_high(context_struct_t *dst, context_s=
truct_t *src)
>> +static inline int mls_context_cpy_high(context_struct_t *dst, const con=
text_struct_t *src)
>>  {
>>         int rc;
>>
>> @@ -92,12 +92,12 @@ out:
>>         return rc;
>>  }
>>
>> -static inline int mls_context_glblub(context_struct_t *dst, context_str=
uct_t *c1, context_struct_t *c2)
>> +static inline int mls_context_glblub(context_struct_t *dst, const conte=
xt_struct_t *c1, const context_struct_t *c2)
>>  {
>>         return mls_range_glblub(&dst->range, &c1->range, &c2->range);
>>  }
>>
>> -static inline int mls_context_cmp(context_struct_t * c1, context_struct=
_t * c2)
>> +static inline int mls_context_cmp(const context_struct_t * c1, const co=
ntext_struct_t * c2)
>>  {
>>         return (mls_level_eq(&c1->range.level[0], &c2->range.level[0]) &&
>>                 mls_level_eq(&c1->range.level[1], &c2->range.level[1]));
>> @@ -118,7 +118,7 @@ static inline void context_init(context_struct_t * c)
>>         memset(c, 0, sizeof(*c));
>>  }
>>
>> -static inline int context_cpy(context_struct_t * dst, context_struct_t =
* src)
>> +static inline int context_cpy(context_struct_t * dst, const context_str=
uct_t * src)
>>  {
>>         dst->user =3D src->user;
>>         dst->role =3D src->role;
>> @@ -135,7 +135,7 @@ static inline void context_destroy(context_struct_t =
* c)
>>         mls_context_destroy(c);
>>  }
>>
>> -static inline int context_cmp(context_struct_t * c1, context_struct_t *=
 c2)
>> +static inline int context_cmp(const context_struct_t * c1, const contex=
t_struct_t * c2)
>>  {
>>         return ((c1->user =3D=3D c2->user) &&
>>                 (c1->role =3D=3D c2->role) &&
>> diff --git a/libsepol/include/sepol/policydb/mls_types.h b/libsepol/incl=
ude/sepol/policydb/mls_types.h
>> index 0ba6d9de..12990c69 100644
>> --- a/libsepol/include/sepol/policydb/mls_types.h
>> +++ b/libsepol/include/sepol/policydb/mls_types.h
>> @@ -50,7 +50,7 @@ typedef struct mls_range {
>>         mls_level_t level[2];   /* low =3D=3D level[0], high =3D=3D leve=
l[1] */
>>  } mls_range_t;
>>
>> -static inline int mls_range_glblub(struct mls_range *dst, struct mls_ra=
nge *r1, struct mls_range *r2)
>> +static inline int mls_range_glblub(struct mls_range *dst, const struct =
mls_range *r1, const struct mls_range *r2)
>>  {
>>         if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens <=
 r1->level[0].sens) {
>>                 /* These ranges have no common sensitivities */
>> @@ -74,7 +74,7 @@ static inline int mls_range_glblub(struct mls_range *d=
st, struct mls_range *r1,
>>  }
>>
>>
>> -static inline int mls_level_cpy(struct mls_level *dst, struct mls_level=
 *src)
>> +static inline int mls_level_cpy(struct mls_level *dst, const struct mls=
_level *src)
>>  {
>>
>>         dst->sens =3D src->sens;
>> @@ -119,7 +119,7 @@ static inline int mls_level_dom(const struct mls_lev=
el *l1, const struct mls_lev
>>  (mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
>>   mls_level_dom(&(r1).level[1], &(r2).level[1]))
>>
>> -static inline int mls_range_cpy(mls_range_t * dst, mls_range_t * src)
>> +static inline int mls_range_cpy(mls_range_t * dst, const mls_range_t * =
src)
>>  {
>>
>>         if (mls_level_cpy(&dst->level[0], &src->level[0]) < 0)
>> @@ -149,7 +149,7 @@ static inline void mls_range_destroy(struct mls_rang=
e *r)
>>         mls_level_destroy(&r->level[1]);
>>  }
>>
>> -static inline int mls_range_eq(struct mls_range *r1, struct mls_range *=
r2)
>> +static inline int mls_range_eq(const struct mls_range *r1, const struct=
 mls_range *r2)
>>  {
>>         return (mls_level_eq(&r1->level[0], &r2->level[0]) &&
>>                 mls_level_eq(&r1->level[1], &r2->level[1]));
>> @@ -174,10 +174,10 @@ extern void mls_semantic_cat_init(mls_semantic_cat=
_t *c);
>>  extern void mls_semantic_cat_destroy(mls_semantic_cat_t *c);
>>  extern void mls_semantic_level_init(mls_semantic_level_t *l);
>>  extern void mls_semantic_level_destroy(mls_semantic_level_t *l);
>> -extern int mls_semantic_level_cpy(mls_semantic_level_t *dst, mls_semant=
ic_level_t *src);
>> +extern int mls_semantic_level_cpy(mls_semantic_level_t *dst, const mls_=
semantic_level_t *src);
>>  extern void mls_semantic_range_init(mls_semantic_range_t *r);
>>  extern void mls_semantic_range_destroy(mls_semantic_range_t *r);
>> -extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, mls_semant=
ic_range_t *src);
>> +extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, const mls_=
semantic_range_t *src);
>>
>>  #ifdef __cplusplus
>>  }
>> diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
>> index 366a1114..4ffe9814 100644
>> --- a/libsepol/src/mls.c
>> +++ b/libsepol/src/mls.c
>> @@ -451,7 +451,7 @@ int mls_context_to_sid(const policydb_t * policydb,
>>   * Copies the MLS range from `src' into `dst'.
>>   */
>>  static inline int mls_copy_context(context_struct_t * dst,
>> -                                  context_struct_t * src)
>> +                                  const context_struct_t * src)
>>  {
>>         int l, rc =3D 0;
>>
>> @@ -471,7 +471,7 @@ static inline int mls_copy_context(context_struct_t =
* dst,
>>   * Copies the effective MLS range from `src' into `dst'.
>>   */
>>  static inline int mls_scopy_context(context_struct_t * dst,
>> -                                   context_struct_t * src)
>> +                                   const context_struct_t * src)
>>  {
>>         int l, rc =3D 0;
>>
>> @@ -490,7 +490,7 @@ static inline int mls_scopy_context(context_struct_t=
 * dst,
>>  /*
>>   * Copies the MLS range `range' into `context'.
>>   */
>> -static inline int mls_range_set(context_struct_t * context, mls_range_t=
 * range)
>> +static inline int mls_range_set(context_struct_t * context, const mls_r=
ange_t * range)
>>  {
>>         int l, rc =3D 0;
>>
>> @@ -601,8 +601,8 @@ int mls_convert_context(policydb_t * oldp,
>>  }
>>
>>  int mls_compute_sid(policydb_t * policydb,
>> -                   context_struct_t * scontext,
>> -                   context_struct_t * tcontext,
>> +                   const context_struct_t * scontext,
>> +                   const context_struct_t * tcontext,
>>                     sepol_security_class_t tclass,
>>                     uint32_t specified, context_struct_t * newcontext)
>>  {
>> @@ -755,9 +755,10 @@ void mls_semantic_level_destroy(mls_semantic_level_=
t * l)
>>  }
>>
>>  int mls_semantic_level_cpy(mls_semantic_level_t * dst,
>> -                          mls_semantic_level_t * src)
>> +                          const mls_semantic_level_t * src)
>>  {
>> -       mls_semantic_cat_t *cat, *newcat, *lnewcat =3D NULL;
>> +       const mls_semantic_cat_t *cat;
>> +       mls_semantic_cat_t *newcat, *lnewcat =3D NULL;
>>
>>         mls_semantic_level_init(dst);
>>         dst->sens =3D src->sens;
>> @@ -800,7 +801,7 @@ void mls_semantic_range_destroy(mls_semantic_range_t=
 * r)
>>  }
>>
>>  int mls_semantic_range_cpy(mls_semantic_range_t * dst,
>> -                          mls_semantic_range_t * src)
>> +                          const mls_semantic_range_t * src)
>>  {
>>         if (mls_semantic_level_cpy(&dst->level[0], &src->level[0]) < 0)
>>                 return -1;
>> diff --git a/libsepol/src/mls.h b/libsepol/src/mls.h
>> index 5ca3cd51..eb4a1cb8 100644
>> --- a/libsepol/src/mls.h
>> +++ b/libsepol/src/mls.h
>> @@ -56,8 +56,8 @@ extern int mls_convert_context(policydb_t * oldp,
>>                                policydb_t * newp, context_struct_t * con=
text);
>>
>>  extern int mls_compute_sid(policydb_t * policydb,
>> -                          context_struct_t * scontext,
>> -                          context_struct_t * tcontext,
>> +                          const context_struct_t * scontext,
>> +                          const context_struct_t * tcontext,
>>                            sepol_security_class_t tclass,
>>                            uint32_t specified, context_struct_t * newcon=
text);
>>
>> --
>> 2.35.1
>>

