Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7374CC433F5
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 10:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiERKcc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiERKc1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 06:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 617EE1EEC5
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652869944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoO0znx8y7Hgxke2wHi1vn8oHSlnBFJSTFQQvN+Iy5U=;
        b=NJdn0LMPJdep43k0pD0iq/5PB0WIDXmQvznCamNEyOzvCVAWqB4a0CvQ0iXOTL/wa5q+6Z
        f/1YJ3/Sg/XhlOXBssDjsMhHtbddbHq8Xt/6lWNIDeo8CKTtKLzRVS0zMqaFrnIVyrvuK8
        WKzpwNgQMEJwP8cwkOc8xH0lDVeTmjc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-16mESyA9O9qXtlan1VOAwg-1; Wed, 18 May 2022 06:32:23 -0400
X-MC-Unique: 16mESyA9O9qXtlan1VOAwg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A67143C01DA6;
        Wed, 18 May 2022 10:32:22 +0000 (UTC)
Received: from localhost (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50325492C14;
        Wed, 18 May 2022 10:32:22 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] ci: declare git repository a safe directory
In-Reply-To: <87v8u46qek.fsf@redhat.com>
References: <20220517132622.3380-1-cgzones@googlemail.com>
 <87v8u46qek.fsf@redhat.com>
Date:   Wed, 18 May 2022 12:32:21 +0200
Message-ID: <87r14r6si2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:
>
>> Since version 2.35.2, due to CVE-2022-24765, git refuses to operate by
>> default on a repository owned by a different user.
>>
>> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged.


>> ---
>> test run: https://github.com/cgzones/selinux/actions/runs/2337320823
>> ---
>>  scripts/ci/fedora-test-runner.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-r=
unner.sh
>> index 3ce2c3a6..7676f6ea 100755
>> --- a/scripts/ci/fedora-test-runner.sh
>> +++ b/scripts/ci/fedora-test-runner.sh
>> @@ -70,6 +70,7 @@ dnf install -y \
>>  cd "$SELINUX_DIR"
>>=20=20
>>  # Show HEAD commit for sanity checking
>> +git config --global --add safe.directory "$SELINUX_DIR"
>>  git log --oneline -1
>>=20=20
>>  #
>> --=20
>> 2.36.1

