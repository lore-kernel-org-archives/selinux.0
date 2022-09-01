Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FCECAAD1
	for <selinux@archiver.kernel.org>; Thu,  1 Sep 2022 16:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiIAQ5h (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234842AbiIAQ5f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Sep 2022 12:57:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E6C7FE40
        for <selinux@vger.kernel.org>; Thu,  1 Sep 2022 09:57:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy31so35596142ejc.6
        for <selinux@vger.kernel.org>; Thu, 01 Sep 2022 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=a4wLDcPTS9JOvbMJJAbnMVeXZOM1toDgy8JbdWDtIro=;
        b=HeIT/vfbORKSpvwGk4xSgDoe3UNejXuWI5iUFlOsS+b4jlSPoAPbb6EY4XoCuhsXTc
         hdsFQejSqeJNFZKcxhey7VS3bptYvMVKWGEJnL1lMU/eYAOBNbU89bDUpfTGWvcXHkBM
         qZsDe8+YqYQQykk/J7DbMgEYPHBwOUw+vqx040ELEbcdhhUMZe82Tz0txCcqLhOfzwEI
         4eiNfyr2GPBqYKBgRiWRfmrN140IIuXF76hZqQgkmCtNTi1rrErCxdGzfqxpmkde78Rm
         r47GjnMk+hV7KVwiGmEe5nzPDUY/jdYYkbI+BuSS3pOLcL3bHy0p3sn7Jgq+a+F0UKCT
         B5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=a4wLDcPTS9JOvbMJJAbnMVeXZOM1toDgy8JbdWDtIro=;
        b=kSp7Ymn0dpLuwZZgML5CNuuOQirfedREYuw+fM2dgT8RPNjEazgzZpEWYNC/IaQhjB
         o/WlXYSfbGkHV6kk6w22spoHyF0n7xxgGsdp6PS2wJh0Oxq1VIZ946iyTNilNrlbh4a1
         Ij2qbjCuKbt85bQWkMFUAIh1M7p2kkmPLC7d+8e82eziQLaCoQ4YMlJgA+QbcO9SVX7C
         m0aHNUNwycN+VXK6XeisAB5kQvnlmFi7ft1CptzKHCmP2HBawpnYXdlqhLAuzmcwIFuu
         Wn+roukh7lc7TJ5+RtQmwdbhmuxMp3m99c/8r7Hn9WbQgq33N78nAiIUGm5IbQGj4IvS
         QJdQ==
X-Gm-Message-State: ACgBeo1YLxHM9CX5eoywsC5+q1m7fi/rE9Ih7zntALdnvRpO74RZtl8k
        fHlLi42FJHFEx/vVAkO1E/dcOtT4eQmcq6Sh8VQ=
X-Google-Smtp-Source: AA6agR4mCYqVGVI2SJ2s0owUmS+CIqtz6KfAS1o1PmIEx/UndxZD70Y2ahWRKCe3UcbTbi9xOcX+KhXMAkzv7icbhUA=
X-Received: by 2002:a17:907:2e01:b0:731:1eb0:b9ff with SMTP id
 ig1-20020a1709072e0100b007311eb0b9ffmr24758599ejc.728.1662051451229; Thu, 01
 Sep 2022 09:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
 <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com>
 <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
 <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com>
 <CAJ2a_DdgQUhCVWVDwOrT2GK3zJgBA-d58MN3cZk06Qiyrm13cw@mail.gmail.com>
 <CAFPpqQHZUV0QLSiv145p6ntt1u6zCY7pNXDpyT-ny_dpo+vnhg@mail.gmail.com> <875yi8b9ux.fsf@defensec.nl>
In-Reply-To: <875yi8b9ux.fsf@defensec.nl>
From:   Ted Toth <txtoth@gmail.com>
Date:   Thu, 1 Sep 2022 11:57:19 -0500
Message-ID: <CAFPpqQEpN74xuoeH+7GNdGxtoDEYC+bqLwCmXtWszZDq6R3xDA@mail.gmail.com>
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

I'm running MLS policy. The following commands were run on a RHEL 8
system without any policy modifications:

rpm -qa | grep selinux-policy
selinux-policy-3.14.3-80.el8_5.2.noarch
selinux-policy-mls-3.14.3-80.el8_5.2.noarch
selinux-policy-devel-3.14.3-80.el8_5.2.noarch
[root@dev tedx]# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             mls
Current mode:                   permissive
Mode from config file:          permissive
Policy MLS status:              enabled
Policy deny_unknown status:     denied
Memory protection checking:     actual (secure)
Max kernel policy version:      33
[root@dev tedx]# ps -efZ | grep systemd | grep init_t
system_u:system_r:init_t:s0-s15:c0.c1023 root  1       0  0 11:35 ?
    00:00:02 /usr/lib/systemd/systemd --switched-root --system
--deserialize 18
[root@bbws-dev tedx]# sesearch -A -t init_t -s init_t -c tcp_socket
allow init_t init_t:tcp_socket { accept append bind connect create
getattr getopt ioctl listen lock read setattr setopt shutdown write };
allow init_t init_t:tcp_socket { accept append bind connect create
getattr getopt ioctl listen lock read setattr setopt shutdown write };
[ nis_enabled ]:True
allow init_t init_t:tcp_socket { append bind connect create getattr
getopt ioctl lock read setattr setopt shutdown write }; [
authlogin_nsswitch_use_ldap ]:True
allow init_t init_t:tcp_socket { append bind connect create getattr
getopt ioctl lock read setattr setopt shutdown write }; [
kerberos_enabled ]:True

On Wed, Aug 31, 2022 at 12:28 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Ted Toth <txtoth@gmail.com> writes:
>
> >
> > On Wed, Aug 31, 2022 at 9:55 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> >>
> >> On Wed, 31 Aug 2022 at 02:47, Paul Moore <paul@paul-moore.com> wrote:
> >> >
> >> > On Tue, Aug 30, 2022 at 6:04 PM Ted Toth <txtoth@gmail.com> wrote:
> >> > > On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com> w=
rote:
> >> > > >
> >> > > > On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wrot=
e:
> >> > > > > I asked on the systemd-devel list about enabling systemd to se=
t the
> >> > > > > context of a socket and got the answer I've included below. I =
don't
> >> > > > > know how a transition rule can be written to transition tcp so=
ckets to
> >> > > > > multiple different target contexts, is this possible and if so=
 how?
> >>
> >> What do you mean by "multiple different target contexts"?
> >
> > Basically what I meant was that you cannot do the following since the
> > source and target type are the same and there is no way to specify the
> > socket other than if it were a UDS (a socket file):
> > type_transition init_t init_t:tcp_socket app1_socket_t;
> > type_transition init_t init_t:tcp_socket app2_socket_t;
> >
> >
> >> How should they be different and how should systemd know?
> >>
> >> Socket unit configurations are normally paired with service unit
> >> configurations (e.g. dovecot.socket <-> dovecot.service).
> >> To handle incoming traffic the service unit configuration should
> >> contain an ExecStart=3D directive, to start a program to handle the
> >> data.
> >> By default systemd tries at socket creation to predict the context of
> >> the started program (via security_compute_create_raw(3) in
> >> src/shared/selinux-util.c:mac_selinux_get_create_label_from_exe()),
> >> see src/core/socket.c:socket_determine_selinux_label().
> >>
> >> For example if the service unit contains ExecStart=3D/usr/bin/myapp an=
d
> >> /usr/bin/myapp has the context myapp_exec_t and the policy contains
> >> `type_transition init_t myapp_exec_t:process myapp_t` systemd should
> >> assign the context myapp_t to the socket specified in the socket unit
> >> configuration.
> >
> > I'll look at the code you reference but my experience is that the
> > socket systemd is listening on is labeled init_t despite, as in your
> > example above, the executable being labeled properly and transitioning
> > to the type that I've specified, in the type_transition rule in the
> > apps policy module, when it is run by systemd.
>
> I am confident that, if were talking about socket activation, this is
> not the case. systemd will create, and listen on the socket with the cont=
ext of the
> domain that will "accept" the connection.
>
> for example i have a mpd instance that is socket activated:
>
> root@brutus:~# ss -antlpZ | grep 6600
> LISTEN 0      5                  *:6600            *:*
> users:(("systemd",pid=3D968,proc_ctx=3Dwheel.id:wheel.role:user.systemd.s=
ubj:s0,fd=3D33))
>
> systemd is listening on behalf of mpd.
>
> if i query the policy:
>
> root@brutus:~# sesearch -A -s user.systemd.subj -t user.systemd.subj -c
> tcp_socket
>
> ... nothing returns. systemd is not allowed to create tcp_socket with
> its own domain type or listen on them. Yes it is still listening on
> tcp:6600
>
> this is because:
>
> root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c tcp_s=
ocket
> allow user.systemd.subj user.systemd.socketactivated.tcp.typeattr:tcp_soc=
ket { append bind connect create getattr getopt ioctl listen read setattr s=
etopt shutdown write };
>
> this systemd created a tcp_socket with type user.mpd.subj (on behalf of
> mpd) and listens for connections on that tcp_socket. Once a connection
> comes in then mpd with accept it (not that user.systemd.subj is not
> allowed to accept tcp_socket on behalf of mpd (or any tcp_socket for
> that matter:
>
> root@brutus:~# sesearch -A -s user.systemd.subj -t user.mpd.subj -c
> tcp_socket -p accept
>
> ... nothing returned.
>
> >
> >>
> >> > > >
> >> > > > Ignoring setsockcreatecon(3) as that really isn't an option here=
,
> >> > >
> >> > > If we determine that policy can't be written to accomplish the
> >> > > transition then maybe systemd will reconsider not wanting to set t=
he
> >> > > socket context using a .socket file option.
> >> >
> >> > I think the challenge is going to be having enough information when
> >> > the socket is created to do any useful type transition.  I'm open to
> >> > suggestions, but I'm skeptical there is anything we can do beyond th=
e
> >> > current approach.
> >> >
> >> > > > sockets created via socket(2) do check to see if there is a type
> >> > > > transition defined in the policy.  In the case of a TCP socket t=
he
> >> > > > type transition would look something like this:
> >> > > >
> >> > > >   type_transition <domain> <domain>:tcp_socket <new_socket_type>
> >> > > >
> >> > > > ... so you can see there is not much one can select on other tha=
n the
> >> > > > socket's object class.  The reason is that the socket(2) call it=
self
> >> > > > is rather spartan, with not even any clue as to if this is a cli=
ent or
> >> > > > server socket in the case of TCP.
> >> > >
> >> > > Having written many policy modules, some of which use the
> >> > > type_transition statement for tcp_socket objects, I do not see how=
 it
> >> > > can be used to transition sockets created by systemd. And under th=
is
> >> > > circumstance I see that the selinux socket create hook would not b=
e
> >> > > able query the policy database for the port context since the port=
 is
> >> > > not known until the bind occurs but what about having the bind hoo=
k
> >> > > set the socket context if it finds a sid for the port?
> >> >
> >> > The problem with waiting until the connect()/bind() is that you are
> >> > effectively doing a relabel operation, which is a big no-no (but you
> >> > already know that).  *Maybe* you could justify it in the special cas=
e
> >> > of stream sockets, as I'm pretty sure there is no way to do anything
> >> > useful with them as a data sink/source until they are either connect=
ed
> >> > to a remote peer or bound to a local port, however, we would all nee=
d
> >> > to think on that for a bit (it is still a relabel, and thus nasty) a=
nd
> >> > probably spend some time staring at the code to make sure there is n=
o
> >> > way to do something sneaky with an unconnected or unbound stream
> >> > socket.
> >> >
> >> > > > Taking a step back, what are you trying to do?  Perhaps there is
> >> > > > another approach that would get you where you want to go.
> >> > >
> >> > > I want to create socket activation services using systemd and to h=
ave
> >> > > the type of the socket being listened on be one that I've defined =
so
> >> > > that I can write policy to control which source types can connect =
to
> >> > > it.
> >> >
> >> > --
> >> > paul-moore.com
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> Dominick Grift
