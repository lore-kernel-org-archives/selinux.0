Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71BC4332F
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 10:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiKGKHB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 05:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiKGKHA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 05:07:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFACB1581A
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667815561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09wja2Vj2XFYGXicwwW9rNLRI6vSEaxvG41BkgbOjAc=;
        b=WItxuwtwe67a4wnBUHWDJidxZPHiy2MKbP/EAfnocwl/NC+PU7nzFg8NnSaPUpyL0RpT+v
        ZCJJHJCUWJKcYC45a44sDNLi1bMbANhX/7Y348TFaB0RRl9XG/x+hYh86s6zYm0qbBHdpW
        A4UpNrZ1ozctrZa6Avo4GPe75qEKfjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-rOjaOpc4OIuOAWeWE8AI4w-1; Mon, 07 Nov 2022 05:05:59 -0500
X-MC-Unique: rOjaOpc4OIuOAWeWE8AI4w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6797087B2A1;
        Mon,  7 Nov 2022 10:05:59 +0000 (UTC)
Received: from localhost (ovpn-192-172.brq.redhat.com [10.40.192.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CE0E492B0B;
        Mon,  7 Nov 2022 10:05:58 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] docs: update the README.md with a basic SELinux
 description
In-Reply-To: <CAHC9VhTugAhgcM7bJOXzKcFq8w7Zu4KR2d1onTKtbsy+kCQY3w@mail.gmail.com>
References: <166480484056.9276.9459961157065300430.stgit@olly>
 <871qqjdlx3.fsf@redhat.com>
 <CAHC9VhTugAhgcM7bJOXzKcFq8w7Zu4KR2d1onTKtbsy+kCQY3w@mail.gmail.com>
Date:   Mon, 07 Nov 2022 11:05:58 +0100
Message-ID: <87o7tjcc55.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Fri, Nov 4, 2022 at 7:00 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>> > This is to help meet the OpenSSF Best Practices requirements.
>> >
>> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>>
>> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Thanks Petr.
>
>> > ---
>> >  README.md |   19 ++++++++++++-------
>> >  1 file changed, 12 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/README.md b/README.md
>> > index 74b0a0c3..f54e0555 100644
>> > --- a/README.md
>> > +++ b/README.md
>> > @@ -7,13 +7,18 @@ SELinux Userspace
>> >  [![OSS-Fuzz Status](https://oss-fuzz-build-logs.storage.googleapis.com/badges/selinux.svg)](https://oss-fuzz-build-logs.storage.googleapis.com/index.html#selinux)
>> >  [![CIFuzz Status](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml/badge.svg)](https://github.com/SELinuxProject/selinux/actions/workflows/cifuzz.yml)
>> >
>> > -Please submit all bug reports and patches to <selinux@vger.kernel.org>.
>> > -
>> > -Subscribe by sending "subscribe selinux" in the body of an email
>> > -to <majordomo@vger.kernel.org>.
>> > -
>> > -Archive of this mailing list is available on https://lore.kernel.org/selinux/.
>> > -
>> > +SELinux is a flexible Mandatory Access Control (MAC) system built into the
>> > +Linux Kernel.  SELinux provides administrators with a comprehensive access
>>
>>                 ^^
>>
>> I was wondering, is the double whitespace intended? Is it something
>> related to typography?
>
> It was intentional, although the "correctness" is of some debate these
> days, or at least that is what I've read.
>
> Back when I was first learning to type the rule was two spaces after
> the end of a sentence, presumably to help make it easier to read,
> especially in print using older typefaces and machines.  I've read a
> few articles that now indicate this method of typing is somewhat "out
> of style" and in fact most (all?) HTML/MD renders don't render the
> double whitespace unless an explicit "&nbsp;" or similar token is
> used.  However, as I've been typing this way for many, many years,
> typing a double space after the period at the end of a sentence
> happens naturally ... good or bad :)
>
> Setting my typing habits aside, we *should* be consistent within the
> README.md file; if you would prefer me to respin the patch with a
> single space at the end of a sentence just let me know.  Otherwise
> please feel free to make whatever changes you feel are necessary.
>

Merged without two spaces.

Thanks!

