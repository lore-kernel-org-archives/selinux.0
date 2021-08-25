Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31F9C432BE
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 20:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B636054E
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 20:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbhHYU1V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbhHYU1T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Aug 2021 16:27:19 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBECC061757
        for <selinux@vger.kernel.org>; Wed, 25 Aug 2021 13:26:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l18so761393lji.12
        for <selinux@vger.kernel.org>; Wed, 25 Aug 2021 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jikZ2+vMFPnNiSHsd2uLSJLYBovN135PYLIWgdPsntw=;
        b=epu/VFj7LeDI77ePLImpcY9zTHvQH7SJsx/IG/exzzsHuf6YAGz8t5I0Xmxg/qzmGx
         BHijtwM9x8opRkwWTv2HFcW5bGs3fdBO0emxEMuPUdfWK0JrJZP+A6kRTOArbeE/UV7b
         yon2ikVdwSBmFwiheQPC7wr9uYVEc4gqPzB8M9gzzAnvpihJ2yLUfTIMx4atoPEpAmYg
         jkGGriDf/t/q74Kchuz816kBI7z+BBmaj4jc74LWFf9yC9bPHkJKLT6Eu4XxtGHCsPPT
         aB13RoHsA3EFt38TBvt1S/a3F/+UV5qoQFeZUyHKb/PU2Fdn9PJiJXB48qDl4mzE8FN2
         aX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jikZ2+vMFPnNiSHsd2uLSJLYBovN135PYLIWgdPsntw=;
        b=GHtzEO0Tzz70STdFkNEFxZzxjwNlDf6pzSxmj2vYlu1sMzPKtqaa9Uk8L7pvwAMxg+
         fn/sayNKUOxObVJPRm701CVPOg9a9uMf2RPCFDCIbLPx5qi8+U85a6yDSLjPZHt/SUlR
         BptGTXoPzS0P2ujwC/H4daD+6OJHpfK9FSFw3KWl8ZognliILKkCka/UUs5rxOcjZwmu
         YyrvW42j/jdpVEnj37RkkWYmKw2SsAkgG7taHuoaOObegG+Qywm+TPWCG5cWG8Be6rQG
         udDLFxBebRHXxSqWTGsIU+9Q4cB555tO0AUTN1IEpf98ofLm96Oj+Kw7F5b/HI/j1qEW
         3P7A==
X-Gm-Message-State: AOAM532JE1IbNjkWFSiywR04bTMtJU9LiSSW5nbBQ+drovRSSiXvOaK8
        sw7H3sJQKEUnKVt5O8efg1fPeOoFJzbUcf+/ju8=
X-Google-Smtp-Source: ABdhPJwRLNEo6k6EOVNTC+Vcjoe+xf4I4cIf4utpjz2Tkjvnwfjp5Bq4OnWav6USX66Be3ToyJqKvr7YEnmwBA0YL5E=
X-Received: by 2002:a2e:2f04:: with SMTP id v4mr39141ljv.43.1629923190917;
 Wed, 25 Aug 2021 13:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <5ab91c4a-1916-02a3-4011-93ea2c7a9fb2@redhat.com>
In-Reply-To: <5ab91c4a-1916-02a3-4011-93ea2c7a9fb2@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 25 Aug 2021 16:26:19 -0400
Message-ID: <CAEjxPJ61LJK5tOX2Fr4F2Aubjfo-rkW1EAe9YDG_G6CQ-gr=-w@mail.gmail.com>
Subject: Re: There is an interesting conversation going on about virtiofsd and SELinux
To:     dwalsh@redhat.com
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 25, 2021 at 3:19 PM Daniel Walsh <dwalsh@redhat.com> wrote:
>
> The problem is how do we handle a VM with SELinux enabled and the rootfs
> handled by virtiofsd? Or if the SELinux inside of the VM wanted to write
> multiple different labels on a volume mounted in via virtiofsd.
>
> Here is how Vivek defines it:
>
> ```
> How do we manage SELinux host and guest policy with passthrough
> filesystems like virtiofs. Both guest and host might have different
> SELinux policies and can conflict with each other in various ways. And
> this problem exacerbates where there are nested VM guests. Now there
> are 3 entities with possibly 3 different SELinux policies and still
> all the real security.selinux xattr is created and stored on host
> filesystem.
>
> One possible proposal is to remap guest SELinux xattrs to some other
> name, say user.virtiofs.security.selinux. That way host will enforce
> SELinux policy based on security.selinux xattr stored on file. Guest
> will get labels stored in user.virtiofs.security.selinux and guest
> kernel will enforce that. This in theory provides both guest and
> host policies to co-exist and work. And this can be extended to
> nested guest where its attrs are prefixed by one more level of
> user.virtiofs. IOW, user.virtiofs.user.virtiofs.security.selinux
> will be the xattr on host which will show up as security.selinux
> xattr when nested guest does getxattr().
>
> Virtiofsd currently has capability to do this remapping. One problem
> we have is that we are using "user" xattr namespace and one can
> not use "user" xattr on symlinks and special files. So when guest
> tries relabeling or chcon on these files, it fails. May be this is
> fixable. I have done an RFC propsal upstream.
>
> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@redhat.com/
>
> Looking for thoughts how to fix the issue of SELinux with passthrough
> filesystems. What's the best way to solve this issue.
>
> Thanks
> Vivek
>
> ```
>
> We used to talk about this way back when, but never found a good solution. Theoretically
> labeled NFS has the same issue, but I don't believe there are any NFS rootfs using SELinux.

The early labeled NFS work included a notion of a label
domain-of-interpretation (DOI) field and label translation as part of
the infrastructure but I don't think that made it into mainline?
It is however part of the NFSv4.2 spec I believe (called a label
format specifier or LFS).
At present I believe the assumption is that either the NFS server is
just a "dumb" server that is not enforcing any SELinux policy at all
(just storing the labels for use by clients) or is enforcing the same
policy as the clients.

A while ago James Morris proposed an approach to namespaced selinux
xattrs to support selinux namespaces,
https://lore.kernel.org/linux-security-module/alpine.LFD.2.20.1711212009330.6297@localhost/
.
However, that keeps them in the security.* namespace which on the one
hand better protects them from tampering but runs afoul of virtiofsd's
goal of avoiding the need to run with capabilities.

If we use the user. namespace we need a way to control which processes
can change these attributes (or remove them) on the host; optimally we
could limit it to only virtiofsd itself and no other processes not
even
root processes on the host. That presumably requires some kind of LSM
hook or hook call; the current SELinux setxattr and removexattr hooks
don't care about user.* beyond a general setattr permission check.
