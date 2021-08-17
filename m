Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395B1C4338F
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 18:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213FB60F22
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 18:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhHQSpb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Aug 2021 14:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233187AbhHQSp3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Aug 2021 14:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629225896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=auhtyRdIsQsxVJf4Cbzc1RqurTkREX8CRqhC1P8hzbg=;
        b=fXbEMrAR83mZM5/StS/YDriJgTlEmXJ3WDwA8VQgr88+YjfBMoGcZh8qoBOv7rPHr1GUG7
        Io5YfWUFR4xJYVckh8WOS4NYTcmb47pi6Ahc3dUtp1sD/Hyas1Em2SNwdCysPHUvm3DWwi
        /KN4F92Sy/JEuKEf2kkL04Jt8PGe1bA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-PCiNuQWMNGKCZlm_AdTiJw-1; Tue, 17 Aug 2021 14:44:54 -0400
X-MC-Unique: PCiNuQWMNGKCZlm_AdTiJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25EE7107ACF5;
        Tue, 17 Aug 2021 18:44:53 +0000 (UTC)
Received: from localhost (unknown [10.40.195.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32DEE5DA60;
        Tue, 17 Aug 2021 18:44:51 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Dominick Grift <dominick.grift@defensec.nl>,
        James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: lets think about 3.3 release
In-Reply-To: <CAJfZ7=naeBBmUiS3YgcW+AttSzx-tDt56ShMJq56NKPqC_yKhA@mail.gmail.com>
References: <87fsvmu2xa.fsf@redhat.com>
 <CAP+JOzRb0vE94arDdF6SxB3Mn-82+ztRi0OjyGRzqjAd3=ck_A@mail.gmail.com>
 <87tujy4r1g.fsf@defensec.nl>
 <CAJfZ7=naeBBmUiS3YgcW+AttSzx-tDt56ShMJq56NKPqC_yKhA@mail.gmail.com>
Date:   Tue, 17 Aug 2021 20:44:51 +0200
Message-ID: <87czqbkj18.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Mon, Aug 9, 2021 at 4:44 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> James Carter <jwcart2@gmail.com> writes:
>>
>> > On Fri, Aug 6, 2021 at 2:29 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>> >>
>> >> Hello,
>> >>
>> >> I's about 184 commits and 5 months since the last release so I think
>> >> it's time to slowly stop the development and start with 3.3 release
>> >> candidates.
>> >>
>> >> According to patchwork, there are few patches in queue which need to be
>> >> reviewed, or which were reviewed and some change for requested:
>> >>
>> >> * https://patchwork.kernel.org/patch/11436955/ New [RFC]
>> >> libsepol,secilc,policycoreutils: add unprivileged sandboxing
>> >> capability
>> >> * https://patchwork.kernel.org/patch/11668455/ New selinux: make use of variables when defining libdir and includedir
>> >>
>> >> old, without any activity for a long time
>> >>
>> >> * https://patchwork.kernel.org/patch/12291637/ New [v2] checkpolicy: fix the leak memory when uses xperms
>> >>
>> >> changes requested
>> >>
>> >> * https://patchwork.kernel.org/patch/12372487/ New [v2] libselinux: add lock callbacks
>> >> * https://patchwork.kernel.org/patch/12377593/ New libselinux/utils: drop requirement to combine compiling and linking
>> >>
>> >> no response yet
>> >>
>> >> * https://patchwork.kernel.org/patch/12420657/ New [userspace]  libsepol/cil: remove obsolete comment
>> >>
>> >> acked, ready to be merged
>> >>
>> >> * https://patchwork.kernel.org/patch/12422971/ New mcstrans: Improve mlstrans-test output
>> >>
>> >> no response yet
>> >>
>> >>
>> >> if I missed something please tell me.
>> >>
>> >>
>> >> There's one issue opened on the mailing list
>> >>
>> >> https://lore.kernel.org/selinux/874kc57220.fsf@defensec.nl/T/#t -
>> >> libsepol regressions
>> >>
>> >
>> > I am working to address this and hope to have something out in the
>> > next couple of days. I am also working on fixing some issues with the
>> > line mark stuff in CIL. It would be nice to have both of these in the
>> > next release, but I don't think they need to hold things up either.
>> > Jim
>>
>> It's too soon for me to start worrying about this but:
>>
>> I don't care if my dssp5 policy breaks due to this regression (that is
>> what it is) because other than me no one probably uses it, but I also
>> maintain a policy for OpenWrt which relies on this functionality (or
>> allowing duplicate blocks, macros) and I would not want to have this
>> break there come 3.3.
>>
>> >
>> >> If you agree and there's no obejction I can start with preparation and
>> >> plan to release 3.3-rc1 on Wed Aug 18 2021
>
> Hello,
> For information I am currently on holidays with quite limited access
> to my mails and will be fully "back with my test machines" on
> 2021-08-30. In the meantime I can participate in some reviews but I am
> not willing to send patches myself. Nevertheless I will try to review
> the "libsepol/cil: move the fuzz target and build script to the
> selinux repository" patch properly before Wednesday.
>
> For the release, I am currently aware of two possibly-minor issues and
> I do not know whether they are tracked somewhere:
>
> 1. secil2tree can output wrongly indented blocks. For example
> "secil2tree -A resolve secilc/test/policy.cil" currently outputs:
>
> (block test_ba
>     (blockinherit ba)
>         (roletype test_ba.r test_ba.t)
>         (blockabstract z.ba)
>     )
>     (role test_ba.r)
>     (type test_ba.t)
> )
>
> The parenthesizing "(blockinherit ba) ... )" is wrong. The
> "(blockinherit ba)" could be replaced with a comment indicating that a
> blockinherit was expanded.
>
> 2. semanage's gettext setup is currently incompatible with Python
> 3.10. More precisely
> https://docs.python.org/3.8/library/gettext.html#gettext.install
> indicates: "Deprecated since version 3.8, will be removed in version
> 3.10: The codeset parameter.". When I stumbled upon this issue, it
> occured to me that the whole try-except statement in
> https://github.com/SELinuxProject/selinux/blob/libsemanage-3.2/python/semanage/semanage#L34-L49
> could be replaced with "import gettext" (which is a built-in module in
> Python 3) and "gettext.install(PROGNAME,
> localedir="/usr/share/locale")". Nevertheless I did not find time to
> properly test this change, which is why I have not sent patches for it
> sooner.
>
> In my opinion, the first issue is not a release-blocker because
> "secil2tree -A resolve" is not expected to output a CIL policy which
> can be compiled. The second one could be, if we want to support Python
> 3.10 (which will be released in October) with the 3.3 release.
>

Thanks everybody.

Based on the input, I will not prepare rc1 tomorrow. And I'll be offline
next week so lets postpone rc1 to Wed Sep 08 2021.

Petr


