Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A049C74A5B
	for <selinux@archiver.kernel.org>; Fri, 17 Mar 2023 20:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCQUnp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjCQUno (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Mar 2023 16:43:44 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ADA3B0EB
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 13:43:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id cj14so7068706ybb.12
        for <selinux@vger.kernel.org>; Fri, 17 Mar 2023 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679085800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fU20fxywhRWXwZ1DJtjS1uiRvlI/+SyujIlKDdPMt5g=;
        b=GASfzLqOwDBpzg8fQWhRINknpEp1xqrIDxa94JDJv2xjTEQ/szCiftJ5LKyxdJlC3N
         i9LgRHjtpviskgQgK9BtfgL2ylbxOR/WnfTWoWebtsKEPHD1wz6rCqqAV6t9k7ZKHxAV
         Jb7U+duT1xt6idDTzE1ibuR4E51jLZobkMZ2LCt53Sd72OaetL9vYOhmFiHE+V23F5nV
         wt6PvbC+qqLFnOd7myjtVZ3VHr7dF/eZLIxJwBmeM70P9/iSUiEuWGg2xNi0Z0/EBadn
         o3yh8ErSJBspdssnYnLc20ZPuJn/qIMs/CA6JRdBgA8rPvxMgl+zs++EDVfMVRvZDWyH
         COQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU20fxywhRWXwZ1DJtjS1uiRvlI/+SyujIlKDdPMt5g=;
        b=1PWl5mLcWCufdjKel4hLlkeil0yOXdCdTm3YqyDDjoyzxy+mvCoo5HUZb7/kXhAYIv
         fO2Z89FYtK+xtPLoo3rT8Rw/wYssa5qjFSVfEp5kT5ECFu85ZgpiSWocfdFVmrRdEtGl
         eQW9Y+EocOzcm8Ok3+8bekMxciJipg4fWaT3T6KfuNC9DawHyFnJ9PltK3wKD/co7o9/
         s3ETLtOi1M76WOoSrUeqMKsFQg17kmYqmjm7xJOUeX/3AN+4M+p/Cz2LYQ+IVboIo+1f
         r95DNp1a6RUyKCRtNxv+mi/OBIcVCdidEH8r5a9aMxFgMY+v41oSnbBafJ1+GcRRL0Y8
         vicw==
X-Gm-Message-State: AO0yUKUYuKwM1CN2ZoZiQMyb3fmV4y1pWErmxG8/+8GocJEYjuQcUx9l
        x2woDDaBdoOQ9pd6ZO61LrlxZqR2HGGM/XgbkN4u
X-Google-Smtp-Source: AK7set+UxQJkEEVKNTpI2JSDVTO7ckrG/nE4zgLwG6YvQr+WkkR5XlZyMQVuPjxWC5aQ7Tk0G374xbFI/UHASYaXWhs=
X-Received: by 2002:a05:6902:1109:b0:b27:4632:f651 with SMTP id
 o9-20020a056902110900b00b274632f651mr555300ybu.3.1679085799908; Fri, 17 Mar
 2023 13:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230317195615.281810-1-paul@paul-moore.com> <7b02ffaa-d9ce-d75d-1078-cd1691f1230f@linux.microsoft.com>
In-Reply-To: <7b02ffaa-d9ce-d75d-1078-cd1691f1230f@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Mar 2023 16:43:09 -0400
Message-ID: <CAHC9VhTF9XXxzeYARYcht_3h7hAkOGtdn1Z86rjHnjfd3c_WGw@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove the runtime disable functionality
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 17, 2023 at 4:25=E2=80=AFPM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 3/17/2023 3:56 PM, Paul Moore wrote:
> > --- a/Documentation/ABI/obsolete/sysfs-selinux-disable
> > +++ b/Documentation/ABI/removed/sysfs-selinux-disable
> > @@ -4,6 +4,9 @@ KernelVersion:        2.6.12-rc2 (predates git)
> >   Contact:    selinux@vger.kernel.org
> >   Description:
> >
> > +     REMOVAL UPDATE: The SELinux checkreqprot functionality was remove=
d in
> > +     March 2023, the original deprecation notice is shown below.
> > +
> >       The selinuxfs "disable" node allows SELinux to be disabled at run=
time
> >       prior to a policy being loaded into the kernel.  If disabled via =
this
> >       mechanism, SELinux will remain disabled until the system is reboo=
ted.
>
> Looks like a copy/paste typo from the other deprecation removal.  I
> assume this should mention runtime disable, rather than checkreqprot.

Ooops, thanks Daniel :)

I've replaced the text above with the following:

  "REMOVAL UPDATE: The SELinux runtime disable functionality was
   removed in March 2023, the original deprecation notice is shown
   below."

--=20
paul-moore.com
