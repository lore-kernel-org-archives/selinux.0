Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2107C4167B
	for <selinux@archiver.kernel.org>; Mon, 12 Dec 2022 15:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiLLPiA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 10:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiLLPhw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 10:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878BB6460
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670859414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PccKKszWkRWP5I2XDQgnn1TfMCygRci1+qIyYeNPyTU=;
        b=EpT0m9r9dK2mVFbML+M/a+0i04oOCftIfL0YpXYsVkajQkXLG7b97cBxDDVNRAV6iCxoj5
        iJSRMckrgRmc6P9MP9lLHbZT/tEFVo7nQvfMHuNVnc35AY4u8QuFdgtXk1RJetk6Y4Olfy
        dssut+/tZ17DTNTgs4c4+lDOaV88azE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-GUO8E9KLPoKBfnelphZTzg-1; Mon, 12 Dec 2022 10:36:53 -0500
X-MC-Unique: GUO8E9KLPoKBfnelphZTzg-1
Received: by mail-yb1-f198.google.com with SMTP id h67-20020a25d046000000b00729876d3b2bso3186602ybg.17
        for <selinux@vger.kernel.org>; Mon, 12 Dec 2022 07:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PccKKszWkRWP5I2XDQgnn1TfMCygRci1+qIyYeNPyTU=;
        b=6qMDHJi31ffZZVLTlHKUSuieELFbrBChkAGft/BZAwHvxD03wd3CX3S5nqK1ZQ6MzV
         1h+cNK68+z2xP1vPk74D8AGNmCOUZH5nyfeHXgegZFMjeQTQakjJCDvAjgSj879J836x
         ZLPBCcTtQukShRvFnPvQ/iz+zpX6tJ3WfM+cdarkj/lFWTAU8xXOC8fqllz72LQyqCvD
         b+tSOjZgUIJTJsedMSz6lWzZCPMko6n0erKEDn5N6PtUPLYiPb37VvWRiIByETqnFT8P
         UmTWc4aTlKh/++MZmn2kfN8TjkMPQtxOfKjwduUZKaCkwSAoBVjV5OhK13XYPDAxZHYK
         g+0A==
X-Gm-Message-State: ANoB5pm4iA9gzLwc6B9IwGKdwwT/ocPQKIvjCMTMTAFPUWwSHmVWH+iA
        TpOlvtRmWPyF526ZTfHyhjCt/geVjpZQaHA2Fv18JzwRae4mOh1k/dRGaxSHjzEwZhmBvpV7Edc
        uxWziu1wh+4trdC2IZA==
X-Received: by 2002:a05:690c:c0f:b0:3e3:b823:db3c with SMTP id cl15-20020a05690c0c0f00b003e3b823db3cmr15425528ywb.46.1670859411949;
        Mon, 12 Dec 2022 07:36:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YEE+nBMdkf+sl+1Cqvao/1eIaETZGMRa8d1Z+htlQZ3qfbcab5EPNjWmo0Y4+I0MTV0Wthg==
X-Received: by 2002:a05:690c:c0f:b0:3e3:b823:db3c with SMTP id cl15-20020a05690c0c0f00b003e3b823db3cmr15425505ywb.46.1670859411656;
        Mon, 12 Dec 2022 07:36:51 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006e99290e83fsm5928683qkb.107.2022.12.12.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 07:36:51 -0800 (PST)
Message-ID: <75d48710be78d59e990cbb3930133a4f42c95a30.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix LSM labeling for passive msk
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc:     mptcp@lists.linux.dev, Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Date:   Mon, 12 Dec 2022 16:36:47 +0100
In-Reply-To: <CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com>
References: <ffee337de5d6e447185b87ade65cc27f0b3576db.1670434580.git.pabeni@redhat.com>
         <a3c81322-36b5-a289-c07b-15d2be75b02d@linux.intel.com>
         <CAHC9VhQzJAhNtpMnU7STEfq6QpaJo-xiie8HoHH2w3io3aXBHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Thu, 2022-12-08 at 18:40 -0500, Paul Moore wrote:
> On Wed, Dec 7, 2022 at 9:19 PM Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:
> > On Wed, 7 Dec 2022, Paolo Abeni wrote:
> > 
> > > MPTCP sockets created via accept() inherit their LSM label
> > > from the initial request socket, which in turn get it from the
> > > listener socket's first subflow. The latter is a kernel socket,
> > > and get the relevant labeling at creation time.
> > > 
> > > Due to all the above even the accepted MPTCP socket get a kernel
> > > label, causing unexpected behaviour and failure on later LSM tests.
> > > 
> > > Address the issue factoring out a socket creation helper that does
> > > not include the post-creation LSM checks. Use such helper to create
> > > mptcp subflow as in-kernel sockets and doing explicitly LSM validation:
> > > vs the current user for the first subflow, as a kernel socket otherwise.
> > > 
> > > Fixes: 0c14846032f2 ("mptcp: fix security context on server socket")
> > > Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > 
> > The MPTCP content looks good to me:
> > 
> > Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > 
> > I didn't see issues with the socket.c changes but I'd like to get some
> > security community feedback before upstreaming - Paul or other security
> > reviewers, what do you think?
> 
> Sorry, I was distracted by other things the past few days ...
> 
> One thing that jumps out is the potential for misuse of
> __sock_create_nosec(); I can see people accidentally using this
> function by accident in other areas of the stack and causing a new set
> of problems.
> 
> We discussed this in the other thread, but there is an issue with
> subflows being labeled based on the mptcp_subflow_create_socket()
> caller and not the main MPTCP socket.
> 
> I know there is a desire to get a small (in size) patch to fix this,
> but I think creating a new LSM hook may be the only way to solve this
> in a sane manner.  My original thought was a new LSM hook call inside
> mptcp_subflow_create_socket() right after the sock_create_kern() call.
> The only gotcha is that it would occur after
> security_socket_post_create(), but that should be easy enough to
> handle inside the LSMs.

If the preferrede solution is via a new LSM hook I have no objections
at all. I'm sorry to put another hook mainteinance on you.

How do you propose to preceed? After quickly digging into the relevant
LSM code, the only module I think I could handle in a reasonable
timeframe is selinux. Hopefully the new hook implementation should be
quite straight-forward for the relevant SME.

I guess the patch[es] should target the LSM tree, as the change in the
mptcp code should be a one-liner. On the flip side, that would likely
lead to some merge conflict, as the mptcp protocol impl. is quite a
moving target.

Cheers,

Paolo

