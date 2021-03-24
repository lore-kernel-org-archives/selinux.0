Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB8C433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 14:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEF361A10
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 14:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhCXOJn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236020AbhCXOJN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Mar 2021 10:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616594952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHCPlo/vOKkCbiemWbvJGSfTdlBCBAEPbhpFi6xrIxA=;
        b=akvFHTaUEJqZnI26CN67PMIw5rk9v1SnM2IwZS+vNSdpypQtIR6bjS7vGPgu0HjXSYCGJF
        j7D4HdabwQ16ETxAFXBlvafXujwPzSD0Z4rsfhxB6HMzsxXJy/F86qotGeQ7aRVFCQ1PTU
        xOfuoRQnaSaoPYtMKjYXoPVqaAI9Phg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-eb-6MnbNP6--KN74gG2PQg-1; Wed, 24 Mar 2021 10:09:09 -0400
X-MC-Unique: eb-6MnbNP6--KN74gG2PQg-1
Received: by mail-yb1-f199.google.com with SMTP id x10so2368791ybr.11
        for <selinux@vger.kernel.org>; Wed, 24 Mar 2021 07:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHCPlo/vOKkCbiemWbvJGSfTdlBCBAEPbhpFi6xrIxA=;
        b=NLBTtftSGW5L2MA9C5naV3tgZNYpIFaus1NU6/dmqFZuSwHoIE36tEPeP7a1RRaqIX
         EUNmYoxEODMof6+zQfi5FEJLaBoC0ma4cmoy2afDzBIinZZ8VneVv/6vcKDgM0e6JRga
         Z5AhZB+qBuZilfoLDNVdx02Y5eVi5uNkuZhdadL5k9LsjFmGen7TTyY/VbwY+dygdncv
         C1Li0ElBA6/yoGGpWYsaDx8rf1BTUDNauKIp899Cgd6ZodJO7nmd/yEuXbVLbn6vu+Pu
         UsZPCEV0Y2PNRSjsNKSkglldH2jDDWeX7AuM0r4f8tyFEiKc64f60ZSJ1bjz6/4OGET/
         laXw==
X-Gm-Message-State: AOAM533CNQFj54m6aU8GRraE03w0a+c9Rwwb+h5Qg91w2TrlvprX62UD
        JYhuMkLyMSMMFm+hQ6m+8u+8/zsuBJHrfkdcu7j5TQl7u64vwivL3OZlNjmLNGpgc7g+ewRyqtK
        eaG3OCYLDHcfa0RqXvVZdBFqnX6OU+/lmrA==
X-Received: by 2002:a5b:74d:: with SMTP id s13mr5221571ybq.289.1616594948656;
        Wed, 24 Mar 2021 07:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPvwH9n6rZG0pdm8jAFDFbBBwVGuo3/kQ7vX7pKssC8ihRiBoyGLEjWg9hZtabka8JrmFqmlj2ppakw/Fx4Lw=
X-Received: by 2002:a5b:74d:: with SMTP id s13mr5221546ybq.289.1616594948458;
 Wed, 24 Mar 2021 07:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210324122616.406572-1-omosnace@redhat.com> <CA+EESO4km4ADU0mAcXWR_MjG_v69-4U6tHqgZfPTmCdacSL_sw@mail.gmail.com>
In-Reply-To: <CA+EESO4km4ADU0mAcXWR_MjG_v69-4U6tHqgZfPTmCdacSL_sw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 24 Mar 2021 15:08:57 +0100
Message-ID: <CAFqZXNt+0CU8gLR2ZmG+XwO9VCi3cdQCM=hnvzVqebG25qBpVw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/userfaultfd: handle __NR_userfaultfd not
 being defined
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 24, 2021 at 1:41 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
>
>
> On Wed, Mar 24, 2021 at 5:56 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>
>> On some old kernels (think RHEL-7) __NR_userfaultfd may not be defined
>> on certain arches, even though the <linux/userfaultfd.h> header is
>> available. To avoid build errors in such environments, abstract the
>> userfaultfd syscall into a helper function and make it fail with ENOSYS
>> when __NR_userfaultfd is not defined.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
>
> Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>

Thanks!

>
> Thanks for this fix.
>
> BTW, does it make sense to keep this test enabled on old kernels which don't have SELinux support for userfaultfd?

No, it doesn't - that's why I made it return ENOSYS in this case,
which will lead to the test being skipped.

>>
>> ---
>>  tests/userfaultfd/userfaultfd.c | 17 ++++++++++++++---
>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/userfaultfd/userfaultfd.c b/tests/userfaultfd/userfaultfd.c
>> index a283a83..dd3a9f3 100644
>> --- a/tests/userfaultfd/userfaultfd.c
>> +++ b/tests/userfaultfd/userfaultfd.c
>> @@ -19,7 +19,7 @@ int page_size;
>>
>>  void *fault_handler_thread(void *arg)
>>  {
>> -       long uffd = (long)arg;
>> +       int uffd = (int)(intptr_t)arg;
>>         struct uffd_msg msg = {0};
>>         struct uffdio_copy uffdio_copy = {0};
>>         ssize_t nread;
>> @@ -83,6 +83,16 @@ void *fault_handler_thread(void *arg)
>>         }
>>  }
>>
>> +int syscall_userfaultfd(int flags)
>> +{
>> +#ifdef __NR_userfaultfd
>> +       return (int)syscall(__NR_userfaultfd, flags);
>> +#else
>> +       errno = ENOSYS;
>> +       return -1;
>> +#endif
>> +}
>> +
>>  int main (int argc, char *argv[])
>>  {
>>         char *addr;
>> @@ -92,7 +102,7 @@ int main (int argc, char *argv[])
>>         pthread_t thr; // ID of thread that handles page faults
>>         ssize_t ret;
>>
>> -       long uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>> +       int uffd = syscall_userfaultfd(O_CLOEXEC | O_NONBLOCK);
>>         if (uffd < 0) {
>>                 if (errno == ENOSYS) {
>>                         return 8;
>> @@ -159,7 +169,8 @@ int main (int argc, char *argv[])
>>         }
>>
>>         // Create a thread that will process the userfaultfd events
>> -       ret = pthread_create(&thr, NULL, fault_handler_thread, (void *) uffd);
>> +       ret = pthread_create(&thr, NULL, fault_handler_thread,
>> +                            (void *)(intptr_t)uffd);
>>         if (ret != 0) {
>>                 errno = ret;
>>                 perror("pthread_create");
>> --
>> 2.30.2
>>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

