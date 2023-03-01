Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A508C64ED6
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCASuL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 13:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjCASuK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 13:50:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C41ACF7
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 10:50:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so214555pjp.2
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677696609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohAcg6/H5SAA0iqp9NlTibC5woCDcIK6hz7C3+2+98A=;
        b=Ucf9rGikkVmyE37SA/Kax2g5ETIz/lMSJ4w4IQRoK5rH9cvUr8ETXts+k+Kc5p+DEd
         r+MFhanDbLbKIf7n/UagNX9Z7hnUPGpTRBEWNL1oNxjLjqaUBaDYy7vahB4fW3tJcdPC
         olnBbZkXS+T2kF5b7yThziqASAsqOcCRV88ZDudojwdp9fiPgdH8ZskHlUqfBuZP3FCH
         4K1hqo/y9uzuFB1T8AHBY7BF44lXHUDfP4y7ObKhMVRymeDWcw7/tROX83SR2RozGTjw
         E1vrkm18hhJuM4tuSy5flNFhjGm4lZo2Y7EJieI4IWmMMi9dAIxBUIf2ZegmyzQfXEvB
         NIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677696609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohAcg6/H5SAA0iqp9NlTibC5woCDcIK6hz7C3+2+98A=;
        b=O/21zP6sedh8PnkKoGxLpkjeucY7PMxQ7uf66zICWfXNonLrNUtNokCymS59r62fpO
         yhynwB/h4OEYN0zbYDmzj8DlLKrjSe/XkdN7/yJ2UqL3QUK7rloxVBQzZ7qKcJ6bQ01K
         QsLcoH04xIsvzTZ4gbe5ktlMVrgmBkhz1a8E6kltwNvCI+J3cOKzH8GZJ1Z0nEt3kod8
         aNikV5GY3r8mllzntxozg/XavI4RleXqIhnRvX2PxGK8CPg3YLL9CkLmNO8s3q6/b6KO
         /DLHpoLJfx/zXCcJXyXhqsOHJrmCW57inDM/MEoDCtvqNltdXZl3dSp16Sgz1OJgpSZr
         +wCg==
X-Gm-Message-State: AO0yUKWqPLBBwU8tZLt9uzUHCNmFB26BuEegUjOme6E0sdXfbBQi5LS1
        Y/V38WrkvxIErgtg7t8uTUjaZ1IpxtRaYVFFRFYp
X-Google-Smtp-Source: AK7set+VdJKfJp6DEjnMroRuk5wuuknogVlkB6iIphMmUAlN+hDXCG7IYdzp3mnASZ5SEAa+I4XBaLkWKCvBVlyt9as=
X-Received: by 2002:a17:903:2782:b0:19b:373:94ad with SMTP id
 jw2-20020a170903278200b0019b037394admr2753315plb.3.1677696608980; Wed, 01 Mar
 2023 10:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-3-omosnace@redhat.com>
 <CAHC9VhT8+vFwzZk4ba5nNd8uQJj3JqqJzttV=1pLPO0U82xxXg@mail.gmail.com> <CAFqZXNuq5q8CADULnNsJnxbNKLym9FY3xA=0FterBMYMv6adww@mail.gmail.com>
In-Reply-To: <CAFqZXNuq5q8CADULnNsJnxbNKLym9FY3xA=0FterBMYMv6adww@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 1 Mar 2023 13:49:58 -0500
Message-ID: <CAHC9VhSqtD8gfGYtBNo0hzBbf-g3oUw9dzQ29JwfaCq0SqYmwg@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/3] policy: allow test_ibpkey_access_t to use
 RDMA netlink sockets
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Chris PeBenito <pebenito@ieee.org>, selinux@vger.kernel.org,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 1, 2023 at 10:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
> On Tue, Feb 28, 2023 at 6:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > ibv_get_device_list(3) first tries to get the device list via netlink
> > > and if that fails it falls back to getting it from sysfs. Currently t=
he
> > > policy denies getting it from netlink, generating some denials. Allow
> > > test_ibpkey_access_t the necessary permissions so it can do it the
> > > preferred way and doesn't generate audit AVC noise.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  policy/test_ibpkey.te | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Similar to the other policy issue, it seems like this is a general
> > problem and not specifically a selinux-testsuite issue, right?  If
> > that is the case should we fix this in refpol?  I think it's okay to
> > put a temporary fix in the test suite, but we should also push to fix
> > this in refpol.
>
> Basically the same as I said in the first paragraph of my reply under
> patch 1 applies here, just in this case we are talking about users of
> ibv_get_device_list(3) instead of ibv_create_cq(3).

Yeah, let's just tackle this in the other thread, at this point it's a
bit silly to duplicate the discussion.

--=20
paul-moore.com
