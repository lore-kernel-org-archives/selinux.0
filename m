Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40816EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 20:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjGQUux (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjGQUuw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 16:50:52 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C810C0
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:50:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso4986356276.2
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689627051; x=1692219051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQvuhpFLaz/ow6oQFOL4+/IASlr49hflcZSKip75GTc=;
        b=AMfaXTW+HTIn1ZrWiPZeRTi097D+iklO2df09dAWMOehCYICFneLFjilYSBQC9HcH7
         Tq8XZr/o/mWt8pPCZUaaCILll6PiabcEeE66Jy/q1bBs8WcoJALmyfQDyrS40aTeQQ4Y
         7IhExT33jFw04mw2yJ45h/T+rF1B+kCxBHuMaT4u8w9NfnykL96H1AoV1IoMEaipHuqW
         mTNj8Z97fuWsSDG6stxPV9pOaKRMJRGt8nz72w8ocvE4BdBiA18p4tKhq8UO0NOUJOrZ
         H8m439iRZPPbJFR/YMTfMm5IkhUmUb4VlIyo4Znx1VZhrwVVf7lNrfAwrYqWboWfv5yy
         a2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689627051; x=1692219051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQvuhpFLaz/ow6oQFOL4+/IASlr49hflcZSKip75GTc=;
        b=LzmIKCHdV4X3EKCWwvda7Z7crSpeHT5/haSu2FTBfwWvajNtUE96KYAcz3BDl1Rif0
         5ym2nNnfzkcZw/fgPOy0jObAgBNslo5sBbLyyw06bpkDWQfrlqQOSZxBvUVMaboIx53i
         98bbc4mK0UbVN3SerWEGrQ/HtPf91kDi7s1kWMRJ39U9j/wd+z9rhNyEgiwz/3uFVEI6
         wpocTPl4C4TUTrFIE6KX7S8DTXitLgsIv0pEF9YsKte/6YBqC3BBSoyamZBD6uxopWLM
         JMz35T4BPZDKg6qnTSn3+izHZaXI6a6FsZ/EQTtdts9Jm2Aicw0fzLH9xjO8mlm+jaHz
         UFxA==
X-Gm-Message-State: ABy/qLakVTJhmcMV0vnU+lpaxbgdoZwJMxF2BZc1I1Cyz2QHVeMpUnE3
        lODT44Wem1E8ZWL34PK026/UVdKyscY5i5yUIpCQ
X-Google-Smtp-Source: APBJJlF15giuoFoTzjJPSaYpOwaMB2a2fzsGAUMwN1+mEM4AYSfLWpgVkcTSMeJVl47iVn8MZ2JRn04zH8f8YWYyAu4=
X-Received: by 2002:a0d:df52:0:b0:573:b42b:4e27 with SMTP id
 i79-20020a0ddf52000000b00573b42b4e27mr13570860ywe.16.1689627050777; Mon, 17
 Jul 2023 13:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230710082500.1838896-1-lsahn@wewakecorp.com>
 <CAHC9VhQY0Uq_xQ_AwAuZ8gJbS52nQvRONHvCxiR-dGDg3BviRw@mail.gmail.com> <0fcac6a8-4ab8-91bc-34e0-cbbb81da3973@schaufler-ca.com>
In-Reply-To: <0fcac6a8-4ab8-91bc-34e0-cbbb81da3973@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:50:40 -0400
Message-ID: <CAHC9VhQ3nmpRQPT6m2jBKtpML0sR9htARWr2cTPt78s=4nRkcg@mail.gmail.com>
Subject: Re: [PATCH] selinux: optimize major part with a kernel config in selinux_mmap_addr()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Leesoo Ahn <lsahn@ooseel.net>, lsahn@wewakecorp.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 17, 2023 at 4:31=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 7/17/2023 1:13 PM, Paul Moore wrote:
> > On Mon, Jul 10, 2023 at 4:25=E2=80=AFAM Leesoo Ahn <lsahn@ooseel.net> w=
rote:
> >> The major part, the conditional branch in selinux_mmap_addr() is alway=
s to be
> >> false so long as CONFIG_LSM_MMAP_MIN_ADDR is set to zero at compile ti=
me.
> >>
> >> This usually happens in some linux distros, for instance Ubuntu, which
> >> the config is set to zero in release version. Therefore it could be a =
bit
> >> optimized with '#if <expr>' at compile time.
> >>
> >> Signed-off-by: Leesoo Ahn <lsahn@wewakecorp.com>
> >> ---
> >>  security/selinux/hooks.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> > First, I agree with Stephen's comments that you should ask your distro
> > (you mentioned Debian) to move MIN_ADDR higher.  Beyond that, I have
> > one request, see below ...
> >
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index d06e350fedee..a049aab6524b 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -3723,11 +3723,13 @@ static int selinux_mmap_addr(unsigned long add=
r)
> >>  {
> >>         int rc =3D 0;
> >>
> >> +#if CONFIG_LSM_MMAP_MIN_ADDR > 0
> >>         if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
> >>                 u32 sid =3D current_sid();
> >>                 rc =3D avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
> >>                                   MEMPROTECT__MMAP_ZERO, NULL);
> >>         }
> >> +#endif
> >>
> >>         return rc;
> >>  }
> > Pre-processor conditionals inside a function are generally something
> > we don't recommend.  In this case I would suggest doing something like
> > this:
> >
> > #if (MMAP_MIN_ADDR > 0)
> > static int selinux_mmap_addr(...)
> > {
> >   /* current func definition */
> > }
> > #else /* MMAP_MIN_ADDR > 0 */
> > static int selinux_mmap_addr(...)
> > {
> >   return 0;
> > }
> > #endif /* MMAP_MIN_ADDR > 0 */
>
> Better yet, skip the #else here and #if out the LSM_HOOK_INIT(mmap_addr, =
...).
> No hook at all is faster than a hook that does nothing.

My only concern with that approach is the disconnected nature: one
ifdef around the func definition, one around the LSM_HOOK_INIT() call.
If we thought a zero MMAP_MIN_ADDR value was a good idea, or even
common, I would be more inclined to pay the bad-code-practices-tax
here, but seeing as we don't want to encourage a zero MMAP_MIN_ADDR
value I'd rather lean towards the more maintainable code.

--=20
paul-moore.com
