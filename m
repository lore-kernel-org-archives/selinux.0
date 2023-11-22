Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D433C61D9B
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 18:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjKVSyN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjKVSyM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 13:54:12 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7491BE
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 10:54:08 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4af8f20034cso28316e0c.3
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700679248; x=1701284048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkTWvgfSLIzKlNPJpLwlynviCJhUkv6w7FhVv0rsr0s=;
        b=lL9yMcXIpWuQGhJCatzg5VU2kOPMVGzlR+qr/uzARCPGTKogXBe8kg5fnujY58ZAL9
         HKaTIZABq+GlMaml8lt3EVrgfdx6XTPmgt6izfs9mlXYl2Zg8Vg2yWkl8ADLPsJcGA9b
         +RnE6OOq9hbzyTdi0IIBSWbtaedgIlgz/3fIt4tlmf53e0l6zbz6rY9zfjk5qjwPRZJC
         G6bTiYtxSheA/aelQChDBUtBpwT0EJlnApEKyhMPZM0PHqv7N12zEwaimWF1oQNQOdRr
         Y5ePm9z1b285H4DaOqcewLzkTJexplSVb6pk5PR0KWUdlYpE/ydcIp09E8+Zyd66zaQf
         CnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679248; x=1701284048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkTWvgfSLIzKlNPJpLwlynviCJhUkv6w7FhVv0rsr0s=;
        b=YOVUMXpdIY9VeIv3GEXss//ik7CZIMNk5R0KrYtAhmjXJ9/QReGWRy8kgWPVihr51d
         2RDCEhGXSWc7osZdsKPzPPBK/Ju6tmMgLl+Jz1j7VUB1SzM1KBmUMXXgZjaVqj9/pUCf
         2t1HDCMex9v26v1nwz3hAA7XjBcgOKznBoskm/NUlsYhb7V6U3lPJ7hWH1rRciMDmbyE
         NBABND8r8jQ3EyVCHWxsegupZzJuZV1HD1VajwA3Kpdu6xsoCEQsUwk9XQW6ucdRzfKH
         o/aHPNZ4qKJCdt+G1++RznoU0KTBB3G03XS4HKG+Wgt7qxxrMJJvXO8cLNvFgtV3EbWg
         TcbQ==
X-Gm-Message-State: AOJu0YzpqPhbXvXmgWTzRb0V5VLHM8S4faO0YQankA1nUCOPL5oVlCqR
        y59XRDCqLHNLI2O+iM/etgX89MEr4HkOI646wrk=
X-Google-Smtp-Source: AGHT+IGMQGxMilT0v3DplLIxOrYSOI6wlCneE69w/DHHMrHycjQE4u/jBcteQKYCPe/1XoY82bI47mob7c6C0/xULVk=
X-Received: by 2002:a1f:da82:0:b0:4ac:49ea:9156 with SMTP id
 r124-20020a1fda82000000b004ac49ea9156mr3738640vkg.2.1700679247831; Wed, 22
 Nov 2023 10:54:07 -0800 (PST)
MIME-Version: 1.0
References: <87o7fmua12.fsf@redhat.com> <CAFftDdrGO=pq-yrZ1bexcxssAA=+P_wYO7DEZ-VUm0EiZbztog@mail.gmail.com>
In-Reply-To: <CAFftDdrGO=pq-yrZ1bexcxssAA=+P_wYO7DEZ-VUm0EiZbztog@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 22 Nov 2023 19:53:57 +0100
Message-ID: <CAJ2a_Df5OdXUDtH+E0C4RBz2szakxp2q2m7UcvALK9wE4Jq+eg@mail.gmail.com>
Subject: Re: getpolicyload returns 0, 2, 3, 4, ...
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Petr Lautrbach <lautrbach@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 22 Nov 2023 at 19:33, William Roberts <bill.c.roberts@gmail.com> wr=
ote:
>
> On Tue, Nov 21, 2023 at 2:27=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
> >
> > Hi,
> >
> > Milos Malik noticed [0] that getpolicyload "skippes" 1 after first
> > `semodule -R`:
> >
> >
> > [root@fedora ~]# getpolicyload
> > 0
> > [root@fedora ~]# semodule -R
> > [root@fedora ~]# getpolicyload
> > 2
> > [root@fedora ~]# semodule -R
> > [root@fedora ~]# getpolicyload
> > 3
> > [root@fedora ~]# semodule -R
> > [root@fedora ~]# getpolicyload
> > 4
> >
> > why it's like that?
> >
> > It looks like increased sequence is not propagated after first
> > policyload and it's propagated to the status after the second
> > policyload.
> >
> >
> > [0] https://src.fedoraproject.org/tests/selinux/pull-request/451#commen=
t-168398
> >
>
> it may not be one, but never zero, so its ok to skip 1 per this comment:
>   - https://elixir.bootlin.com/linux/latest/source/security/selinux/statu=
s.c#L57
>
> On the creation of the page, the policyload is set to 0, on updates,
> the seqno is used:
>   - https://elixir.bootlin.com/linux/latest/source/security/selinux/statu=
s.c#L104
>
> Definitely odd behavior, but seems expected. I just don't know why
> seqno isn't used on page creation.
>
> Bill

The initial policy load will call selinux_status_update_policyload(1),
trying to set the sequence number to 1, but probably the status page
is not yet allocated.
It is only allocated on first access of /selinux/status (see
selinuxfs.c:sel_open_handle_status()).
