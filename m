Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69752C3F68F
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F76214D8
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 15:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wWgjANu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLJPEd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:04:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41968 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfLJPEd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 10:04:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so20254594ljc.8
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2019 07:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9+cmgh3HD9S9uE5wFEyd4vZmkhZKezQ302IokUVvco=;
        b=wWgjANu7C4oXSmWGg8mliBfvY2FMGGUjAJRpYoJUqn4dbtUMFiNRDP80+rGfIj2VsZ
         5J/RfsHQF9L/HhFyC5vo4yiTHcAm4qbvmzXrOAXhImbwYWQpfRXwr2LBlfCatKAlOh8K
         SeiFAXFiijLChT0sU0ScWaCU95ulzRn5oWanV/AWJozIvUrHaC+xUvALB5TzbzxMJQkp
         cX4HV1T/hspYkgr3EImHiCcVCvYQl2pdR8S5cIjr/tclL6KKPeAycfNYxBsCXkVEVt5W
         zAQtxqZr2GFubFL8Urks/8LY/qGh8+RXjLe1SGPahci+Tffy1r41AdEYHU0NkcNtBqNo
         iMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9+cmgh3HD9S9uE5wFEyd4vZmkhZKezQ302IokUVvco=;
        b=Y1gPcEzD4RRNdaN8Pp0dDNyUc5rvar41xPWoKfWC1XYvKhntBh0Q2nk3+DEsZMnrbl
         dNxegQgb5tAvBvw4wPjKSqeBjkRzITcxQ/coRf+1WtIZEdhW+K9tGLFIXMLEHYPZbRb1
         jL5PTcrI13rLq4m+7Lw1pbyyk0eGFglCVq4ibYZ7HR/egbFQsyd/N1tboLXjx6IDxbXU
         OCJ6WaJq102/r8bYooFUaYAn6jqaii77qlMuihlqVkIdmIGp/Kqj2C6nOMUoW8/roXiX
         1S9vuU7OG1PmsDpO9cwPqulmo3dEGmkII0F5zU5VOXFdYsgOT8bP+wLgUIiD8S/AJGwH
         v2RQ==
X-Gm-Message-State: APjAAAV7wMaPAx3JYn1yklnNYF+z08svukYmohB2lbOR8rgzS3gYIwds
        cZGC3UHLAwJzYDPXRaO3EbSoLncbJAfUdy5aI2j0
X-Google-Smtp-Source: APXvYqxtjbTFXNwQlbYDewXPeCInnPXVNOwyU657jJBi5C8UehIKEu7ltGtLXt7Q3kkw7MenHgzodqEc65jPogNZ3GE=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr3420317ljj.225.1575990271457;
 Tue, 10 Dec 2019 07:04:31 -0800 (PST)
MIME-Version: 1.0
References: <157594493094.748324.9234611948545428995.stgit@chester> <285edbb5-b08e-5bdc-f951-841fe1d77521@tycho.nsa.gov>
In-Reply-To: <285edbb5-b08e-5bdc-f951-841fe1d77521@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 10 Dec 2019 10:04:20 -0500
Message-ID: <CAHC9VhS4ksmcqBMzwQDArgd9xn_cJ+nyEBrHJcYjoiMaFzCq-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] security: add an interface to lookup the lockdown reason
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-next@vger.kernel.org, jamorris@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 10, 2019 at 9:59 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/9/19 9:28 PM, Paul Moore wrote:
> > With CONFIG_AUDIT enabled but CONFIG_SECURITY disabled we run into
> > a problem where the lockdown reason table is missing.  This patch
> > attempts to fix this by hiding the table behind a lookup function.
>
> Shouldn't lsm_audit.c be conditional on both CONFIG_AUDIT and
> CONFIG_SECURITY?  When/why would we want it built without
> CONFIG_SECURITY enabled?

My first thought of a fix was just that, but I remembered that the
capabilities code is built regardless of the CONFIG_SECURITY setting
and I thought there might be some value in allowing for lsm_audit to
be used in commoncap (although in full disclosure commoncap doesn't
currently make use of lsm_audit).

-- 
paul moore
www.paul-moore.com
