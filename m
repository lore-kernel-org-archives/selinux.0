Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE3AC74A5B
	for <selinux@archiver.kernel.org>; Fri, 17 Mar 2023 16:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCQQns (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCQQnX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Mar 2023 12:43:23 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFF947827
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 09:42:56 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 187so5025451vsq.10
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679071375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO+MhvRZGhwFMN2l9eu7PGLq5QYzWS+ooId9FrJZEiw=;
        b=dv/izEVUKs6Z8xn6geDiOG0/lneOTrbkjowlJh+zMcVzvFxiwHUh37gPszIziMWLcN
         +nxwaIgBrcFQjYdnu/xvhsaHfeK0F6Kts94oBLH3RSklC7rwkSWlc6+uOfB6AJHq7XQM
         NZn4tpbVnzZHixbstYpZZAtAqa5vu7mr/OKQRiotU/bq0RYEf1lB82tgfpicAg4bdOB7
         yeCjBV9SWdp991ymTW9HxtdTCyqTLL7IWHHIp2e9bDvoYeinQEwrXdOzO2bmMDTLTcOF
         z8UXe9w2dsE4fKQ/njyzQeIaFN6oTyCP/Zpunq+g2CSlrK1yGQucgoW75TRVawqKA0qL
         TE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO+MhvRZGhwFMN2l9eu7PGLq5QYzWS+ooId9FrJZEiw=;
        b=OKeYPwFqIdUEWoiMQ7XEO8gD7EdNg60G6oWUH7sbSdCDB9owbDRU1JgOk2h6XmMMfd
         xL1SzsuR5PxOuXWl2SQSYWRqkpA83t5/71+X26sHQ9BZxkmdWEq6YbJNnZ4C8Qg1X2X9
         H6PufxhZHFp54Paak9NKMmnqVmyIF583kqLfwLNeauWHr+sAVgnc2On21Odvvs7QoMxR
         A/U+HBhFgvtSjm3NlvUb2X0Kgm6QvXSutokaVK0w3PQpAi7CclR+k1d/GU+Fxu1rrWe6
         qGVIlKWcmF1ZP5RB5PSZfqZfxX0MaSKzcCAl/Gip1PyMMf+p95SiPlv1CtjpNJp1J/ry
         +6sQ==
X-Gm-Message-State: AO0yUKU/mVn4gvynwFW6jUbjCiF36uUAb710LCQFb1TKLnX8HOfGQKTf
        3fdalhdQ8ECxx78+8bO4zLjh1YEGmGvCmU4H0lEsVUnpz5VbCZs=
X-Google-Smtp-Source: AK7set9Vn94kq6bU2y3WuHjWRSdS5HQDB0D4LdASpqHuxqIzJPC7v9iUJxARS7rnBJ9EedBIsKH5/U7CHbwIKl+KY+o=
X-Received: by 2002:a67:d798:0:b0:420:10e:14e8 with SMTP id
 q24-20020a67d798000000b00420010e14e8mr95927vsj.1.1679071375031; Fri, 17 Mar
 2023 09:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230316202355.349179-1-paul@paul-moore.com> <CAEjxPJ4cC+KAD1AQyJE8M3e_3-gXck5SmQeTS6ww8A_nEy=eeQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4cC+KAD1AQyJE8M3e_3-gXck5SmQeTS6ww8A_nEy=eeQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Mar 2023 12:42:44 -0400
Message-ID: <CAHC9VhRrcH1--3sTAAcxmuFerW1snSDdTiKuTxpAa7A9LN1aPA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove the 'checkreqprot' functionality
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 17, 2023 at 8:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Mar 16, 2023 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > We originally promised that the SELinux 'checkreqprot' functionality
> > would be removed no sooner than June 2021, and now that it is March
> > 2023 it seems like it is a good time to do the final removal.  The
> > deprecation notice in the kernel provides plenty of detail on why
> > 'checkreqprot' is not desirable, with the key point repeated below:
> >
> >   This was a compatibility mechanism for legacy userspace and
> >   for the READ_IMPLIES_EXEC personality flag.  However, if set to
> >   1, it weakens security by allowing mappings to be made executable
> >   without authorization by policy.  The default value of checkreqprot
> >   at boot was changed starting in Linux v4.4 to 0 (i.e. check the
> >   actual protection), and Android and Linux distributions have been
> >   explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
> >   initialization for some time.
> >
> > Along with the official deprecation notice, we have been discussing
> > this on-list and directly with several of the larger SELinux-based
> > distros and everyone is happy to see this feature finally removed.
> > In an attempt to catch all of the smaller, and DIY, Linux systems
> > we have been writing a deprecation notice URL into the kernel log,
> > along with a growing ssleep() penalty, when admins enabled
> > checkreqprot at runtime or via the kernel command line.  We have
> > yet to have anyone come to us and raise an objection to the
> > deprecation or planned removal.
> >
> > It is worth noting that while this patch removes the checkreqprot
> > functionality, it leaves the user visible interfaces (kernel command
> > line and selinuxfs file) intact, just inert.  This should help
> > prevent breakages with existing userspace tools that correctly, but
> > unnecessarily, disable checkreqprot at boot or runtime.  Admins
> > that attempt to enable checkreqprot will be met with a removal
> > message in the kernel log.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks Stephen.  I'm going to hold off on merging this into
selinux/next until Monday, partially to give people some additional
time to comment/object, and partially because I don't want to blow up
anyone's system over the weekend ;)

--=20
paul-moore.com
