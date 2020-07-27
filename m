Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CC7C433E4
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C98720672
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 16:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8WWPDDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgG0QMY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgG0QMY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 12:12:24 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5FC061794;
        Mon, 27 Jul 2020 09:12:24 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so14814143oib.0;
        Mon, 27 Jul 2020 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=piFsRY7JOm24njFZpgZZGCe0rwON4Csurmi1k3Fom/s=;
        b=R8WWPDDf5X7l/Ty4nDs3DP5h7tdNgpwJpBxPH1TKawwvOBua6NA4iyd9xCoCNAJCiJ
         lVfc3AnvMvCZIZjRbY9QYrCLswa9WdJHK+gGBe6Gt18ocHZxw0/YjfUalbE4nO3irDU5
         sBQMwx8gPM0qMSTLZDfz01zFshUSwT9/zbudDToQn3h99Jb4VlZiSCKf0BjgjL3OKlW0
         TmJ0KkUKus3flMsf+CJJ3o8eUwqu9PpUgdZFD5yTriIW8t1sgqEHOfuoJmx10f/2mv+D
         DadruT/8ILwj5ToSxVn7V8QHTwU3KbwIJaNF835hK6tFqqGJFJmi0+xvUev3xWfflgNN
         j+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=piFsRY7JOm24njFZpgZZGCe0rwON4Csurmi1k3Fom/s=;
        b=rT3SEYkXcCtjlXKaiqpRx701nuEdelSzeBxPi+DCCyzcRK2dlcnrRz9SM/2TmYIcbB
         DzE2HvcLnnBOriQsaVb/6xzgyOdxfJQg5dcQhzcB3q3HRj6ROlgsA1g/qBMEefWSSocI
         ZAN345OGco3OQQ6DEy3+T7S/COepS76Lqe2tt4wVlmkHudqSAWuGuExcwtjZWN5yPlO+
         pUgLWUIp8OTsGLJfe8Oc/iBirB82c60MbBHKuWjZyq7+2A1EtEaqIxAuSN0GQRoUm6Zr
         UfMJjK0fwGj/etKanUCbCtak5C1lNoKPYvg6sKpu3m/F7NJEIWU1gXxVxZ5FC4nNBE+E
         d+MQ==
X-Gm-Message-State: AOAM531w/GiNYYIgMk2MEBGPtneNQIhFFS4Yd0c7Vwt9a9xXt9aspYR7
        Pbdb9v70Kla78f9pbIA350x29vFFxV+hY4Gw9Vs=
X-Google-Smtp-Source: ABdhPJxzbXrmkz19yELtpn/YxAJN5p300896o7TLZsr1hdQEGgmj6ERW5cTYe5V1vbtSJwkncp45dtNUGsy/Vz4qvyg=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr56473oif.160.1595866343429;
 Mon, 27 Jul 2020 09:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200724203226.16374-1-casey@schaufler-ca.com> <20200724203226.16374-3-casey@schaufler-ca.com>
In-Reply-To: <20200724203226.16374-3-casey@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Jul 2020 12:12:12 -0400
Message-ID: <CAEjxPJ453W-8PmB4WPq2vZHfvvG6yWFmoqnuHtHvz5Y5MYaj1g@mail.gmail.com>
Subject: Re: [PATCH v19 02/23] LSM: Create and manage the lsmblob data structure.
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-audit@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 4:35 PM Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
>
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
>
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
>
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
>
> The audit rules data is expanded to use an array of
> security module data rather than a single instance.
> Because IMA uses the audit rule functions it is
> affected as well.
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

With CONFIG_BPF_LSM=3Dy:

security/bpf/hooks.c: In function =E2=80=98bpf_lsm_init=E2=80=99:
security/bpf/hooks.c:18:63: error: passing argument 3 of
=E2=80=98security_add_hooks=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   18 |  security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf"=
);
      |                                                               ^~~~~
      |                                                               |
      |                                                               char =
*
In file included from security/bpf/hooks.c:6:
./include/linux/lsm_hooks.h:1592:26: note: expected =E2=80=98struct lsm_id =
*=E2=80=99
but argument is of type =E2=80=98char *=E2=80=99
 1592 |           struct lsm_id *lsmid);
      |           ~~~~~~~~~~~~~~~^~~~~
