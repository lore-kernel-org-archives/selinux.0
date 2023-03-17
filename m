Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1677CC6FD1D
	for <selinux@archiver.kernel.org>; Fri, 17 Mar 2023 12:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCQM0w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Mar 2023 08:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjCQM0v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Mar 2023 08:26:51 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19266584AB
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 05:26:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p20so5091396plw.13
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 05:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679056008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ6OahKAJb0Xr5zLSdT1R1iY8UTNlJLYyH2CCOyq6bI=;
        b=RweNtroycqCg8G24LvviTJldubWWGt76GfSW5srrc0M8r/OKHx3PRFWHAgCCxrMjXJ
         9YrrjIaOpVXydgkhIgBOkAqWsZ+f4ZH0K6RwiszkCNpAgFtsx09dTIxjL5gKDMCvZxwz
         LUJDzaj/KXOg0ODJAvbpscWtushYg1jpItUeUSJ8Oy72Zw0M8P58leAeSba1P/HyA0VT
         EakH9pp6+LKpDljEKfHFdm3P4S42UbObqYtPS1enYcWteE1aVHzOe9WBJ27DUzb+5zkf
         /wZL6Lp/M/w0bYbHqhPm1BMK99vBYOi3s1WqJqS0QkphTBky85eU/taQVpgl5IIwVjLY
         NW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679056008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ6OahKAJb0Xr5zLSdT1R1iY8UTNlJLYyH2CCOyq6bI=;
        b=B8KtVimRKPv7/eo04oyTB7IxAjfeJUkGaBIzWvDWzKClYqHsrSTLkPE6xy5l0U1LUM
         rylenlujPZOt2k1trdA+je0aATHeAHLAzi7wXlNehKeMi3y2G0R19EveyvSFk+GNqywE
         6nS+OMrbvXnkI4ar6PQ7NIKGYKenZE4iu/PNC1/1h2Uwx9C9R7GKMBJ88hDSZ4DaPXGz
         AqJIShbsOVJcDAK5BOBN3cdhoO7fUpm7VteAwfFA+DHKd6KNFTxbS1FGkPycfgleOhje
         4+jsf3X540hDGzIUiTX8bnr+A7IWd7uUlrJX969zwKuDA6+35gHTX2CsvQ0lvdCj4vuF
         W8Sw==
X-Gm-Message-State: AO0yUKXMfpaUaXipchPUsICA3khWXJ9uIn40n35eUJgAfELNl3HzqIbD
        HY5Wm58KnYW+A387dQO8k5amR4kTaZArdUqCA2EeghFH
X-Google-Smtp-Source: AK7set/fowobETnjlxLREFV7GjxDvuLKl/EmGqzVlozdLjiWFrWG/EPWVZE7Tm6/yPl2caCXiEMQYGnVtMIsqV7YObo=
X-Received: by 2002:a17:90b:1996:b0:23d:20c:2065 with SMTP id
 mv22-20020a17090b199600b0023d020c2065mr922451pjb.1.1679056008487; Fri, 17 Mar
 2023 05:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230316202355.349179-1-paul@paul-moore.com>
In-Reply-To: <20230316202355.349179-1-paul@paul-moore.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 17 Mar 2023 08:26:37 -0400
Message-ID: <CAEjxPJ4cC+KAD1AQyJE8M3e_3-gXck5SmQeTS6ww8A_nEy=eeQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove the 'checkreqprot' functionality
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 16, 2023 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> We originally promised that the SELinux 'checkreqprot' functionality
> would be removed no sooner than June 2021, and now that it is March
> 2023 it seems like it is a good time to do the final removal.  The
> deprecation notice in the kernel provides plenty of detail on why
> 'checkreqprot' is not desirable, with the key point repeated below:
>
>   This was a compatibility mechanism for legacy userspace and
>   for the READ_IMPLIES_EXEC personality flag.  However, if set to
>   1, it weakens security by allowing mappings to be made executable
>   without authorization by policy.  The default value of checkreqprot
>   at boot was changed starting in Linux v4.4 to 0 (i.e. check the
>   actual protection), and Android and Linux distributions have been
>   explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
>   initialization for some time.
>
> Along with the official deprecation notice, we have been discussing
> this on-list and directly with several of the larger SELinux-based
> distros and everyone is happy to see this feature finally removed.
> In an attempt to catch all of the smaller, and DIY, Linux systems
> we have been writing a deprecation notice URL into the kernel log,
> along with a growing ssleep() penalty, when admins enabled
> checkreqprot at runtime or via the kernel command line.  We have
> yet to have anyone come to us and raise an objection to the
> deprecation or planned removal.
>
> It is worth noting that while this patch removes the checkreqprot
> functionality, it leaves the user visible interfaces (kernel command
> line and selinuxfs file) intact, just inert.  This should help
> prevent breakages with existing userspace tools that correctly, but
> unnecessarily, disable checkreqprot at boot or runtime.  Admins
> that attempt to enable checkreqprot will be met with a removal
> message in the kernel log.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

>
> --
> * v2
> - removed the checkreqprot_set() function
> * v1
> - initial release
> ---
>  .../sysfs-selinux-checkreqprot                |  3 +++
>  security/selinux/Kconfig                      | 23 -------------------
>  security/selinux/hooks.c                      | 20 ++++------------
>  security/selinux/include/security.h           | 11 ++-------
>  security/selinux/selinuxfs.c                  | 13 ++++-------
>  5 files changed, 14 insertions(+), 56 deletions(-)
>  rename Documentation/ABI/{obsolete =3D> removed}/sysfs-selinux-checkreqp=
rot (90%)
