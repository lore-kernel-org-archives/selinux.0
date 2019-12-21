Return-Path: <SRS0=Y3F+=2L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6709C2D0C0
	for <selinux@archiver.kernel.org>; Sat, 21 Dec 2019 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D632070C
	for <selinux@archiver.kernel.org>; Sat, 21 Dec 2019 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WQcVneRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLUPCw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 21 Dec 2019 10:02:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38407 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfLUPCw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 21 Dec 2019 10:02:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so9273448lfm.5
        for <selinux@vger.kernel.org>; Sat, 21 Dec 2019 07:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O/OH/cOpJm4HcDQq3bqmVyhEerqk2hauMDOV8HxvEFM=;
        b=WQcVneRe46p8ZR3uXZlv+0mgx79c6+8bv2J+3KXXGvigrTkm/6SMjUKUTaib0820gh
         CXe7VZiXtAEWoK3ALHA7umeN2Ujuiwp8A1QjmM0xqp+pF/7IstWdK1/t7vg6gINss79m
         4FZcEpaA+yAX3+oVBoiIKDkwcpfpfzzbimn6EmiNyzWcRyj7+ixGonE7oyrJK3tE5qEx
         2V1XHcTXkSsYr5GbxYi943zvCWc2ZO/OXjtYLc0F6x6fJP52bFsNG0PLI7eo2K89R+NN
         tFRulX1MdfFJoB0IPLfOC/tH085qD1e3l8L7eoQDRYk+6eM8r/EbhM4TukEZaHxtbhmO
         +tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O/OH/cOpJm4HcDQq3bqmVyhEerqk2hauMDOV8HxvEFM=;
        b=HwmSjBbMxkdFazheyxL24QBZX3auhETEUNVzEDoZBeAQ6hbSYeXuPjFUxCm60UMJSM
         yCAzeGcM/F3qGmY5x3+PFeZghoKzCNnwOJDqvUu1HNSJa1EFGpN6/ROpvD3HaQ9gXvR8
         CEQhA/g2s2sSni8Iz6GLr+CqcrzMUJqpBfGGFYSiUKvEEYAekc5NDFNepye8LDniwehY
         WeL+Rytulc8W4BhkKSj/iaFINUCkhZTYyKOkZib6eK8TYj+N5jYvfKS22NiG3flPUlew
         atcZvaMjsoF9ITTWoxoIXSdfIa6MwWxzjRje35Aesab7Lff9Uaq8+FKpmuQOpa2M8SIZ
         0KZw==
X-Gm-Message-State: APjAAAXxvrwAMdMkUxdQKdmODCUP3TVhTDZKw7osd4ZusIWbh5a2FiyR
        En3GQvTl1qj96zCKGvV53q2Gd7GXRN+uE6mISggV
X-Google-Smtp-Source: APXvYqxF3bHZlJxTgnAriSMNJIrrldoDx20D7oRmOZsJO+lZyhrXidRm/cN/Ek3YvsCTMn2+x5pwlr0a80+WDjihV98=
X-Received: by 2002:a19:f701:: with SMTP id z1mr12223027lfe.13.1576940569512;
 Sat, 21 Dec 2019 07:02:49 -0800 (PST)
MIME-Version: 1.0
References: <1576836441-4140-1-git-send-email-yanghui.def@gmail.com>
 <CAHC9VhTup_3LnC+i77_bC93G0GUdh1xY7JM5fbRD5_oPO9=jMA@mail.gmail.com> <CA+wXOo0Hfvmht5he5eMNZFyHsSgVV_uvBYriqMXJzU5g0rkigw@mail.gmail.com>
In-Reply-To: <CA+wXOo0Hfvmht5he5eMNZFyHsSgVV_uvBYriqMXJzU5g0rkigw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 21 Dec 2019 10:02:38 -0500
Message-ID: <CAHC9VhQ3ybWPQdAebwk=hz=OJwzusYYK_A9eAEnSgUE1uyG3Gg@mail.gmail.com>
Subject: Re: [PATCH] netnode.c : fix sel_netnode_hash be destroyed
To:     hui yang <yanghui.def@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 20, 2019 at 9:37 PM hui yang <yanghui.def@gmail.com> wrote:
> Dear Paul Moore :
>      When the phone is power on about 30 second. it happened kernel
> panic . The probability of kerner panic is about 4/10000=E3=80=82
>       I used Android Q base kerner-4.9. I can't reproduce it, it
> happened four times on  different phone. all message is Unable to
> handle kernel paging request at virtual address fffffffffffffffc =EF=BC=
=8C x0
> : ffffffffffffffe8
>       In our code ,we  did not change the code in netnode.c.
>       sel_netnode_find code line is 114.
>       list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)  i=
s 131.
>       if (node->nsec.family =3D=3D family) is 132 .
>       The backtrace is :
> [   31.152983] [<00000000584f97e1>] sel_netnode_find+0x6c/0xf0
> [   31.157670] [<00000000d1009c50>] sel_netnode_sid+0x3c/0x248
> [   31.163225] [<00000000c6ff20a5>] selinux_socket_bind+0x204/0x230
> [   31.168777] [<0000000080a7de33>] security_socket_bind+0x64/0x94
> [   31.180679] [<00000000a01eb02b>] SyS_bind+0x10c/0x164
> [   31.187269] [<00000000c7a460e5>] el0_svc_naked+0x34/0x38
>
> please help to check more . I think there is a bug in netnode.c
> Thank you so much.

