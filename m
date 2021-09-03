Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFEDC433F5
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 14:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286C661058
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 14:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhICOOD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhICON7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 10:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630678378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o+BZxvzYzDFyWC9HT8VAuZGIM2jsyzFquJGrAUtKbmU=;
        b=Z0gwMVDhTnu3xvPLuuOXt05otnPq12wdqGXMhvssRqQe8SuLqLXCVEDlUw7Q0UpNmlMKTp
        iBsj+MkpdiCQlKMqIrtjifv+5eqRFAHs15NEyEfbNulbwG0oifgvYFzGRCIwSXRbVL/lio
        tMYjocbZRGZN1FmtSUNWAwR9YU5IYZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-zHHDbjNdOPCX9astg4GlJg-1; Fri, 03 Sep 2021 10:12:57 -0400
X-MC-Unique: zHHDbjNdOPCX9astg4GlJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2FC4189C457;
        Fri,  3 Sep 2021 14:12:56 +0000 (UTC)
Received: from localhost (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D86A2657E;
        Fri,  3 Sep 2021 14:12:55 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     James Carter <jwcart2@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Subject: Re: lets think about 3.3 release
In-Reply-To: <CAP+JOzSmoDp_9XhoXXghu9HL=H3iXPFWAVkN_AnDxbhdDRRF2g@mail.gmail.com>
References: <87fsvmu2xa.fsf@redhat.com> <87zgsu9j9c.fsf@redhat.com>
 <87pmtq8374.fsf@defensec.nl>
 <CAP+JOzSmoDp_9XhoXXghu9HL=H3iXPFWAVkN_AnDxbhdDRRF2g@mail.gmail.com>
Date:   Fri, 03 Sep 2021 16:12:54 +0200
Message-ID: <87v93hagt5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Sep 3, 2021 at 4:38 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Petr Lautrbach <plautrba@redhat.com> writes:
>>
>> > Petr Lautrbach <plautrba@redhat.com> writes:
>> >
>> >> Hello,
>> >>
>> >> I's about 184 commits and 5 months since the last release so I think
>> >> it's time to slowly stop the development and start with 3.3 release
>> >> candidates.
>> >
>> >
>> > Currently patchwork contains just these patches which should be relevant
>> > to 3.3:
>> >
>> > https://patchwork.kernel.org/patch/12435365/ New [1/2] libsepol/cil:
>> > Improve in-statement to allow use after inheritance
>> > https://patchwork.kernel.org/patch/12435363/ New [2/2] libsepol/secilc/docs: Update the CIL documentation
>>
>> Strictly speaking these can probably wait until after 3.3 although it would
>> be nice to get this in.
>>
>> Maybe eventually some day in the distant future we can re-consider
>> disallowing duplicate macro and block declarations in favor of this functionality.
>>
>> >
>> > These are probably superseeded already, but I'm not sure. Please take a look.
>> >
>
> They are waiting for the three patches below, so they can all be
> merged together.
>
>> >
>> > https://patchwork.kernel.org/patch/12470297/ New [1/3,v2] libsepol/cil: Remove redundant syntax checking
>> > https://patchwork.kernel.org/patch/12470301/ New [2/3,v2]
>> > libsepol/cil: Use size_t for len in __cil_verify_syntax()
>> > https://patchwork.kernel.org/patch/12470299/ New [3/3,v2]
>> > libsepol/cil: Fix syntax checking in __cil_verify_syntax()
>> >
>> > Wait for review.
>> >
>
> The only changes are what Nicolas suggested when he reviewed them, so
> I don't think it will be too long before these will be merged. I don't
> have anything else other than these.
>

Great, thanks!

Petr



>
>
>
>> > So I think selinux-3.3-rc1 can be released on next Wednesday 2021-09-08
>> >
>> > If you have any concerns, comments or suggestion, let us know.
>> >
>> > Also I really don't understand all the changes in libsepol so please help me
>> > to collect release notes information for it. I'll post a release notes
>> > draft with other components later today.
>> >
>> >
>> > Thanks,
>> >
>> > Petr
>> >
>> >
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl
>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
>> Dominick Grift

