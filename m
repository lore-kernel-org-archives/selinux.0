Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C6ECAAD5
	for <selinux@archiver.kernel.org>; Fri,  2 Sep 2022 10:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiIBKBP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Sep 2022 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbiIBKBO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Sep 2022 06:01:14 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51CC80E88
        for <selinux@vger.kernel.org>; Fri,  2 Sep 2022 03:00:53 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 118DFFC145E;
        Fri,  2 Sep 2022 12:00:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1662112851;
        bh=1NYLT+taxBPvYYO/BFcM2XRZo+7VHq4z7VYKVfFfhk4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RQ2+epsn0rzhwzDd4trjBDP6XxoaeDOchf2s3+Hj6/xpUrdohdypQNLJZ4k3vbjA4
         YbbMewXI9FwKJxZjx4X+zBDT0DygFSVO5WwPfpZq/j2BWPGbUng6iDyH2zJWiaY7ww
         EYKfpeFWkII7lG53nX0qJVdOhsXW/FTkGBX7I1Zg=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ted Toth <txtoth@gmail.com>
Cc:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>
Subject: Re: [systemd-devel] socket activation selinux context on create
In-Reply-To: <CAFPpqQEpN74xuoeH+7GNdGxtoDEYC+bqLwCmXtWszZDq6R3xDA@mail.gmail.com>
        (Ted Toth's message of "Thu, 1 Sep 2022 11:57:19 -0500")
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
        <Ywc+pjOFkAEswVuQ@gardel-login>
        <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
        <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
        <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
        <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com>
        <CAJ2a_DdgQUhCVWVDwOrT2GK3zJgBA-d58MN3cZk06Qiyrm13cw@mail.gmail.com>
        <CAFPpqQHZUV0QLSiv145p6ntt1u6zCY7pNXDpyT-ny_dpo+vnhg@mail.gmail.com>
        <875yi8b9ux.fsf@defensec.nl>
        <CAFPpqQEpN74xuoeH+7GNdGxtoDEYC+bqLwCmXtWszZDq6R3xDA@mail.gmail.com>
Date:   Fri, 02 Sep 2022 12:00:50 +0200
Message-ID: <871qsuayel.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ted Toth <txtoth@gmail.com> writes:

>
> I'm running MLS policy. The following commands were run on a RHEL 8
> system without any policy modifications:

As far as i am concerned that is a bug in the policy. systemd certainly
shouldnt be allowed to "accept" on any tcp_socket.

It shouldnt be allowed to create and, listen on, tcp_socket with type
init_t either.

I guess its the nis_enabled "feature" support. Is anyone still using that?

>
> rpm -qa | grep selinux-policy
> selinux-policy-3.14.3-80.el8_5.2.noarch
> selinux-policy-mls-3.14.3-80.el8_5.2.noarch
> selinux-policy-devel-3.14.3-80.el8_5.2.noarch
> [root@dev tedx]# sestatus
> SELinux status:                 enabled
> SELinuxfs mount:                /sys/fs/selinux
> SELinux root directory:         /etc/selinux
> Loaded policy name:             mls
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy MLS status:              enabled
> Policy deny_unknown status:     denied
> Memory protection checking:     actual (secure)
> Max kernel policy version:      33
> [root@dev tedx]# ps -efZ | grep systemd | grep init_t
> system_u:system_r:init_t:s0-s15:c0.c1023 root  1       0  0 11:35 ?
>     00:00:02 /usr/lib/systemd/systemd --switched-root --system
> --deserialize 18
> [root@bbws-dev tedx]# sesearch -A -t init_t -s init_t -c tcp_socket
> allow init_t init_t:tcp_socket { accept append bind connect create
> getattr getopt ioctl listen lock read setattr setopt shutdown write };
> allow init_t init_t:tcp_socket { accept append bind connect create
> getattr getopt ioctl listen lock read setattr setopt shutdown write };
> [ nis_enabled ]:True
> allow init_t init_t:tcp_socket { append bind connect create getattr
> getopt ioctl lock read setattr setopt shutdown write }; [
> authlogin_nsswitch_use_ldap ]:True
> allow init_t init_t:tcp_socket { append bind connect create getattr
> getopt ioctl lock read setattr setopt shutdown write }; [
> kerberos_enabled ]:True
>
> On Wed, Aug 31, 2022 at 12:28 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> Ted Toth <txtoth@gmail.com> writes:
>>
>> >
>> > On Wed, Aug 31, 2022 at 9:55 AM Christian G=C3=B6ttsche
>> > <cgzones@googlemail.com> wrote:
>> >>
>> >> On Wed, 31 Aug 2022 at 02:47, Paul Moore <paul@paul-moore.com> wrote:
>> >> >
>> >> > On Tue, Aug 30, 2022 at 6:04 PM Ted Toth <txtoth@gmail.com> wrote:
>> >> > > On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com> =
wrote:
>> >> > > >
>> >> > > > On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wro=
te:
>> >> > > > > I asked on the systemd-devel list about enabling systemd to s=
et the
>> >> > > > > context of a socket and got the answer I've included below. I=
 don't
>> >> > > > > know how a transition rule can be written to transition tcp s=
ockets to
>> >> > > > > multiple different target contexts, is this possible and if s=
o how?
>> >>
>> >> What do you mean by "multiple different target contexts"?
>> >
>> > Basically what I meant was that you cannot do the following since the
>> > source and target type are the same and there is no way to specify the
>> > socket other than if it were a UDS (a socket file):
>> > type_transition init_t init_t:tcp_socket app1_socket_t;
>> > type_transition init_t init_t:tcp_socket app2_socket_t;
>> >
>> >
>> >> How should they be different and how should systemd know?
>> >>
>> >> Socket unit configurations are normally paired with service unit
>> >> configurations (e.g. dovecot.socket <-> dovecot.service).
>> >> To handle incoming traffic the service unit configuration should
>> >> contain an ExecStart=3D directive, to start a program to handle the
>> >> data.
>> >> By default systemd tries at socket creation to predict the context of
>> >> the started program (via security_compute_create_raw(3) in
>> >> src/shared/selinux-util.c:mac_selinux_get_create_label_from_exe()),
>> >> see src/core/socket.c:socket_determine_selinux_label().
>> >>
>> >> For example if the service unit contains ExecStart=3D/usr/bin/myapp a=
nd
>> >> /usr/bin/myapp has the context myapp_exec_t and the policy contains
>> >> `type_transition init_t myapp_exec_t:process myapp_t` systemd should
>> >> assign the context myapp_t to the socket specified in the socket unit
>> >> configuration.
>> >
>> > I'll look at the code you reference but my experience is that the
>> > socket systemd is listening on is labeled init_t despite, as in your
>> > example above, the executable being labeled properly and transitioning
>> > to the type that I've specified, in the type_transition rule in the
>> > apps policy module, when it is run by systemd.
>>
>> I am confident that, if were talking about socket activation, this is
>> not the case. systemd will create, and listen on the socket with the con=
text of the
>> domain that will "accept" the connection.
>>
>> for example i have a mpd instance that is socket activated:
>>
>> root@brutus:~# ss -antlpZ | grep 6600
>> LISTEN 0      5                  *:6600            *:*
>> users:(("systemd",pid=3D968,proc_ctx=3Dwheel.id:wheel.role:user.systemd.=
subj:s0,fd=3D33))
>>
>> systemd is listening on behalf of mpd.
>>
>> if i query the policy:
>>
>> root@brutus:~# sesearch -A -s user.systemd.subj -t user.systemd.subj -c
>> tcp_socket
>>
>> ... nothing returns. systemd is not allowed to create tcp_socket with
>> its own domain type or listen on them. Yes it is still listening on
>> tcp:6600
>>
>> this is because:
>>
>> root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c tcp_=
socket
>> allow user.systemd.subj
>> user.systemd.socketactivated.tcp.typeattr:tcp_socket { append bind
>> connect create getattr getopt ioctl listen read setattr setopt
>> shutdown write };
>>
>> this systemd created a tcp_socket with type user.mpd.subj (on behalf of
>> mpd) and listens for connections on that tcp_socket. Once a connection
>> comes in then mpd with accept it (not that user.systemd.subj is not
>> allowed to accept tcp_socket on behalf of mpd (or any tcp_socket for
>> that matter:
>>
>> root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c
>> tcp_socket -p accept
>>
>> ... nothing returned.
>>
>> >
>> >>
>> >> > > >
>> >> > > > Ignoring setsockcreatecon(3) as that really isn't an option her=
e,
>> >> > >
>> >> > > If we determine that policy can't be written to accomplish the
>> >> > > transition then maybe systemd will reconsider not wanting to set =
the
>> >> > > socket context using a .socket file option.
>> >> >
>> >> > I think the challenge is going to be having enough information when
>> >> > the socket is created to do any useful type transition.  I'm open to
>> >> > suggestions, but I'm skeptical there is anything we can do beyond t=
he
>> >> > current approach.
>> >> >
>> >> > > > sockets created via socket(2) do check to see if there is a type
>> >> > > > transition defined in the policy.  In the case of a TCP socket =
the
>> >> > > > type transition would look something like this:
>> >> > > >
>> >> > > >   type_transition <domain> <domain>:tcp_socket <new_socket_type>
>> >> > > >
>> >> > > > ... so you can see there is not much one can select on other th=
an the
>> >> > > > socket's object class.  The reason is that the socket(2) call i=
tself
>> >> > > > is rather spartan, with not even any clue as to if this is a cl=
ient or
>> >> > > > server socket in the case of TCP.
>> >> > >
>> >> > > Having written many policy modules, some of which use the
>> >> > > type_transition statement for tcp_socket objects, I do not see ho=
w it
>> >> > > can be used to transition sockets created by systemd. And under t=
his
>> >> > > circumstance I see that the selinux socket create hook would not =
be
>> >> > > able query the policy database for the port context since the por=
t is
>> >> > > not known until the bind occurs but what about having the bind ho=
ok
>> >> > > set the socket context if it finds a sid for the port?
>> >> >
>> >> > The problem with waiting until the connect()/bind() is that you are
>> >> > effectively doing a relabel operation, which is a big no-no (but you
>> >> > already know that).  *Maybe* you could justify it in the special ca=
se
>> >> > of stream sockets, as I'm pretty sure there is no way to do anything
>> >> > useful with them as a data sink/source until they are either connec=
ted
>> >> > to a remote peer or bound to a local port, however, we would all ne=
ed
>> >> > to think on that for a bit (it is still a relabel, and thus nasty) =
and
>> >> > probably spend some time staring at the code to make sure there is =
no
>> >> > way to do something sneaky with an unconnected or unbound stream
>> >> > socket.
>> >> >
>> >> > > > Taking a step back, what are you trying to do?  Perhaps there is
>> >> > > > another approach that would get you where you want to go.
>> >> > >
>> >> > > I want to create socket activation services using systemd and to =
have
>> >> > > the type of the socket being listened on be one that I've defined=
 so
>> >> > > that I can write policy to control which source types can connect=
 to
>> >> > > it.
>> >> >
>> >> > --
>> >> > paul-moore.com
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl
>> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> Dominick Grift

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
