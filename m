Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D20C433FE
	for <selinux@archiver.kernel.org>; Mon, 21 Nov 2022 20:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKUU4Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKUU4Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Nov 2022 15:56:24 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DCFD0DE5
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:56:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ft34so31240376ejc.12
        for <selinux@vger.kernel.org>; Mon, 21 Nov 2022 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOVuJW8gbXOUOQ7OhJJ7/enmNkpYzPIQb4QjRWN8vc8=;
        b=oHldNSvloCnnV+ZS5YuKZ6uZPHWhJRMSKzzQEf+c0aR8TXbTKJYTlCg4uVKbTMcxcB
         wN7jXM/96bkHpVvAyZZBmsKkRfl3JQRnQ4NIhe8re2NXMMCajYuR6girnEt/rxWMfj7W
         KXaFFbdp9fCw0QIMWNpd7y4FqpGVZbwaxIbVAnUXqSSqKvBRFuwICSLS9XZacx1VMV2M
         UKhQQKg5GoV8uZ485WpTQZTm9x/xhoRIHJUa19l9Zn4b98v8k67Iu2foK8pDp1ee3T/+
         45aX/zE5InEEM+BSEEMm26nwWGNsYALxO7Bo2oGIrhbtoEJgxWEm8lKwfht1lkFgWVlO
         A/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOVuJW8gbXOUOQ7OhJJ7/enmNkpYzPIQb4QjRWN8vc8=;
        b=2QOcJNSR6IbS2iFHsdPN+6VRjycIo4p/fRm+MR/0KA+dFf3qiilc4j0l7+OLjdKhJu
         EvcNrkNcBcW1fDVUmYQEery9U619MdXvwuHeLyiMEGAL8q+5kbSV+xNiqA+6g7Ce3hZ2
         mABhHPPtaAings2yspUaUC3vmh1atjs5GLSOO303/ejxB9o20D25OoEs+a//eedwk3uA
         l/ADy3i1kLfLTjoOjoKF18cI9WUUiJmeXfcBRGPLfvhBWnlZ3Oyix42EX6cpyd0zZf4C
         AYuT6Qr5dh5WPeo3d6ZuGpjR6VHO0eEOoMhL1lq459qJ0LuvHYWCg+PxRIQABYdkEKMd
         RHrg==
X-Gm-Message-State: ANoB5pnvSmNQ+NCP9MDqz8v3M/RFSc7h8UQBBeWl3EynP27uC71GG2Gn
        +7+JWQYUPv1+88+6SGQ1DxbZ9Oew5Z6ICwZT5ZE=
X-Google-Smtp-Source: AA0mqf46UHe/0wJhiDADUj5UtFMLZMadCLXoCMucJf+7K4IEi177oSBOotUY7t1bxChbvB7vZosdpyMwddbqTzSugmw=
X-Received: by 2002:a17:906:e2cb:b0:7ad:c35a:ad76 with SMTP id
 gr11-20020a170906e2cb00b007adc35aad76mr17063957ejb.705.1669064181838; Mon, 21
 Nov 2022 12:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20221109201701.64203-1-cgzones@googlemail.com> <CAP+JOzR=H2YujfURqnOADxZ1jv1U+A0pzd78p6H0Df-TtY9=sA@mail.gmail.com>
In-Reply-To: <CAP+JOzR=H2YujfURqnOADxZ1jv1U+A0pzd78p6H0Df-TtY9=sA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Nov 2022 15:56:10 -0500
Message-ID: <CAP+JOzT7V+WUMWfXDH0SsXcXfcrcnorhvbqujHE+Ua=RVdXr_A@mail.gmail.com>
Subject: Re: [PATCH] libselinux: drop set but not used internal variable
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 10, 2022 at 9:17 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Nov 9, 2022 at 3:24 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The internal variable avc_netlink_trouble is only assigned but never
> > read from.
> > Unused since the initial commit 13cd4c896068 ("initial import from svn
> > trunk revision 2950").
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/avc_internal.c | 2 --
> >  libselinux/src/avc_internal.h | 3 ---
> >  libselinux/src/sestatus.c     | 1 -
> >  3 files changed, 6 deletions(-)
> >
> > diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_interna=
l.c
> > index 71a1357b..ffc663e5 100644
> > --- a/libselinux/src/avc_internal.c
> > +++ b/libselinux/src/avc_internal.c
> > @@ -51,7 +51,6 @@ char avc_prefix[AVC_PREFIX_SIZE] =3D "uavc";
> >  int avc_running =3D 0;
> >  int avc_enforcing =3D 1;
> >  int avc_setenforce =3D 0;
> > -int avc_netlink_trouble =3D 0;
> >
> >  /* process setenforce events for netlink and sestatus */
> >  int avc_process_setenforce(int enforcing)
> > @@ -295,7 +294,6 @@ void avc_netlink_loop(void)
> >
> >         close(fd);
> >         fd =3D -1;
> > -       avc_netlink_trouble =3D 1;
> >         avc_log(SELINUX_ERROR,
> >                 "%s:  netlink thread: errors encountered, terminating\n=
",
> >                 avc_prefix);
> > diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_interna=
l.h
> > index a9a4aa0b..54f0ce28 100644
> > --- a/libselinux/src/avc_internal.h
> > +++ b/libselinux/src/avc_internal.h
> > @@ -180,7 +180,4 @@ int avc_ss_set_auditdeny(security_id_t ssid, securi=
ty_id_t tsid,
> >                          security_class_t tclass, access_vector_t perms=
,
> >                          uint32_t seqno, uint32_t enable) ;
> >
> > -/* netlink kernel message code */
> > -extern int avc_netlink_trouble ;
> > -
> >  #endif                         /* _SELINUX_AVC_INTERNAL_H_ */
> > diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> > index 89c1f621..fbe64301 100644
> > --- a/libselinux/src/sestatus.c
> > +++ b/libselinux/src/sestatus.c
> > @@ -343,7 +343,6 @@ error:
> >                 if (avc_using_threads)
> >                 {
> >                         fallback_netlink_thread =3D avc_create_thread(&=
avc_netlink_loop);
> > -                       avc_netlink_trouble =3D 0;
> >                 }
> >
> >                 fallback_sequence =3D 0;
> > --
> > 2.38.1
> >
