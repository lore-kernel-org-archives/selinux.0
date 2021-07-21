Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B7C6377A
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 22:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F76461208
	for <selinux@archiver.kernel.org>; Wed, 21 Jul 2021 22:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhGUVhP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 17:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhGUVhO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 17:37:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33207C061575;
        Wed, 21 Jul 2021 15:17:50 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id k3so2979723qtq.7;
        Wed, 21 Jul 2021 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2UpZSeislmz7R5tei71D3tCZ1sNPw/f4t+sr/wd1U8=;
        b=og6KVqjVLFq8nzCtvW2UybIUXLpq8n7K1BnDQjB0Tp2ILt8qWUocnqKrDeXbLnaNAz
         z7dlk+AW5+KqVgdY0Jo5//7PmMwlT0PJsWNj7k/8gLhXECUtFaoaCVFZPlUKUfAtkx2g
         za7Dub7JBZC4lSqVRMWXllIHdfTZAu3l2gYQpiguBXRlexXp0o/vAlhq+T9uoEmXdeUa
         92TfVfIUDnMZOfhFifxNidW0654RWFjwvpcQLBTyWUYPOnWw1wvQYAHJjvfBZu+gVp6N
         bdCrzq9MUBYO7FDXffiymMx8GlqszXmwoorfcpRrsMGjYXi/prjnIvvOUYNA8OZA0AjS
         +adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2UpZSeislmz7R5tei71D3tCZ1sNPw/f4t+sr/wd1U8=;
        b=pIgnSg7LT7LtXa3YtpO52nYrWV4djcY1YEpiCtaVDUTYoeiK0h67UvTlmYX2rnEXvu
         8fGwzd1ryTnXWTEIYZ0X653JhYr/Q7yY5Uy8M8gg3BONri095tO90TmpqYvU/y6OtPUN
         RzPwB0pfhIfaf66+ZBwn8sn3rLjNNNngLyLQi5kBtupoHu3mnuIBpN6KEgDlTJOtO+o4
         K1CTsvt1ivAdt5TbZ7XzVgfmh5hfrzf/TLZX8RE0jXg51CJrR92qZU1JtLiCoFAVuVIp
         xypEVW8lNPw5AQgA1ndI1wVDp/vnOuTmQdeXRvP5v/lObINOJcMfyfntq1eJAlxTrhI2
         QWlw==
X-Gm-Message-State: AOAM533p0ZFE0eU9EC7nYEAIKj2+8sdrTNQHfMRlpizICCRaRyiin/1M
        HC8e+XbCwuzWUcbTm3iebsseXH/6S/SohcqgjvY=
X-Google-Smtp-Source: ABdhPJz3w/WzT5A2alzrkFUj2uxsBD+3I8whCriz6hYnPAWgJ9N0GeUlSH0Z4/D7cd8nxn2iLtLZBjtI2tRTXZQsDZQ=
X-Received: by 2002:ac8:a84:: with SMTP id d4mr33240729qti.109.1626905869267;
 Wed, 21 Jul 2021 15:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAP198X8TNTv1tqpO6Y7eyE2+iSwK9XHk0qRH6J-Z0Ww=a+53tA@mail.gmail.com>
 <CAHC9VhSBo1CHCM+k5TocQS7--+bGL5RY0z6WKKunE76-fuR6iw@mail.gmail.com>
In-Reply-To: <CAHC9VhSBo1CHCM+k5TocQS7--+bGL5RY0z6WKKunE76-fuR6iw@mail.gmail.com>
From:   Sujithra P <sujithrap@gmail.com>
Date:   Wed, 21 Jul 2021 15:17:38 -0700
Message-ID: <CAP198X-7NZ+1QfYK3cUUkMMNoaJTwNzBN8wr27egWT1kVh=g3Q@mail.gmail.com>
Subject: Re: AVC denied for docker while trying to set labels for tmpfs mounts
To:     Paul Moore <paul@paul-moore.com>, dwalsh@redhat.com
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks Paul!

Is there any specific centos/RH mailing list that I can ask? Not sure
whether it is a problem with kernel/docker/kubelet.
semodule -R seems to fix the problem, but not sure what is causing the
loaded policy to get corrupt.
Any insight on how to figure this out would be very much appreciated.

Thanks
Sujithra.

On Wed, Jul 21, 2021 at 2:01 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jul 21, 2021 at 2:46 PM Sujithra P <sujithrap@gmail.com> wrote:
> >
> > Hi SELinux Experts,
> >
> > The following issue is described in the below post as well.
> > https://github.com/containers/container-selinux/issues/141
> >
> > Occasionally running into the following selinux denials for docker
> >
> > type=AVC msg=audit(1626732057.636:4583): avc:  denied  { associate }
> > for  pid=57450 comm="dockerd" name="/" dev="tmpfs" ino=150014
> > scontext=system_u:object_r:container_file_t:s0:c263,c914
> > tcontext=system_u:object_r:lib_t:s0 tclass=filesystem permissive=0
> >
> > type=AVC msg=audit(1626812823.170:9434): avc:  denied  { associate }
> > for  pid=20027 comm="dockerd" name="/" dev="tmpfs" ino=198147
> > scontext=system_u:object_r:container_file_t:s0:c578,c672
> > tcontext=system_u:object_r:locale_t:s0 tclass=filesystem permissive=0
> >
> >
> >  level=error msg="Handler for POST
> > /v1.40/containers/a3a875e7896384e3bff53b8317e91ed4301a13957f42187eb227f28e09bd877c/start
> > returned error: error setting label on mount source
> > '/var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret':
> > failed to set file label on
> > /var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret:
> > permission denied"
> >
> >
> > Docker is not able to set labels for these tmpfs mounts because they
> > end up having wrong labels when they are created (sometimes
> > "locale_t", sometimes "lib_t" which of course is not the
> > default/correct context for tmpfs fs).
> > Apparently semodule -R and deleting these tmps files or reboot of the
> > node fixes the problem.
> > Not sure what is causing the tmpfs mounts to get wrong labels in the
> > first place.
> >
> > Everything seems to be fine to begin with, but as the system keeps
> > scheduling pods on the node, this behavior is observed sometimes (not
> > consistent always).
> >
> >
> > OS Details:
> >
> > NAME="CentOS Linux"
> > VERSION="8 (Core)"
> > ID="centos"
> > ID_LIKE="rhel fedora"
> > VERSION_ID="8"
> > PLATFORM_ID="platform:el8"
> > PRETTY_NAME="CentOS Linux 8 (Core)"
> >
> > Docker Version:
> > Client: Docker Engine - Community
> > Version: 19.03.13
> > API version: 1.40
> > Go version: go1.13.15
> > Git commit: 4484c46d9d
> > Built: Wed Sep 16 17:02:36 2020
> > OS/Arch: linux/amd64
> > Experimental: false
> >
> > Kubernetes Version*
> > v1.20.8-gke.1500
> >
> >
> > Any help on how to debug this issue  would be greatly appreciated.
>
> This sounds like it might be a problem with CentOS and/or your Docker
> install, have you tried talking with the RH/CentOS folks about this
> problem?  We focus mostly on upstream issues here and it isn't clear
> to me at this moment that this is an upstream issue.
>
> --
> paul moore
> www.paul-moore.com
