Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A675C38145
	for <selinux@archiver.kernel.org>; Fri,  2 Sep 2022 14:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiIBOhD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbiIBOgk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Sep 2022 10:36:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2191146E30
        for <selinux@vger.kernel.org>; Fri,  2 Sep 2022 06:57:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y3so4105640ejc.1
        for <selinux@vger.kernel.org>; Fri, 02 Sep 2022 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Sl0BzuNuEq9nzVG2zR2+CGyyCBjqHDxnXoxaTsfSN2c=;
        b=Y/A/Mz69GyMSKVc7leI8fBMUyMzmGw2UlvOttuLLkz8xdGR3jeUbCDWyGU4O23Y0b1
         KtzckiB5xQ8ynDIudqq23NqTqvIDD6nfI5OToQ1PGFEpAMxegRfhFJ+7Vm2LHq3gHkNz
         SE5Ex/svHxke/MLSuCaYJNFLaoh1ZQqVDcDHo5ldTPC2u4CHLjkIWhW24SchTsBuGl4k
         hVV5YPWLkLpElr+qBIX6wugqlK2LoTawdpEGVClfyYH8c1e5MO3M/cPuQdKhD0WyyVt6
         FVSBo2S5zI644Ezm6e0bLn0qBxXjlY1d4AbeRRDHzoq5ARvXHw/vFVS+VZdraoOtdp65
         V2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sl0BzuNuEq9nzVG2zR2+CGyyCBjqHDxnXoxaTsfSN2c=;
        b=J00tuFBx2pYNFpQhrMoKaNdpQaX2lm0sq0nR1eDjTAHSh3G/NAjNRcdoQ9cP9EYz8e
         KjkG2J3WG0befOmUnxBaJ2qUeM4+fevYHwk4pGfdmz5mFYn6t09p1HsmMnF2TFnovLCq
         bC/3ST5/kNhPLrNVw9qN0X/B2wGFk5/dhSWh5l/skZYgtAenWAFjZnymsGQZDxJ2cvs1
         HENXd+W/FbNNLk7LKM3wDlPK+0sPmfYxF9NN06/RR+Dji7NF4rxS7bfT6MPioo1nyiTS
         RPEN1bp7YTStVujlCsGb2XcIflWtLo03Cjl/fZt8vGyHuicD1fgPUPWiVsusKjliOwt0
         LqCQ==
X-Gm-Message-State: ACgBeo1PSUemU1QJVF4YcNG9bdUSFPCe/g1lq4rmaSQq8rmWyoAoATLV
        OvZA/aLfuqfPvCCoNl0b0FegQOtSRAKf+btknRI=
X-Google-Smtp-Source: AA6agR5bruMEfoAr/qa0oV73SsNQZ2teWw8nE2QRO7Crzpa6WYLYrp9m0nT/l2dziF+6NobPbJ5i4IqbAS6XGxNUzPo=
X-Received: by 2002:a17:906:cc5d:b0:73f:e0cd:9e64 with SMTP id
 mm29-20020a170906cc5d00b0073fe0cd9e64mr22966538ejb.536.1662127018008; Fri, 02
 Sep 2022 06:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
 <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
 <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
 <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com>
 <CAJ2a_DdgQUhCVWVDwOrT2GK3zJgBA-d58MN3cZk06Qiyrm13cw@mail.gmail.com>
 <CAFPpqQHZUV0QLSiv145p6ntt1u6zCY7pNXDpyT-ny_dpo+vnhg@mail.gmail.com>
 <875yi8b9ux.fsf@defensec.nl> <CAFPpqQEpN74xuoeH+7GNdGxtoDEYC+bqLwCmXtWszZDq6R3xDA@mail.gmail.com>
 <871qsuayel.fsf@defensec.nl>
In-Reply-To: <871qsuayel.fsf@defensec.nl>
From:   Ted Toth <txtoth@gmail.com>
Date:   Fri, 2 Sep 2022 08:56:46 -0500
Message-ID: <CAFPpqQF-64o7_4Pg2sV=3OoqGGKmXw9G2otsDC+WBc5a=X4HRQ@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A couple of things and I understand that this isn't the place to
discuss systemd issues so please forgive me.

Dominick, I'm not sure what should be done about your argument that
systemd shouldn't be able to create, accept, ... sockets, open a bug
on RHEL policy?

