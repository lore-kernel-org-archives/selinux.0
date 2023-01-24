Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8BCC38142
	for <selinux@archiver.kernel.org>; Tue, 24 Jan 2023 04:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjAXEr3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Jan 2023 23:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjAXEr2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Jan 2023 23:47:28 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9737F38B62
        for <selinux@vger.kernel.org>; Mon, 23 Jan 2023 20:47:26 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id a9so17481481ybb.3
        for <selinux@vger.kernel.org>; Mon, 23 Jan 2023 20:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5+rk6gG92yU871Q18SGdLg7yIfDbgS5v3bi+1rCUbI=;
        b=aWyceTWtE5DTXNyf9TvC5uY4/OZwC8YyWYVPbtQZa82CqvSa6NLYy7WyPJWvo1gHfR
         qbqDg2g0l+Ahec3b15JPqyZBqEWwhusTLppzRnqY5x9zcHeYavXxKgYAg8mIW3k8ULE5
         sKYGam3VNwr5rFIaYa2weHMKPhAlUexGu6I7BsgaF2BY/zDAErUTVigE890Cwy6KLrLc
         9yqPI2WnnMdJHwF42k8jmH74XUPI11iHViGtCj+XOvHYb5av5UEmYLP4v0+hPOymIYpP
         lWNcJpvaBML6U8BIJzbtH/XxL8W2IM9HC5UZ/bhRzYNKonuqg2CbUJvEgWkhW0R7YNE1
         MdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5+rk6gG92yU871Q18SGdLg7yIfDbgS5v3bi+1rCUbI=;
        b=HMBzp+s6jzqpPtB+Nd0mmvLcqRpsLtmB25mbkP9IdMDkpMuk9DU3k/eV6wzq2LvdRB
         iC0eEfUhJJMwACrI1tY00wu6Wvg8ay3CrVl0QbN5c3w1H5JdWs+qIxL1ocE6JoijhXS9
         KXbHTWUHWhROBredilddSIXiHQvL3OWPf4eREmxYiQw343+zA04FJb2DmMS5RQ0Ng8Uc
         XpX8+ovtZ9lN7FSSXYhuDxR7U1vw4XraOpx2YJpzP0H1jU8UVhFIsNLxbIC6KhvBIqb7
         Z3K1QQv9zRvLt2WB5NXk7btNrQD8QYu1KHMJXlDLC72/hXW7ew4EyJI/Rvr9s8kTCijT
         COVw==
X-Gm-Message-State: AFqh2kq7ReJxMZOfkfJMp9y1GQ82vnitKZta25Xb/ZyfA4F0bIC1J9F0
        rK2HAkhQvVkXhD5LHePfHIcnRwcb8uAzI3oFXixu2g==
X-Google-Smtp-Source: AMrXdXuYdYgfPuS6e/ypCYP4fU7Onii28qxOTxo06MVE/ttY1OEfzR8WQcc4gqxY5GLV14tPPWAYGcO2P7+hD94HjyM=
X-Received: by 2002:a25:c00a:0:b0:733:4dbc:7215 with SMTP id
 c10-20020a25c00a000000b007334dbc7215mr3054103ybf.636.1674535645579; Mon, 23
 Jan 2023 20:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
 <20230123191728.2928839-5-tjmercier@google.com> <CAHC9VhQtbTWXXy8mNxNDdukaAp6YB4CX5Xa6dvSZ_r4DhM2EXg@mail.gmail.com>
 <CABdmKX0Jc3OTnSMv_GoL0eEo=7W9dP29+r5K=PfF84xAUHviBw@mail.gmail.com>
