Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66A0C433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6EA2246B
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAFNxY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:53:24 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:59034 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbhAFNxX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Jan 2021 08:53:23 -0500
Received: from brutus (brutus.defensec.nl [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 739332A0D7E;
        Wed,  6 Jan 2021 14:52:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 739332A0D7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1609941161;
        bh=H4HqXeQrPilQge4z5bLl5dWA9Bk+WtLXUiAXyNqmpCk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=efUz6fPwgaScj3qo99beu0VDYvWaObp8L+/Lxx/90vY/0wcyCkYOigxlC8f3D6l+v
         uZRzaQmlxwcdK/dOqqDmR5xmfTlrTzU5NjLFJJMPnbvMUziFLOOTmJlLK4YZz5vFYX
         W0AUZSAczm64+sqK3ixW/OS8okY9XyaEL3JpENNA=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Selinux context type is same for root & normal user both
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
        <ypjlzh1o523g.fsf@defensec.nl>
        <CAP2Ojcg2+FbjEc0mDuE6uLKL45vtNmUnwQDMAoYp97ST67XL1g@mail.gmail.com>
        <ypjlv9cc50hj.fsf@defensec.nl>
        <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
Date:   Wed, 06 Jan 2021 14:52:37 +0100
In-Reply-To: <CAP2Ojch8tfxeYwep2LmouBF7RgUctfJ5Xh_MxvnKZ3fd82Bogw@mail.gmail.com>
        (Ashish Mishra's message of "Wed, 6 Jan 2021 19:05:53 +0530")
Message-ID: <ypjla6tmgoka.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ashish Mishra <ashishm@mvista.com> writes:

> Hi Dominick ,
>
> Thanks for the inputs above.
>
> 1) w.r.t Monolithic , i am trying refpolicy with monolithic design as suggested.
>
> 2) I am debugging on the lines you suggested , and prima facie looks like the
>     busybox login is being executed here which takes
> system_u:object_r:root_t as context

I do not understand what you mean by that. Context
"system_u:object_r:root_t" is a "file" context and I do not understand
where you get that from.

Busybox is a shell with built-in modules AFAIK. It should be labeled
"u:object_r:shell_exec_t" IMHO

>
> 3) Can you please let me know which stable source code for
>     a) policycoreutils-python    ( to get semanage on target )
>     b) setools-console              ( to get seinfo / sesearch on target )
>     Please note that we have integrated userland libraries and tools
> projects from https://github.com/SELinuxProject/selinux
>     But the above mentioned binaries are not present on target.

https://github.com/SELinuxProject/selinux/releases/download/20200710/selinux-python-3.1.tar.gz
https://github.com/SELinuxProject/setools/releases/download/4.3.0/setools-4.3.0.tar.bz2

>
> Request to please let me know input / feedback if i am missing any
> obvious things here

Its hard to say. There are quite a few variables and I am not sure
exactly what the current state of your work is and where you want to go
(ie what your goals and requirements are)

I guess you should determine what the login programs used are and then
to address those to ensure that login user shells are labeled the way
you want them labeled.

It is probably best to enclose avc denials for any challenge you face.


>
> Thanks ,
> Ashish
>
>
>
>
>
>
>
> On Mon, Jan 4, 2021 at 6:21 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Ashish Mishra <ashishm@mvista.com> writes:
>>
>> > Hi Dominick ,
>> >
>> > Thanks for inputs .
>> >
>> > a) This is an embedded board which logs in by default as a ROOT user.
>> >      Any pointers as to where can i look to debug the cause due to
>> > which context is "system_u"
>>
>> Lack of PAM support or misconfigurated PAM config (pam_selinux needs to
>> be present in the appropriate PAM stacks)
>>
>> >
>> > b) Apologies , but can you please help method / approach / debug
>> > points by which
>> >     -> I can evaluate the expected contexts for root & testuser
>> >     -> I can see that the labels are created using ls -alZ .
>> >         Is there any other method / debug point to check filesystems
>> > are labeled according to the policy.
>> >         ( as i am using standard refpolicy to create an default policy
>> > on board )
>>
>> You start by determining the current context of the login user (id -Z
>> will print the context of the current shell). Then you determine the
>> context of the directory in which the file is created (ls -dZ)
>>
>> With this information you can query:
>>
>> sesearch -T -s "type returned by id -Z" | grep "type returned by ls -dZ"
>>
>> That should return any existing "type_transition" rules where the type
>> of the user is the source and the type of the destination directory is a target
>>
>> >
>> >
>> > Thanks ,
>> > Ashish
>>
>> The question is whether you want/need IBAC/RBAC on an embedded device
>> with only one user (root)
>>
>> In my policy for OpenWrt (which is a embedded wireless router firmare) i
>> do not use IBAC/RBAC either and i just add a rule that say's when the
>> login program (sshd) executes a shell then assume that this is a login
>> user shell and automatically transition from the sshd context to a specified
>> user context)
>>
>> On embedded devices "modular reference policy" does not make sense to
>> use (these devices generally do not have the resources to compile/link
>> policy at runtime) IMHO and the "monolithic reference policy" does not work well with
>> PAM and users.
>>
>> But, yes, if you want modular refpolicy on a multi-user system then you
>> probably want PAM
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl
>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
>> Dominick Grift

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
