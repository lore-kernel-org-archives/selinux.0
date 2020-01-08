Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92207C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64275206DB
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 13:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaX/WMAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgAHNlk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:41:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37641 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgAHNlj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 08:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578490898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LpLNr3NPA0yf2CrG1xyCr8Zw4FNK6E46Q5gEQI0gmM=;
        b=UaX/WMAMIHDb6eZtwwDzv7KBLVjpa6p23TVtilZSrQlTYRC7WYfSn8kgjXm8F0cJ9b44OB
        GuQUQaTPbsmSE6yGpTz488asLKwV0Ih7g3EVfIOvCE1O2vQ9UsYftVBoyjS4ibaCxLL5NX
        434Mnd0T1FnlfhO/IDFcDG0DuxQ9gYI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-GUvmVjXGMU6jMCF0XmPHWw-1; Wed, 08 Jan 2020 08:41:37 -0500
X-MC-Unique: GUvmVjXGMU6jMCF0XmPHWw-1
Received: by mail-oi1-f197.google.com with SMTP id d9so1611553oij.4
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 05:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1LpLNr3NPA0yf2CrG1xyCr8Zw4FNK6E46Q5gEQI0gmM=;
        b=Fx4oWrvMm6+hzEk8foWc7c85V4moAoouEW0LmWdQtZYPxihwBRJF5YDsu1VU4dOucQ
         eWfWxRAolBx4vVN0dDVXT1o6mlLALScI9WWWnzDcvcKYNhy0C33EQC4Kr69ZxKyqQ1ql
         F5tkcXwIykRFQL/8c3LAMv9Gz4BEMSm7RJvdisNyAwXZDlmFZQbYVC3HWrV6z+DI7irU
         m2kOGzpUV9gCXwcei7mapLkLmaKpipvP8apr9UV+rCd3CGkDqMQmNyvKX0oURLFZyyoB
         jAB5tu+pBiOoHveKMLL8VCWO1cjUBLY0OB7WzENLQiBq9m+PNcVBF5HMnepnfVpXmsMf
         /K2w==
X-Gm-Message-State: APjAAAUgqFix23xNuCBYpmEt8Wp/Wnbrp21PS7rkrcZJGYjxhakVFyT/
        0lFyoF8ndD0EGB59gYMYOUKO568j2NidfgUBq5Frd3Geu53grQL3RT2ak3ZPs7foCwELy4eJI+y
        QW6hCwJR7hsTmxY8KiuPd5xP6nrXCocFNZw==
X-Received: by 2002:aca:f507:: with SMTP id t7mr3168525oih.156.1578490896603;
        Wed, 08 Jan 2020 05:41:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHzTyc0D9Gf584Mw/+kIQSZCRq3b9WBkfCLv9Zt717IlIx0Uv0fa87B3GmS2blRgtTV5hnYqq57OG4F3jFaV0=
X-Received: by 2002:aca:f507:: with SMTP id t7mr3168514oih.156.1578490896397;
 Wed, 08 Jan 2020 05:41:36 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov> <CAJ2a_DcEnxg4w92ayqg7y76_5AvkGnzFBU32FpV_qzcxuUN_Pg@mail.gmail.com>
In-Reply-To: <CAJ2a_DcEnxg4w92ayqg7y76_5AvkGnzFBU32FpV_qzcxuUN_Pg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 14:41:25 +0100
Message-ID: <CAFqZXNsOJMS_pi80O1+-57dBgwGJ0oHS=v2b1X9SR2rU1u0=dg@mail.gmail.com>
Subject: Re: incorrect sysfs contexts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 19, 2019 at 3:16 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> Default Debian sid kernel:
> Linux debian-test 5.3.0-3-amd64 #1 SMP Debian 5.3.15-1 (2019-12-07)
> x86_64 GNU/Linux
>
> Somehow symlinks do not inherit their parent label.
> They all have the root-sysfs label.
>
> Remounting sysfs with `mount -o remount -t sysfs /sys` leaves all
> symlinks with the root-sysfs label.

Hm... this seems to happen due to the !S_ISLNK(inode->i_mode)
condition in inode_doinit_with_dentry() introduced in ea6b184f7d521
("selinux: use default proc sid on symlinks"). Since the condition was
apparently only intended for procfs at that time, I think we can
change the condition to !((sbsec->flags & SE_SBPROC) &&
S_ISLNK(inode->i_mode)) to fix this for sysfs (et al.). Stephen, do
you agree? Or could the condition even be removed completely?

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

