Return-Path: <SRS0=uVUB=MY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497CDC6787C
	for <selinux@archiver.kernel.org>; Fri, 12 Oct 2018 17:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0769B2064E
	for <selinux@archiver.kernel.org>; Fri, 12 Oct 2018 17:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvdhwlPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0769B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeJMBMF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:12:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46782 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJMBMF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Oct 2018 21:12:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so10454214oia.13
        for <selinux@vger.kernel.org>; Fri, 12 Oct 2018 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5zGSoRXBsXLTU53ikLNO1YG35yqV1JEt6ogoScxmoI=;
        b=tvdhwlPVBNN55bRZUw95K9nVjkMODzVHop3ZcSk+BWYOP2jvAJ+JiPeNA7G9OWhHbH
         L+IjX7UN2NCmf2wOlKrW05BfFN42Twg91Ik/LhrKX0uqmdLilA7vl+Ufd/dvu1gC9agz
         yYcwHuOmWNLqZyJNwJyRjE/m+ayG5suxWqswU+nnE+bgNmlRqSyZjiDMK5zZ5tgcuDeA
         3otwiPPxsQp76/AJnErAb7nYtcplaDBDJjPlQU8OALmkrf02TUOpJCdQ4Lfekq/SipGn
         kh1AJ5PmwUkAk+0vWTNDoO9qa7P/ltx8UmZJF3EZaY8olA7tnLBUD8Cxo9Cipv9724R2
         qtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5zGSoRXBsXLTU53ikLNO1YG35yqV1JEt6ogoScxmoI=;
        b=RBbCl0oeHKB4u704gN0fS7dy6Ex4AHG4LbZ5pZyfBEZ/FG9iRmrXodoJmrZdxsnvMh
         AAsHyC0M7XVgQD21cUVl08SZqNV8eOFIMJbauXjG+qlo27tE426bAEzCySsz3wBrf7mm
         VyuceO/P5Crr8AnX4ClgQ3Q2harJmuVDqi1jUuRXLJ97+8k6Jw+IKwdZ+GhLCObxZYwv
         0Z5nHNlLTa/Jp+LDOspRriiDL7sF3fXLsuxAVCcb8B8iNy5CsFuzzmgQbp+IRWQfMwiH
         xdLGm9BdbZDcVRUoxI5mudv/2gMwfvwH3XPue90QTBRE8MFyExipZM7wlbWDHotoFW9/
         thqg==
X-Gm-Message-State: ABuFfoj5NEgCHaubWX2f8EXf6qjB7bjUCkjukzbCuBXtmSM7/3uO9eoU
        E1AjIIDjemFQMNcurAillzqk9Z9pgFH3ThZbP8e2bvYf
X-Google-Smtp-Source: ACcGV62FVM7h7UVe2yhSVDI0NdqSp6gRMd9O1zlmLLvY5koey1vnI0ymEnKrPlYk6ALTmJctaJOnRYUVXuvk6Agx86A=
X-Received: by 2002:aca:4ccd:: with SMTP id z196-v6mr3599413oia.318.1539365910409;
 Fri, 12 Oct 2018 10:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181011123543.14822-1-jwcart2@tycho.nsa.gov>
In-Reply-To: <20181011123543.14822-1-jwcart2@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 12 Oct 2018 10:38:18 -0700
Message-ID: <CAFftDdqZoedaBam5XUoekJDwNeEKp0=OiHXH5TUyHJ9ocPKs_w@mail.gmail.com>
Subject: Re: [PATCH 0/2] libsepol: Add ability to sort ocontexts in libsepol
 and add option to use it in checkpolicy
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 11, 2018 at 5:37 AM James Carter <jwcart2@tycho.nsa.gov> wrote:
>
> [Resending because I originally only sent these to the new list]
>
> ocontexts (initial sids, fs_use_*, genfscon, portcon, etc) are sorted by libsemanage when using policy modules and by libsepol when using CIL, but they are not sorted by checkpolicy when creating a policy from a policy.conf.
>
> Checkpolicy's behavior allows control over the ordering which determines the matching order for portcons and other ocontext rules, but there are times when that specific control is not desired.
>
> This patch set exposes an internal ocontext sorting function and adds a command line option to checkpolicy to sort ocontexts.
>
>
> James Carter (2):
>   libsepol: Create policydb_sort_ocontexts()
>   checkpolicy: Add option to sort ocontexts when creating a binary
>     policy
>
>  checkpolicy/checkpolicy.c                  | 22 +++++++++++++++++-----
>  libsepol/include/sepol/policydb/policydb.h |  2 ++
>  libsepol/src/policydb.c                    |  5 +++++
>  3 files changed, 24 insertions(+), 5 deletions(-)
>
> --
> 2.17.1
>

merged: https://github.com/SELinuxProject/selinux/pull/103
