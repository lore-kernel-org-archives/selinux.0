Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451C4ECAAD1
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 17:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiHaRDG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiHaRCb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 13:02:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01E33DBE6
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 10:02:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so19193954edi.8
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=RU2j5g2s628OmU5PrM6O3dROxNbKg+UjEqkY3DRjNlY=;
        b=qMJG1wJNwnDvnS3jyIi92K9WSKoafDhIV2f05hrrfcTQeeOW6aw3gnmP28u6AviLPQ
         fwsXjSFh6hjdX5tVgha390+j2ZprNAfmreg9jZHgv2p5KU/kQKnoiMx5CRR7m8/la4gd
         ZFt2lNRqIwfN4uqwqusTxw7tv1laqTj8hsDv53jtywj9RPK7lT6VCcCqeNA8S++mxNyE
         8/p1zNhrOxOUOx03EKzjA8D3gz6e9LU9XHHZOvO6Lrqi1zFN7sQK0tfJbqX3RwhjOKam
         bqdWpVLfwfbe+krFt0Iyci+dfl0GzX0u3OmpLlNEPwq6hauL9X/xCoe3AzI+knmD8KTt
         ce3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=RU2j5g2s628OmU5PrM6O3dROxNbKg+UjEqkY3DRjNlY=;
        b=naA9Y2j6cEfc+TxWhwidIMVC3AYrpvuxxKWO3VwTGy0cw6cNoFfecyA2/96scd2pWR
         DVesK9OLPgWXaVp4QOycqY8gtu4QCZ4fkm189cP6QVl1qWKzgp7uWfkLKEosZilSFYTg
         hMTCV+Vmw0gbak9wgASMuxIGdv1MD6kdTxC6KXGLiqCxRV44n+PKV2CtnpMzZU5hWfnh
         TFtKYzp5+2pFzKTljrh86jL+nRnzjyrMBSjweBVFi/e5l4k91sl/eIBOlvMb3bbTuvb4
         nnPBZdBJYRgY8GYYDbf4QMvcZivGuEGsHiuLe1Q91Fxa4u7u2uwmgxUIvo+7taTp4X/J
         Yv9Q==
X-Gm-Message-State: ACgBeo2CHJli3CygWtXSrndWSemf5MCYRZw+11WEowsIr31komJWW/g0
        4Js6MbvlV2GSDuf6rKzr25ln5cavSoQI0lDHn1A=
X-Google-Smtp-Source: AA6agR6/Gwvk1fHLtpwtuztAb2oqltorsnYS0QWGEVgDKyIAfY+t/haOlbzPW6L2vGKjul7rhA71ICL4ztCJKsd1N8A=
X-Received: by 2002:aa7:d58b:0:b0:448:e63d:ee5e with SMTP id
 r11-20020aa7d58b000000b00448e63dee5emr5666669edq.236.1661965344300; Wed, 31
 Aug 2022 10:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
 <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
 <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
 <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com> <CAJ2a_DdgQUhCVWVDwOrT2GK3zJgBA-d58MN3cZk06Qiyrm13cw@mail.gmail.com>
In-Reply-To: <CAJ2a_DdgQUhCVWVDwOrT2GK3zJgBA-d58MN3cZk06Qiyrm13cw@mail.gmail.com>
From:   Ted Toth <txtoth@gmail.com>
Date:   Wed, 31 Aug 2022 12:02:13 -0500
Message-ID: <CAFPpqQHZUV0QLSiv145p6ntt1u6zCY7pNXDpyT-ny_dpo+vnhg@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Paul Moore <paul@paul-moore.com>, SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 31, 2022 at 9:55 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 31 Aug 2022 at 02:47, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Tue, Aug 30, 2022 at 6:04 PM Ted Toth <txtoth@gmail.com> wrote:
> > > On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com> wrot=
e:
> > > >
> > > > On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wrote:
> > > > > I asked on the systemd-devel list about enabling systemd to set t=
he
> > > > > context of a socket and got the answer I've included below. I don=
't
> > > > > know how a transition rule can be written to transition tcp socke=
ts to
> > > > > multiple different target contexts, is this possible and if so ho=
w?
>
> What do you mean by "multiple different target contexts"?

