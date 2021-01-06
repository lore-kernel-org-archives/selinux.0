Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868AFC433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 16:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6882311E
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbhAFQk2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhAFQk2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 11:40:28 -0500
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D0BBC06134C
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 08:39:48 -0800 (PST)
Received: from brutus (brutus.defensec.nl [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 8A9E82A0D7E;
        Wed,  6 Jan 2021 17:39:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 8A9E82A0D7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1609951187;
        bh=fCpy8DYLVKwWHuXdc0uD1Kj+HoxOO3WoMK8uFet4lN0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V8sTVcndXoHohqMOg8fCEuJiEP5cedu57aQI/bCkscdARtF7NvY1alzbjoQwzwZ3R
         6vx9TbMjJH0dPO1KMsvj3nbBWiOE2XWXj4SAjPJS1ZBDrYXpBw0l2hSb+cVlu369+G
         NdpFpwevkOMUfL1G13+pU/x7rWPJvFOhac7IMyC8=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Selinux context type is same for root & normal user both
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
        <ypjlzh1o523g.fsf@defensec.nl>
        <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
        <ypjlv9cc50hj.fsf@defensec.nl>
        <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
        <ypjla6tmgoka.fsf@defensec.nl>
        <CAP2OjcjOEXsWM1H2pkMzhb3y2ss7SCTw8_1Tsb23kUnEDVfx-g@mail.gmail.com>
        <ypjl5z4agmt4.fsf@defensec.nl>
        <CAP2Ojci-JoSP_DtOecVNFi8AhTKTqKmpu+558Kzpucr8-z3nyg@mail.gmail.com>
        <ypjlsg7ef6nh.fsf@defensec.nl>
        <CAP2Ojcg5d=i0FKM0f1DTqtT2N3ftKEEqJq4=zdZr4m22xn4zjA@mail.gmail.com>
        <ypjlo8i2f519.fsf@defensec.nl>
        <CAFqZXNuUdij1v4yvSvpLJPi+0KSFSR46k+c52E3=QdF-f_C9yQ@mail.gmail.com>
        <CAP2Ojci+UGvCCr6XMHYvm6jCr4p9GmwM3j97ZFLoqB2prNH4gQ@mail.gmail.com>
Date:   Wed, 06 Jan 2021 17:39:43 +0100
In-Reply-To: <CAP2Ojci+UGvCCr6XMHYvm6jCr4p9GmwM3j97ZFLoqB2prNH4gQ@mail.gmail.com>
        (Ashish Mishra's message of "Wed, 6 Jan 2021 21:46:13 +0530")
Message-ID: <ypjlble2f29c.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ashish Mishra <ashishm@mvista.com> writes:

> Hi Dominick / Ondrej ,
>
> Thanks for valuable inputs , I will try to evaluate them .
>
> Ashish

We have a IRC channel on chat.freenode.net where we can have casual and
more interactive conversations if youre interested in that

https://freenode.net/kb/answer/chat

>
> On Wed, Jan 6, 2021 at 9:30 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>
>> On Wed, Jan 6, 2021 at 4:40 PM Dominick Grift
>> <dominick.grift@defensec.nl> wrote:
>> > Ashish Mishra <ashishm@mvista.com> writes:
>> >
>> > > Hi Dominick ,
>> > >
>> > > Will look at the re-labelling as you suggested.
>> > > Is there any doc / blog / implementation etc to understand the
>> > > sequence and commands to do this.
>> > > To understand this step in a better way.
>> > >
>> > > We are working with such a setup freshly so any inputs / guidance will
>> > > be helpful.
>> > >
>> > > Thanks for your time & inputs for this long thread .
>> >
>> > For docs i would suggest selinuxproject.org and
>> > https://github.com/SELinuxProject/selinux-notebook/blob/main/src/toc.md
>> >
>> > For implementations i would suggest looking at how OpenWrt implemented
>> > SELinux as this is a very simple implementation and the target seems to
>> > be relatively similar to yours with the exception that OpenWrt does not
>> > use a volatile root but instead uses a read-only squashfs and a overlay.
>> >
>> > You can also look at Fedora CoreOS for inspiration, and Googles SEAndroid.
>> >
>> > Implementing meaningful SELinux for exotic use cases like yours is not
>> > trivial though IMHO. Using reference policy as a base-policy might not
>> > be optimal for your use-case (to say the least) and it would probably be easier to create a
>> > policy from scratch instead in the longer run.
>>
>> Well said. I'll just add that you'll at the very least need to remove
>> the "genfscon" rule for "rootfs" from your policy and replace it with
>> an appropriate "fs_use_xattr" one to be able to relabel the root
>> filesystem. (Assuming it uses tmpfs under the hood (or supports
>> xattrs), otherwise you may need to mount tmpfs somewhere and chroot
>> into it at the beginning of your init script. Or something like
>> that...)
>>
>> --
>> Ondrej Mosnacek
>> Software Engineer, Platform Security - SELinux kernel
>> Red Hat, Inc.
>>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
