Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27228C61DA4
	for <selinux@archiver.kernel.org>; Mon, 13 Mar 2023 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCMUn4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCMUnz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Mar 2023 16:43:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0437B21959
        for <selinux@vger.kernel.org>; Mon, 13 Mar 2023 13:43:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u5so4877763ybm.7
        for <selinux@vger.kernel.org>; Mon, 13 Mar 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678740226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpallsyVWp4X08BRu3LzaIlUbB9qVedyIOW4XaLO78U=;
        b=Dx4W9y+4xxpBpOolAKWkBObbAUSIOoX15XjrVmudQUQkcarwJO9dT/EhcKvnmhM3Fr
         WXwSkHhcaxuCM8SBlGj3oE7APCuTCpfnnSPWk0SK9EhPd7iT/tXv6ypU0poAJsArJqO7
         AqRRPpbQGwNgk1m8W70qIQMEvH5luiJiLd2PknArRGQ9VMCcXARtSbEJatx2hSRZC7bs
         4g/tYhfdljmFC6S+XSmvmE+k8gZSo7lHoynQbkq8/TFcj7GlC5RLe4RPqFBXWvIIaVG4
         NA9QjSkSBh1tnKXNzk0gbJ+nkoadadzD9J+lx5jzzgwpkkbpE6A2YfTyNjs0o7M5+rNT
         2xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpallsyVWp4X08BRu3LzaIlUbB9qVedyIOW4XaLO78U=;
        b=7uoAFId7Sx6jjaMpJo3ZjFYrnvQoyyT80YamuaUatrL6GCjX7UTs9P6myBdWn56dkF
         2kEZ3QObs99nTusS7xmxYlJ0sQehoc86hplRZUGD1wparZw582VTDj7wkEuNnSr2aFj9
         F7+FH2wm/B1hAwhBRjgq8znaVdCvepe/BRds+KMV0hBmCRxxev0tge9woR4iD/totLdz
         BtM2ErOM5OkKrREyzia5srjoBybgDgU5vVXQKy2QEPqiSAsn5dAadccyDgRnuz3OC69d
         s00xIVFLQSYELm7GZpx0mc2os3/uL+6vbVjA+mHE4PwKuYPjwifPbQpo1dFCujdEddRX
         1vYA==
X-Gm-Message-State: AO0yUKV2ELvJbkBV6JYjKiBclCznOYmjmeNUIE0ony2vNmYyCO7qEEsu
        CtgYuwrgCraUUrDcRyuQ9IzkhclhT3GeyZi9UhWf
X-Google-Smtp-Source: AK7set/1ypMPSZDs4sjqyzXZkstT0dQPtsqkKvXnonoSsgmW2pediUdIt/g4UY9GajMI7WUokHtC6jGZjJ9LMqdP+SU=
X-Received: by 2002:a05:6902:4f0:b0:ab8:1ed9:cfc1 with SMTP id
 w16-20020a05690204f000b00ab81ed9cfc1mr19911211ybs.3.1678740226073; Mon, 13
 Mar 2023 13:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230313113211.178010-1-aleksandr.mikhalitsyn@canonical.com> <CAEivzxf630y_kjVLNM4m1vfQxnwyOBK+0wiCLW1T+8miPVC5Fg@mail.gmail.com>
In-Reply-To: <CAEivzxf630y_kjVLNM4m1vfQxnwyOBK+0wiCLW1T+8miPVC5Fg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Mar 2023 16:43:35 -0400
Message-ID: <CAHC9VhT2-QJ6yRoAvbicg5n_NUZLpJ5YjNer4TcHwiaW2hq6FQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] scm: fix MSG_CTRUNC setting condition for SO_PASSSEC
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 13, 2023 at 7:40=E2=80=AFAM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> +CC security subsystem folks
>
> On Mon, Mar 13, 2023 at 12:32=E2=80=AFPM Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > Currently, kernel would set MSG_CTRUNC flag if msg_control buffer
> > wasn't provided and SO_PASSCRED was set or if there was pending SCM_RIG=
HTS.
> >
> > For some reason we have no corresponding check for SO_PASSSEC.
> >
> > In the recvmsg(2) doc we have:
> >        MSG_CTRUNC
> >               indicates that some control data was discarded due to lac=
k
> >               of space in the buffer for ancillary data.
> >
> > So, we need to set MSG_CTRUNC flag for all types of SCM.
> >
> > This change can break applications those don't check MSG_CTRUNC flag.

Unless I'm missing something I don't think this will actually result
in a userspace visible change as put_cmsg() already has a number of
checks which set the MSG_CTRUNC flag if necessary (including if no
control buffer is passed, e.g. msg_control =3D=3D NULL).

Regardless, it looks fine to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> >
> > v2:
> > - commit message was rewritten according to Eric's suggestion
> > ---
> >  include/net/scm.h | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/scm.h b/include/net/scm.h
> > index 1ce365f4c256..585adc1346bd 100644
> > --- a/include/net/scm.h
> > +++ b/include/net/scm.h
> > @@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *sock=
, struct msghdr *msg, struct sc
> >                 }
> >         }
> >  }
> > +
> > +static inline bool scm_has_secdata(struct socket *sock)
> > +{
> > +       return test_bit(SOCK_PASSSEC, &sock->flags);
> > +}
> >  #else
> >  static inline void scm_passec(struct socket *sock, struct msghdr *msg,=
 struct scm_cookie *scm)
> >  { }
> > +
> > +static inline bool scm_has_secdata(struct socket *sock)
> > +{
> > +       return false;
> > +}
> >  #endif /* CONFIG_SECURITY_NETWORK */
> >
> >  static __inline__ void scm_recv(struct socket *sock, struct msghdr *ms=
g,
> >                                 struct scm_cookie *scm, int flags)
> >  {
> >         if (!msg->msg_control) {
> > -               if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
> > +               if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp ||
> > +                   scm_has_secdata(sock))
> >                         msg->msg_flags |=3D MSG_CTRUNC;
> >                 scm_destroy(scm);
> >                 return;
> > --
> > 2.34.1

--=20
paul-moore.com
