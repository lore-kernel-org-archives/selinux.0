Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E02C4361B
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B96422ADF
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 21:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgLGVcR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLGVcR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 16:32:17 -0500
X-Greylist: delayed 520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Dec 2020 13:31:37 PST
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14F11C061749
        for <selinux@vger.kernel.org>; Mon,  7 Dec 2020 13:31:37 -0800 (PST)
Received: from brutus (brutus.defensec.nl [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 8AEE12A0065;
        Mon,  7 Dec 2020 22:22:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 8AEE12A0065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1607376175;
        bh=vfrDMTJG1ipDj0UWJdQMzuFQebhP2vkBljtUwSr5J68=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JSWbPDsmALt0A9WMC1vfGcuncy6OnAYEyXAqbM65E/zbObT5yug5Gzn52U6toRW/6
         xC0WRLahpmvbe/isXzq3IFsEDWqx73hOaRFUqIWSs8Q2bEqldAvL9kKfuE+PUz5+Mo
         eT79LJ+d1jEeB+pbIp3NWwALEX5Qj33FCD247WC4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
        <CAHC9VhRCu5W4YOzcidUhv7biVc+a4QrRknVn-57YVSM3vWZH+Q@mail.gmail.com>
        <20201207205209.GD3107@redhat.com>
Date:   Mon, 07 Dec 2020 22:22:35 +0100
In-Reply-To: <20201207205209.GD3107@redhat.com> (Vivek Goyal's message of
        "Mon, 7 Dec 2020 15:52:09 -0500")
Message-ID: <ypjlczzlmhus.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, Dec 07, 2020 at 10:03:24AM -0500, Paul Moore wrote:
>> On Mon, Dec 7, 2020 at 9:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> >
>> > Hi everyone,
>> >
>> > In [1] we ran into a problem with the current handling of filesystem
>> > labeling rules. Basically, it is only possible to specify either
>> > genfscon or fs_use_xattr for a given filesystem, but in the case of
>> > virtiofs, certain mounts may support security xattrs, while other ones
>> > may not.
>> 
>
> [ cc virtio-fs list and miklos ]
>> Quickly skimming the linked GH issue, it appears that the problem
>> really lies in the fact that virtiofs allows one to enable/disable
>> xattrs at mount time.  What isn't clear to me is why one would need to
>> disable xattrs, can you explain that use case?  Why does enabling
>> xattrs in virtiofs cause problems?
>
> Its not exactly a mount time option. Its a virtiofs file server option.
>
> xattr support by default is disabled because it has performance
> penalty. Users can enable it if they want to.

if SELinux is enabled then you should preferably just use fs_use xattr unconditionally

>
> So if virtiofsd starts without xattr support and somebody runs a
> VM with SELinux enabled, they should still be able to mount virtiofs,
> I guess (instead of failing it).

SELinux requires that everything is always labeled one way or another
and so if SELinux is enabled one should either use genfscon or fs_use xattr

Since is support fs_use xattr that should be the default and if any
would for any reason want to replace that with genfscon then that is
something they have to address (by excluding the fs_use xattr rule and
replacing it with a genfscon rule (not sure why anyone would ever want
that)

Gist is that if SELinux is enabled then one of the two should be
present, preferably fs_use xattr (so thats the default).

>
> Thanks
> Vivek
>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
