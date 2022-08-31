Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40F9ECAAD1
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 17:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiHaRgW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiHaRgV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Aug 2022 13:36:21 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 10:36:20 PDT
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80449A7AA6
        for <selinux@vger.kernel.org>; Wed, 31 Aug 2022 10:36:20 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 544E2FC09F0;
        Wed, 31 Aug 2022 19:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1661966935;
        bh=dr54SxD+c7/2MHTyJWdkvngtkdsq+jOMQDxBOBUIRr8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DeMFA6BaiSvRvLumogp92SqcQQYOH2Wdh3xFO2ypkBQ0ImbqHtEQ/jMT5+h6AIFrF
         dz1zvO7sv8x9GnS/2H/HauO5yZqTW2z2CpE1FmJqrNJp2qkCVI7wouhDm/27kGyVf6
         LJEqc7jBNKJaayUNx7DKyr5ONLBzUn+I3AcF1GWI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ted Toth <txtoth@gmail.com>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>
Subject: Re: [systemd-devel] socket activation selinux context on create
In-Reply-To: <CAFPpqQHZUV0QLSiv145p6ntt1u6zCY7pNXDpyT-ny_dpo+vnhg@mail.gmail.com>
        (Ted Toth's message of "Wed, 31 Aug 2022 12:02:13 -0500")
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
        <Ywc+pjOFkAEswVuQ@gardel-login>
        <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
        <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
        <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
        <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com>
        <CAJ2a_DdgQUhCVWVDwOrT2GK3zJgBA-d58MN3cZk06Qiyrm13cw@mail.gmail.com>
        <CAFPpqQHZUV0QLSiv145p6ntt1u6zCY7pNXDpyT-ny_dpo+vnhg@mail.gmail.com>
Date:   Wed, 31 Aug 2022 19:28:54 +0200
Message-ID: <875yi8b9ux.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ted Toth <txtoth@gmail.com> writes:

>
> On Wed, Aug 31, 2022 at 9:55 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
>>
>> On Wed, 31 Aug 2022 at 02:47, Paul Moore <paul@paul-moore.com> wrote:
>> >
>> > On Tue, Aug 30, 2022 at 6:04 PM Ted Toth <txtoth@gmail.com> wrote:
>> > > On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com> wro=
te:
>> > > >
>> > > > On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wrote:
>> > > > > I asked on the systemd-devel list about enabling systemd to set =
the
>> > > > > context of a socket and got the answer I've included below. I do=
n't
>> > > > > know how a transition rule can be written to transition tcp sock=
ets to
>> > > > > multiple different target contexts, is this possible and if so h=
ow?
>>
>> What do you mean by "multiple different target contexts"?
>
> Basically what I meant was that you cannot do the following since the
> source and target type are the same and there is no way to specify the
> socket other than if it were a UDS (a socket file):
> type_transition init_t init_t:tcp_socket app1_socket_t;
> type_transition init_t init_t:tcp_socket app2_socket_t;
>
>
>> How should they be different and how should systemd know?
>>
>> Socket unit configurations are normally paired with service unit
>> configurations (e.g. dovecot.socket <-> dovecot.service).
>> To handle incoming traffic the service unit configuration should
>> contain an ExecStart=3D directive, to start a program to handle the
>> data.
>> By default systemd tries at socket creation to predict the context of
>> the started program (via security_compute_create_raw(3) in
>> src/shared/selinux-util.c:mac_selinux_get_create_label_from_exe()),
>> see src/core/socket.c:socket_determine_selinux_label().
>>
>> For example if the service unit contains ExecStart=3D/usr/bin/myapp and
>> /usr/bin/myapp has the context myapp_exec_t and the policy contains
>> `type_transition init_t myapp_exec_t:process myapp_t` systemd should
>> assign the context myapp_t to the socket specified in the socket unit
>> configuration.
>
> I'll look at the code you reference but my experience is that the
> socket systemd is listening on is labeled init_t despite, as in your
> example above, the executable being labeled properly and transitioning
> to the type that I've specified, in the type_transition rule in the
> apps policy module, when it is run by systemd.

I am confident that, if were talking about socket activation, this is
not the case. systemd will create, and listen on the socket with the contex=
t of the
domain that will "accept" the connection.

for example i have a mpd instance that is socket activated:

root@brutus:~# ss -antlpZ | grep 6600
LISTEN 0      5                  *:6600            *:*
users:(("systemd",pid=3D968,proc_ctx=3Dwheel.id:wheel.role:user.systemd.sub=
j:s0,fd=3D33))

systemd is listening on behalf of mpd.

if i query the policy:

root@brutus:~# sesearch -A -s user.systemd.subj -t user.systemd.subj -c
tcp_socket

... nothing returns. systemd is not allowed to create tcp_socket with
its own domain type or listen on them. Yes it is still listening on
tcp:6600

this is because:

root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c tcp_soc=
ket
allow user.systemd.subj user.systemd.socketactivated.tcp.typeattr:tcp_socke=
t { append bind connect create getattr getopt ioctl listen read setattr set=
opt shutdown write };

this systemd created a tcp_socket with type user.mpd.subj (on behalf of
mpd) and listens for connections on that tcp_socket. Once a connection
comes in then mpd with accept it (not that user.systemd.subj is not
allowed to accept tcp_socket on behalf of mpd (or any tcp_socket for
that matter:

root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c
tcp_socket -p accept

... nothing returned.

>
>>
>> > > >
>> > > > Ignoring setsockcreatecon(3) as that really isn't an option here,
>> > >
>> > > If we determine that policy can't be written to accomplish the
>> > > transition then maybe systemd will reconsider not wanting to set the
>> > > socket context using a .socket file option.
>> >
>> > I think the challenge is going to be having enough information when
>> > the socket is created to do any useful type transition.  I'm open to
>> > suggestions, but I'm skeptical there is anything we can do beyond the
>> > current approach.
>> >
>> > > > sockets created via socket(2) do check to see if there is a type
>> > > > transition defined in the policy.  In the case of a TCP socket the
>> > > > type transition would look something like this:
>> > > >
>> > > >   type_transition <domain> <domain>:tcp_socket <new_socket_type>
>> > > >
>> > > > ... so you can see there is not much one can select on other than =
the
>> > > > socket's object class.  The reason is that the socket(2) call itse=
lf
>> > > > is rather spartan, with not even any clue as to if this is a clien=
t or
>> > > > server socket in the case of TCP.
>> > >
>> > > Having written many policy modules, some of which use the
>> > > type_transition statement for tcp_socket objects, I do not see how it
>> > > can be used to transition sockets created by systemd. And under this
>> > > circumstance I see that the selinux socket create hook would not be
>> > > able query the policy database for the port context since the port is
>> > > not known until the bind occurs but what about having the bind hook
>> > > set the socket context if it finds a sid for the port?
>> >
>> > The problem with waiting until the connect()/bind() is that you are
>> > effectively doing a relabel operation, which is a big no-no (but you
>> > already know that).  *Maybe* you could justify it in the special case
>> > of stream sockets, as I'm pretty sure there is no way to do anything
>> > useful with them as a data sink/source until they are either connected
>> > to a remote peer or bound to a local port, however, we would all need
>> > to think on that for a bit (it is still a relabel, and thus nasty) and
>> > probably spend some time staring at the code to make sure there is no
>> > way to do something sneaky with an unconnected or unbound stream
>> > socket.
>> >
>> > > > Taking a step back, what are you trying to do?  Perhaps there is
>> > > > another approach that would get you where you want to go.
>> > >
>> > > I want to create socket activation services using systemd and to have
>> > > the type of the socket being listened on be one that I've defined so
>> > > that I can write policy to control which source types can connect to
>> > > it.
>> >
>> > --
>> > paul-moore.com

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
