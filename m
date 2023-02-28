Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE339C64ED6
	for <selinux@archiver.kernel.org>; Tue, 28 Feb 2023 16:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjB1QxQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 11:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjB1QxP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Feb 2023 11:53:15 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8091C3646C
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 08:52:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y11so6949592plg.1
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677603071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMlBkjresGm8vVhkLiU6FC5nmZvDxE1oNDL2LusX7Eg=;
        b=Zb93Yrhnv8HExJLlG2Fayb4rkW4keRPW79dx4iADlJlRQeXEUqdYFbmWawFhvKYx7k
         OcTZZb6ZfrYJq96jqGEhw0VoM6SQt92dpbBWTrw7QBWUGvK/PXb8Ey7rPAQYHjq6+P7y
         /4tz411HZSVIy9kgMKb5f4ptNJYhUktlt5osakJ+js3rHOVx+90AcTQdnTKIAodpTaf6
         t2dYzq4zk/3SieW9Nqg5a2Vi/E5IW2Mk3ud6RyhRmzIhzMubqc0FtePip4MWtEr0WhVs
         jvQTDavB718SttoZvTMLKxs//RUAF2vs12yhu0c6kyYJVM/DzikGt1TQ5LILWvKlzOvJ
         UJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677603071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMlBkjresGm8vVhkLiU6FC5nmZvDxE1oNDL2LusX7Eg=;
        b=dsyhuNxjnitcGsXgU30sIyC3LRzn2K9HypvdU4n2rQGkDjGY0WhpFWt2FPfNEJLanb
         1nI6TsoDW3Pau9tBGCgFmbN4iMrXhEX03+C+JAfiWSJ41y8Kk9eWOuGYCWogV11plneJ
         Vi+sS27jFJvFWKx8J+Oe3MFk47E7DuYfcc4AO+tLeOs8D6ej2mjNpJb8HvXS2GSQ3Gwp
         v8It5nvYAdWGTWwEGz+KcDt+MnbftH5IHWw9kZdZg+ih51tbf0mEnnmI69A1rTSvE6bp
         NIysgDPYnoqQhNrpfjv1v6EyAECTJI83UQitbYp5uVvtbYKJVEE9+rTC5LQe10P1HZYH
         cOEw==
X-Gm-Message-State: AO0yUKW2Ll0KaVzi3WB8v4nHrkxP6C7qdts+L2G9QP+U0luLpcXeW7cf
        A8lc+uHeqOWt5gn98CRkNM5Exwwg0Z98feHINxPy
X-Google-Smtp-Source: AK7set8IZL8foz3uG3I8eWyI0dEXcWjY0kyqzg2VfWlO+oGpjRzvzY/uYW5Klz2wJubDtiYyNPQSeafCb6MeFg0hTEg=
X-Received: by 2002:a17:902:f7c5:b0:19a:f80f:9619 with SMTP id
 h5-20020a170902f7c500b0019af80f9619mr1283996plw.3.1677603071396; Tue, 28 Feb
 2023 08:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-2-omosnace@redhat.com>
In-Reply-To: <20230228141247.626736-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Feb 2023 11:51:00 -0500
Message-ID: <CAHC9VhQnCchbn+kgZQ4cxUQKWCKd=H02R++qeKtqR75BpZETxQ@mail.gmail.com>
Subject: Re: [PATCH testsuite 1/3] policy: make sure test_ibpkey_access_t can
 lock enough memory
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
Cc:     selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The ibv_create_cq() operation requires the caller to be able to lock
> enough memory (RLIMIT_MEMLOCK). In some environments (such as RHEL-8)
> the default resource limits may not be enough, requiring CAP_IPC_LOCK to
> go above the limit. To make sure the test works also under stricter
> resource limits, grant CAP_IPC_LOCK to test_ibpkey_access_t.
>
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/test_ibpkey.te | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
> index 863ff16..97f0c3c 100644
> --- a/policy/test_ibpkey.te
> +++ b/policy/test_ibpkey.te
> @@ -10,6 +10,8 @@ type test_ibpkey_access_t;
>  testsuite_domain_type(test_ibpkey_access_t)
>  typeattribute test_ibpkey_access_t ibpkeydomain;
>
> +allow test_ibpkey_access_t self:capability ipc_lock;

FWIW, I brought this up back in 2019 and have been carrying a local
selinux-testsuite patch for this ever since (it's the only way to get
a clean run of the IB tests).  While it can be fixed in the
selinux-testsuite policy, I believe this is a more general problem and
should probably be fixed in refpol.

https://lore.kernel.org/selinux/CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1=
v04mouWw@mail.gmail.com/

>  dev_rw_infiniband_dev(test_ibpkey_access_t)
>  dev_rw_sysfs(test_ibpkey_access_t)
>
> --
> 2.39.2

--=20
paul-moore.com
