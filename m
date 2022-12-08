Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505ADC4332F
	for <selinux@archiver.kernel.org>; Thu,  8 Dec 2022 23:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiLHXmp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Dec 2022 18:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLHXmQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Dec 2022 18:42:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD013F1E
        for <selinux@vger.kernel.org>; Thu,  8 Dec 2022 15:40:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so3138788pli.0
        for <selinux@vger.kernel.org>; Thu, 08 Dec 2022 15:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pwL0f6qdQdYVM5VRohID8qZNEBwlNrmly3cwVpA605c=;
        b=dZI29FsRJaw06KcpQAlFs7VjYatn0ViSZvhlZMhfokznqH74PuWp0F1WIIxrzP6TgX
         DdV6sCGZHomutZITSPNcHtGckfm9Qa60fKMaGl4QV+BG8yHg34+PjrQQLpdEMWmXxY2k
         hUAmqd57dgZh9oBqlvHjf0ahRgNDF/AKtmtJYmZheIjxrkHz00ZEKkQejPdd+WJnVrnb
         g+XygtpIRd+uy99JNMPyJsgGk1u38qTTrEW4/isnv1TOePhGtA6z+2/TxtPTd2b9cMY7
         GpYfAXVCeQOEK7QkplLMgj+0yUzPaLy/Spx+WbLkcD0GSlLQEFqNZJORB0SfKWsdWJAt
         1YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwL0f6qdQdYVM5VRohID8qZNEBwlNrmly3cwVpA605c=;
        b=ve79mSl/zAv66oPLYrX5C4cnlJ4DurGQOqoyGppkJ06QP1Epof/e1oc1Ttl+C6McPD
         YAUTjsKb6Z9/Wb920vAiWvrWLRxN+4qH2iPhxjK5MPiiS8Us25BnMEX+LtX5NrVaU7Wa
         Pzy9Eww6P7pYfJqfR2wseKVZgqBhrNQNxDovGq15nRuSEbUYyH7Fm4RcPC1pCC+vUfeu
         G5bVGHfgQ7ElTWZPdwM/jSw2zfIfv1EPxCGWoWvlum6IY+5IX8Vr3FBvT+w/j8WQv/RA
         +pTcme4VItuLb5IrlBKbx2qDvlQ66GyN3OcWy7bKi+odKNh5qq6c3kizPZs1R0Swr04u
         HObA==
X-Gm-Message-State: ANoB5pmKsivpZ5M2KuQtcHYHek0RybsEoyLwYreqU4bAUyFHNvTlEGk0
        WY4qA4VK9wgiMEErmI/AVSMoMy5/vLGGizCMvbZdUyeaZFi8TJQ=
X-Google-Smtp-Source: AA0mqf6AxdSDIbXaGdkL6pZX3JaUGhpGSDR2YMil10FMvtSnJ1+1x9RGHydJuNTiBOcCXCio/Nh1AJ95Ire5LmPOYxA=
X-Received: by 2002:a17:902:a70b:b0:189:b0a3:cf4f with SMTP id
 w11-20020a170902a70b00b00189b0a3cf4fmr36150965plq.56.1670542837326; Thu, 08
 Dec 2022 15:40:37 -0800 (PST)
MIME-Version: 1.0
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
 <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
In-Reply-To: <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Dec 2022 18:40:26 -0500
Message-ID: <CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 7, 2022 at 9:19 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
> On Wed, 7 Dec 2022, Paolo Abeni wrote:
>
> > MPTCP sockets created via accept() inherit their LSM label
> > from the initial request socket, which in turn get it from the
> > listener socket's first subflow. The latter is a kernel socket,
> > and get the relevant labeling at creation time.
> >
> > Due to all the above even the accepted MPTCP socket get a kernel
> > label, causing unexpected behaviour and failure on later LSM tests.
> >
> > Address the issue factoring out a socket creation helper that does
> > not include the post-creation LSM checks. Use such helper to create
> > mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
> > vs the current user for the first subflow, as a kernel socket otherwise.
> >
> > Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
> > Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>
> The MPTCP content looks good to me:
>
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> I didn't see issues with the socket.c changes but I'd like to get some
> security community feedback before upstreaming - Paul or other security
> reviewers, what do you think?

Sorry, I was distracted by other things the past few days ...

One thing that jumps out is the potential for misuse of
__sock_create_nosec(); I can see people accidentally using this
function by accident in other areas of the stack and causing a new set
of problems.

We discussed this in the other thread, but there is an issue with
subflows being labeled based on the mptcp_subflow_create_socket()
caller and not the main MPTCP socket.

I know there is a desire to get a small (in size) patch to fix this,
but I think creating a new LSM hook may be the only way to solve this
in a sane manner.  My original thought was a new LSM hook call inside
mptcp_subflow_create_socket() right after the sock_create_kern() call.
The only gotcha is that it would occur after
security_socket_post_create(), but that should be easy enough to
handle inside the LSMs.

-- 
paul-moore.com
