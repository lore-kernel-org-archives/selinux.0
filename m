Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A09C432BE
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 06:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE55460E90
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 06:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhGWFZx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Jul 2021 01:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhGWFZx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Jul 2021 01:25:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E4C061575;
        Thu, 22 Jul 2021 23:06:27 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o13so419149qkk.9;
        Thu, 22 Jul 2021 23:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnSmAnvNAduU2vw3pFl+YZS79O7vlyGeOi1mUa2at+A=;
        b=P842otSNV7QxzORmEIrQ+yDBbs/34KjN7qY3F7Og/MtAl1wsvwd1pSQSXzvnEjz4sN
         U8zhDBmhsOrlgqHBpJ5larUWHvRGq2smErx+FIOTa1VrlfDdujEm3t9RDHbbTLQGW2pp
         4X2kEwLSMW2A8QMViEgfd0DdmBt4nImoYoz0MPSdoZ0Mbc6dQhBhccXd2C/PBe+u9Ay7
         EZNeeBs0b59A3gNk3/3G6BT85uJwqa2wBot5nbtgiG3oECZtIY6viR6MLbhfg69sYeoP
         WlEn1M+VSr5r08g5vtlj2c9f6TWaNSN0bdhqwNb0WkGrckCQktlf1mIGNvgko+Xj48g2
         ZMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnSmAnvNAduU2vw3pFl+YZS79O7vlyGeOi1mUa2at+A=;
        b=rxa/B/X+gymtSICqKyKZyDkyjAZUzdZCeBe+Gvczewc4fh2+mlGMI//iFcMp6uuf2F
         F4jAwMo+5S7Rit0e9xHCoxE2NEd5hPtcfUybjIspkNBZxkaTa6B9+cvB/8Km0HTlQ7Qs
         nKHM6ptrDM31/QcQqvJVEcQPLabAXE+VImHXCbZeK52IDghGRQC6POV4H86Mm1mUh7SM
         7oFkiG879953Xynp/rnM31LbrzJboXvIM/JSEX9s4Z+gqu3INoxn3+OurCeOMtBUXLIF
         q/tr0jw3sIeHK3FsXJuA56QicIHOcPUP+0Qoomf1qQBadNN2imks74jGboZp+1w0yI5C
         7ljA==
X-Gm-Message-State: AOAM531LOaoQWRerch+gxjqLEV9OpfjxATa3wNAZ5KwijpFsvrb0OPs4
        3B4MCJRZ826cDPntLjTAEeCJfD8AexOr6Sk2A8g=
X-Google-Smtp-Source: ABdhPJyceFpI7tmhazN23LrJE9GoGfvcVYtvpOsVMksqmyOIyvdwUf6gzoszJiEfNYIg/hiILWNzgDNGJzJYt9n4RAE=
X-Received: by 2002:ae9:ef16:: with SMTP id d22mr3179829qkg.383.1627020386411;
 Thu, 22 Jul 2021 23:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAP198X8TNTv1tqpO6Y7eyE2+iSwK9XHk0qRH6J-Z0Ww=a+53tA@mail.gmail.com>
 <CAHC9VhSBo1CHCM+k5TocQS7--+bGL5RY0z6WKKunE76-fuR6iw@mail.gmail.com>
 <CAP198X-7NZ+1QfYK3cUUkMMNoaJTwNzBN8wr27egWT1kVh=g3Q@mail.gmail.com> <c22dcebb-e766-d1e2-1e15-15a85e2124bb@redhat.com>
In-Reply-To: <c22dcebb-e766-d1e2-1e15-15a85e2124bb@redhat.com>
From:   Sujithra P <sujithrap@gmail.com>
Date:   Thu, 22 Jul 2021 23:06:15 -0700
Message-ID: <CAP198X8Gun1xhzJrmyzFC7Vh0UP=k_5tSPu5ev5FQ+FumE-0iw@mail.gmail.com>
Subject: Re: AVC denied for docker while trying to set labels for tmpfs mounts
To:     dwalsh@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks Daniel.

I'm not seeing anything suspicious in the audit logs, the. following
are the MAC_POLICY_LOAD events

type=SYSCALL msg=audit(1622991228.547:183): arch=c000003e syscall=1
success=yes exit=8577048 a0=4 a1=7fd682c61000 a2=82e018 a3=0 items=0
ppid=62178 pid=62186 auid=1004 uid=0 gid=0 euid=0 suid=0 fsuid=0
egid=0 sgid=0 fsgid=0 tty=pts0 ses=1 comm="load_policy"
exe="/usr/sbin/load_policy"
subj=unconfined_u:unconfined_r:load_policy_t:s0-s0:c0.c1023 key=(null)

