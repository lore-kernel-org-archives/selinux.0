Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B24CC433EB
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 07:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E5E20663
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 07:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="q5KGV8q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgGOH4m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgGOH4m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 03:56:42 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCA3AC061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 00:56:41 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 112622A100B;
        Wed, 15 Jul 2020 09:56:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 112622A100B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1594799799;
        bh=IdFM0PZMSXALHD2AdW25qRRs7TpkrpX+4hn+DFLcq80=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=q5KGV8q8sxXs5CwySvxSxJK7hEy6zN0JTKifwDd5ItHDWrqxR8sKtMN/7iNIlZMA9
         9zafeGjZxFW3a5A5vhMtNpbHgYfHaGclxiB+IjrkgWLQPAkh/rnju6FNHtzQNS6a8R
         9FG7WA4FBWOTXHcch/OpZ3ZWbPhD5zNMuhgNHIQk=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [SELinux-notebook PATCH v2] objects.md: some clarifications
References: <20200710070903.106482-1-dominick.grift@defensec.nl>
        <20200710071431.107444-1-dominick.grift@defensec.nl>
        <CAHC9VhRNWLQAVzOnei5Hne8k7nXQkoQkY7txBov_rNMhKHNCFw@mail.gmail.com>
Date:   Wed, 15 Jul 2020 09:56:32 +0200
In-Reply-To: <CAHC9VhRNWLQAVzOnei5Hne8k7nXQkoQkY7txBov_rNMhKHNCFw@mail.gmail.com>
        (Paul Moore's message of "Tue, 14 Jul 2020 22:15:17 -0400")
Message-ID: <ypjlsgdtfbyn.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Fri, Jul 10, 2020 at 3:14 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> v2: fixes patch description
>> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Thanks for the patch, but just like any other project, it would be
> nice to see a patch description here.  You can also move the changelog
> portion of the patch below a "--" delimiter so it doesn't get caught
> up in the main description (changelogs aren't quite as useful once the
> patch has been committed to the tree).

Thanks. I will redo it

>
>> ---
>>  src/objects.md | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> ...
>
>> @@ -269,6 +275,20 @@ and manage their transition:
>>
>>  `type_transition`, `role_transition` and `range_transition`
>>
>> +SELinux-aware applications can enforce a new label (with the policies
>
> As someone who is barely fluent in one language I hate to criticize
> others when they are writing in their non-native language, but I think
> this should be "policy's" not "policies".

I appreciate these corrections and will apply that with a v3

>
>> +approval of course) using the **libselinux** API functions. The
>> +`process setexec`, `process setkeycreate` and `process setsockcreate`
>> +access vectors can be used to allow subjects to label processes,
>> +kernel keyrings, and sockets programmatically using the
>> +***setexec**(3)*, ***setkeycreatecon**(3)* and
>> +***setsockcreatecon**(3)* functions respectively, overriding
>> +transition statements.
>> +
>> +The `kernel` and `unlabeled` **initial security identifiers** are used
>> +to associate specified labels with subjects that were left unlabeled
>> +due to initialization or with subjects that had their label
>> +invalidated due to policy changes at runtime respectively.
>
> That looks like a good definition for "unlabeled", but it doesn't look
> like you've defined the "kernel" isid?

I did (note the "respectively") but maybe I wrote it down in a less than optimal way?:

kernel: "are used to associate specified labels with subjects that were
left unlabeled due to initialization"

unlabeled: "(are used to associate specified labels) with subjects that
had their label invalidated due to policy changes at runtime"

>
>>  ### Object Reuse
>>
>>  As GNU / Linux runs it creates instances of objects and manages the
>> --
>> 2.27.0

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
