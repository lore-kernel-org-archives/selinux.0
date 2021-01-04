Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597D3C43381
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 12:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263EB221E5
	for <selinux@archiver.kernel.org>; Mon,  4 Jan 2021 12:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhADMR0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADMR0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Jan 2021 07:17:26 -0500
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F24C061794
        for <selinux@vger.kernel.org>; Mon,  4 Jan 2021 04:16:45 -0800 (PST)
Received: from brutus (brutus.defensec.nl [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id D08062A12B1;
        Mon,  4 Jan 2021 13:16:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl D08062A12B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1609762603;
        bh=qp+qWxuqCCe5xTA1mx+DItWH5cEfFIJEdt+HZ02lRYA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AUyGvs6aW8I5Z2msuQXWzzQ+ZLeKgkgSZqrYv0o9rOc26hJFfJL5c3C/MATFLSjxH
         EnjXLzChn5mWe9AjikAYL18eekpWb81Va3AW9eJmeeDqiYCl9N3/UHZq370Wc+wj9x
         8lBc5UscC+y5ng4NZyvNToi/wNItmOz2NkjnC+vo=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Selinux context type is same for root & normal user both
References: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
Date:   Mon, 04 Jan 2021 13:16:35 +0100
In-Reply-To: <CAP2OjcjH0=HdTMr3eVkD-LkK++8XVDb05C+TtC9+1ii61kErzg@mail.gmail.com>
        (Ashish Mishra's message of "Mon, 4 Jan 2021 16:25:23 +0530")
Message-ID: <ypjlzh1o523g.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ashish Mishra <ashishm@mvista.com> writes:

> Hi Group members ,
>
> I am trying to get SELINUX being added in our custom BSP .
>
> I am able to reach till i have selinux-refpolicy installed on target &
> the getenforce / setenforce commands are working.
> I can verify them using log messages in /var/log/audit.log
>
> Below is the observation ( problem ) which i am observing w.r.t context type of
> selinux .
> a) File created as root has "system_u:object_r:root_t"

"root" is a hybrid user (system processes are often associated with
root identity as well a the root login user) When a system process
associated with "system_u" creates a "file" in a directory with type
root_t (and there is no type transition rule telling selinux to
transition to default_t) then the file ends up with
system_u:object_r:root_t"

if the file was created by a "real" login user, then the label of the
file indicates that the context associated with the root login user was
wrong because generally the root login user shouldnt be associated with
"system_u"

> b) File created as testuser also has "system_u:object_r:root_t"

provided that the "testuser" identity is not a identity for system
services, than this indicates that both the processes creating the file
as well as the target directory of the file are mislabeled.

ensure that your login users are associated with the expected contexts,
and also ensure that your filesystems are labeled according to the policy

>     but i was expecting something  "unconfined_u:object_r:user_home_t"
>
> Can members please provide any input as to what might be the cause of this
> or any pointers to debug the same.
>
> I am using TEMPFS as a file system .
>
> Thanks ,
> Ashish

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