type=MAC_POLICY_LOAD msg=audit(1627002776.825:6075): auid=4294967295
ses=4294967295 lsm=selinux res=1
----
type=MAC_POLICY_LOAD msg=audit(1627008064.852:7615): auid=4294967295
ses=4294967295 lsm=selinux res=1
----
type=MAC_POLICY_LOAD msg=audit(1627008273.029:7617): auid=4294967295
ses=4294967295 lsm=selinux res=1
----
type=MAC_POLICY_LOAD msg=audit(1627009159.383:8392): auid=4294967295
ses=4294967295 lsm=selinux res=1
----

On Thu, Jul 22, 2021 at 2:38 AM Daniel Walsh <dwalsh@redhat.com> wrote:
>
> On 7/21/21 18:17, Sujithra P wrote:
> > Thanks Paul!
> >
> > Is there any specific centos/RH mailing list that I can ask? Not sure
> > whether it is a problem with kernel/docker/kubelet.
> > semodule -R seems to fix the problem, but not sure what is causing the
> > loaded policy to get corrupt.
> > Any insight on how to figure this out would be very much appreciated.
> >
> > Thanks
> > Sujithra.
> I am guessing that one of the containers is loading policy.  You should
> be able to see something in the auditlog, about a policy load.
> > On Wed, Jul 21, 2021 at 2:01 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Wed, Jul 21, 2021 at 2:46 PM Sujithra P <sujithrap@gmail.com> wrote:
> >>> Hi SELinux Experts,
> >>>
> >>> The following issue is described in the below post as well.
> >>> https://github.com/containers/container-selinux/issues/141
> >>>
> >>> Occasionally running into the following selinux denials for docker
> >>>
> >>> type=AVC msg=audit(1626732057.636:4583): avc:  denied  { associate }
> >>> for  pid=57450 comm="dockerd" name="/" dev="tmpfs" ino=150014
> >>> scontext=system_u:object_r:container_file_t:s0:c263,c914
> >>> tcontext=system_u:object_r:lib_t:s0 tclass=filesystem permissive=0
> >>>
> >>> type=AVC msg=audit(1626812823.170:9434): avc:  denied  { associate }
> >>> for  pid=20027 comm="dockerd" name="/" dev="tmpfs" ino=198147
> >>> scontext=system_u:object_r:container_file_t:s0:c578,c672
> >>> tcontext=system_u:object_r:locale_t:s0 tclass=filesystem permissive=0
> >>>
> >>>
> >>>   level=error msg="Handler for POST
> >>> /v1.40/containers/a3a875e7896384e3bff53b8317e91ed4301a13957f42187eb227f28e09bd877c/start
> >>> returned error: error setting label on mount source
> >>> '/var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret':
> >>> failed to set file label on
> >>> /var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret:
> >>> permission denied"
> >>>
> >>>
> >>> Docker is not able to set labels for these tmpfs mounts because they
> >>> end up having wrong labels when they are created (sometimes
> >>> "locale_t", sometimes "lib_t" which of course is not the
> >>> default/correct context for tmpfs fs).
> >>> Apparently semodule -R and deleting these tmps files or reboot of the
> >>> node fixes the problem.
> >>> Not sure what is causing the tmpfs mounts to get wrong labels in the
> >>> first place.
> >>>
> >>> Everything seems to be fine to begin with, but as the system keeps
> >>> scheduling pods on the node, this behavior is observed sometimes (not
> >>> consistent always).
> >>>
> >>>
> >>> OS Details:
> >>>
> >>> NAME="CentOS Linux"
> >>> VERSION="8 (Core)"
> >>> ID="centos"
> >>> ID_LIKE="rhel fedora"
> >>> VERSION_ID="8"
> >>> PLATFORM_ID="platform:el8"
> >>> PRETTY_NAME="CentOS Linux 8 (Core)"
> >>>
> >>> Docker Version:
> >>> Client: Docker Engine - Community
> >>> Version: 19.03.13
> >>> API version: 1.40
> >>> Go version: go1.13.15
> >>> Git commit: 4484c46d9d
> >>> Built: Wed Sep 16 17:02:36 2020
> >>> OS/Arch: linux/amd64
> >>> Experimental: false
> >>>
> >>> Kubernetes Version*
> >>> v1.20.8-gke.1500
> >>>
> >>>
> >>> Any help on how to debug this issue  would be greatly appreciated.
> >> This sounds like it might be a problem with CentOS and/or your Docker
> >> install, have you tried talking with the RH/CentOS folks about this
> >> problem?  We focus mostly on upstream issues here and it isn't clear
> >> to me at this moment that this is an upstream issue.
> >>
> >> --
> >> paul moore
> >> www.paul-moore.com
>
>
