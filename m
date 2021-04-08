Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C549C433B4
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 18:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E6161108
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 18:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhDHSRW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSRW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 14:17:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BCC061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 11:17:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so3125465wrr.2
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 11:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w3Hms04HS9iouAnx/gnJaP0ewpZIlIH2J5LETUzqwXY=;
        b=WEas3H/9mk/oq9DnTz9o8aB/qfoPHLmvSijiAkbpLzOTo6FRrYcIN4S7nBau1xjG6P
         cal3GYvqUXdKmu+PhGKO2AE6DShjCaQJYRYDilSGPovBefQ0uVG3PxcvA70FpqQc1eNJ
         SIj/d1RKzXl5vkvYiQ6nj6CZWNC7FkPFt8/uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=w3Hms04HS9iouAnx/gnJaP0ewpZIlIH2J5LETUzqwXY=;
        b=PiLpJwqPmrurNuJJZ1De3tFpJv3uJ85qPNhcIqrWcuWKsWHunxb5QMU9ckyZApZKI7
         n5qbHHAr2bCBk3cq6KNqu80T6IHb+X9zUJlrjWmDted5dWCZiJvwMw3HMkSaco9ZV/t+
         94h8QcCgXgohXX+uHrJ2ZZVdwYO2XP5DgwZtVn4a5AiGc6Rkg7P8GEUDN06TUbQFMESE
         meqtLAVt/4GA18xP7OvQnt+OxW8KBnb1LtZlNwZOfOd/Lw/EYdWby+hUZE/xWDStJhxS
         7B7Q1oaPBCfJF/osolXRvddszWawwlFf8FkmkFmO+QIxfNUq82kIy1DE2ddKDfE4AmCj
         D8hw==
X-Gm-Message-State: AOAM530C+1GKpEKsNGyHtU3HEpW73tPxSfC1caQrKgdn8pTnp+bOENNY
        Uc+Ip9VjAPoyonGshCut65A6J3Wxhrl5zQdw/GEVInwORhLOTQ==
X-Google-Smtp-Source: ABdhPJx8taNElmYT05YZ3s6ImgiSPEvbeIbSXzhAGtT47ayvIjpgCljLWbmXdX+puUTMu8tcDjtJNhZKUuSkhfrdBh8=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr5766791wru.57.1617905827892;
 Thu, 08 Apr 2021 11:17:07 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?S2FpIEzDvGtl?= <kai@kinvolk.io>
Date:   Thu, 8 Apr 2021 20:16:57 +0200
Message-ID: <CAL6HQvHN+9pp8+h0kqf9mJAtYS6_ZQvVE2JNkk3QqqUveXiTzg@mail.gmail.com>
Subject: Detect SELinux by checking if policy is loaded
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

to detect if SELinux is disabled, in version 2.4 there was a check for
/proc/PID/attr/current to have something else than "kernel" as value.
This allowed to distinguish between "Disabled" and "Permissive" when
the filesystem is mounted and the /enforce file has the value 0.

That check got removed in later versions and a check was added based
on whether /etc/selinux/config exists.

This leads to two problems. The first one is that older versions which
have SELinux disabled in the config file still have the filesystem
mounted (unless selinux=3D0 is passed as kernel param) which causes the
newer behavior to think SELinux is "Permissive" instead of disabled.

The second problem is that the existence of the config file is only
loosely related to whether SELinux is disabled or not. On one hand a
recent change of the config file (creation/removal) is not valid now
but only after it got applied, e.g., by a reboot, on the second hand
the check does not work from containers.=C2=B9

I suggest to drop the config file check and replace it by a
/proc/PID/attr/current check which is more reliable because it tells
something about the current state and works from containers.
What do you think?

For context, this is the GitHub issue where this suggestion originated from=
:
https://github.com/kubevirt/kubevirt/issues/5298

Regards,
Kai

=C2=B9 Here an example:
$ getenforce ; podman run --rm -it fedora sh -c 'dnf install -y
/usr/sbin/getenforce >/dev/null && getenforce'
Permissive
Disabled



--=20
Kinvolk GmbH | Adalbertstr.6a, 10999 Berlin | tel: +491755589364

Gesch=C3=A4ftsf=C3=BChrer/Directors: Alban Crequy, Chris K=C3=BChl, Iago L=
=C3=B3pez Galeiras

Registergericht/Court of registration: Amtsgericht Charlottenburg

Registernummer/Registration number: HRB 171414 B

Ust-ID-Nummer/VAT ID number: DE302207000
