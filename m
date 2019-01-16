Return-Path: <SRS0=uPJ/=PY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB8C43387
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 14:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BA520657
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 14:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="auPzw4SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbfAPOpP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:45:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32947 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393741AbfAPOpO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Jan 2019 09:45:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so5688530ljd.0
        for <selinux@vger.kernel.org>; Wed, 16 Jan 2019 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9WOevP7uzw6j1nPOD/HcrCeNYIEkVehu+thUq52uk8=;
        b=auPzw4SHsi/AtB1ougxNmEP/bckxE1cg4FC4ksDII2DQVZpQxV2Ka59eERWI8uuCqU
         Bnm80xPAr76O5C0zWRB8AwAfzDGl4DAh8lx4X8CbGNwCvPngvpCpHygpIHCrcLwwTtB7
         HsE50uaFaekyPDH47sUGdQTMDiEnsmBlsWH+wj0fXK9RQgWdchZ90nEy6ulK49Ap09mT
         O33zmiH5y4ahlHQyYlakRl4ZDYtnxXuIFBkj6r67NLnj20c4VD3JF7Vgt/DyoRWm4oe5
         RukNzZXBOqE0EBVkTmRnood1P7EmxUnL4rl7YarKA6Ep53RqlrFHJq931Zj/ZAke5UET
         opPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9WOevP7uzw6j1nPOD/HcrCeNYIEkVehu+thUq52uk8=;
        b=Z/KDUaGAD+WgRr3eN3mibfmwvkm1DbV3QocVa4eXl4ouaUqFG/9ocxMzLfLcQALI+Z
         I4DtXqDK2Q1gdFukZGisQDeT0QTjCNFcxQSDhS0BmrinrnVZsUOLCHR5vvtOqtgJKi2q
         ZnVgACLR+1yvzFv7UJtWTOAjwdeZnDx26UkFrfEMN5XeLoeCIQOxXwzuqcWTQSjhdULn
         B6PFk+/KhxHKK3wPPawtsHLvCxsu8zg380zsIw4u1rvp+LRJ4IVy+TC4sRzPscNwCQLX
         iQ1Lu3M8hSAx4z6tDKpMBAtf2ukYjD9WH4e6Uvp5AVN7+2dCH5uJOov4EfHzGf2gurbB
         N52w==
X-Gm-Message-State: AJcUukf3GP2NkUKpNFZuPv5zxd87WtHOD4oqJGgoo/VM2gslfS5WPHVB
        TrPOmFu6BJgVHYRT/Ab2eXemDucSASbxHfc+Q9ux
X-Google-Smtp-Source: ALg8bN7yTrDd5rz0WuVmzm2hWXQ5scU3yNs/u2kDay2Fmj16AGo8OgSJAZ/C8i8Eqn+D/8h4k6zM+KBz+uAsZyz5SaY=
X-Received: by 2002:a2e:8ec8:: with SMTP id e8-v6mr6825420ljl.162.1547649912283;
 Wed, 16 Jan 2019 06:45:12 -0800 (PST)
MIME-Version: 1.0
References: <41e46a6c-a42f-a01e-60ce-c1afef70c303@canonical.com>
In-Reply-To: <41e46a6c-a42f-a01e-60ce-c1afef70c303@canonical.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Jan 2019 09:45:01 -0500
Message-ID: <CAHC9VhQdUAKWbn=_5b9sjmoh9rGj5gZp3DtwLyscDTAtOMxn2A@mail.gmail.com>
Subject: Re: Bug Report: bug if selinux_msg_queue_msgsnd & and selinux_msg_queue_msgrcv
To:     John Johansen <john.johansen@canonical.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 16, 2019 at 5:14 AM John Johansen
<john.johansen@canonical.com> wrote:
>
> kernel: 5.0-rc2
>
> d8c6e85432944 ("msg/security: Pass kern_ipc_perm not msg_queue into the msg_queue security hooks")
>
> appears to have introduced a bug into selinux_msg_queue_msgsnd and selinux_msg_queue_msgrcv
>
> specifically the portion of the patch that does
>
> -       isec = msq->q_perm.security;
> +       isec = msq->security;
>
> which leaves the code
>         isec = msq->security;
>         msec = msg->security;
>
> however isec and msec are different size structures. specifically isec is an ipc_security_struct and msec is a msg_security_struct ...

I suspect there may be some mistaken identity regarding "msq" (with a
lower-case "Q") and "msg" (with a lower-case "G").

Looking quickly at selinux_msg_queue_msgsnd() and
selinux_msg_queue_msgrcv() it would appear that in both cases the
kern_ipc_perm->security pointer is assigned to an ipc_security_struct
pointer and the msg_msg->security struct is assigned a
msg_security_struct pointer.  This appears to be correct, or is there
something I'm missing in your report?

-- 
paul moore
www.paul-moore.com
