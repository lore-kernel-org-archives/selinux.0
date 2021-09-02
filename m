Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB05C432BE
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8917610A4
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 09:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245623AbhIBJ3Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245653AbhIBJ3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Sep 2021 05:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630574902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/6D3vvdPnguDZcVYu8sl5ReQ44TE/0ywRmU4RcPzHI=;
        b=N24jvStBAywHU8HVVI1nZVsNianSHc95HXrGqwrv5k9eGKQ1QMgOVHIVW7IS3hjgU9ZdpP
        GeMyllyAzCrZtotw11LF22/n1ioXaalRTnmBdsmN46usmKDLYZFEuZGnRpmJSIrI+ZwuyG
        L5k9GiZp3iUFmwucgHDuw0Ast3aKFWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-o-crlq8YNmqpvJl5P_hHgQ-1; Thu, 02 Sep 2021 05:28:21 -0400
X-MC-Unique: o-crlq8YNmqpvJl5P_hHgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A70E3801ADA;
        Thu,  2 Sep 2021 09:28:20 +0000 (UTC)
Received: from localhost (unknown [10.40.193.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 432A45D9C6;
        Thu,  2 Sep 2021 09:28:20 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: libselinux issue
In-Reply-To: <CAJ2a_Dc+YG0v3tMzXKYoFNfQykHwnhr9yE9+MxfAE1JTQSQ=Mw@mail.gmail.com>
References: <87czpthm7x.fsf@defensec.nl> <878s0hhlwp.fsf@defensec.nl>
 <CAJ2a_Dc+YG0v3tMzXKYoFNfQykHwnhr9yE9+MxfAE1JTQSQ=Mw@mail.gmail.com>
Date:   Thu, 02 Sep 2021 11:28:19 +0200
Message-ID: <87lf4fcong.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> On Tue, 31 Aug 2021 at 13:51, Dominick Grift <dominick.grift@defensec.nl>=
 wrote:
>>
>> Dominick Grift <dominick.grift@defensec.nl> writes:
>>
>> > We can get into a state where selinux is enabled without a policy.
>>
>
> While testing a potential fix several questions came up:
>
> I. What are the expected/desired outcomes after the following
> configuration setups:
>
>     * invalid SELINUX=3D, valid SELINUXTYPE=3D  (currently permissive,
> except cmdline contains `enforcing=3D1` then system halt)

Unspecified or invalid SELINUX defaults to enforce =3D 0. I guess it could
help administrators during initial selinux setup - the system would boot
even with a typo.

`enforcing=3D1` on the kernel command line overrides value set
in config file (in this case it is not set). If SELINUXTYPE is valid,
the policy is loaded and systemd boots. If it's invalid, the systemd
freeze, see bellow.



>     * valid SELINUX=3D, invalid SELINUXTYPE=3D  (currently disabled if
> SELINUX=3Ddisabled, system halt if SELINUX=3Denforcing or `enforcing=3D1`,
> else zombie state)

If systemd can't load policy it logs the problem and freeze in
enforcing. The result of selinux_init_load_policy is ignored in
permissive and systemd continue with boot, see bellow.

                if (enforce > 0) {
                        if (!initialized)
                                return log_emergency_errno(SYNTHETIC_ERRNO(=
EIO),
                                                           "Failed to load =
SELinux policy.");

                        log_warning("Failed to load new SELinux policy. Con=
tinuing with old policy.");
                } else
                        log_debug("Unable to load SELinux policy. Ignoring.=
");
        }



>
> II. When does the kernel considers SELinux to be *enabled*? After the
> mount of a selinuxfs or after the first policy load?

My understanding is that internally in kernel is SELinux enabled during
build process and it considers SELinux to be enabled unless selinux=3D0 is
used on kernel command line.

For userspace it's propagated as availability of /sys/fs/selinux.


>     With SELinux being unable to disable at runtime in the near future
> and SELinux being initialized after a selinuxfs mounting, that
> probably needs selinux_init_load_policy(3) to check for a valid
> SELINUXTYPE=3D before mounting a selinuxfs.

AFAIK whether /sys/fs/selinux is mounted or not doesn't say anything
about status of SELinux inside kernel. It's just used as simple
indicator for userspace whether it can use SELinux API or not.


> Also selinux_init_load_policy(3) libselinux should probably reset its
> state via `umount(selinux_mnt); fini_selinuxmnt();` after a
> selinux_mkload_policy(3) failure.

