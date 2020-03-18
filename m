Return-Path: <SRS0=MhFn=5D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6C4C10DCE
	for <selinux@archiver.kernel.org>; Wed, 18 Mar 2020 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C79320757
	for <selinux@archiver.kernel.org>; Wed, 18 Mar 2020 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584544302;
	bh=1MNA2h6wtq/dlobzeRGT0bdRHCTK6CaoKiK8KMOfsR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vKCFwnNR9ApaEumOZlCpez4cMbnZspsIL8Z37i9TvYgMrTAkymtoyTRTxdACm/pty
	 A5WPxK8A3MLrDEej8fow56W3TzA/Y585KSM0ln4oOTSom2Z8KyMZJf2z2xQcmD9GxS
	 WnSWywiQ4pEjec7yJ5zKydRnJPqUdRSsbyChhL/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCRPLm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:11:42 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:32940 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCRPLm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Mar 2020 11:11:42 -0400
Received: by mail-qt1-f175.google.com with SMTP id d22so20984443qtn.0
        for <selinux@vger.kernel.org>; Wed, 18 Mar 2020 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBYW0UwDlFqu6Mtk8zs15gpSjZXGrnPCv8HSY8PeaT0=;
        b=VGb3LVLiXwJHppvy1PJ5viaUtQq+yRxv0xYQMYLhA7NJiDYj6YNREKhCHK+rDPsb6S
         xqnGaPocCFPRQPCXu4a/vi0jJzORmLz+vF8+QfE0QrY/SHWabn9E/bd6Snd/iedJ6g8j
         3ndGB0tkKe5GbiCxjKZhV95jk9OfUH9cIEad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cBYW0UwDlFqu6Mtk8zs15gpSjZXGrnPCv8HSY8PeaT0=;
        b=eAIHegkUqV+geo6/7zU72IeWZHLviUDdmP4Evc0sldYN04fR1pwZ1QyPxo8VfVOKUk
         wlu3XFXwxhMpiklnzEIbSYLyGDfAs9infgarJv0FqrKWVPPQnSfYqLSzXsuSOvnA8PPN
         5LNmfUDatWcnHofnTCQVtiT5TWq1IifEeRSqz/lO9HpVbqWhqKvrsH6XaTW45XbMhU/8
         W+yI6Vyo4IPbQIKW4LKvcyb3/pQ8qXMkSJM0hPLj+2cWzan6IQT9n6VYdLsYZnIAddhC
         bZ3DrmUpEb3mhwoYR15Cxhij8A33VGsFLAwoYBip48m6Ar5c4+WNP9pTzMt1z87imQFJ
         3y4Q==
X-Gm-Message-State: ANhLgQ3rjoptEIYVw6//fk8lLTCXbP2R22GsHvHbqiLKHDI+99FcnEpM
        Ls9Swocepi+MH0Aifw6bFwnp9+ynGTDcBg==
X-Google-Smtp-Source: ADFU+vvUA72DBxyNp4q1pMyzL84thCC7GSkB4NfFgcsfz3Whg9bCEaA9sHL3dUFzLZZ257AFmZgX8g==
X-Received: by 2002:ac8:6f58:: with SMTP id n24mr4820237qtv.63.1584544299759;
        Wed, 18 Mar 2020 08:11:39 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id k66sm4275984qke.10.2020.03.18.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 08:11:38 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:11:36 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-audit@redhat.com
Subject: Re: Looking for help testing patch attestation
Message-ID: <20200318151136.kfjf6sdkjikptuwj@chatter.i7.local>
Mail-Followup-To: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-audit@redhat.com
References: <20200317221237.vrkru2kdc63zq3vi@chatter.i7.local>
 <CAHC9VhTF8MH7UodKLGmAmMNzUeh-68W92pivnBgJfGhWV5F7HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhTF8MH7UodKLGmAmMNzUeh-68W92pivnBgJfGhWV5F7HQ@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 17, 2020 at 06:51:38PM -0400, Paul Moore wrote:
> You might want to extend this test to the LSM list as well.  I'm
> refraining from CC'ing them on this email because I don't want to
> spoil your beta test rollout, but I think it would be a good thing to
> do.

I'll do that, thanks! I'll also loop in kernel-hardening folks.

> Speaking as the person who merges patches for both the SELinux and
> audit kernel subsystems, I look at every patch I merge; I don't
> blindly merge patches (even from certain "trusted" individuals).
> Simply put, I've always considered that to be part of the job.  While
> the patch attestation could provide some assurance about who created
> the patch (assuming a reasonable web-of-trust), and that it hadn't
> been tampered with, I feel it is more important to review correctness
> than it is to guarantee provenance.  If you ever develop a tool which
> can help with the correctness part, I'll gladly jump to the front of
> the line to test that one! ;)

Yes I understand -- I view this as an auxiliary feature that helps 
maintainers in their duties, but certainly doesn't aim to replace due 
diligence. I am most worried about the following scenario:

1. a maintainer receives a long series of patches that arrives into 
   their inbox
2. they carefully review the patches and decide to merge them
3. they use "b4 am" to grab that patch series from lore.kernel.org
4. however, the archive has been manipulated and returns patches 
   containing malicious edits, which get merged because the maintainer 
   assumes that what "b4 am" returns is the same as what they reviewed

Cryptographic attestations helps hedge against this scenario by removing 
any implicit trust from the centralized system like lore.kernel.org (or 
patchwork.kernel.org, for that matter).

> Having said that, I'm happy to see work going into tools like this,
> and at some point I'll look into adding it into my workflow for an
> extra level of safety (although I'm on the fence about making it
> mandatory for submissions).  Sorry to disappoint, but I'm probably not
> the best test monkey right now.

All good, this is why I'm casting the net wide looking for initial 
adopters. :)

Best regards,
Konstantin
