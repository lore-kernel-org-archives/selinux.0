Return-Path: <SRS0=Y3F+=2L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69160C43603
	for <selinux@archiver.kernel.org>; Sat, 21 Dec 2019 02:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F88A206DA
	for <selinux@archiver.kernel.org>; Sat, 21 Dec 2019 02:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7KpDnhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfLUChV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Dec 2019 21:37:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43367 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfLUChV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Dec 2019 21:37:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so7300066qtj.10;
        Fri, 20 Dec 2019 18:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mP+hnBLPLxqYSPeijE5C30RxpwOW1ab1qcj2/ypCv8k=;
        b=L7KpDnhhOLfWbH0TvysKqjmboTpEWNJrKGWtloSZRV9oX9Wwht28l4D3eTKeZr5C4F
         q7BrMBpVuUqhc+Wxnm5dgjmIWSCGoI6yFO1G2KnBdAHecSJUzhaddH1xijqYgOowCtwb
         gnNnPw9B20bXMt47IbkQyY0vHVmzg6eqemt2Fkc+43Yl6qp1duCTCZs4b+EPjT6bhKeo
         auJtmGW3lngLW+eyJ/93Cnmyg1Z9T0XRflanvzBa5OXGyz0RdbSp1ss4V0IVVTRuAOH+
         edFMF8lkU87LEYhAGOAkLlV/U9xZXVWhHlo8R0NCeX9DvkZ+Gy+3vRc/m2oTep1OHx+k
         a0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mP+hnBLPLxqYSPeijE5C30RxpwOW1ab1qcj2/ypCv8k=;
        b=Rx4O+qtCGjR0UA8688m3M8MJSAfx0H7l1dbDWCndDyh5JwJ1/mp/PvePjlhbhYV6op
         qaPPajMLoKINMyEwVCzmDl1kJ2YwBfYBRbPnB6SevYPWEfMvV0FkCIaU6ryfMqVyTi2p
         eH2eO7t9B580A5djLCrCwZfBR8OrO7JKD5DEssAGwVSUXujehv97ewmqTEghDtdzZ+Ms
         LVZRnd+PTHLT6FJafN+i8D3MuupsCvOaMNrD4VY3ruG4xZ8QwUwi33Rw1zdFc3cN9/kP
         aEr6/Rv8rFmXZoVnIKArsfJNjMcmt8u/9j0RKXrM7hA8heQcPELMNCBD91Ci23g5SVOI
         1OMA==
X-Gm-Message-State: APjAAAXG+DNDRaSSBVbX45gyGMKgMsJz7HItemJKMyGEujcbirF56oFb
        S8mRq7U/MOw+qO6+BsGltd81/NldWYRCp2ik2bSqq0KT
X-Google-Smtp-Source: APXvYqxU5NE+WZwXzyH9h4mTAXQVuCSSr1s6g8ipdsGjIDyyPpk8rQHT2QFqUnYV72O/mh07Agye16kk+Ktn1hLRzOs=
X-Received: by 2002:ac8:4289:: with SMTP id o9mr14382751qtl.277.1576895840319;
 Fri, 20 Dec 2019 18:37:20 -0800 (PST)
MIME-Version: 1.0
References: <1576836441-4140-1-git-send-email-yanghui.def@gmail.com> <CAHC9VhTup_3LnC+i77_bC93G0GUdh1xY7JM5fbRD5_oPO9=jMA@mail.gmail.com>
In-Reply-To: <CAHC9VhTup_3LnC+i77_bC93G0GUdh1xY7JM5fbRD5_oPO9=jMA@mail.gmail.com>
From:   hui yang <yanghui.def@gmail.com>
Date:   Sat, 21 Dec 2019 10:37:07 +0800
Message-ID: <CA+wXOo0Hfvmht5he5eMNZFyHsSgVV_uvBYriqMXJzU5g0rkigw@mail.gmail.com>
Subject: Re: [PATCH] netnode.c : fix sel_netnode_hash be destroyed
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dear Paul Moore :
     When the phone is power on about 30 second. it happened kernel
panic . The probability of kerner panic is about 4/10000=E3=80=82
      I used Android Q base kerner-4.9. I can't reproduce it, it
happened four times on  different phone. all message is Unable to
handle kernel paging request at virtual address fffffffffffffffc =EF=BC=8C =
x0
: ffffffffffffffe8
      In our code ,we  did not change the code in netnode.c.
      sel_netnode_find code line is 114.
      list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)  is =