In-Reply-To: <CABdmKX0Jc3OTnSMv_GoL0eEo=7W9dP29+r5K=PfF84xAUHviBw@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Mon, 23 Jan 2023 20:47:14 -0800
Message-ID: <CABdmKX0EoAw+TYk29z1dJXtWekfw22KDQAkQPGiDAh8ojeKd1A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] security: binder: Add binder object flags to selinux_binder_transfer_file
To:     Paul Moore <paul@paul-moore.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        jeffv@google.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 23, 2023 at 2:04 PM T.J. Mercier <tjmercier@google.com> wrote:
>
>
>
> On Mon, Jan 23, 2023 at 1:36 PM Paul Moore <paul@paul-moore.com> wrote:
>>
>> On Mon, Jan 23, 2023 at 2:18 PM T.J. Mercier <tjmercier@google.com> wrot=
e:
>> >
>> > Any process can cause a memory charge transfer to occur to any other
>> > process when transmitting a file descriptor through binder. This shoul=
d
>> > only be possible for central allocator processes, so the binder object
>> > flags are added to the security_binder_transfer_file hook so that LSMs
>> > can enforce restrictions on charge transfers.
>> >
>> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>> > ---
>> >  drivers/android/binder.c            |  2 +-
>> >  include/linux/lsm_hook_defs.h       |  2 +-
>> >  include/linux/lsm_hooks.h           |  5 ++++-
>> >  include/linux/security.h            |  6 ++++--
>> >  security/security.c                 |  4 ++--
>> >  security/selinux/hooks.c            | 13 ++++++++++++-
>> >  security/selinux/include/classmap.h |  2 +-
>> >  7 files changed, 25 insertions(+), 9 deletions(-)
>>
>> ...
>>
>> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> > index 3c5be76a9199..d4cfca3c9a3b 100644
>> > --- a/security/selinux/hooks.c
>> > +++ b/security/selinux/hooks.c
>> > @@ -88,6 +88,7 @@
>> >  #include <linux/bpf.h>
>> >  #include <linux/kernfs.h>
>> >  #include <linux/stringhash.h>  /* for hashlen_string() */
>> > +#include <uapi/linux/android/binder.h>
>> >  #include <uapi/linux/mount.h>
>> >  #include <linux/fsnotify.h>
>> >  #include <linux/fanotify.h>
>> > @@ -2029,7 +2030,8 @@ static int selinux_binder_transfer_binder(const =
struct cred *from,
>> >
>> >  static int selinux_binder_transfer_file(const struct cred *from,
>> >                                         const struct cred *to,
>> > -                                       struct file *file)
>> > +                                       struct file *file,
>> > +                                       u32 binder_object_flags)
>> >  {
>> >         u32 sid =3D cred_sid(to);
>> >         struct file_security_struct *fsec =3D selinux_file(file);
>> > @@ -2038,6 +2040,15 @@ static int selinux_binder_transfer_file(const s=
truct cred *from,
>> >         struct common_audit_data ad;
>> >         int rc;
>> >
>> > +       if (binder_object_flags & BINDER_FD_FLAG_XFER_CHARGE) {
>> > +               rc =3D avc_has_perm(&selinux_state,
>> > +                           cred_sid(from), sid,
>> > +                           SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
>> > +                           NULL);
>> > +               if (rc)
>> > +                       return rc;
>> > +       }
>> > +
>> >         ad.type =3D LSM_AUDIT_DATA_PATH;
>> >         ad.u.path =3D file->f_path;
>> >
>> > diff --git a/security/selinux/include/classmap.h b/security/selinux/in=
clude/classmap.h
>> > index a3c380775d41..2eef180d10d7 100644
>> > --- a/security/selinux/include/classmap.h
>> > +++ b/security/selinux/include/classmap.h
>> > @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[]=
 =3D {
>> >         { "tun_socket",
>> >           { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>> >         { "binder", { "impersonate", "call", "set_context_mgr", "trans=
fer",
>> > -                     NULL } },
>> > +                     "transfer_charge", NULL } },
>> >         { "cap_userns",
>> >           { COMMON_CAP_PERMS, NULL } },
>> >         { "cap2_userns",
>>
>> My first take on reading these changes above is that you've completely
>> ignored my previous comments about SELinux access controls around
>> resource management.  You've leveraged the existing LSM/SELinux hook
>> as we discussed previously, that's good, but can you explain what
>> changes you've made to address my concerns about one-off resource
>> management controls?
>>
> It's been a couple of weeks since v1 so I've sent this update out now to =
incorporate all the other feedback so far to make sure it's headed in the r=
ight direction. I've tried opening up a discussion about this rather unique=
 case, but there's been no activity on that yet.
>
Someone pointed out this didn't make it to the lists. Retrying.

>> --
>> paul-moore.com
