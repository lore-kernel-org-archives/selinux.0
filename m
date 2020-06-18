Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F75C433DF
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8034F20739
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 14:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="GTBUgEM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgFRONh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:13:37 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:33604 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgFRONf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 18 Jun 2020 10:13:35 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 8F0092A0FFA;
        Thu, 18 Jun 2020 16:13:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 8F0092A0FFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1592489612;
        bh=AsrVuYvGEHIfEfOnYLLbBwP54KUaIVR8O4uJdIeC8Aw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GTBUgEM4HjoG2BYMLI7k5OkOGX6FhR8hYHSfgvmKNFms0AAJJARM6dncZnl1ePBtO
         J3ao+b7DfPobN0bF9zNWHIegwsuXxxF8gcA2gPTP4Vua6a+IPeQtRWwfMFYwG4QSxB
         7Ch/96h42g/G5T3GM0USarCDQVrNwqt8fr6rTLvQ=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        bauen1 <j2468h@googlemail.com>
Subject: Re: [PATCH] selinux: log error messages on required process class / permissions
References: <20200617192309.69595-1-stephen.smalley.work@gmail.com>
        <CAEjxPJ6EHbCh+S1D8dm61Mw7YkMDHELNHVwKEtinNciaoTzYoQ@mail.gmail.com>
Date:   Thu, 18 Jun 2020 16:13:25 +0200
In-Reply-To: <CAEjxPJ6EHbCh+S1D8dm61Mw7YkMDHELNHVwKEtinNciaoTzYoQ@mail.gmail.com>
        (Stephen Smalley's message of "Thu, 18 Jun 2020 10:03:10 -0400")
Message-ID: <ypjlo8pgo41m.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Jun 17, 2020 at 3:23 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>>
>> In general SELinux no longer treats undefined object classes or permissions
>> in the policy as a fatal error, instead handling them in accordance with
>> handle_unknown. However, the process class and process transition and
>> dyntransition permissions are still required to be defined due to
>> dependencies on these definitions for default labeling behaviors,
>> role and range transitions in older policy versions that lack an explicit
>> class field, and role allow checking.  Log error messages in these cases
>> since otherwise the policy load will fail silently with no indication
>> to the user as to the underlying cause.  While here, fix the checking for
>> process transition / dyntransition so that omitting either permission is
>> handled as an error; both are needed in order to ensure that role allow
>> checking is consistently applied.
>>
>> Reported-by: bauen1 <j2468h@googlemail.com>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> BTW I considered and even put together an initial patch to instead
> make the process class and transition permissions optional but thought
> it was unnecessary complexity for no real gain.  One would end up with
> a system where new processes would be treated like objects for
> labeling (e.g. object_r for the role, inherit type from related object
> in this case the executable file) and role allow rules would be
> unenforceable.  I suppose we could change the test of the process
> class to be based on the kernel value rather than the policy value,
> which would at least provide sane defaults for labeling.

Everything considering I think this is a good compromise (at least for
now). secilc requires a class to compile so in practice your initial
policy will have atleast one class, might as well be process.

Atleast this will give you enough information to get started.

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
