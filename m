Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D37C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 14:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiIHOiY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiIHOiW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 10:38:22 -0400
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2a10:3781:2099::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD846600
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 07:38:17 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 46DA3FC148E;
        Thu,  8 Sep 2022 16:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1662647894;
        bh=aHMRYr//CUid1AcmEdTeABKvSTsiFOdJKOwxKwYc5pA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Wtn7shrwDJ32TuVJ7Kjrd+JT6sGSpzJRdJuTtG9TmUjGCY76+SCQ/u1FvxsyOmJyL
         hMTk4neu48FNkP/oJfCQPPgCbWRKxNISYrwyxYn6vnJWR6XGSL+1vY+E4Zr5+OHV5L
         k1ZsIWGkq11ycpTh8A7Lf+Ifs1EJe/uTUAVZC0tU=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Ted Toth <txtoth@gmail.com>, Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>
Subject: Re: context of socket passed between processes
In-Reply-To: <CAFqZXNus2pSv4=oxm-Mj+vz0D2TDNqiG6tf_--CSo5OcExK74Q@mail.gmail.com>
        (Ondrej Mosnacek's message of "Thu, 8 Sep 2022 16:28:07 +0200")
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
        <87a67ac398.fsf@defensec.nl>
        <CAHC9VhTioQVN28CZmcwdcTeZ_WOA77ovXMk0xqdzF+HXeZMCpQ@mail.gmail.com>
        <CAFPpqQGmo8zt4h3aLy7j8rkzZA4cKM8D2DbkVStBre9b17dvdg@mail.gmail.com>
        <CAFPpqQEoAcmpQALgD9S5ZYnd2KVSPOtsBaC67t3VLv9uS3KRbw@mail.gmail.com>
        <CAFqZXNus2pSv4=oxm-Mj+vz0D2TDNqiG6tf_--CSo5OcExK74Q@mail.gmail.com>
Date:   Thu, 08 Sep 2022 16:38:13 +0200
Message-ID: <875yhyaq3u.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Thu, Sep 8, 2022 at 4:15 PM Ted Toth <txtoth@gmail.com> wrote:
>>
>> On Thu, Sep 8, 2022 at 8:43 AM Ted Toth <txtoth@gmail.com> wrote:
>> >
>> > On Wed, Sep 7, 2022 at 5:48 PM Paul Moore <paul@paul-moore.com> wrote:
>> > >
>> > > On Wed, Sep 7, 2022 at 4:56 PM Dominick Grift
>> > > <dominick.grift@defensec.nl> wrote:
>> > > > Ted Toth <txtoth@gmail.com> writes:
>> > > > > systemd uses a helper process (sd-listen) to create sockets and pass
>> > > > > their fds back to its parent. I've patched systemd to call semanage to
>> > > > > get the context for the port if it exists and create a context using
>> > > > > the returned type when calling setsockcreatecon. Everything looks
>> > > > > right i.e. the port type is retrieved, the context is created and
>> > > > > setsockcreatecon is called without errors. However 'netstat -Z' shows
>> > > > > the listening sockets type as init_t and not the type in the
>> > > > > setsockcreatecon call, is this the expected behavior? Can anyone help
>> > > > > me understand why this is happening?
>> > > >
>> > > > It is probably the context of the process listening on the port and not
>> > > > the context of the socket that binds to the port
>> > >
>> > > That's a good point, I would have thought it would have looked at the
>> > > socket itself but perhaps it is the calling process' label.  Actually,
>> > > it might be the fd's label associated with the socket; that would
>> > > explain it.  Someone would need to look at the netstat sources to
>> > > confirm.
>> >
>> > Is there an API to query the context of a socket fd?
>>
>> I wrote a client which connects and calls getpeercon and indeed the
>> context is what was set via setsockcreatecon so that's reassuring.
>> Unfortunately it seems that netstat, ss and lsof don't have a way to
>> query the context of the listening socket :( I'd like to see a
>> getsockcon function (taking an fd as its argument) added to libselinux
>> if it can be written.
>
> There is a way to see a socket's context, though it's a bit obscure:
>
> ls -ZL /proc/<PID>/fd/<FD>

Nice, that is one way to confirm at least that systemd socket activation does the
right thing:

root@brutus:~# ss -antlZ | grep 6600
LISTEN 0      5                  *:6600            *:*    users:(("systemd",pid=968,proc_ctx=wheel.id:wheel.role:user.systemd.subj:s0,fd=28))       
root@brutus:~# ls -ZL /proc/968/fd/28
wheel.id:wheel.role:user.mpd.subj:s0 /proc/968/fd/28
root@brutus:~#

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
