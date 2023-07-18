Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D0EB64DA
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 08:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGRIbk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGRIbj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 04:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635A10E
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689669052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIQQjuwU2FZ/HXn1FLExdIthyIU5EJCPEuds0lxBCxk=;
        b=cTMuZO+TbWs19efkf4U9K9DDiLVRc7u0Y9PmHOCIy8SWI+kyQTgWBuF1AikthpkKcfxcUv
        BdOXYMaYoIo3t15uwSPQNkz9J7Cm41yi1ZmB73vDwUZOxi6p5O+ay1Z8/h5o89U1WMCXaw
        9tMzY+mQGRicLgqNssBZFIeZpJ3BCY0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-eyZzEfqEMf2oak4eLWYinw-1; Tue, 18 Jul 2023 04:30:51 -0400
X-MC-Unique: eyZzEfqEMf2oak4eLWYinw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262e04a6f5aso2272506a91.2
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 01:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669050; x=1692261050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eIQQjuwU2FZ/HXn1FLExdIthyIU5EJCPEuds0lxBCxk=;
        b=j4syIkn39wLsS4arhkdYYBzA+H2p6QuCUDT9TCXLhBU/ys4t6BLDtHOTHLBFEau7EV
         2WXb6qHMTCwRKYbDAciZpiKyDF0AcLAFPwht5VILZX1qVOAgizLMC2XP5sT8Ej3v3JbB
         V//1rZtK1IZwjRhbalSiN5ryfQ1BtqFLCz9+7RWf23z0VLYGrhRxJWLNw2Kgz7aoFjRp
         SdM6Aha/9ORRXQ9gClBqQwvhTdVbZr/YUwi93GZqC5fYJJnI61jw3hgqOr87h898AJwQ
         4oKEx8qx8j1gJ1f65kiPaouw8DvaxkwAa79MLBxvGol2hm4/a48wjYIsseWYzxMFb+dE
         pj3Q==
X-Gm-Message-State: ABy/qLbM/anPfbDc227GNOPSaftu4oV39zUpS9N5fim9AnsPyAtO0JI9
        wMmWUJe/tXYiZHfXQxWoXr5DaCC/Qe+I0NvUnSp9m85lF34zDbXAzkA6YHQ5l2f7h22iuGG57hd
        XafOLthND3+uJfB3EIMUoUOu6UfyEcOEJ3Q==
X-Received: by 2002:a17:90a:7185:b0:25e:d727:6fb4 with SMTP id i5-20020a17090a718500b0025ed7276fb4mr11874976pjk.2.1689669050332;
        Tue, 18 Jul 2023 01:30:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGuJMPzk8/bn7YdaAcNpTleCpkuf5HGZs57MI45l64U2QTY1kk3KuGFfe0TzmqgL+o8BbYVEUj1N5ZAhgtXPhg=
X-Received: by 2002:a17:90a:7185:b0:25e:d727:6fb4 with SMTP id
 i5-20020a17090a718500b0025ed7276fb4mr11874969pjk.2.1689669050090; Tue, 18 Jul
 2023 01:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230717122800.619345-1-omosnace@redhat.com> <CAEjxPJ6a8taRLUotfLtq6kyOMeiN28odwmgWh6yFpX3HW6-gDA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6a8taRLUotfLtq6kyOMeiN28odwmgWh6yFpX3HW6-gDA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Jul 2023 10:30:38 +0200
Message-ID: <CAFqZXNvtbRw0E51BixS8iWYmXRRqHwXDmLM871MKLTi_0LhUwA@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow all test domains to search
 user/admin home directories
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 17, 2023 at 2:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 17, 2023 at 8:28=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > The permissions are sometimes needed to resolve paths when running the
> > testsuite from a user/admin home directory. To avoid cluttering
> > individual policy files with macros that allow it, apply the macros to
> > the whole testsuite_domain attribute. Thankfully this doesn't break the
> > other tests.
> >
> > This also fixes the inet_socket test, which started to require these
> > permissions after a recent change.
> >
> > While there, also remove userdom_read_user_tmp_files() from
> > test_overlay_mounter_t, which doesn't seem to be needed.
> >
> > Fixes: 4dcea27ada77 ("tests/inet_socket: cover the MPTCP protocol")
> > Inspired-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> All tests pass with this applied, thanks.
>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/ab02919a0f9db4b6=
f3d162073b93380d80478014

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

