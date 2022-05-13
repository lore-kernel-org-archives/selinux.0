Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18DEC433EF
	for <selinux@archiver.kernel.org>; Fri, 13 May 2022 16:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382016AbiEMQjp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 May 2022 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381108AbiEMQjo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 May 2022 12:39:44 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6374214
        for <selinux@vger.kernel.org>; Fri, 13 May 2022 09:39:41 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-ed8a3962f8so11170326fac.4
        for <selinux@vger.kernel.org>; Fri, 13 May 2022 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=je2/EYNH/pX9YvvTFapKRwUQzXx/4ToahBNFDrSeTn8=;
        b=ZPmN5zCepY3a/wJ0VTCjyyz6HgqV4h8PGJZQaQk/aWxbCB6Guv28lEBGmPaQoZ2wNy
         3wQaFIY1x45JTBEYeSB9K5MRlH+PTVqPdhialBTLHYEsWst+JnsDP0GEogC8RNFDhs5W
         eJ453gd5WtQhZZUHA2ruqPSK52w/rwaVNyQ1V0GsQ8I+nps7kBeIPpheXZ0XP1+D0SvD
         QN/t8hzP1bZFECoXVZlqcxLD1hIvgP4GyFjbBbzoTJmC01WDhL1XfluGMIJGFt4PF05W
         Vl+u1IYVQHJeAjb6g7NGj6Fr+9sdbz0FKhOLrIIHfSac3WHtRaZl8vYg8zd14XC76A0B
         DTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=je2/EYNH/pX9YvvTFapKRwUQzXx/4ToahBNFDrSeTn8=;
        b=VUFBWam0B26muZIXwI4wk8loTxEun/4bkkml7ia39kXY9oPy9Fvv5HBXKXM18WCzIj
         PpVzs6tLKssR14EGWea+KlTxf6zDmN06Zyzy1obNjNzwEyeaKa1SjLgliqz5Z4k4Lkh+
         PaSJ/KpayS6YnJfR/FnzVQZ7ks1K4nzu3XH7xhYZolwgqkREpnemdS20dgur5cR8PHuM
         QipWd0jPceVg0K9RExdZvEk+mwar4CrG0Y2Ucs/Y4qZvexCc3yrqun6L3S25xzo4Pw6n
         balFb5Al9SdbxHMKbZ2xtRp1TREwq44Qqh7NndsQmvWCyyyvr0aqs99x7n1WhQmNb1B1
         6i+Q==
X-Gm-Message-State: AOAM530bTgRKjopCZEHtyIERRZBONDl/sak/POb+7vOIPVoN17XWzI58
        aZtE70Q7VOGGOhreKBMyGe3jSJyafV99NbpOSa8=
X-Google-Smtp-Source: ABdhPJwWzuJy0vhNUuBcuMQTKQDXhDcQfGHXq+jyN2FSbhSCubAmuUQuGkJ+2n/k5bSuWlbXGwYlpOqks34hptPVhpY=
X-Received: by 2002:a05:6870:c692:b0:e9:5368:10df with SMTP id
 cv18-20020a056870c69200b000e9536810dfmr2997173oab.182.1652459980599; Fri, 13
 May 2022 09:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220513095628.154274-1-omosnace@redhat.com>
In-Reply-To: <20220513095628.154274-1-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 13 May 2022 12:39:29 -0400
Message-ID: <CAP+JOzSCWVAqfurogeSRV9G7Jc21pY2_co7csEcNU1_=bGzPFA@mail.gmail.com>
Subject: Re: [PATCH userspace v4 0/2] Support the 'self' keyword in type transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 13, 2022 at 5:56 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
>
> With the addition of the anon_inode class in the kernel, 'self'
> transition rules became useful, but haven't been implemented.
>
> This series implements the self keyword support in the CIL & TE
> languages and the module policydb format. The kernel policydb format
> doesn't need any changes, as type transitions are always expanded in the
> kernel policydb. Since type_change and type_member rules are handled by
> the same common code, these are extended with self keyword support as
> well.
>
> The patches have been tested using the following WIP beakerlib/tmt test:
> https://src.fedoraproject.org/fork/omos/tests/selinux/blob/self-in-tt/f/l=
ibsepol/self-keyword-in-type-rules
>
> Changes in v4:
> - fix module_to_cil.c behavior for rules with the including self + other
>   types/attributes (James Carter)
> - update the test to verify the above + also type_change and type_member
>
> Changes in v3:
> - update commit messages and cover letter to state that other type rules
>   also gain self keyword support with these patches (James Carter)
> - error out in case a policy module containing the newly supported rules
>   is downgraded to an earlier module policy version (James Carter)
>
> Changes in v2:
> - validate the flags member of filename_trans_rule_t in
>   policy_validate.c (Christian G=C3=B6ttsche)
> - add missing error check in filename_trans_rule_write()
>   (Christian G=C3=B6ttsche)
>
> Ondrej Mosnacek (2):
>   libsepol/cil: add support for self keyword in type transitions
>   libsepol,checkpolicy: add support for self keyword in type transitions
>
>  checkpolicy/policy_define.c                |  42 +++++-
>  libsepol/cil/src/cil_binary.c              | 168 +++++++++++++++------
>  libsepol/cil/src/cil_resolve_ast.c         |  25 ++-
>  libsepol/include/sepol/policydb/policydb.h |   4 +-
>  libsepol/src/expand.c                      |  69 ++++++---
>  libsepol/src/link.c                        |   1 +
>  libsepol/src/module_to_cil.c               |   7 +
>  libsepol/src/policydb.c                    |  33 +++-
>  libsepol/src/policydb_validate.c           |   4 +
>  libsepol/src/write.c                       |  32 +++-
>  secilc/test/policy.cil                     |   7 +
>  11 files changed, 302 insertions(+), 90 deletions(-)
>
> --
> 2.36.1
>

For the series:
Acked-by: James Carter <jwcart2@gmail.com>
