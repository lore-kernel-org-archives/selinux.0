Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9CAC54FB9
	for <selinux@archiver.kernel.org>; Thu, 16 Nov 2023 14:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjKPO6C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Nov 2023 09:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbjKPO6B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Nov 2023 09:58:01 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2440693
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:57:58 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso11720501fa.2
        for <selinux@vger.kernel.org>; Thu, 16 Nov 2023 06:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700146676; x=1700751476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/lE8wZa7yel2o4b9KWxoxZuhyH/IB8iMCK6yPwsXXI=;
        b=DFITEdYjQ8c9jiMkX2mv848wJiHDxYQufjpUjZUUnbmEVnCDqxG2daok1plrSigzai
         PCaK2CMtdcZqwMKu4f0qnjTCgN1YUCAneXDc5CoaZrpQw0fFmSach4YqlF8p0hyosCMQ
         pCMwSbRFuc+6LWxAYFddQk1DpdrfnLlDCbvWzZ1zQg/d7xAwOPQVAJjdkqs+5wqdJANm
         9CLpaCvZE+mdunGOAA9RNgUhdsZv1nPTzY+52eGDjekjGPdwHu+dmbG+q4wTJwLzKiLF
         iSJdl8xkUeynkEJeH1iKxwE+OrMduYiXjenIPiK9H6refxddO796dH+R53TCHKeUcgtV
         kTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146676; x=1700751476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/lE8wZa7yel2o4b9KWxoxZuhyH/IB8iMCK6yPwsXXI=;
        b=mjh5LcQFx4V0FyvQ070l3YDfX4Q6T+BQ/Zf5GxdmM4tPfxzimzLVHUGJzodx0hJC5s
         YsQsi71GqI6MJA2bgolnV/Hv3CU+rx46y07jZWyYp4E0JYsqWkSZXc5P6cjcZqNua0dF
         14HbMEH3jP8cT2+3iJUp5mVHLB8dFwm37JcD9sLPUYeAWA6zvyRcK6Klt4UqPuf3FSls
         kpIDE7PycRvZmggGmLpOoUjbfZNuQplyVMWVp/SxoW9IwaILOk1kkHXL6P3u8oQr3grX
         1USvZqGHLL5LOz+FpIOZlKbP15KwWywyd7FWbojTS5P5vHLcMjzAJxhcBnggUAiL+2Zp
         IbbA==
X-Gm-Message-State: AOJu0YwV5RtaGpuHeB988frppdAU5e9EibOox1KROghWnx+hTTBlw5g5
        STfsYkcIFWs+dO4nOM15Aj3m5I4bv9NLNzUeJnURK/Yz
X-Google-Smtp-Source: AGHT+IEf5kfGk2IDimlzNZhOiv4oF1Nkdgo9yIJEwWherdqWuF7mlqnMXuFLyUBNMw2duSHRPtlunAbkSMyhBIfh1rc=
X-Received: by 2002:ac2:4831:0:b0:50a:72e6:96c7 with SMTP id
 17-20020ac24831000000b0050a72e696c7mr1821685lft.3.1700146676080; Thu, 16 Nov
 2023 06:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20231109135400.44658-1-cgzones@googlemail.com> <CAP+JOzQOz0cw7qe45K5kFB1UXCwpKRwDUwPQYyU=ceYQK1K9Jg@mail.gmail.com>
In-Reply-To: <CAP+JOzQOz0cw7qe45K5kFB1UXCwpKRwDUwPQYyU=ceYQK1K9Jg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 16 Nov 2023 09:57:44 -0500
Message-ID: <CAP+JOzQemCPAqDTzSEwMJJ3XiKD7zgUct-zdx5GiYY-wUPC0Wg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: update policy capabilities array
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 14, 2023 at 3:41=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Nov 9, 2023 at 8:54=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use their enum values as indices to clarify their relationships.
> > Specify array size to verify it at compile time.
> > Remove unnecessary trailing entry, since all access is controlled by a
> > check against POLICYDB_CAP_MAX.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch has been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/polcaps.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > index be12580a..8289443a 100644
> > --- a/libsepol/src/polcaps.c
> > +++ b/libsepol/src/polcaps.c
> > @@ -5,17 +5,16 @@
> >  #include <string.h>
> >  #include <sepol/policydb/polcaps.h>
> >
> > -static const char * const polcap_names[] =3D {
> > -       "network_peer_controls",        /* POLICYDB_CAP_NETPEER */
> > -       "open_perms",                   /* POLICYDB_CAP_OPENPERM */
> > -       "extended_socket_class",        /* POLICYDB_CAP_EXTSOCKCLASS */
> > -       "always_check_network",         /* POLICYDB_CAP_ALWAYSNETWORK *=
/
> > -       "cgroup_seclabel",              /* POLICYDB_CAP_SECLABEL */
> > -       "nnp_nosuid_transition",        /* POLICYDB_CAP_NNP_NOSUID_TRAN=
SITION */
> > -       "genfs_seclabel_symlinks",      /* POLICYDB_CAP_GENFS_SECLABEL_=
SYMLINKS */
> > -       "ioctl_skip_cloexec",           /* POLICYDB_CAP_IOCTL_SKIP_CLOE=
XEC */
> > -       "userspace_initial_context",    /* POLICYDB_CAP_USERSPACE_INITI=
AL_CONTEXT */
> > -       NULL
> > +static const char * const polcap_names[POLICYDB_CAP_MAX + 1] =3D {
> > +       [POLICYDB_CAP_NETPEER]                          =3D "network_pe=
er_controls",
> > +       [POLICYDB_CAP_OPENPERM]                         =3D "open_perms=
",
> > +       [POLICYDB_CAP_EXTSOCKCLASS]                     =3D "extended_s=
ocket_class",
> > +       [POLICYDB_CAP_ALWAYSNETWORK]                    =3D "always_che=
ck_network",
> > +       [POLICYDB_CAP_CGROUPSECLABEL]                   =3D "cgroup_sec=
label",
> > +       [POLICYDB_CAP_NNP_NOSUID_TRANSITION]            =3D "nnp_nosuid=
_transition",
> > +       [POLICYDB_CAP_GENFS_SECLABEL_SYMLINKS]          =3D "genfs_secl=
abel_symlinks",
> > +       [POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]               =3D "ioctl_skip=
_cloexec",
> > +       [POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]        =3D "userspace_=
initial_context",
> >  };
> >
> >  int sepol_polcap_getnum(const char *name)
> > --
> > 2.42.0
> >
