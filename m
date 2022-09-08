Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F607C38145
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 14:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiIHOsx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Sep 2022 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiIHOsj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Sep 2022 10:48:39 -0400
X-Greylist: delayed 64320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 07:48:38 PDT
Received: from markus.defensec.nl (markus.defensec.nl [45.80.168.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9575FE0
        for <selinux@vger.kernel.org>; Thu,  8 Sep 2022 07:48:38 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2a10:3781:2099::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 10D65FC148E;
        Thu,  8 Sep 2022 16:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1662648516;
        bh=jVSsNqEk6Trgd1ihKtbBAHGYhzm0hWDTYJF1qWRo7hc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LV72hG8rGESmng9HxKPAR3Dle7uF62id6Z5LoOc+oY52vEZvOS1nWbMjpMVicV05v
         p+/Jz+dfmOZhAUe9n8uvQKZzQ+cZ9FPozpi8s/xlxb0s5Kg5nOEFHGsPUbgCS/Hinq
         Lm5b0gsNRHTSUJmHg/QrBbPUDZH8whcHMV2WJECw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ted Toth <txtoth@gmail.com>, SELinux <selinux@vger.kernel.org>
Subject: Re: context of socket passed between processes
In-Reply-To: <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com>
        (Paul Moore's message of "Thu, 8 Sep 2022 10:41:59 -0400")
References: <CAFPpqQE4isJqSmSOozWdKRN1rmt7_6sG_9VsroD-zjfQzWYqEQ@mail.gmail.com>
        <CAHC9VhRWwwxB=8De88_MdMS2ncEgP9dqX6hH1ao_zrJeRE_ndA@mail.gmail.com>
        <CAFPpqQFJYz79tFEanv1F2busJJzMw+DSe6Ba0qhoAkiTH9OSZg@mail.gmail.com>
        <CAHC9VhSOfWRKLAJzbHkBnWffHFzZS2Gi1VD=-Ocgp9PEx0kUew@mail.gmail.com>
Date:   Thu, 08 Sep 2022 16:48:35 +0200
Message-ID: <871qslc470.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Thu, Sep 8, 2022 at 9:41 AM Ted Toth <txtoth@gmail.com> wrote:
>> On Wed, Sep 7, 2022 at 5:46 PM Paul Moore <paul@paul-moore.com> wrote:
>> > On Wed, Sep 7, 2022 at 4:19 PM Ted Toth <txtoth@gmail.com> wrote:
>> > >
>> > > systemd uses a helper process (sd-listen) to create sockets and pass
>> > > their fds back to its parent. I've patched systemd to call semanage to
>> > > get the context for the port if it exists and create a context using
>> > > the returned type when calling setsockcreatecon.
>> >
>> > This obviously depends on how you structure and write your policy, but
>> > I don't think you want to use a port type directly as a socket type.
>> > I think we talked about this a little in the other thread, but for
>> > bound/listening sockets maybe you could do a transition for new child
>> > sockets based on the listening socket and port types.
>>
>> To be clear you are suggesting to call setsockcreatecon with the port
>> type but also have a transition rule to transition the port type to a
>> socket type?
>
> Two things:
>
> * I'm not sure you want to reuse a port type as a socket type, that
> seems wrong to me.
>
> * The socket type transition I was talking about would be new as there
> is not currently a type transition when the kernel creates a new
> socket for incoming connections.
>
>> > > Everything looks
>> > > right i.e. the port type is retrieved, the context is created and
>> > > setsockcreatecon is called without errors. However 'netstat -Z' shows
>> > > the listening sockets type as init_t and not the type in the
>> > > setsockcreatecon call, is this the expected behavior? Can anyone help
>> > > me understand why this is happening?
>> >
>> > You're calling setsockcreatecon() before you create the listening
>> > socket, right?  I wouldn't expect this to work properly if you create
>> > the listening socket and then call setsockcreatecon() hoping to have
>> > the new label applied to the new child sockets.
>>
>> It's not my code  ;) the systemd sd-listen process code does the
>> setsockccreatecon, bind and then listen.
>
> Well, regardless of who wrote the code, setsockcreatecon() is not
> going to have any effect on a socket's label if it is called *after*
> the socket is created.  Additionally, setsockcreatecon() has no effect
> on child sockets created by incoming connections on a listening
> socket; if you want to affect the label of those child sockets today
> you would need to change the label of the listening parent socket.
>
>> Regarding how to get the port context, what would you suggest?
>> Currently I'm calling semanage functions but have considered using the
>> sepol instead.
>
> I'll leave that to the folks who better understand the SELinux
> libraries, my only comment would be that I'm not sure reusing the port
> label is a good idea here.

I do not know what a good alternative is either. libsepol and libselinux
are guaranteed to be available. libsemanage is not:

root@OpenWrt:~# opkg list-installed | grep libse
libselinux - 3.3-2
libsepol - 3.3-1
root@OpenWrt:~#

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
