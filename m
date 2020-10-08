Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB05C4363A
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC4C20782
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 13:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="W0UOq3Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgJHNuE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgJHNuE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 09:50:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A010EC061755;
        Thu,  8 Oct 2020 06:50:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg9so3557538edb.12;
        Thu, 08 Oct 2020 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=566aGx0fjn/Cf/+3IIVZxccUrWM+zMuL27UgTu3X9qI=;
        b=W0UOq3LfBHP7GlKANOemtnFlYbU7E1dykEyeE1U+8klIf99LuDjOldc2Cn84agNugG
         GzvuAUpJNpDpmM16q6zoKstSPd4AxTyZIxa2pooWY7ggfJoKwYKjK0IRoyZx1qM6TXzz
         epmkkoOc2QMR+m6PHXDYTm2GA91q2hkYBGhWl7WyyflcXgyjRDgACkqFruFxvndKA4Bq
         LCN3zZ9+T6CkglnVA0H2pf2iouw2YOVkj/W8Oiwuorh3g7U4U/OWmHrlYkhSU+dE8T2Q
         A29RH/kwnfPXp2xVLOM/LO0AMwat55vwcqksrv1EDFLCI8L0L0SO+/lltjo++7o77eBn
         5uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=566aGx0fjn/Cf/+3IIVZxccUrWM+zMuL27UgTu3X9qI=;
        b=f7qnNwKr2yFzIgcm3GG790aF4qj0maq68FOPagvav9MqjETnP3b77s5PqLxeb027J6
         SYLmlSdvJCgZpjuMdtTPl5y7ELXWLlPoIRv9A+T9L/ajLor+NzLcQj0AWMhK5UGFTcHA
         6OGPOFFOOpOXv57RPjWVgCUJNfv++d12Do+N+FvJXjtaXGxM+FThQ2vQuIT368UsFSpC
         Mp/1l/hdy0gXu7fRN9HG4+G1dT4s+OzIazvpZo8GdmOipmFEC1qs5XUPxNqMgw5sU8rT
         ZuKX9AKGZQedfQnMu5wbTpNO952sPy71lWQVq2XSgzlZKb89Ik5cmhsGs4kunMesUpan
         FDnA==
X-Gm-Message-State: AOAM530gNvhmRWG6KUuJ1aVG9cLE2Uzk5MBykwb4MMOVEAJn4Y6l41t0
        NntiyHirBxfpCReOoqPRM014f9ovQuTgSiIbsTkGUHeHEaU=
X-Google-Smtp-Source: ABdhPJzC6M5m72vSKXA2IhJ5e8O7fla/erUCzPWS5NyyQmhxjmmlf0MHjhEspnLduJfvw4foauBn3K+bHLvjQHKthrg=
X-Received: by 2002:a05:6402:176c:: with SMTP id da12mr9250328edb.28.1602165002282;
 Thu, 08 Oct 2020 06:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
In-Reply-To: <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 8 Oct 2020 09:49:51 -0400
Message-ID: <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > Hi folks,
> >
> > From some linux kernel module, is it possible to query and find out
> > whether or not selinux is currently enabled or not?
> >
> > Thank you.
>
> [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> that the LSM list]
>
> In general most parts of the kernel shouldn't need to worry about what
> LSMs are active and/or enabled; the simply interact with the LSM(s)
> via the interfaces defined in include/linux/security.h (there are some
> helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> bit more on what you are trying to accomplish?

Hi Paul,

Thank you for the response. What I'm trying to accomplish is the
following. Within a file system (NFS), typically any queries for
security labels are triggered by the SElinux (or I guess an LSM in
general) (thru the xattr_handler hooks). However, when the VFS is
calling to get directory entries NFS will always get the labels
(baring server not supporting it). However this is useless and affects
performance (ie., this makes servers do extra work  and adds to the
network traffic) when selinux is disabled. It would be useful if NFS
can check if there is anything that requires those labels, if SElinux
is enabled or disabled.

Thank you.

> P.S. Go Blue :)

Go Blue! :)

>
> --
> paul moore
> www.paul-moore.com