Christian, I looked at the systemd code and see why the bound socket
is init_t, it is because I use the SELinuxContextFromNet so that my
service runs at the level (MLS) of the peer.
socket_determine_selinux_label checks to see if the
SELinuxContestFromNet option is set and if so eventually calls
getcon_raw (there is a misleading comment that reads in part "get
label from network label") which I don't think is the right thing to
do. Instead I think socket_determine_selinux_label should first check
the policy db to see if a port type has been set and if so use it.

On Fri, Sep 2, 2022 at 5:00 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Ted Toth <txtoth@gmail.com> writes:
>
> >
> > I'm running MLS policy. The following commands were run on a RHEL 8
> > system without any policy modifications:
>
> As far as i am concerned that is a bug in the policy. systemd certainly
> shouldnt be allowed to "accept" on any tcp_socket.
>
> It shouldnt be allowed to create and, listen on, tcp_socket with type
> init_t either.
>
> I guess its the nis_enabled "feature" support. Is anyone still using that=
?
>
> >
> > rpm -qa | grep selinux-policy
> > selinux-policy-3.14.3-80.el8_5.2.noarch
> > selinux-policy-mls-3.14.3-80.el8_5.2.noarch
> > selinux-policy-devel-3.14.3-80.el8_5.2.noarch
> > [root@dev tedx]# sestatus
> > SELinux status:                 enabled
> > SELinuxfs mount:                /sys/fs/selinux
> > SELinux root directory:         /etc/selinux
> > Loaded policy name:             mls
> > Current mode:                   permissive
> > Mode from config file:          permissive
> > Policy MLS status:              enabled
> > Policy deny_unknown status:     denied
> > Memory protection checking:     actual (secure)
> > Max kernel policy version:      33
> > [root@dev tedx]# ps -efZ | grep systemd | grep init_t
> > system_u:system_r:init_t:s0-s15:c0.c1023 root  1       0  0 11:35 ?
> >     00:00:02 /usr/lib/systemd/systemd --switched-root --system
> > --deserialize 18
> > [root@bbws-dev tedx]# sesearch -A -t init_t -s init_t -c tcp_socket
> > allow init_t init_t:tcp_socket { accept append bind connect create
> > getattr getopt ioctl listen lock read setattr setopt shutdown write };
> > allow init_t init_t:tcp_socket { accept append bind connect create
> > getattr getopt ioctl listen lock read setattr setopt shutdown write };
> > [ nis_enabled ]:True
> > allow init_t init_t:tcp_socket { append bind connect create getattr
> > getopt ioctl lock read setattr setopt shutdown write }; [
> > authlogin_nsswitch_use_ldap ]:True
> > allow init_t init_t:tcp_socket { append bind connect create getattr
> > getopt ioctl lock read setattr setopt shutdown write }; [
> > kerberos_enabled ]:True
> >
> > On Wed, Aug 31, 2022 at 12:28 PM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> Ted Toth <txtoth@gmail.com> writes:
> >>
> >> >
> >> > On Wed, Aug 31, 2022 at 9:55 AM Christian G=C3=B6ttsche
> >> > <cgzones@googlemail.com> wrote:
> >> >>
> >> >> On Wed, 31 Aug 2022 at 02:47, Paul Moore <paul@paul-moore.com> wrot=
e:
> >> >> >
> >> >> > On Tue, Aug 30, 2022 at 6:04 PM Ted Toth <txtoth@gmail.com> wrote=
:
> >> >> > > On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com=
> wrote:
> >> >> > > >
> >> >> > > > On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> w=
rote:
> >> >> > > > > I asked on the systemd-devel list about enabling systemd to=
 set the
> >> >> > > > > context of a socket and got the answer I've included below.=
 I don't
> >> >> > > > > know how a transition rule can be written to transition tcp=
 sockets to
> >> >> > > > > multiple different target contexts, is this possible and if=
 so how?
> >> >>
> >> >> What do you mean by "multiple different target contexts"?
> >> >
> >> > Basically what I meant was that you cannot do the following since th=
e
> >> > source and target type are the same and there is no way to specify t=
he
> >> > socket other than if it were a UDS (a socket file):
> >> > type_transition init_t init_t:tcp_socket app1_socket_t;
> >> > type_transition init_t init_t:tcp_socket app2_socket_t;
> >> >
> >> >
> >> >> How should they be different and how should systemd know?
> >> >>
> >> >> Socket unit configurations are normally paired with service unit
> >> >> configurations (e.g. dovecot.socket <-> dovecot.service).
> >> >> To handle incoming traffic the service unit configuration should
> >> >> contain an ExecStart=3D directive, to start a program to handle the
> >> >> data.
> >> >> By default systemd tries at socket creation to predict the context =
of
> >> >> the started program (via security_compute_create_raw(3) in
> >> >> src/shared/selinux-util.c:mac_selinux_get_create_label_from_exe()),
> >> >> see src/core/socket.c:socket_determine_selinux_label().
> >> >>
> >> >> For example if the service unit contains ExecStart=3D/usr/bin/myapp=
 and
> >> >> /usr/bin/myapp has the context myapp_exec_t and the policy contains
> >> >> `type_transition init_t myapp_exec_t:process myapp_t` systemd shoul=
d
> >> >> assign the context myapp_t to the socket specified in the socket un=
it
> >> >> configuration.
> >> >
> >> > I'll look at the code you reference but my experience is that the
> >> > socket systemd is listening on is labeled init_t despite, as in your
> >> > example above, the executable being labeled properly and transitioni=
ng
> >> > to the type that I've specified, in the type_transition rule in the
> >> > apps policy module, when it is run by systemd.
> >>
> >> I am confident that, if were talking about socket activation, this is
> >> not the case. systemd will create, and listen on the socket with the c=
ontext of the
> >> domain that will "accept" the connection.
> >>
> >> for example i have a mpd instance that is socket activated:
> >>
> >> root@brutus:~# ss -antlpZ | grep 6600
> >> LISTEN 0      5                  *:6600            *:*
> >> users:(("systemd",pid=3D968,proc_ctx=3Dwheel.id:wheel.role:user.system=
d.subj:s0,fd=3D33))
> >>
> >> systemd is listening on behalf of mpd.
> >>
> >> if i query the policy:
> >>
> >> root@brutus:~# sesearch -A -s user.systemd.subj -t user.systemd.subj -=
c
> >> tcp_socket
> >>
> >> ... nothing returns. systemd is not allowed to create tcp_socket with
> >> its own domain type or listen on them. Yes it is still listening on
> >> tcp:6600
> >>
> >> this is because:
> >>
> >> root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c tc=
p_socket
> >> allow user.systemd.subj
> >> user.systemd.socketactivated.tcp.typeattr:tcp_socket { append bind
> >> connect create getattr getopt ioctl listen read setattr setopt
> >> shutdown write };
> >>
> >> this systemd created a tcp_socket with type user.mpd.subj (on behalf o=
f
> >> mpd) and listens for connections on that tcp_socket. Once a connection
> >> comes in then mpd with accept it (not that user.systemd.subj is not
> >> allowed to accept tcp_socket on behalf of mpd (or any tcp_socket for
> >> that matter:
> >>
> >> root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c
> >> tcp_socket -p accept
> >>
> >> ... nothing returned.
> >>
> >> >
> >> >>
> >> >> > > >
> >> >> > > > Ignoring setsockcreatecon(3) as that really isn't an option h=
ere,
> >> >> > >
> >> >> > > If we determine that policy can't be written to accomplish the
> >> >> > > transition then maybe systemd will reconsider not wanting to se=
t the
> >> >> > > socket context using a .socket file option.
> >> >> >
> >> >> > I think the challenge is going to be having enough information wh=
en
> >> >> > the socket is created to do any useful type transition.  I'm open=
 to
> >> >> > suggestions, but I'm skeptical there is anything we can do beyond=
 the
> >> >> > current approach.
> >> >> >
> >> >> > > > sockets created via socket(2) do check to see if there is a t=
ype
> >> >> > > > transition defined in the policy.  In the case of a TCP socke=
t the
> >> >> > > > type transition would look something like this:
> >> >> > > >
> >> >> > > >   type_transition <domain> <domain>:tcp_socket <new_socket_ty=
pe>
> >> >> > > >
> >> >> > > > ... so you can see there is not much one can select on other =
than the
> >> >> > > > socket's object class.  The reason is that the socket(2) call=
 itself
> >> >> > > > is rather spartan, with not even any clue as to if this is a =
client or
> >> >> > > > server socket in the case of TCP.
> >> >> > >
> >> >> > > Having written many policy modules, some of which use the
> >> >> > > type_transition statement for tcp_socket objects, I do not see =
how it
> >> >> > > can be used to transition sockets created by systemd. And under=
 this
> >> >> > > circumstance I see that the selinux socket create hook would no=
t be
> >> >> > > able query the policy database for the port context since the p=
ort is
> >> >> > > not known until the bind occurs but what about having the bind =
hook
> >> >> > > set the socket context if it finds a sid for the port?
> >> >> >
> >> >> > The problem with waiting until the connect()/bind() is that you a=
re
> >> >> > effectively doing a relabel operation, which is a big no-no (but =
you
> >> >> > already know that).  *Maybe* you could justify it in the special =
case
> >> >> > of stream sockets, as I'm pretty sure there is no way to do anyth=
ing
> >> >> > useful with them as a data sink/source until they are either conn=
ected
> >> >> > to a remote peer or bound to a local port, however, we would all =
need
> >> >> > to think on that for a bit (it is still a relabel, and thus nasty=
) and
> >> >> > probably spend some time staring at the code to make sure there i=
s no
> >> >> > way to do something sneaky with an unconnected or unbound stream
> >> >> > socket.
> >> >> >
> >> >> > > > Taking a step back, what are you trying to do?  Perhaps there=
 is
> >> >> > > > another approach that would get you where you want to go.
> >> >> > >
> >> >> > > I want to create socket activation services using systemd and t=
o have
> >> >> > > the type of the socket being listened on be one that I've defin=
ed so
> >> >> > > that I can write policy to control which source types can conne=
ct to
> >> >> > > it.
> >> >> >
> >> >> > --
> >> >> > paul-moore.com
> >>
> >> --
> >> gpg --locate-keys dominick.grift@defensec.nl
> >> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> >> Dominick Grift
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
