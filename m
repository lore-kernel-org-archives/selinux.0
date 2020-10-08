Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72986C433E7
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 20:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FA12223F
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 20:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="ULPhNMFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgJHU41 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgJHU41 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 16:56:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8AC0613D2;
        Thu,  8 Oct 2020 13:56:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t20so914351edr.11;
        Thu, 08 Oct 2020 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cy3duE5suiqgSSilZ7NyjIBZxufYXYqTkUAMBDABkCs=;
        b=ULPhNMFpWiallX67+ULEw6UZMjE71klcUhxss8B8UXKdf7EiDFzD2WoyVWzptimNgJ
         +pW84xPYimYp582JYLpkcAStT1k0nH7jc6l2RAVbfni31jE2SJl+U2AdPbKOvSVSC0gS
         wuRqngJWGMnUE7qLfPy8Chl2BABKTNEqPzbWW0AL+8gPvOCvlPuXaLkdK15Y0A95eHf2
         V6hHJePc71o0o+HXp/akONsoo7Cbvaz9Onztv8Qva5Zx9Z/rf7dQxZTg7qQO+0LnIAoT
         rQi6S0++O/yavno/931momPiuFbR5r90y8jCYDhfBMiAoniATeZNVoUcAX9kForY7GPd
         eywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cy3duE5suiqgSSilZ7NyjIBZxufYXYqTkUAMBDABkCs=;
        b=c+fVSqRV3HtTfMO0hR+rEUyIUSqTWNjmHLh9A1J4RSY0iv6lrHxtdlzPMHFs2ven+B
         spjbZdaCUhU34NiH3km6WGMoTWGa0aN5G4clAf2TWOxIVCriLl5yw3+oIPj64Otd68kU
         8KVfAkOCEEwwtvto22PUNPtu2sffYVXcyhAzZ223b+yjLM0Wd26unFkv0vzJ8dmuObCF
         PB8cSaEG4wzBCoqKjQO1JZD1L0zpiIv6gp8WPZS55NL3d2TCkGRnOQQHSkwRtbb53Mro
         9i58OTgTS+Q/1lLWiJmlHzPfd8PGWc3EawK55FkiQjhenPSZwB1qqIfZGgakizyX8x1K
         WKrg==
X-Gm-Message-State: AOAM532c5VvEH9eKIrzEOOI9D2Mw3LX4LmMHvmgG2CvvDvN8qlv+4diU
        9VYI70Au2N6hxJXrv3aaVH8B+pVHbmexwTHHO5g=
X-Google-Smtp-Source: ABdhPJy37rk689QmF1RfjAC/voB6wZjIP9kAT956GxA9ue461jrK60gI3YxZV+4M2Ga4lkwrUYCYpKkoZ+bchz233Eg=
X-Received: by 2002:aa7:d689:: with SMTP id d9mr11433991edr.128.1602190585698;
 Thu, 08 Oct 2020 13:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAFqZXNsG+B7OdmQimwNNVYCJM_Dc3jpNUFUpraoCEaicaoi+kQ@mail.gmail.com>
 <CAN-5tyE2ri+SWTQZfZQoV=U__UdMRgB5MR5ma0yQM4Yy03oEZw@mail.gmail.com> <d0dfede2-0e8d-25ae-0f20-58da4f4bc08b@schaufler-ca.com>
In-Reply-To: <d0dfede2-0e8d-25ae-0f20-58da4f4bc08b@schaufler-ca.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 8 Oct 2020 16:56:14 -0400
Message-ID: <CAN-5tyGA34529m5GNEE7xt1ys2vbUuQHn=N12kmtYzhTi-Rcyg@mail.gmail.com>
Subject: Re: selinux: how to query if selinux is enabled
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 8, 2020 at 2:44 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 10/8/2020 8:15 AM, Olga Kornievskaia wrote:
> > On Thu, Oct 8, 2020 at 10:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> On Thu, Oct 8, 2020 at 3:50 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >>> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
> >>>> On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
> >>>>> Hi folks,
> >>>>>
> >>>>> From some linux kernel module, is it possible to query and find out
> >>>>> whether or not selinux is currently enabled or not?
> >>>>>
> >>>>> Thank you.
> >>>> [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
> >>>> that the LSM list]
> >>>>
> >>>> In general most parts of the kernel shouldn't need to worry about what
> >>>> LSMs are active and/or enabled; the simply interact with the LSM(s)
> >>>> via the interfaces defined in include/linux/security.h (there are some
> >>>> helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
> >>>> bit more on what you are trying to accomplish?
> >>> Hi Paul,
> >>>
> >>> Thank you for the response. What I'm trying to accomplish is the
> >>> following. Within a file system (NFS), typically any queries for
> >>> security labels are triggered by the SElinux (or I guess an LSM in
> >>> general) (thru the xattr_handler hooks). However, when the VFS is
> >>> calling to get directory entries NFS will always get the labels
> >>> (baring server not supporting it). However this is useless and affects
> >>> performance (ie., this makes servers do extra work  and adds to the
> >>> network traffic) when selinux is disabled. It would be useful if NFS
> >>> can check if there is anything that requires those labels, if SElinux
> >>> is enabled or disabled.
> >> Isn't this already accomplished by the security_ismaclabel() checks
> >> that NFS is already doing?
> > No it is not (for the readdir). Yes security_ismaclabel() is used
> > during the calls triggers thru the xattr_handle when a security_label
> > is queried on a specific file system object (inode).
> >
> > This is done thru the xattr_handler interface which supplies things
> > like a "key" (which I'm not exactly sure that is but LSM(selinux)
> > uses). The only thing that we have in VFS readdir call is a
> > dentry(inode). (inode)->i_security isn't NULL (I already checked as I
> > was hoping that would be null when selinux is disabled). So I need
> > something else to check to see if selinux/LSM is active.
>
> The NFS labeling is supposed to work for any security module, not
> just SELinux. security_ismaclabel() should be the interface you need
> to use. Checking inode->i_security would NOT give you a definitive
> answer, as a security module may very well have an inode attribute
> that is not related to Mandatory Access Control (MAC).

Can you suggest what should be passed into security_ismaclabel()?
Typically this is driven by a call into the kernel module that
registered an xattr_handler and LSM passes into it an attribute name
to use to lookup (basically what is passed into the xatrr_handler for
key/name is passed to security_ismaclabel()). VFS readdir doesn't have
anything like that.
