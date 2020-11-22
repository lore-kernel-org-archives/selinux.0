Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C2DC64E7A
	for <selinux@archiver.kernel.org>; Sun, 22 Nov 2020 22:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D12B20776
	for <selinux@archiver.kernel.org>; Sun, 22 Nov 2020 22:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="IsIYVTGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgKVWRy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKVWRx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 22 Nov 2020 17:17:53 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033BBC061A4C
        for <selinux@vger.kernel.org>; Sun, 22 Nov 2020 14:17:51 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id oq3so20652607ejb.7
        for <selinux@vger.kernel.org>; Sun, 22 Nov 2020 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4CY2UVVySQTR/IgGfrcAE9Yvfw8Rpt8ESDEqvgdlV0=;
        b=IsIYVTGVaCrVj9c5DcaTFqsBEseZHJ9vWNSoDkjdubHWL5RuSrHMX8lpFwvrVEbr+D
         YIaQzOtzE37dPsYUgIX3D0QQOgxuxcNycAVPUzh0u5rzIXxw1LzVcowcy040lmKqzTjc
         mBOGV1IjonOIMMt7fcNcLg0Jv9GavSzdJiCvSUjrG/Em5mfms4rj7V855zdZH+Mebjf/
         3a3ZJ43HzWf5s0G6gG55hnXRwDtz/TIIGYpZD/Dd2APn5UY5ULuxLKkIgKrRUpEgHBra
         zZASjWMuvIFAgw2L7OuVG7b+2NvuCyaLPF5cXQpaqgo8do08Ply0k66nA+LZF82DGHj4
         OyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4CY2UVVySQTR/IgGfrcAE9Yvfw8Rpt8ESDEqvgdlV0=;
        b=OvHswhfB104/yxMBr+3DGW4cd9RFlrq4feKBN2AtKuRGRJyN0y257pEMyUa4MOU0OI
         mqFwhxxL3pabykSzB9u6Wh4iKOW1nS5h2JCZRZSi9te9JFuRmtF3kGepJ7b7UDwJjDEY
         jBFKuY54209y3w0RDG+qP+eDHn5ya5J2UD5XsExRw1fB7zgMrEAWr2nVPo2ltocEBArp
         jxv/D6SkdjA0pksblGYKXQQANqKXxG7IV8Mo6iGKeAjs/WVqfM99KSviuGBoTIr/yhNn
         xIHyW8U+L4bHQ279GlsQ2adqAgNKbZxSCiLO0YnwYo2EKNeIBW8SlkmwpdZdU4qFtxn4
         nF0g==
X-Gm-Message-State: AOAM5330bdcAG/xOos3+nI1geCXvr0zLE5FFXuTK2ETUbwRv6ge70jHJ
        /ngACOW5isuoVIn273c7qxwBOb4u94PyUjloZMzd
X-Google-Smtp-Source: ABdhPJw12xuRZoIeL/vGVBoUF4Pp6Vi1slczsoOA2TmXfkvzw8XIX8310DsMH/5qvds2YuOjg+U0QMN2daNuxBFO/6M=
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr40871916ejc.178.1606083470433;
 Sun, 22 Nov 2020 14:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20201115103718.298186-1-christian.brauner@ubuntu.com> <20201115103718.298186-32-christian.brauner@ubuntu.com>
In-Reply-To: <20201115103718.298186-32-christian.brauner@ubuntu.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 22 Nov 2020 17:17:39 -0500
Message-ID: <CAHC9VhQ5gcOa0+KKDtKEgg_v4SZV2hPdaKUbPGJAQrVB8mn0jA@mail.gmail.com>
Subject: Re: [PATCH v2 31/39] audit: handle idmapped mounts
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Nov 15, 2020 at 5:43 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Audit will sometimes log the inode's i_uid and i_gid. Enable audit to log the
> mapped inode when it is accessed from an idmapped mount.

I mentioned this in an earlier patch in this patchset, but it is worth
repeating here: audit currently records information in the context of
the initial/host namespace and I believe it should probably stay that
way until the rest of the namespace smarts that Richard is working on
is merged.  If we do change the context of the inode's UID and GID
information it has the potential to create a rather odd looking audit
record with inconsistent credentials and the filters would yield some
very interesting results.

> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> /* v2 */
> unchanged
> ---
>  fs/namei.c            | 14 +++++++-------
>  include/linux/audit.h | 10 ++++++----
>  ipc/mqueue.c          |  8 ++++----
>  kernel/auditsc.c      | 26 ++++++++++++++------------
>  4 files changed, 31 insertions(+), 27 deletions(-)

-- 
paul moore
www.paul-moore.com
