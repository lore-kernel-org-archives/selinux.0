Return-Path: <SRS0=EaKV=CR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F5EC433E2
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634B82080C
	for <selinux@archiver.kernel.org>; Tue,  8 Sep 2020 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="IXd1iYgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgIHSeZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbgIHScu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Sep 2020 14:32:50 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 169FFC06138E
        for <selinux@vger.kernel.org>; Tue,  8 Sep 2020 11:25:40 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 2036A2A0FFC;
        Tue,  8 Sep 2020 20:25:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 2036A2A0FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1599589531;
        bh=b7XEi3EyTauEFCTEPJnpmD1an//9uhVP1yd5+ZJ2ZG8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IXd1iYgGWzmPAgMl8fu3UHAkURjJUWUVTXO6RLl/lPRrtBI02p7C0TbhHzWcd1vSu
         BHBR9CsaKFY0Ea2F97nGl+UjaHFlYH38ISVgy/OEA/yqcdnG/y97MLcGIXGTBFHTfO
         t7HBcqdHsdpS+i+/o+e8GE9yARLVu8HfOp6gYOQE=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give an error when constraint expressions
 exceed max depth
References: <20200903181900.81179-1-jwcart2@gmail.com>
        <CAEjxPJ53Z6z2VAw75QOHZdK-kFz1fnkEFth7acyUGh_2nzpGkQ@mail.gmail.com>
        <CAEjxPJ6EXg5B8pjCxs2SdqBGe91u7PZnBPEphWgvvQ_u1mZtYA@mail.gmail.com>
        <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com>
Date:   Tue, 08 Sep 2020 20:25:27 +0200
In-Reply-To: <CAEjxPJ7fd62jYjhT18tNRhdMiRHt1Nt6QGexHDaDx4DcrBY42w@mail.gmail.com>
        (Stephen Smalley's message of "Tue, 8 Sep 2020 09:50:42 -0400")
Message-ID: <ypjlimconn1k.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Tue, Sep 8, 2020 at 9:46 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> On Fri, Sep 4, 2020 at 8:49 AM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>> >
>> > On Thu, Sep 3, 2020 at 2:19 PM James Carter <jwcart2@gmail.com> wrote:
>> > >
>> > > CIL was not correctly determining the depth of constraint expressions
>> > > which prevented it from giving an error when the max depth was exceeded.
>> > > This allowed invalid policy binaries with constraint expressions exceeding
>> > > the max depth to be created.
>> > >
>> > > Correctly calculate the depth of constraint expressions when building
>> > > the AST and give an error when the max depth is exceeded.
>> > >
>> > > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
>> > > Signed-off-by: James Carter <jwcart2@gmail.com>
>> >
>> > The fix for conditional boolean expression depth checking can be a
>> > separate patch.  For this one,
>> >
>> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>
>> Actually, this breaks selinux-testsuite. Will have to look into why.
>> /usr/sbin/semodule -i test_policy/test_policy.pp test_mlsconstrain.cil
>> test_overlay_defaultrange.cil test_add_levels.cil test_glblub.cil
>> Max depth of 4 exceeded for constraint expression
>> Bad expression tree for constraint
>> Bad constrain declaration at
>> /var/lib/selinux/targeted/tmp/modules/100/base/cil:919
>
> Here is the failing cil module:
> $ cat policy/test_mlsconstrain.cil
> (mlsconstrain (peer (recv)) (or (dom l1 l2) (and (neq t1
> mcs_constrained_type) (neq t2 mcs_constrained_type))))
> (mlsconstrain (packet (recv)) (or (dom l1 l2) (and (neq t1
> mcs_constrained_type) (neq t2 mcs_constrained_type))))
>
> Maybe an off-by-one in your depth checking?

That looks scary to me. Those constrains are simple compared to some of
the ones I currently successfully use and rely upon:

https://git.defensec.nl/?p=dssp3.git;a=blob;f=policy/constrain/rbacsep.cil;h=935c722167bcf214f286eb339e0793cd94d3edd0;hb=HEAD

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
