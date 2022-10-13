Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C332BC4332F
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 13:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJMNOE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 09:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJMNN7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 09:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F33215DB2B
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 06:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665666831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHTEL41aHw0BwAsKqfG7uoZyHZCqi0dy8LNKaVp2Bpw=;
        b=Dh0NM9SC0prNyZodveIgQn16YIlJAIcGwph1ImWEYT6xvClrFtlRPWqnEknfAJBHIZABUx
        Q1SpbAO5dEnL+RAFH/EGQ/u9KFWoYisK1LhInRyKwrcfxH1zde7s2vFgt57fuN2RN9jTfi
        Kvxfaw3qZNe1pZqIWwIlO+Kgku1oxes=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-HtgWW7kiOymHkQdEF7taQQ-1; Thu, 13 Oct 2022 09:13:48 -0400
X-MC-Unique: HtgWW7kiOymHkQdEF7taQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA4CD380450C;
        Thu, 13 Oct 2022 13:13:47 +0000 (UTC)
Received: from localhost (ovpn-193-3.brq.redhat.com [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 921137AE5;
        Thu, 13 Oct 2022 13:13:46 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Milos Malik <mmalik@redhat.com>
Subject: Re: [PATCH] libsepol/cil: restore error on context rule conflicts
In-Reply-To: <CAP+JOzQr_1bBDAp=jyBb37cNFQKW0CDsixiM3aAcWSWAJtvQxg@mail.gmail.com>
References: <20221012142751.17979-1-cgzones@googlemail.com>
 <CAP+JOzQr_1bBDAp=jyBb37cNFQKW0CDsixiM3aAcWSWAJtvQxg@mail.gmail.com>
Date:   Thu, 13 Oct 2022 15:13:45 +0200
Message-ID: <87czavsw6u.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Wed, Oct 12, 2022 at 10:28 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> Commit bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for
>> context rule conflicts") reworked the processing of context rule
>> conflicts to limit the number of written conflicting statements to
>> increase readability of the printed error message.  It forgot to set the
>> return value, signaling a context conflict, in the case the logging
>> level is higher than warning (e.g. in semodule(8), which defaults to
>> error).
>>
>> Reported-by: Milos Malik <mmalik@redhat.com> [1]
>> Fixes: bc26ddc59c8d ("libsepol/cil: Limit the amount of reporting for co=
ntext rule conflicts")
>>
>> [1]: https://lore.kernel.org/selinux/87y1u1rkoo.fsf@redhat.com/
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Tested-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


>> ---
>>  libsepol/cil/src/cil_post.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
>> index 6e95225f..11e572e2 100644
>> --- a/libsepol/cil/src/cil_post.c
>> +++ b/libsepol/cil/src/cil_post.c
>> @@ -2290,6 +2290,7 @@ static int __cil_post_process_context_rules(struct=
 cil_sort *sort, int (*compar)
>>                 } else {
>>                         removed++;
>>                         if (!db->multiple_decls || concompar(&sort->arra=
y[i], &sort->array[j]) !=3D 0) {
>> +                               rc =3D SEPOL_ERR;
>>                                 conflicting++;
>>                                 if (log_level >=3D CIL_WARN) {
>>                                         struct cil_list_item li;
>> @@ -2297,7 +2298,6 @@ static int __cil_post_process_context_rules(struct=
 cil_sort *sort, int (*compar)
>>                                         li.flavor =3D flavor;
>>                                         if (conflicting =3D=3D 1) {
>>                                                 cil_log(CIL_WARN, "Found=
 conflicting %s rules\n", flavor_str);
>> -                                               rc =3D SEPOL_ERR;
>>                                                 li.data =3D sort->array[=
i];
>>                                                 rc2 =3D cil_tree_walk(db=
->ast->root, __cil_post_report_conflict,
>>                                                                         =
                NULL, NULL, &li);
>> --
>> 2.37.2
>>

