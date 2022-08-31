Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DCDECAAA1
	for <selinux@archiver.kernel.org>; Wed, 31 Aug 2022 00:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiHaArB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiHaAqj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 20:46:39 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC53A59BB
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 17:45:43 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11e9a7135easo18332325fac.6
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 17:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qaw5DQU+wxM2aiycf5+P/MdMpj8XnqS71Q2t5Evtupk=;
        b=iC9A7xJdXnhny1luoQMz4Md+9vg8wROURmWkFhZCznu/Q1acG4E4UBdXyOp4VsVM3a
         doLkyRO9R3MV6CdhUCJcLNLd6J3BdQqVDfW4jNzkKX+p38emeE3U9dLHTGTiD69MnfQy
         diO54dx8OaBvgXYfk4LFaPzDiSZvkU/79wdbKgBEqlh1ic2N49F91bqEiKeKUa6w3TPb
         b2YuUsuKzDkQy6pg3WIPhv/EP8hUw0COrXlEK6z738QAJyS6ezUgphdKd0lX/x65bV8T
         B7Wxs5/0BrtqUCHdKVdTQu1SJmqIeKyJ7AX/fCXrGznyAAR1MpzUsw4Rl1rGOx3Ng7wS
         61Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qaw5DQU+wxM2aiycf5+P/MdMpj8XnqS71Q2t5Evtupk=;
        b=34I1JQldMQooPBskznRnNQd+5871mUPIQ+QwZxZ3FfYO+WPszPA922VqcMyauSMVwB
         k/Ln9YoUBF8ExPYx1HeoPz/281ap6oGjmdlWQWgy0/z/DldGTF9st2j31gn1yJC82O/d
         Na8L1wXo1x0NrnZZnw5cfdp20upSGQiVV66vOpCZI/iqkv62IjKAmO/QnDLZDkgIt2qE
         /ztd+kW+28i+UCWh/pJuAWRmqj9+dvXwSZuAw8vSdCRkciDndLd4NubybPJrm2q0GaJ8
         McH64DtutvYRKA/dvJ+c7nb8s7Ct/bQxvSQ6NCreQDikngjnLy4VbWfzguGp083xq+VJ
         trNQ==
X-Gm-Message-State: ACgBeo3bHcrfAh6sVfKvNCq7Ny0l7uLrdERQkkCj8e6X7OC3cJoRhJMS
        zFq9mWifStbtqmrUDJutdG8f+CoKBpbDVU7L2l8PDnRu5Q==
X-Google-Smtp-Source: AA6agR4xAgDcd41s6KY3wE3Z0Yet68EtdOJ9GrZNHDM/h6zHmi9PoG375vAeBEhxxKsLevS7qRVHlZwFgIQNby6BGnU=
X-Received: by 2002:a05:6808:bd1:b0:345:da59:d3ae with SMTP id
 o17-20020a0568080bd100b00345da59d3aemr267778oik.136.1661906742724; Tue, 30
 Aug 2022 17:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPpqQHS_v7gqXsdCpE3LXA4JzL=-K0U7Q9jiGY5EqT6XCoQbg@mail.gmail.com>
 <Ywc+pjOFkAEswVuQ@gardel-login> <CAFPpqQEva6Z339ZXKxF2=ueug7YFrsFD0Tk6W88cZQxx0sg7OQ@mail.gmail.com>
 <CAHC9VhST2zg4w51KnxnsXp0CSULXtp9iRiXaJ18is2dtV55cdQ@mail.gmail.com> <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
In-Reply-To: <CAFPpqQECY2dFLy4qOcF83i_wE9VDJefrkhwYwuURyzStv32KDQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 20:45:32 -0400
Message-ID: <CAHC9VhQeyEW3aHAuLUKJSkXgEkVZis0xZAAP9J5sATAr24xG7Q@mail.gmail.com>
Subject: Re: [systemd-devel] socket activation selinux context on create
To:     Ted Toth <txtoth@gmail.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 30, 2022 at 6:04 PM Ted Toth <txtoth@gmail.com> wrote:
> On Mon, Aug 29, 2022 at 4:22 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 9:22 AM Ted Toth <txtoth@gmail.com> wrote:
> > > I asked on the systemd-devel list about enabling systemd to set the
> > > context of a socket and got the answer I've included below. I don't
> > > know how a transition rule can be written to transition tcp sockets to
> > > multiple different target contexts, is this possible and if so how?
> >
> > Ignoring setsockcreatecon(3) as that really isn't an option here,
>
> If we determine that policy can't be written to accomplish the
> transition then maybe systemd will reconsider not wanting to set the
> socket context using a .socket file option.

I think the challenge is going to be having enough information when
the socket is created to do any useful type transition.  I'm open to
suggestions, but I'm skeptical there is anything we can do beyond the
current approach.

> > sockets created via socket(2) do check to see if there is a type
> > transition defined in the policy.  In the case of a TCP socket the
> > type transition would look something like this:
> >
> >   type_transition <domain> <domain>:tcp_socket <new_socket_type>
> >
> > ... so you can see there is not much one can select on other than the
> > socket's object class.  The reason is that the socket(2) call itself
> > is rather spartan, with not even any clue as to if this is a client or
> > server socket in the case of TCP.
>
> Having written many policy modules, some of which use the
> type_transition statement for tcp_socket objects, I do not see how it
> can be used to transition sockets created by systemd. And under this
> circumstance I see that the selinux socket create hook would not be
> able query the policy database for the port context since the port is
> not known until the bind occurs but what about having the bind hook
> set the socket context if it finds a sid for the port?

The problem with waiting until the connect()/bind() is that you are
effectively doing a relabel operation, which is a big no-no (but you
already know that).  *Maybe* you could justify it in the special case
of stream sockets, as I'm pretty sure there is no way to do anything
useful with them as a data sink/source until they are either connected
to a remote peer or bound to a local port, however, we would all need
to think on that for a bit (it is still a relabel, and thus nasty) and
probably spend some time staring at the code to make sure there is no
way to do something sneaky with an unconnected or unbound stream
socket.

> > Taking a step back, what are you trying to do?  Perhaps there is
> > another approach that would get you where you want to go.
>
> I want to create socket activation services using systemd and to have
> the type of the socket being listened on be one that I've defined so
> that I can write policy to control which source types can connect to
> it.

-- 
paul-moore.com
