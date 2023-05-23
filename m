Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC7BC7EE23
	for <selinux@archiver.kernel.org>; Tue, 23 May 2023 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbjEWTjs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 May 2023 15:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjEWTjo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 May 2023 15:39:44 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE2185
        for <selinux@vger.kernel.org>; Tue, 23 May 2023 12:39:21 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-561c1436c75so1478187b3.1
        for <selinux@vger.kernel.org>; Tue, 23 May 2023 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684870750; x=1687462750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSklzBjxhZmzMNotdKdz2ZXQTBM+PT0yLU4Hf0qksUo=;
        b=J1+Lh90+86HHzJ7Ba1MAeG6dBd/GlUnA8IZWFTSpRu1BcxvZ/Bjetmd8L1OCVI7bsG
         /vHoMAhkCLNIsJXlDFSjuhNK/i92CV1ZcXtHndRLXbtLyo814cuuLTHE4PeWowcDRcE7
         QT4gwr5ty9kkloUBxcKKqvl+zIm1CqWoNyw4JmxtgZDzEm20RV4X2T44Ai8MBCIkmd9S
         ayCtjHJW+9kwDX5kcGYBiY2wQwI/UFf7dqbw3XvOKTgV9LxTuSKD2u5scnh5egG2cCDw
         3LBW5QaprHdfc6uj4l7B5WneoF4V+5PfN9trESHUUh3+M0ec9z4nLh5HOOR5FdJHTIFl
         KFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870750; x=1687462750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSklzBjxhZmzMNotdKdz2ZXQTBM+PT0yLU4Hf0qksUo=;
        b=hbr5aG68svQy3s4tM/nPpq36z7Z9JLUmrw0p+rLXtXVYe5kZjGH9602u4YsrSdAorV
         1bnfIXu1HKXdSvNo7nPZTt/V8DVZFEhUfYnj37g3QWEUPlq6B9YkmhqcGc66EdH593Uj
         FmkkIk03uopY6VDWVBi4QUbo0yExlNN6vfSCw9BnBNRKRHJyArpI6E6rA3QSeKkJhdb0
         ng6ApEyF4zS3fde+0Wov4a3dxV6+obDfUsFaAlrGZ0pkpP8mpV6WagMFYFpUCkgu4evD
         HW5PPB8IdEKjw5tIR1g+cbODDXBF982kE2B8f/9D5VG/xvNjgo4qx8YHD8rBJxjKLITk
         ZlKA==
X-Gm-Message-State: AC+VfDxKIVId3ol42bPmp4CKOjoCN1H0ypsO+k0CCgl/huEpho4bDrUe
        PC850hvF8ZItgX34CYjZ3VtBSm7KvhNYGkqqvZR3
X-Google-Smtp-Source: ACHHUZ5t3ISNlc8css/TIbS3nKAqJFZ751H1T5Cj7O+AaEakwztSyfUhzg3HqqZydPeGF3do/inmnStTBrpGIbF5Z2Q=
X-Received: by 2002:a81:a0d2:0:b0:559:f52b:7c5f with SMTP id
 x201-20020a81a0d2000000b00559f52b7c5fmr15335674ywg.17.1684870750245; Tue, 23
 May 2023 12:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230511123213.722912-1-cgzones@googlemail.com>
 <6301fdfd0927df2b2fd7a4f2b384e477.paul@paul-moore.com> <CAHC9VhSSA04wzPFgx_Z4jf1gOdEO40hU-augjMqX1uGd-eHLQA@mail.gmail.com>
 <CAJ2a_DeJhGcXBtVfuOp3xeUNxJyFR4QG-+5=4Q_38go+v6d9-A@mail.gmail.com>
In-Reply-To: <CAJ2a_DeJhGcXBtVfuOp3xeUNxJyFR4QG-+5=4Q_38go+v6d9-A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 15:38:59 -0400
Message-ID: <CAHC9VhQ_yLL432Ete+ZB3TV-wwG7capXCOE1NKY029evKxQ9DA@mail.gmail.com>
Subject: Re: [PATCH] selinux: deprecated fs ocon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 23, 2023 at 2:25=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 18 May 2023 at 22:18, Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, May 18, 2023 at 1:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On May 11, 2023 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgzo=
nes@googlemail.com> wrote:
> > > >
> > > > The object context type `fs`, not to be confused with the well used
> > > > object context type `fscon`, was introduced in the initial git comm=
it
> > > > 1da177e4c3f4 ("Linux-2.6.12-rc2") but never actually used since.
> > > >
> > > > The paper "A Security Policy Configuration for the Security-Enhance=
d
> > > > Linux" [1] mentions it under `7.2 File System Contexts` but also st=
ates:
> > > >
> > > >     Currently, this configuration is unused.
> > > >
> > > > The policy statement defining such object contexts is `fscon`, e.g.=
:
> > > >
> > > >     fscon 2 3 gen_context(system_u:object_r:conA_t,s0) gen_context(=
system_u:object_r:conB_t,s0)
> > > >
> > > > It is not documented at selinuxproject.org or in the SELinux notebo=
ok
> > > > and not supported by the Reference Policy buildsystem - the stateme=
nt is
> > > > not properly sorted - and thus not used in the Reference or Fedora
> > > > Policy.
> > > >
> > > > Print a warning message at policy load for each such object context=
:
> > > >
> > > >     SELinux:  void and deprecated fs ocon 02:03
> > > >
> > > > This topic was initially highlighted by Nicolas Iooss [2].
> > > >
> > > > [1]: https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELIN=
UX-SECURITY-POLICY-CONFIGURATION-REPORT.PDF
> > > > [2]: https://lore.kernel.org/selinux/CAJfZ7=3DmP2eJaq2BfO3y0VnwUJaY=
2cS2p=3DHZMN71z1pKjzaT0Eg@mail.gmail.com/
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  security/selinux/ss/policydb.c | 4 ++++
> > > >  security/selinux/ss/policydb.h | 2 +-
> > > >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >
> > > Thanks, this is a nice catch, although some minor suggestions below .=
..
> > >
> > > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/p=
olicydb.c
> > > > index 97c0074f9312..31b08b34c722 100644
> > > > --- a/security/selinux/ss/policydb.c
> > > > +++ b/security/selinux/ss/policydb.c
> > > > @@ -2257,6 +2257,10 @@ static int ocontext_read(struct policydb *p,=
 const struct policydb_compat_info *
> > > >                               if (rc)
> > > >                                       goto out;
> > > >
> > > > +                             if (i =3D=3D OCON_FS)
> > > > +                                     pr_warn("SELinux:  void and d=
eprecated fs ocon %s\n",
> > > > +                                             c->u.name);
> > >
> > > Instead of having to check if 'i =3D=3D OCON_FS', why not simply put =
the
> > > pr_warn() call up in the OCON_FS case block on line ~2249 and let it
> > > continue to fallthrough to the OCON_NETIF block?
> >
> > Bah, nevermind, you need to leave it here because of the 'c->u.name'
> > in the pr_warn().  If you're okay with me adjusting the deprecation
> > comment (below) during the merge I'll can merge this now ... ?
>
> Yes, please feel free to adjust the inline comment.

Okay, done and merged into selinux/next, thanks.

--=20
paul-moore.com