Looking at netnode.c again somewhat quickly I don't see anything
obvious, but it sounds like this is an Android kernel, yes?  I don't
have a copy of the Android kernel sources to inspect, but given that
kernel v4.9 is quite old compared to upstream I suspect the Android
kernel has a number of backports, making this difficult to diagnose.

If this is an Android kernel, I would suggest talking with the Android
kernel developers.

> Paul Moore <paul@paul-moore.com> =E4=BA=8E2019=E5=B9=B412=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:48=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Dec 20, 2019 at 5:07 AM hui yang <yanghui.def@gmail.com> wrote:
> > > From: YangHui <yanghui.def@gmail.com>
> > >
> > > we often find below error :
> > > [   30.729718] Unable to handle kernel paging request at virtual addr=
ess fffffffffffffffc
> > > [   30.747478] Kernel BUG at sel_netnode_find+0x6c/0xf0 [verbose debu=
g info unavailable]
> > > [   30.818858] PC is at sel_netnode_find+0x6c/0xf0
> > > [   30.824671] LR is at sel_netnode_sid+0x3c/0x248
> > > [   30.829170] pc : [<ffffff8008428094>] lr : [<ffffff8008428154>] ps=
tate: a0400145
> > > [   30.833701] sp : ffffffc026f27c50
> > > [   30.841319] x29: ffffffc026f27c50 x28: ffffffc026f27e40
> > > [   30.849634] x27: ffffff8009132000 x26: 0000000000000000
> > > [   30.854932] x25: ffffffc016f0aa80 x24: 0000000000000000
> > > [   30.860224] x23: ffffffc026f27e38 x22: ffffffc026f27d34
> > > [   30.865520] x21: 000000000000000a x20: ffffffc026f27e40
> > > [   30.870818] x19: 000000000000000a x18: 0000007a13b48000
> > > [   30.876118] x17: 0000007a16ca93c0 x16: ffffff8008e56b2c
> > > [   30.881406] x15: 0000000000000020 x14: 002dc6bffa5d9e00
> > > [   30.886701] x13: 203a644974654e4c x12: 00000000000017c1
> > > [   30.891997] x11: 0000000000000000 x10: 0000000000000001
> > > [   30.897292] x9 : 0000000000000002 x8 : ffffff8009933090
> > > [   30.902588] x7 : ffffffc0725fd090 x6 : 0000000004fd9f2c
> > > [   30.907881] x5 : 0000000000000000 x4 : 0000000000000000
> > > [   30.913176] x3 : 00000001ffffffff x2 : 0000000000000000
> > > [   30.918475] x1 : ffffff800a10ca80 x0 : ffffffffffffffe8
> > > some sel_netnode_hash[idx].list=3D=3DNULL,so happend this.
> > > I add spin_lock_bh on sel_netnode_init.
> > >
> > > Signed-off-by: YangHui <yanghui.def@gmail.com>
> > > ---
> > >  security/selinux/netnode.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> > > index 9ab84ef..aa0eeb7 100644
> > > --- a/security/selinux/netnode.c
> > > +++ b/security/selinux/netnode.c
> > > @@ -293,11 +293,12 @@ static __init int sel_netnode_init(void)
> > >
> > >         if (!selinux_enabled)
> > >                 return 0;
> > > -
> > > +       spin_lock_bh(&sel_netnode_lock);
> > >         for (iter =3D 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
> > >                 INIT_LIST_HEAD(&sel_netnode_hash[iter].list);
> > >                 sel_netnode_hash[iter].size =3D 0;
> > >         }
> > > +       spin_unlock_bh(&sel_netnode_lock);
> > >
> > >         return 0;
> > >  }
> >
> > I'm confused as to why this patch solved your problem.  The
> > sel_netnode_init() function is only run once during early boot and
> > there shouldn't be any other threads trying to access the netnode
> > cache at this point.
> >
> > Can you explain the conditions under which you see this problem?  What
> > kernel are you using (stock distro kernel?  upstream?  Android?)?  Can
> > you reproduce this problem?  Can you provide source code line numbers
> > associated with the func/offset lines in the backtrace above?
> >
> > --
> > paul moore
> > www.paul-moore.com



--=20
paul moore
www.paul-moore.com
