Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9882DC4338F
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 15:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723D460EEA
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 15:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhHEPIb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhHEPI3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 11:08:29 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 987FAC0617B9
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 08:08:14 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6EABC2A006A;
        Thu,  5 Aug 2021 17:08:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6EABC2A006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1628176092;
        bh=8bOwT+wldDmftBlkmNQ1BNyHbklRVmmp1nzcIr/I8BQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MwymS2/icwys4V5cuS3apw6fps6YL1VA0TPJyJbE/tweNNCpyCkWjZyMAYsWEJefs
         IAXRl8ZhVhshllsut4WgdPoSO6T4xUcuCst9fj8li/X4NN9/XHa5xZAG/cEbeq2hnt
         cnLRw9wp74ytN8zjPwfImlpW6bDmPfXcwjGxjMCw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH SYSTEMD 0/7] Re-add SELinux checks for unit install
 operations
References: <20210805142445.61725-1-cgzones@googlemail.com>
Date:   Thu, 05 Aug 2021 17:08:09 +0200
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com> ("Christian
        =?utf-8?Q?G=C3=B6ttsche=22's?= message of "Thu, 5 Aug 2021 16:24:38 +0200")
Message-ID: <87zgtw53qe.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> The checks (permission verbs) in question are enable for the operations
> enable, reenable, link and unmask and disable for the operations disable
> and mask; those SELinux permissions exist in the the reference and fedora
> SELinux policy.
> These checks were dropped with v225 (see [1]) due to incomplete and
> missing infrastructure in the unit handling code.
>
> In addition the operations preset and revert are checked with the (also
> already existing) SELinux permission reload.
> (In the future I'd like to separate them into a new permission modify?
> together with calls to the standard D-Bus interfaces at
> org.freedesktop.DBus.Properties.Set.)

Please consider that any policy leveraging these permissions would
potentially have to deal with compatibility. We don't want to be forced
into a situation similiar to that situation we were led in when systemd
permissions were associated with the system Linux object class.

Also it distracts from the main topic which is to re-do properly
what was reverted earlier.

If at all possible then please address any "additions" such as preset
and revert elsewhere.

Thanks for picking this up again.

>
> Job actions JOB_RELOAD_OR_START and JOB_VERIFY_ACTIVE are now checked with
> the permission start instead of reload.
>
> The D-Bus filter now falls back to an instance check in case no unit can
> be decoded (e.g. the job has finished or the unit does not exist).
>
> Reduced proposal of [2]/[3]
> Closes: [4]
>
> [1]: https://github.com/systemd/systemd/pull/1044
> [2]: https://github.com/systemd/systemd/pull/10023
> [3]: https://lore.kernel.org/selinux/20191218142808.30433-1-cgzones@googl=
email.com/
> [4]: https://github.com/systemd/systemd/issues/1050
>
> Christian G=C3=B6ttsche (7):
>   selinux: add function name to audit data
>   selinux: improve debug log format
>   selinux: mark _mac_selinux_generic_access_check with leading
>     underscore
>   core: add support for MAC checks on unit install operations
>   core: implement the sd-bus generic callback for SELinux
>   core: avoid bypasses in D-BUS SELinux filter
>   core: tweak job_type_to_access_method SELinux permissions
>
>  src/core/dbus-callbackdata.h             |  15 +++
>  src/core/dbus-manager.c                  |  70 +++++++---
>  src/core/dbus.c                          |  44 +++----
>  src/core/job.c                           |  14 +-
>  src/core/manager.c                       |   9 +-
>  src/core/manager.h                       |   1 +
>  src/core/selinux-access.c                |  75 +++++++++--
>  src/core/selinux-access.h                |  17 ++-
>  src/shared/install.c                     | 160 ++++++++++++++++++++---
>  src/shared/install.h                     |  44 +++++--
>  src/systemctl/systemctl-add-dependency.c |   2 +-
>  src/systemctl/systemctl-enable.c         |  16 +--
>  src/systemctl/systemctl-is-enabled.c     |   2 +-
>  src/systemctl/systemctl-preset-all.c     |   2 +-
>  src/test/test-install-root.c             |  88 ++++++-------
>  src/test/test-install.c                  |  38 +++---
>  16 files changed, 437 insertions(+), 160 deletions(-)
>  create mode 100644 src/core/dbus-callbackdata.h
>
> --
> 2.32.0
>

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift
