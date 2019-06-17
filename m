Return-Path: <SRS0=LfCf=UQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A4FC31E5B
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 22:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FE220673
	for <selinux@archiver.kernel.org>; Mon, 17 Jun 2019 22:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yuWRKTDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfFQWBv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:01:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43887 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfFQWBv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jun 2019 18:01:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so10865969ljv.10
        for <selinux@vger.kernel.org>; Mon, 17 Jun 2019 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsWdsGdHcCmWS5nc++DZu7iYbolrJmLe83td+Ig9vaE=;
        b=yuWRKTDlK+XqWjq7QVlSItRs/dXUKXy1A8l3JjvZDzMpjItd4K3XndJGD4EYZk89dH
         ftrGFYjxe/x+W0J4EENOQisBCGxAwZ74knvZTRRAdc95RzUE9ZqN7rle2lcHExq1+7+d
         KNKVUjO1/Tq7NCsuoyRpvvkXWShHtHahsZfcDYzKLOg/fIryjzvvFvVDPfhLU3/5KH1y
         5XpSd5sD9vfVqdAAPfRO+haO4Iyy2q/gOCkrVTjDr6Dwp+wLbDg3Ed7Ml30TrT1443Pg
         n+L8c/D2Ni7oRRnHXfPjEJBiwUCTC5tLd2F6dwMPu0LhLviEmx1CX74t2z/9l/sAASI7
         WMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsWdsGdHcCmWS5nc++DZu7iYbolrJmLe83td+Ig9vaE=;
        b=dH1Q1ap/s5s+GGcaEMwmnYoFeuDjYjSo5K6hYmXJg/DDSP9hgHg3DPH2Pt/BCS8Bsw
         kM9JQNUrjx6foWP1WeaqlRWZaVvimFYmCy8WMHEiE7JGsuif4nX0TpZF5LMWsMVYZBk1
         1l/hFBFjFzo97yNV89UQPLJh+7P7xvn9tADvEoZmAhY9+TpFs9WECp0KnpAUyzNyE4Q0
         UvQpwI6MCbVkLjy8RDOgJU8n6u23YfyhJzo09rzZuHFNGBxdMs3DDb9uIjTFkRI86ss4
         Ki4y7qPHqZFJmvNSxhCiAPsfKz7OG/YNIIIbPPaC3wPf5cC1EgzrtlXD/199Ajmy62dL
         x6bA==
X-Gm-Message-State: APjAAAUNMOICLM+SSb7/RIwVeC4wJuF4pM6fLplYeVhmLORgb0nJj1cs
        aZv8YcsENBBOJF6VgYORE4kxDbNG07DIXAMaD62F
X-Google-Smtp-Source: APXvYqxO80PFS2J7nH7z2/60Uxxt+c0vds1wc/30QCv3aD8rM/v8/T8bRZyfd3RubIYEKJbFyWNOStsHG2Y6SBEYbYI=
X-Received: by 2002:a2e:9dc1:: with SMTP id x1mr617238ljj.0.1560808909485;
 Mon, 17 Jun 2019 15:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
In-Reply-To: <53af233d05da5e07d75d122878387288a10276df.1560447640.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jun 2019 18:01:38 -0400
Message-ID: <CAHC9VhQ5xgV2hnegThALdCP8KcqTLZsf2w6h2aT1WnH=-AdtEA@mail.gmail.com>
Subject: Re: [PATCH ghak57 V1] selinux: format all invalid context as untrusted
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacec <omosnace@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 13, 2019 at 2:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> All instances of one field type should be encoded in the same way.
> Since some invalid_context fields can contain untrusted strings, encode
> all instances of this field the same way.
>
> Please see github issue
> https://github.com/linux-audit/audit-kernel/issues/57

It would be good to see a list of all the places we are using the
"invalid_context" field and some discussion about if those labels are
really "trusted" or "untrusted".  In both the
compute_sid_handle_invalid_context() and security_sid_mls_copy() cases
below it would appear that the labels can be considered "trusted",
even if they are invalid.  I understand your concern about logging
consistency with the "invalid_context" field, but without some further
discussion it is hard to accept this patch as-is.

-- 
paul moore
www.paul-moore.com
