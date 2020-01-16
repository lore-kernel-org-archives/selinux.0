Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DECC33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 23:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF06206E6
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 23:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VF1SqX0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgAPX76 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:59:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33986 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPX76 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 18:59:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so24576798ljg.1
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKsIw9CE1osUbzKWTNuCAUcMjcuF9akzYFe6U2xarRE=;
        b=VF1SqX0d6Hq0s9XPJV6xXKghCze6CFabDV5fTjOZYNy+4Rf3rGYpQoW9n27gWxj8Y0
         iZ5h3jjMZssOF8F2sIhw1ARKuXDbhaKCSPDilJFqFPfx9dCu2Ac0M+ZLXn4Igr0Fg5gM
         VHf1k74rtqqLJZe70F6i6eSCJREBOKs1AGjpkLoda1ZtzgEdzlSfg7fmJCrX4Klc7ehv
         Ck1COWuKplaAzd2SyPVvlzR9Y73QB8Dk+DRd0LWoVyExFaa2fb8GUFwAxOcgZ394xcS+
         LIioG+Z85rRzEvXXNOvDE5w3PB520jB57kKYH4XCqR4kct7oRlpY82gBdslGUb59OMWP
         hCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKsIw9CE1osUbzKWTNuCAUcMjcuF9akzYFe6U2xarRE=;
        b=cRehFf5xwHkRHI80JnHri0sX/sfIgjiytzhd58RlhEABlGcQDQk7CSi7V/RQHwEsJY
         VloMHj28XV+/PWQoB1vrmY7A3dTViVmuB9D0yUPPfTib60DCO5HTScQrztyP3pasxE+m
         PwFUSuiIK11H2lXM1Udc5bmJVjCNb9l5OUofvLN5ms/U/9WxgLLjIJz5rFlihE0xHNfa
         rcAUqHOoiNCDUfWXdoRAtFCNTMfH2264NFRFdcwP+Lzr742BCKLdS8wqdjSnmJ/8tDHz
         3JMPE+MiKiTOIR8w7rcIEormSVl2pv+YQJbfYsQaLSwWQEkrVQz7Gj/Kcjsc0ctMnZKx
         gF3g==
X-Gm-Message-State: APjAAAXRfPo8Q6USfQhi9UcAVdW/JUe6fjASfKH0LteOnf0X/BdzqAWo
        N0Qm18AxwWRhPq7yU17wPpFWP1Bp8fDQ/kGPRwPJ
X-Google-Smtp-Source: APXvYqy/9XGd5tx+l0z9gRxNaiTudFtn4jZVS1PE26Dc3lXu+wtEaorREYfz8h7BxYzGiRcZaRpeotjNlwSy7xy151o=
X-Received: by 2002:a2e:8152:: with SMTP id t18mr3541276ljg.255.1579219196473;
 Thu, 16 Jan 2020 15:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20200116120439.303034-1-omosnace@redhat.com> <bfa5a08c-9e72-5de5-4f57-c89debd94590@schaufler-ca.com>
In-Reply-To: <bfa5a08c-9e72-5de5-4f57-c89debd94590@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 18:59:46 -0500
Message-ID: <CAHC9VhSGW9OwTPf1yHLea3oN6bRrpawsF4kSSgK1NkX9sXn5cQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] selinux: Assorted simplifications and cleanups
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 16, 2020 at 6:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/16/2020 4:04 AM, Ondrej Mosnacek wrote:
> > This series contains some simplifications that I discovered while
> > working on another patch. I believe they also save some run time
> > (although not in any perf-critical paths) and some memory overhead.
> >
> > The first patch is a cleanup in security_load_policy()
>
> It's a real nuisance that the security server code uses the
> prefix "security_". If you're making significant changes in
> the security server it would be really nice to clean up the
> namespace collision.

For all the people lurking on the mailing list reading Casey's
response, *please* do not do this (without discussion).  That change
has the potential to wreck a development cycle.

-- 
paul moore
www.paul-moore.com
