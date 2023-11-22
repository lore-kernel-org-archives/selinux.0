Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEC3C61D9B
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 18:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjKVSdN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 13:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjKVSdM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 13:33:12 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5701B3
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 10:33:08 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a62d4788so22793e87.0
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677987; x=1701282787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JeWgKqI36TS32i0ulxUweYl8let659yrZtojetoKxM=;
        b=VCcyNkHVEootNKzSQx2q2vAojAtFTzfuJZ1Hm12mro0H0TFmzRJv3yVJFa5N7+yBt8
         GCJuC5+rlPxhFznYEov0rPxsaVhv1mYrH7ssOSI8seNbVMZZTw3dzfUxvktaNHTp7ou9
         mezVX9ZdbiRFtf1JbgoyxhxFFeaEqF0XxS+rLKU/XpwrVwBisOhFOIPYHIXcdZH7wINg
         z1vTH/rETOUs6o5bZtUXkJ+HgYTp3dwZ1xOvyuLEFs4PXDu8nFTAEMQlB52isjOPSwdl
         5S12Rro3RjK7+44ZHru8IUlqfiATr5bO12Il4Xi9OaFZKYrZRJYLoOJAb52btedRhHaF
         BtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677987; x=1701282787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JeWgKqI36TS32i0ulxUweYl8let659yrZtojetoKxM=;
        b=vmaeZc6fZVpWBBNJhvmsvNy3gtyJK5OTnO8YdB6HoPsT3uzQxjdObsrlaja/Io1teZ
         YyAuQasHJhL2xzM/UV9kE3GS+YVk4xy3LLAq+fnZr6Yw1ptmWnM9DyddJsTVBe+gqKKg
         wDhfBPglVj6rs0m/9UzUA6LJ2ChyePGkXM39NwCHSE+4vnBIiAPvhbS+i8mGvsBMCSBM
         dpJGagPJ05aELef35AOQe57wkmUgWv8KG629b87ID22mp/Gek6Ngt9if5iO2HDORZ+rp
         Gb3h+mC0h+nYmN0cxwc5h5eO9P4hjfNkypaSGv73G0TIkirUnjYFe0OSuNs9A8p+5NXz
         hhPA==
X-Gm-Message-State: AOJu0Yyfv9A8pYKmN3BcX/9ua08GYkgjmE8BZUkshw0ssBcwnpShRamg
        m4yzRG1bLyMy3ZRq9WQzimi3tc/w7uIempAWmsSIKxgz3+8=
X-Google-Smtp-Source: AGHT+IHO1F7A6irZglnUznlfsaauHzu/0GTsg0MmxRpjQR4tcJJKD5tflTFRzRp0KnRgKo95YgHI6x95V0XDwjwni4g=
X-Received: by 2002:a05:6512:3daa:b0:509:43c8:f5d9 with SMTP id
 k42-20020a0565123daa00b0050943c8f5d9mr3183541lfv.49.1700677986706; Wed, 22
 Nov 2023 10:33:06 -0800 (PST)
MIME-Version: 1.0
References: <87o7fmua12.fsf@redhat.com>
In-Reply-To: <87o7fmua12.fsf@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 22 Nov 2023 12:32:55 -0600
Message-ID: <CAFftDdrGO=pq-yrZ1bexcxssAA=+P_wYO7DEZ-VUm0EiZbztog@mail.gmail.com>
Subject: Re: getpolicyload returns 0, 2, 3, 4, ...
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 21, 2023 at 2:27=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Hi,
>
> Milos Malik noticed [0] that getpolicyload "skippes" 1 after first
> `semodule -R`:
>
>
> [root@fedora ~]# getpolicyload
> 0
> [root@fedora ~]# semodule -R
> [root@fedora ~]# getpolicyload
> 2
> [root@fedora ~]# semodule -R
> [root@fedora ~]# getpolicyload
> 3
> [root@fedora ~]# semodule -R
> [root@fedora ~]# getpolicyload
> 4
>
> why it's like that?
>
> It looks like increased sequence is not propagated after first
> policyload and it's propagated to the status after the second
> policyload.
>
>
> [0] https://src.fedoraproject.org/tests/selinux/pull-request/451#comment-=
168398
>

it may not be one, but never zero, so its ok to skip 1 per this comment:
  - https://elixir.bootlin.com/linux/latest/source/security/selinux/status.=
c#L57

On the creation of the page, the policyload is set to 0, on updates,
the seqno is used:
  - https://elixir.bootlin.com/linux/latest/source/security/selinux/status.=
c#L104

Definitely odd behavior, but seems expected. I just don't know why
seqno isn't used on page creation.

Bill
