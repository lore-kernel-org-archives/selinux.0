Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5314DC27C76
	for <selinux@archiver.kernel.org>; Wed, 25 Jan 2023 13:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjAYNhY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Jan 2023 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYNhY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Jan 2023 08:37:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3161158961
        for <selinux@vger.kernel.org>; Wed, 25 Jan 2023 05:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674653794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SMWujLw2YmWYrrRYVnPdJAQjR3j9bJSwyz9mYmrTn4s=;
        b=adRcd/f4fPosLFBmnYxmximBYmD70XY7J4r6q4uEAd68clBTcMdMIZWfJ5US9P5mn6Ryr3
        lhn04SgHKVUZ0JrrQs9Idp2RT3occ/4qdFagY0XZoRh8wx0m6OCrX7Wjh0/5SIKMwqT62V
        I6osdl1jkyVqEyLOpc/yL2t7XFpSDjg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-338-5gjJSdxBPz2Zn6d3K2StiQ-1; Wed, 25 Jan 2023 08:36:33 -0500
X-MC-Unique: 5gjJSdxBPz2Zn6d3K2StiQ-1
Received: by mail-pl1-f197.google.com with SMTP id y9-20020a1709027c8900b00195e237dc8bso8797581pll.13
        for <selinux@vger.kernel.org>; Wed, 25 Jan 2023 05:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SMWujLw2YmWYrrRYVnPdJAQjR3j9bJSwyz9mYmrTn4s=;
        b=L+qNWXb0ozYpv57a3XWczssbxyVEYNUR0MEYcUwtgKrSd+IZ7bwUCo9nSPtoFzPmIQ
         R4Gi7c+FDHqd//G09sRJXrjNSnzsJmzoS5dxOLDrr3PSzHoytAVEBWR3Spw/kAUSF6Rj
         /N7GDIFtOEdJkaB0qf66XpKxLZJh3FlxPAfdaEanM3RckvVsIq2UKMH8NormsgmQ1jiI
         cQ8JlNRX3W3273CMd7+NBgSsIxleil8U0OF0QMX6/UZk/SCNZAyiBBL/f1MkKriBEPut
         i3BBqXSIECAEFbZ7ubZ1hznQEIV8SnLKv6UNMR09Ov9hTRTAG1m+vcquvUZQ8OBLBmBf
         MSjA==
X-Gm-Message-State: AFqh2krtshXz6xHq+QjrAy4sYODVQjqsKUHFgL40f8mKj4AYFu6HW3js
        H73dx0LLZXArm/uIM9TYOZVRjQZvgbHkoVAR3HuYOq836qQTUznvyRXxWJfyD107XJJUv8cJaFd
        ebWvH7P3BdIgW5m99miyEZ3SxjNEjUhMyig==
X-Received: by 2002:a17:90a:1c81:b0:229:f07b:7ae with SMTP id t1-20020a17090a1c8100b00229f07b07aemr3940784pjt.239.1674653792084;
        Wed, 25 Jan 2023 05:36:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvPB0qo+S3olgSWUuD9DEuRHdXWA6n+jp1HUmEPNwMgCy5qfKTkXLJkei+VJ2bZnpBd6LsAOP/WsaOAh6b8JD4=
X-Received: by 2002:a17:90a:1c81:b0:229:f07b:7ae with SMTP id
 t1-20020a17090a1c8100b00229f07b07aemr3940778pjt.239.1674653791748; Wed, 25
 Jan 2023 05:36:31 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS1tSbP8s4QzVPB42O6_3wGX47=9HXBSyqwnHrW47965w@mail.gmail.com>
 <CAFqZXNvAsNBjACaoaH48wDEgKV-aKM1G9dwuozfhYvYmwCNcyQ@mail.gmail.com> <CAEjxPJ5VV3nXSW+AtiXkbUbJJUhsz0hFQz++aqP=LK1PicQq4Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5VV3nXSW+AtiXkbUbJJUhsz0hFQz++aqP=LK1PicQq4Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 25 Jan 2023 14:36:20 +0100
Message-ID: <CAFqZXNtgOq8Bk_w7hBp0KrSb5FSzOnLebHTVCXNRH4WMnh_LgA@mail.gmail.com>
Subject: Re: selinux-testsuite broken pipe noise
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 25, 2023 at 12:50 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jan 25, 2023, 4:29 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>
>> On Tue, Jan 24, 2023 at 8:39 PM Paul Moore <paul@paul-moore.com> wrote:
>> > When running the selinux-testsuite manually today I noticed the
>> > following noise in the filesystem tests:
>> >
>> > % make test
>> > ...
>> > chmod +x */test
>> > chcon -R -t test_file_t .
>> > Running as user root with context unconfined_u:unconfined_r:unconfined_t
>> >
>> > domain_trans/test ........... ok
>> > entrypoint/test ............. ok
>> > ...
>> > perf_event/test ............. ok
>> > filesystem/ext4/test ........ 1/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 14/76 yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 20/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 22/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 24/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 30/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 34/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 40/76 yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 43/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 49/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 55/76 yes: standard output: Broken pipe
>> > yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ 64/76 yes: standard output: Broken pipe
>> > filesystem/ext4/test ........ ok
>> >
>> > The test system was an updated Rawhide system with the following details:
>> >
>> > % uname -r
>> > 6.2.0-0.rc5.20230123git2475bf02.38.1.secnext.fc38.x86_64
>> > % rpm -q selinux-policy
>> > selinux-policy-38.5-1.fc38.noarch
>> >
>> > ... and my selinux-testsuite build should be current:
>> >
>> > % git log --oneline | head -n 1
>> > 2cc067f ci: limit VM reboot time to 5 minutes
>>
>> Yep, some change in Rawhide seems to have triggered this... The most
>> straightforward solution seems to be to just silence the errors. As it
>> is a trivial change, I have pushed it to the master branch:
>>
>> https://github.com/SELinuxProject/selinux-testsuite/commit/909f3aea627300a7e5ad2bc724d12c3560d34515
>
>
> Are there any new denials audited, possibly requiring semodule -DB to make visible? Wondering if we are denying access to the inherited pipe fd and closing it? Denial would be on fd use or fifo file read/write.

I did check now and there were no such denials. Most likely this has
nothing to do with SELinux and it's just mkfs closing stdin before it
exits or something like that.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

