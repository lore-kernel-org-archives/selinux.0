Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC46FC433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 11:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3C060C41
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 11:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhBXLBD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 06:01:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234922AbhBXLAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 06:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614164349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvZjrKTApD0Vfpzo2uUspP1DkJ0fB87kaPqBXelYsoE=;
        b=GRuJS8vNxsMDDJfeOH9T2CfwaizhbODW0XkprOQcfoW3VmznMw6SmyK5dlpPifjfJKA1kL
        oQdTF7Hgu4tJ4VZ4Bnc9NW6awT6X2d2Orknabr4TnAWjs6yfjuLgKdqE0uM6yklEmygZJo
        y+V97xONLE0yTeK7w0vCLMEyowsvwGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-Tr_hXyAbMCasf2AGoHXRrw-1; Wed, 24 Feb 2021 05:59:07 -0500
X-MC-Unique: Tr_hXyAbMCasf2AGoHXRrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 036CC107ACC7;
        Wed, 24 Feb 2021 10:59:06 +0000 (UTC)
Received: from localhost (unknown [10.40.193.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6050619C46;
        Wed, 24 Feb 2021 10:59:05 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>,
        Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v2] libsepol/cil: handle SID without assigned context
 when writing policy.conf
In-Reply-To: <CAP+JOzTz0X+AEF3KJ1N-L8DLitit6r-+nFUegkYorFg=GSSv8g@mail.gmail.com>
References: <20210220190806.22139-1-cgzones@googlemail.com>
 <20210223130917.23360-1-cgzones@googlemail.com>
 <CAP+JOzTz0X+AEF3KJ1N-L8DLitit6r-+nFUegkYorFg=GSSv8g@mail.gmail.com>
Date:   Wed, 24 Feb 2021 11:59:04 +0100
Message-ID: <874ki13f5z.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Feb 23, 2021 at 8:13 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> CIL permits not assigning a context to a SID, e.g. to an unused initial
>> SID, e.g. 'any_socket'.
>>
>> When using the example policy from the SELinux Notebook,
>> https://github.com/SELinuxProject/selinux-notebook/blob/main/src/noteboo=
k-examples/cil-policy/cil-policy.cil,
>> secilc logs:
>>
>>     No context assigned to SID any_socket, omitting from policy at cil-p=
olicy.cil:166
>>
>> But secil2conf segfaults when writing the policy.conf:
>>
>>     ../cil/src/cil_policy.c:274:2: runtime error: member access within n=
ull pointer of type 'struct cil_context'
>>
>> Only print the sid context statement if a context was actually assigned.
>> The sid declaration is still included via cil_sid_decls_to_policy().
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Oops, I should have noticed that. I was too focused on the segfault.
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged, thanks!

>> ---
>> v2:
>>   Drop the statement completely in cil_sid_contexts_to_policy(),
>>   cause cil_sid_decls_to_policy() will have printed the context less
>>   declaration already.
>>
>>  libsepol/cil/src/cil_policy.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy=
.c
>> index 74edb345..91e767b7 100644
>> --- a/libsepol/cil/src/cil_policy.c
>> +++ b/libsepol/cil/src/cil_policy.c
>> @@ -1660,9 +1660,11 @@ static void cil_sid_contexts_to_policy(FILE *out,=
 struct cil_list *sids, int mls
>>
>>         cil_list_for_each(i1, sids) {
>>                 sid =3D i1->data;
>> -               fprintf(out, "sid %s ", sid->datum.fqn);
>> -               cil_context_to_policy(out, sid->context, mls);
>> -               fprintf(out,"\n");
>> +               if (sid->context) {
>> +                       fprintf(out, "sid %s ", sid->datum.fqn);
>> +                       cil_context_to_policy(out, sid->context, mls);
>> +                       fprintf(out,"\n");
>> +               }
>>         }
>>  }
>>
>> --
>> 2.30.1
>>

