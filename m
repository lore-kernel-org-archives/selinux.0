Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A86C761A6
	for <selinux@archiver.kernel.org>; Tue,  4 Apr 2023 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjDDS4b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjDDS4a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Apr 2023 14:56:30 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6B91BD3
        for <selinux@vger.kernel.org>; Tue,  4 Apr 2023 11:56:28 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5416698e889so633823997b3.2
        for <selinux@vger.kernel.org>; Tue, 04 Apr 2023 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680634588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuYMP9oERucJ/O/ah5M668zvZcUxIDKJFH+6ndYhYhw=;
        b=PQaRIIZkpGihz6wkjt6tSlzCY4838BGeVloFrkgUy+TiPjGJbg3Xju0fSOz0ugEkLa
         4M8JsBMaHjY8ojIZiBKrw25TFChUm/J4/9aimvN5zAF5yyzAJlL2UfxkMYrv/zAJW/nA
         jwyh8THBan3RpnhNHPD9gjX0xuKBf51UcePGUO7o0LaDMyF74f8YReyFbAXUUPkQpImX
         DC76fVSQD8bpquZb3y4h8S8ed1r8VitaUMVJbkb5wVqkWxpxh/fzAO9pT/D1XDoekIuz
         qjzS8hMqbNGhmWQaD035n8+tMbSOtDVlAbMYXFICMdWGmUL28QNylVAGMUDdcFBiprXN
         MQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuYMP9oERucJ/O/ah5M668zvZcUxIDKJFH+6ndYhYhw=;
        b=zDx++YDsQe+Qk+hePcz0fqStJW5k54JJ/Kr75NgPuNPVrNSjfiSZfF2MHrCstpEGrY
         Qb8zrzdxaueJj0CqoyTzityyX1qbWiHVOVRhNSr5L8cWDzItEs+TtrzvArwZEzXqQrUt
         AobHuQCwDUfQEAMP6nBaIVUfjsP0uFSj73PnVlZw6d6nuOxUBUMGoSrnt+eieIBP6w2k
         CjlYpiyslZkUAV1Vbdiaa3j2i8XoaUG2WRONUcqb5uHDEZibEYXU0fCAgv6ZHUP5X+EB
         jEEoqTQc27dMBwdfYBnBHbCq6uY6uZeLXuyoob/mmZOVKjibJ/wB72aHQtd66JBQCyIT
         lp0A==
X-Gm-Message-State: AAQBX9emeCFCmVnVNoAHGcBOdpOEiyWXSdQiM1rqgQQ2IVKehtskkXjT
        /J60TCg1a9VxbQUPBPMCOjIuchkifvxm/R9X/L4L
X-Google-Smtp-Source: AKy350YxxXydXcJ3GRJ0BEKkYqhynh4SF2ERZFWAntaIKyMLNleszHadlV51xUjwR+gGb8zwomvEMLjrI4Z2QWit7js=
X-Received: by 2002:a81:b389:0:b0:544:cd0e:2f80 with SMTP id
 r131-20020a81b389000000b00544cd0e2f80mr1986292ywh.8.1680634587849; Tue, 04
 Apr 2023 11:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230331123221.3273328-1-roberto.sassu@huaweicloud.com> <20230331123221.3273328-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230331123221.3273328-4-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 4 Apr 2023 14:56:17 -0400
Message-ID: <CAHC9VhSMdrPP6+9cmhAU1=tDikJ5Y8_mJEORdqiaJw3pQuFDDg@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 8:33=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Change the evm_inode_init_security() definition to align with the LSM
> infrastructure. Keep the existing behavior of including in the HMAC
> calculation only the first xattr provided by LSMs.
>
> Changing the evm_inode_init_security() definition requires passing the
> xattr array allocated by security_inode_init_security(), and the number o=
f
> xattrs filled by previously invoked LSMs.
>
> Use the newly introduced lsm_get_xattr_slot() to position EVM correctly i=
n
> the xattrs array, like a regular LSM, and to increment the number of fill=
ed
> slots. For now, the LSM infrastructure allocates enough xattrs slots to
> store the EVM xattr, without using the reservation mechanism.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/evm.h               | 13 +++++++------
>  security/integrity/evm/evm_main.c | 16 ++++++++++------
>  security/security.c               |  6 +++---
>  3 files changed, 20 insertions(+), 15 deletions(-)

This seems reasonable to me, but I'll want to see a sign-off from Mimi
for the EVM bits.  Same thing for patch 4/4.

--=20
paul-moore.com