Basically what I meant was that you cannot do the following since the
source and target type are the same and there is no way to specify the
socket other than if it were a UDS (a socket file):
type_transition init_t init_t:tcp_socket app1_socket_t;
type_transition init_t init_t:tcp_socket app2_socket_t;


> How should they be different and how should systemd know?
>
> Socket unit configurations are normally paired with service unit
> configurations (e.g. dovecot.socket <-> dovecot.service).
> To handle incoming traffic the service unit configuration should
> contain an ExecStart=3D directive, to start a program to handle the
> data.
> By default systemd tries at socket creation to predict the context of
> the started program (via security_compute_create_raw(3) in
> src/shared/selinux-util.c:mac_selinux_get_create_label_from_exe()),
> see src/core/socket.c:socket_determine_selinux_label().
>
> For example if the service unit contains ExecStart=3D/usr/bin/myapp and
> /usr/bin/myapp has the context myapp_exec_t and the policy contains
> `type_transition init_t myapp_exec_t:process myapp_t` systemd should
> assign the context myapp_t to the socket specified in the socket unit
> configuration.

I'll look at the code you reference but my experience is that the
socket systemd is listening on is labeled init_t despite, as in your
example above, the executable being labeled properly and transitioning
to the type that I've specified, in the type_transition rule in the
apps policy module, when it is run by systemd.

>
> > > >
> > > > Ignoring setsockcreatecon(3) as that really isn't an option here,
> > >
> > > If we determine that policy can't be written to accomplish the
> > > transition then maybe systemd will reconsider not wanting to set the
> > > socket context using a .socket file option.
> >
> > I think the challenge is going to be having enough information when
> > the socket is created to do any useful type transition.  I'm open to
> > suggestions, but I'm skeptical there is anything we can do beyond the
> > current approach.
> >
> > > > sockets created via socket(2) do check to see if there is a type
> > > > transition defined in the policy.  In the case of a TCP socket the
> > > > type transition would look something like this:
> > > >
> > > >   type_transition <domain> <domain>:tcp_socket <new_socket_type>
> > > >
> > > > ... so you can see there is not much one can select on other than t=
he
> > > > socket's object class.  The reason is that the socket(2) call itsel=
f
> > > > is rather spartan, with not even any clue as to if this is a client=
 or
> > > > server socket in the case of TCP.
> > >
> > > Having written many policy modules, some of which use the
> > > type_transition statement for tcp_socket objects, I do not see how it
> > > can be used to transition sockets created by systemd. And under this
> > > circumstance I see that the selinux socket create hook would not be
> > > able query the policy database for the port context since the port is
> > > not known until the bind occurs but what about having the bind hook
> > > set the socket context if it finds a sid for the port?
> >
> > The problem with waiting until the connect()/bind() is that you are
> > effectively doing a relabel operation, which is a big no-no (but you
> > already know that).  *Maybe* you could justify it in the special case
> > of stream sockets, as I'm pretty sure there is no way to do anything
> > useful with them as a data sink/source until they are either connected
> > to a remote peer or bound to a local port, however, we would all need
> > to think on that for a bit (it is still a relabel, and thus nasty) and
> > probably spend some time staring at the code to make sure there is no
> > way to do something sneaky with an unconnected or unbound stream
> > socket.
> >
> > > > Taking a step back, what are you trying to do?  Perhaps there is
> > > > another approach that would get you where you want to go.
> > >
> > > I want to create socket activation services using systemd and to have
> > > the type of the socket being listened on be one that I've defined so
> > > that I can write policy to control which source types can connect to
> > > it.
> >
> > --
> > paul-moore.com