131.
      if (node->nsec.family =3D=3D family) is 132 .
      The backtrace is :
[   31.152983] [<00000000584f97e1>] sel_netnode_find+0x6c/0xf0
[   31.157670] [<00000000d1009c50>] sel_netnode_sid+0x3c/0x248
[   31.163225] [<00000000c6ff20a5>] selinux_socket_bind+0x204/0x230
[   31.168777] [<0000000080a7de33>] security_socket_bind+0x64/0x94
[   31.180679] [<00000000a01eb02b>] SyS_bind+0x10c/0x164
[   31.187269] [<00000000c7a460e5>] el0_svc_naked+0x34/0x38

please help to check more . I think there is a bug in netnode.c
Thank you so much.


Paul Moore <paul@paul-moore.com> =E4=BA=8E2019=E5=B9=B412=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 20, 2019 at 5:07 AM hui yang <yanghui.def@gmail.com> wrote:
> > From: YangHui <yanghui.def@gmail.com>
> >
> > we often find below error :
> > [   30.729718] Unable to handle kernel paging request at virtual addres=
s fffffffffffffffc
> > [   30.747478] Kernel BUG at sel_netnode_find+0x6c/0xf0 [verbose debug =
info unavailable]
> > [   30.818858] PC is at sel_netnode_find+0x6c/0xf0
> > [   30.824671] LR is at sel_netnode_sid+0x3c/0x248
> > [   30.829170] pc : [<ffffff8008428094>] lr : [<ffffff8008428154>] psta=
te: a0400145
> > [   30.833701] sp : ffffffc026f27c50
> > [   30.841319] x29: ffffffc026f27c50 x28: ffffffc026f27e40
> > [   30.849634] x27: ffffff8009132000 x26: 0000000000000000
> > [   30.854932] x25: ffffffc016f0aa80 x24: 0000000000000000
> > [   30.860224] x23: ffffffc026f27e38 x22: ffffffc026f27d34
> > [   30.865520] x21: 000000000000000a x20: ffffffc026f27e40
> > [   30.870818] x19: 000000000000000a x18: 0000007a13b48000
> > [   30.876118] x17: 0000007a16ca93c0 x16: ffffff8008e56b2c
> > [   30.881406] x15: 0000000000000020 x14: 002dc6bffa5d9e00
> > [   30.886701] x13: 203a644974654e4c x12: 00000000000017c1
> > [   30.891997] x11: 0000000000000000 x10: 0000000000000001
> > [   30.897292] x9 : 0000000000000002 x8 : ffffff8009933090
> > [   30.902588] x7 : ffffffc0725fd090 x6 : 0000000004fd9f2c
> > [   30.907881] x5 : 0000000000000000 x4 : 0000000000000000
> > [   30.913176] x3 : 00000001ffffffff x2 : 0000000000000000
> > [   30.918475] x1 : ffffff800a10ca80 x0 : ffffffffffffffe8
> > some sel_netnode_hash[idx].list=3D=3DNULL,so happend this.
> > I add spin_lock_bh on sel_netnode_init.
> >
> > Signed-off-by: YangHui <yanghui.def@gmail.com>
> > ---
> >  security/selinux/netnode.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> > index 9ab84ef..aa0eeb7 100644
> > --- a/security/selinux/netnode.c
> > +++ b/security/selinux/netnode.c
> > @@ -293,11 +293,12 @@ static __init int sel_netnode_init(void)
> >
> >         if (!selinux_enabled)
> >                 return 0;
> > -
> > +       spin_lock_bh(&sel_netnode_lock);
> >         for (iter =3D 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
> >                 INIT_LIST_HEAD(&sel_netnode_hash[iter].list);
> >                 sel_netnode_hash[iter].size =3D 0;
> >         }
> > +       spin_unlock_bh(&sel_netnode_lock);
> >
> >         return 0;
> >  }
>
> I'm confused as to why this patch solved your problem.  The
> sel_netnode_init() function is only run once during early boot and
> there shouldn't be any other threads trying to access the netnode
> cache at this point.
>
> Can you explain the conditions under which you see this problem?  What
> kernel are you using (stock distro kernel?  upstream?  Android?)?  Can
> you reproduce this problem?  Can you provide source code line numbers
> associated with the func/offset lines in the backtrace above?
>
> --
> paul moore
> www.paul-moore.com
