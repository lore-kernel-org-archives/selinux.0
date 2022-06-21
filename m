Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4079C433EF
	for <selinux@archiver.kernel.org>; Tue, 21 Jun 2022 13:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiFUNYE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbiFUNXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jun 2022 09:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29623DF75
        for <selinux@vger.kernel.org>; Tue, 21 Jun 2022 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655817801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UB/ttOui23WdnyqzUDbf/aED7t+RJZ7NKQaBZqY+fMs=;
        b=BE6Oh+aYKR/2HHdIutT8DC9mWtcc1dOtvJfkCFX8m8/Q1/Z4mAg29ELQOmHlNtHdUtcBSy
        UMFUKsx3Q6qQuNw2PH7YHYSWHOP67VzGw/RPXtcBLkb5xVZ8WfiWrgQmiwCGqCl7434fHm
        w9C9JWgU1Pt9Gn9Go13hJOwoXkqYEHA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-z_g_6akTMIKKZLKVjnHU5Q-1; Tue, 21 Jun 2022 09:23:17 -0400
X-MC-Unique: z_g_6akTMIKKZLKVjnHU5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C265811E75;
        Tue, 21 Jun 2022 13:23:17 +0000 (UTC)
Received: from localhost (unknown [10.40.193.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 256471121314;
        Tue, 21 Jun 2022 13:23:16 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH] checkpolicy: error out if required permission would
 exceed limit
In-Reply-To: <CAJ2a_Df8QY92WENiLMcpiayr_QgJP-pyckb5XWcsb-i8YjhqVA@mail.gmail.com>
References: <20220610150637.21133-1-cgzones@googlemail.com>
 <CAP+JOzSYuPN-W-qsruMq1xGjUq-kwf_WXxz0VZAt1q_9sRY5cw@mail.gmail.com>
 <CAJ2a_Df8QY92WENiLMcpiayr_QgJP-pyckb5XWcsb-i8YjhqVA@mail.gmail.com>
Date:   Tue, 21 Jun 2022 15:23:16 +0200
Message-ID: <87ilourvzv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Wed, 15 Jun 2022 at 20:18, James Carter <jwcart2@gmail.com> wrote:
>>
>> On Fri, Jun 10, 2022 at 11:12 AM Christian G=C3=B6ttsche
>> <cgzones@googlemail.com> wrote:
>> >
>> > A require statement for a class permission adds that permission to the
>> > class representation for the current module.  In case the resulting
>> > class would have more than the supported amount of 32 permissions
>> > assigned the resulting binary module will fail to load at link-time
>> > without an informative error message (since [1]).
>> >
>> > Bail out if adding a permission would result in a class having more th=
en
>
> s/then/than/

Merged, thanks!


>> > the supported amount of 32 permissions assigned.
>> >
>> > [1]: https://github.com/SELinuxProject/selinux/commit/97af65f69644a323=
3d073ae93980a0d2e51f42e1
>> >
>> > Closes: https://github.com/SELinuxProject/selinux/issues/356
>> > Reported-by: Julie Pichon
>> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>>
>> Acked-by: James Carter <jwcart2@gmail.com>
>>
>> > ---
>> >  checkpolicy/module_compiler.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compil=
er.c
>> > index 129650fa..3188af89 100644
>> > --- a/checkpolicy/module_compiler.c
>> > +++ b/checkpolicy/module_compiler.c
>> > @@ -851,6 +851,14 @@ int require_class(int pass)
>> >                                 free(perm_id);
>> >                                 return -1;
>> >                         }
>> > +                       if (datum->permissions.nprim >=3D PERM_SYMTAB_=
SIZE) {
>> > +                               yyerror2("Class %s would have too many=
 permissions "
>> > +                                        "to fit in an access vector w=
ith permission %s",
>> > +                                        policydbp->p_class_val_to_nam=
e[datum->s.value - 1],
>> > +                                        perm_id);
>> > +                               free(perm_id);
>> > +                               return -1;
>> > +                       }
>> >                         allocated =3D 1;
>> >                         if ((perm =3D malloc(sizeof(*perm))) =3D=3D NU=
LL) {
>> >                                 yyerror("Out of memory!");
>> > --
>> > 2.36.1
>> >

