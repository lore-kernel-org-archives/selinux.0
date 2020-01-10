Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7EAC282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139B120673
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lxC2wrdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgAJQzw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:55:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38522 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgAJQzw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 11:55:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so2833718ljh.5
        for <selinux@vger.kernel.org>; Fri, 10 Jan 2020 08:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tJkfOz11yyIz4iZnOpsNHoPwmnJHa3OhXlKEzq+ccJ8=;
        b=lxC2wrdA8tZQyJZtAmG/iemGPXAkHjDiwcStcFBdPFp2eAw6YZmVvPjUnNotyCRmPw
         4fsHrhIf5Q1AE7596eDL1hrmCYe+dyFFEe20XX6TjqY2dvVD9yAk55dZehPoezr7dgNf
         FDMw89CC0UDCH4ZVRVkD+4egXLQtlJ6p/CNggFKYf9F2Gq7vUlfia1KsHy5WUwxa40ld
         cWLupX+kF39JeecKuTevc3mbNuTYs929WTAMtuMqZeBlgix/42guFSB6wnmFroV2QsQ8
         a+M1GnadGqmeEON8KPjuXr9RiewPS4n/ruzOQZhvNk5+3wHkwzs4K55Ya2/FoAxNj9X+
         xfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tJkfOz11yyIz4iZnOpsNHoPwmnJHa3OhXlKEzq+ccJ8=;
        b=IwGz00IB4t4yYHsmIusvc7vsM74gOZ8y1lyrVoKzHbZ7xKnApnotD747SU+mHY53PE
         gMpDIYoQmXZ/vLB8sXIVBpwDbXluPjn5EoVoNhYKAPK6PitCBvGdhPa3xLpi8Is+2i5w
         HZ1hI7PXmQLysKBcOvH75HfQtPH8CSUWl+SAP3dbR8dCbukP1X0Ij0wPVbfZxd1bUks2
         ok09KNe63HevtG9Wd/6oiUZ2h6f3WCclBw0ZOSTLpcV0eWnr+NXGhEiGYfyQii9L/NN8
         RicNw97Aik9NbWFNyhuKMEX3Ts9ra0tXOfyne1YSbthBmHR8h9MCeE8uaihLiObx0NgZ
         ecSw==
X-Gm-Message-State: APjAAAU68xy5lXnPRBwvg6lP7c18RysEjp2UAHg22LIzRyggi7HqTzWX
        IqSLYTNsr9A2RuvYUxFueuI74d/ApMAdLgTxwwaQ
X-Google-Smtp-Source: APXvYqxF1SlLoLkkrXJcp6DdVrDEN3hSkafsxgTiUFcSxL3zfxQrnufWXDnKKDusya61z6s+tMJJfEgjvyUaGNbu60o=
X-Received: by 2002:a2e:3a12:: with SMTP id h18mr3335333lja.81.1578675350497;
 Fri, 10 Jan 2020 08:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20200110142038.21602-1-cgzones@googlemail.com>
In-Reply-To: <20200110142038.21602-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 11:55:39 -0500
Message-ID: <CAHC9VhTm4Mv2=vy7-LVFnnVnNd87MajzN1imjSLcqx9H17uQqg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add policy capability for systemd overhaul
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 10, 2020 at 9:20 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Support a SELinux overhaul of systemd by adding a policy capability.
>
> The systemd patch can be found at
> https://github.com/systemd/systemd/pull/10023
> and has NOT yet been accepted.
>
> This is just a rfc to test the water.
> ---
>  security/selinux/include/security.h | 1 +
>  security/selinux/ss/services.c      | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)

Generally the SELinux policy capabilities are reserved for *kernel*
changes that potentially break compatibility with existing SELinux
policies.  I'm probably not the best person to talk about
tricks/conventions used to do similar things in userspace, but you've
come to the right place :)

> diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
> index ecdd610e6449..2853e462977f 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -79,6 +79,7 @@ enum {
>         POLICYDB_CAPABILITY_ALWAYSNETWORK,
>         POLICYDB_CAPABILITY_CGROUPSECLABEL,
>         POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
> +       POLICYDB_CAPABILITY_SYSTEMD_OVERHAUL,
>         __POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 55cf42945cba..cb50e187b181 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILI=
TY_MAX] =3D {
>         "extended_socket_class",
>         "always_check_network",
>         "cgroup_seclabel",
> -       "nnp_nosuid_transition"
> +       "nnp_nosuid_transition",
> +       "systemd_overhaul"
>  };
>
>  static struct selinux_ss selinux_ss;
> --
> 2.24.1

--=20
paul moore
www.paul-moore.com
