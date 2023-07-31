Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94D4C001DF
	for <selinux@archiver.kernel.org>; Mon, 31 Jul 2023 12:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGaMNW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGaMNU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Jul 2023 08:13:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0C4199
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 05:13:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-268b3ddc894so734679a91.1
        for <selinux@vger.kernel.org>; Mon, 31 Jul 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690805599; x=1691410399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTV/88R+1F2S5vTyh0GGup4+fNY4hr/oTcZyasgQYuQ=;
        b=Wg8CbwAwNh6VFqz3SWh+HfBs5Uf7pPRwlZiL6d9UlCtQN8IhW/Uc1um4rgOBqxd0G+
         n21epFV9WlcOdllN6znwj/+snvKuIjSiapY/avdMzC5EhH86XWk2dQnu1DhtJX4vx8x3
         yWq5vAyQkTU4J06pqhOppxtBU1EPyzQNwHKdAZFYmu26w9EGeTqINoQXvRymCsszhf2+
         fZbHbw6YzAI8C2SqwXGaJY3yaBmT7jQZwS8RZ/O5znte9Y8ZCHuOFNgQh2QvZtzDtjPi
         232BgrVQAzaWa/vDRyHZE5CLIy/NvdPZ0QtU+861EAzBdURwYRc/YvNALufHCS5Ag9OQ
         3dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805599; x=1691410399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTV/88R+1F2S5vTyh0GGup4+fNY4hr/oTcZyasgQYuQ=;
        b=QqqOmWaK232g3TMgAETZ1EdHJaYztLlb/dwDmF2MJKPAJ2nB8/bY1j+724JnCMZes1
         g6Fh3yIPrrP2dhvQqnRI8PBmmQ/vZhVaKz22QhhPxoAJFhEIwa4GwzgDdarnuw4toNlh
         W7uoV3VQItwL66wI/mdft7+kfOJAdNykQ9OwDwiCa3W1Ds8TWJr2d74RRH4liNn+CHpb
         ACwdKcTSQsgtkRqUcvsMxzPzbJV5u9AmXHsJPgU+od+buh8Zi343ql9xSy0lHZVPa4KX
         LonqovrG60tXOSq40OBarQBiiN3gl40HYUTXmGNpBR6WJPC2XSQd2+XTZeP3hPqSjXJ3
         nIfg==
X-Gm-Message-State: ABy/qLYhS9UGXBsDi9GYaJDJSitDnqVT0yTWbAM7cln698aMzRmyIj04
        hmBjg4vF2KsW66Aj5njG5wWywF9lLWkunbrcWXFUkBPZ
X-Google-Smtp-Source: APBJJlH6ndJ6dAqhNBuTEe3tjpmOCasf0Z3WGE4l0axExv4k+fG60SZpQoIlBfnuvR5oDvQv/9TRjNdTD/9PA2ebZlM=
X-Received: by 2002:a17:90a:5512:b0:268:2500:b17e with SMTP id
 b18-20020a17090a551200b002682500b17emr9093519pji.23.1690805599258; Mon, 31
 Jul 2023 05:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <5d5fdc57-6bf3-ec9a-b71b-b17e259f55d7@gmail.com>
In-Reply-To: <5d5fdc57-6bf3-ec9a-b71b-b17e259f55d7@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Jul 2023 08:13:07 -0400
Message-ID: <CAEjxPJ63oh92-49Oz3BjVxc=Kn6Rcwf1BbdziE_qLTnQ24VbLg@mail.gmail.com>
Subject: Re: Network ports - multiple types?
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 30, 2023 at 5:03=E2=80=AFPM Ian Pilcher <arequipeno@gmail.com> =
wrote:
>
> I've been playing with network port types, and I've just discovered that
> it appears to be possible to assign more than one type to a network
> port (e.g. udp/1900).
>
> # semanage port -a -t fdf_port_t -p udp 1900
> ValueError: Port udp/1900 already defined
>
> # semanage port -m -t fdf_port_t -p udp 1900
>
> # semanage port -l | grep 1900
> fdf_port_t                     udp      1900, 3483
> ssdp_port_t                    tcp      1900
> ssdp_port_t                    udp      1900
>
> And, sure enough, my FDF service is now able to bind to udp/1900.
>
> I was not previously aware of this feature, and my internet searches
> aren't turning up anything about it.  I'd just like to confirm that this
> is expected behavior (as it just seems really weird).  Are there any
> caveats to doing this?

As far as the kernel is concerned, there can only be one type assigned
to a network port, so your new definition is overriding the earlier
one. Is the earlier one in a policy module rather than being created
via semanage? A potential concern with what you are doing is that any
rules written on the earlier type obviously won't be automatically
applied to your new type, so anything relying on that behavior will
break.
