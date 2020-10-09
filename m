Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D639EC433DF
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 11:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B2522268
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="rsm45zT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbgJILte (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732520AbgJILtd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Oct 2020 07:49:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6EC0613D2;
        Fri,  9 Oct 2020 04:49:33 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so12652010ejb.3;
        Fri, 09 Oct 2020 04:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pT8vQashcbJSEQIERb420Ltn8jcbZ9+zc3sDEilK40=;
        b=rsm45zT2E4nAZ0tunm4wqkaPwDISBch1FKQvZgOt9lSh5Rgp76SfZG4iLGiUC9mdIk
         aUeV1oj1jrcBvC7yNKxrATvQ5XbSpWjqXcJWGBc4kGBA3TTWQGO8wx39R45bJqzvcZoy
         pD/S6VHPOzx/p82JtxmiaHpIgNFp+X1J8cPljnsrTOQdAfJ8uMN0ZPf5X3f6vZxGu1i/
         +/wZ78ySkh5Vl3SF7zeFNSS+J/vAnuJMI8joywot8U9oehLx/s+lUfJgfN7VTzG79T45
         nTAMuNVe6MHAPPTpXU/e5wGX2M05K7ZqnpmK3qGQh3FF540s0vvmvjjqkdwRUq3Njg5e
         f96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pT8vQashcbJSEQIERb420Ltn8jcbZ9+zc3sDEilK40=;
        b=JJ9itY69Q8Nycqlu5dME3obHbVPFLS5GFOX/24n4JlO190ybRaGKvz7rDmdqNCcx69
         Nq5zlP+5mMGYsdqBxejGMeomrkhYQAgn5X17BP4RETumQpWuL2obIyxz5L3XSnJ9uK1C
         DCZ0AwCHFMkqs9dA98FdXpTpUJICpT84WAhYW4Rn7GNH5rqgzL75U4PPQvMxw+MTc53l
         WPD6PFC5UaqgFs/wNE+cxdm7JvLim5M8T9a4J5jgl8ihtcOk6e1twedndhA8nNmkl3s9
         WJ4GeQD0ohL6/r8Vgk932ZLfvKZIzLw2cd9O21ouITlD7H7qQ8CI30AGS16yzHRMBKIi
         bhsg==
X-Gm-Message-State: AOAM5313vTw7lWOAPeWn64A15u8lNVbpeOAaW2uj2xcqTs9HvUTMo9u0
        F9YH+C7PEKOfE1Z7q/sv8ZVSN9Hh4hVOywoHo0s=
X-Google-Smtp-Source: ABdhPJwA4yTGf1UKUCfiRzsWMruM2d5SWZcLas+ZWR6jJZ/9DKKq8qvE7hPeiJg84hV67aHxlES4xjOBYTWQyn9ERSw=
X-Received: by 2002:a17:906:c015:: with SMTP id e21mr13533313ejz.432.1602244172064;
 Fri, 09 Oct 2020 04:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com> <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTzO1z6NmYz6cOLg5OvJiyQXdH_VmLh4=+h1MrGXx36JQ@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 9 Oct 2020 07:49:21 -0400
Message-ID: <CAN-5tyGJxUZb5QdJ=fh+L-6rc2B-MhQbDcDkTZNAZAAJm9Q8YQ@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Chuck Lever <chucklever@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 8, 2020 at 9:03 PM Paul Moore <paul@paul-moore.com> wrote:
>
> ->On Thu, Oct 8, 2020 at 9:50 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> > On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> > > > Hi folks,
> > > >
> > > > From some linux kernel module, is it possible to query and find out
> > > > whether or not selinux is currently enabled or not?
> > > >
> > > > Thank you.
> > >
> > > [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> > > that the LSM list]
> > >
> > > In general most parts of the kernel shouldn't need to worry about what
> > > LSMs are active and/or enabled; the simply interact with the LSM(s)
> > > via the interfaces defined in include/linux/security.h (there are some
> > > helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> > > bit more on what you are trying to accomplish?
> >
> > Hi Paul,
> >
> > Thank you for the response. What I'm trying to accomplish is the
> > following. Within a file system (NFS), typically any queries for
> > security labels are triggered by the SElinux (or I guess an LSM in
> > general) (thru the xattr_handler hooks). However, when the VFS is
> > calling to get directory entries NFS will always get the labels
> > (baring server not supporting it). However this is useless and affects
> > performance (ie., this makes servers do extra work  and adds to the
> > network traffic) when selinux is disabled. It would be useful if NFS
> > can check if there is anything that requires those labels, if SElinux
> > is enabled or disabled.
>
> [Adding Chuck Lever to the CC line as I believe he has the most recent
> LSM experience from the NFS side - sorry Chuck :)]
>
> I'll need to ask your patience on this as I am far from a NFS expert.
>
> Looking through the NFS readdir/getdents code this evening, I was
> wondering if the solution in the readdir case is to simply tell the
> server you are not interested in the security label by masking out
> FATTR4_WORD2_SECURITY_LABEL in the nfs4_readdir_arg->bitmask in
> _nfs4_proc_readdir()?  Of course this assumes that the security label
> genuinely isn't needed in this case (and not requesting it doesn't
> bypass access controls or break something on the server side), and we
> don't screw up some NFS client side cache by *not* fetching the
> security label attribute.
>
> Is this remotely close to workable, or am I missing something fundamental?
>

No this is not going to work, as NFS requires labels when labels are
indeed needed by the LSM. What I'm looking for is an optimization.
What we have is functionality correct but performance might suffer for
the standard case of NFSv4.2 seclabel enabled server and clients that
don't care about seclabels.


> --
> paul moore
> www.paul-moore.com
