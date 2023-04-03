Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C5EC76196
	for <selinux@archiver.kernel.org>; Mon,  3 Apr 2023 13:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjDCNjQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Apr 2023 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDCNjI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Apr 2023 09:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D879F10E5
        for <selinux@vger.kernel.org>; Mon,  3 Apr 2023 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680529101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=easzI6Qs83kmmzT964mYaqxYOdCOSlvZ9+q30VeDX/I=;
        b=REaSO06UUGWOj0B8hNEt4Au2tVDR8ggN65Lfz+IuFuu/F7YExUeE3lGwxNPpCRhVvLV591
        ZZXG65mn7sKvDN9qoQZBm1FVAg+v8JSV2GsZmHSJPJISs0TyIkZTVM6+Z5EMSGPZ//n2Fa
        z1qCY8QqHZLKj+31vtSzKXBmuEC0xTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-8Ybx1mAvP4CSh5VO-1YPFQ-1; Mon, 03 Apr 2023 09:38:17 -0400
X-MC-Unique: 8Ybx1mAvP4CSh5VO-1YPFQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33762100DED3;
        Mon,  3 Apr 2023 13:38:17 +0000 (UTC)
Received: from localhost (unknown [10.45.225.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0276175AD;
        Mon,  3 Apr 2023 13:38:16 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: sesearch --neverallow
In-Reply-To: <2d898b44-02a3-dae2-8e92-fa3a22f9d7a1@linux.microsoft.com>
References: <87ileh5ckg.fsf@redhat.com>
 <CAEjxPJ675EhOoKXHzXKaVOoSXfqkqKudPzCL=F4aAG0vbd+Cdg@mail.gmail.com>
 <87h6u0bwvp.fsf@defensec.nl>
 <CAEjxPJ72BTh3MzGje82uN4ayCGFGnJyz7uKobprRhx0R1R0JNA@mail.gmail.com>
 <87cz4obsa0.fsf@defensec.nl>
 <2d898b44-02a3-dae2-8e92-fa3a22f9d7a1@linux.microsoft.com>
Date:   Mon, 03 Apr 2023 15:38:15 +0200
Message-ID: <87lej9ytko.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Chris PeBenito <chpebeni@linux.microsoft.com> writes:

> On 3/31/2023 16:05, Dominick Grift wrote:
>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>=20
>>> On Fri, Mar 31, 2023 at 2:26=E2=80=AFPM Dominick Grift
>>> <dominick.grift@defensec.nl> wrote:
>>>>
>>>> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>>>>
>>>>> On Fri, Mar 31, 2023 at 8:37=E2=80=AFAM Petr Lautrbach <lautrbach@red=
hat.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I've got a question what is `sesearch --neverallow` good for and how=
 to
>>>>>> make it work. I wasn't able to get any output from this command.
>>>>>>
>>>>>> Is it supposed to work with current userspace and policies? How?
>>>>>
>>>>> I don't see how it could work. neverallow rules aren't preserved in
>>>>> the kernel policies.
>>>>> It would only make sense if sesearch could be run on source policies =
or modules.
>>>>
>>>> Which according to `man sesearch` is possible, but only monolithic pol=
icy.conf.
>>>
>>> Even that doesn't seem to be supported by setools 4,
>>> $ sesearch --neverallow policy.conf
>>> Invalid policy: policy.conf. A binary policy must be specified. (use
>>> e.g. policy.33 or sepolicy) Source policies are not supported.
>>>
>>> $ rpm -q -f /usr/bin/sesearch
>>> setools-console-4.4.0-9.fc37.x86_64
>>=20
>> I was probably looking at the man for setools3 then. (the one on linux.d=
ie.net)
>
> I dropped source policy support some time ago. I'll remove --neverallow=20
> option and man page info.
>

Thanks.

Petr

