Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5976C43603
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 22:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A255214D8
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 22:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelim-com.20150623.gappssmtp.com header.i=@kernelim-com.20150623.gappssmtp.com header.b="nS+uGuly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLMWkE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:40:04 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:38517 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMWkD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 17:40:03 -0500
Received: by mail-wr1-f49.google.com with SMTP id y17so407809wrh.5
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2019 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jwx+eyXN2Y8vFAXh4vpEJiC3p19UQ9BZ2KLI9MNJRBU=;
        b=nS+uGulyZrhKwshR8s9cFu4d0h9AjAyOsjfHXz93UzEzZpuA0MgUCQmDtfKHQMJzvJ
         0iolK5SF/e6wM74zI6cO9zTxf+mYDlfwDR7uSbC7AvQFolWDwSYU4XGQzGp4R5t795fs
         +cKc1PNXkceJxA6ZdQnZ8BYq4j0iPBD6yW142o1btzyaEtFl8GG8J94shQjoyWlMdVP8
         Qu7MkY0Hrwgu1gOak9mIQ6xVcOFwWU7SPmqY+5wJhu3k4BMpr7Zx38n5SMQt9bHRz3pW
         Mo/2/zTt+Wrj25daTUwYuSTB4ZieIjCT98hjPW/EjFKESmxTCniSiZGOIyjtS6Ykcwmf
         Zihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwx+eyXN2Y8vFAXh4vpEJiC3p19UQ9BZ2KLI9MNJRBU=;
        b=SsySDt9cFYeBTC79wPihV0/Ky92QpmsApqJuN4cn6i+gDQ10QtFr0X7JM6fidIhQGy
         fba3xi86WZLFbaSY6et6WydnhM1MXSaL/Jb2QayemhUqpuUhOYLANf+G0tDvMx/2cryW
         1AmF+QUPWoteLs/nMtnLDTR4suaPzd3OFOV877+Kf7TJs+fxhKXgNcCVEZEgLUQXz/JT
         4n6a3ZXY1FcaH7Q/dzK4Lwe3No2hPu/2wKexo1wMu6qZAlr9GFaJKgax29biU9XmJrHE
         j4Oa/kxp9x3t6ubk4HeoShpHRxn3jfhaBuorOWZUYESb85Um54r7qIVGzbZz4uC6HLHu
         acmQ==
X-Gm-Message-State: APjAAAVMlM+7M1veZ5MOdDtvVAGMyJU6AuvOHHUtStxWH3fzczIhkwZY
        WCj1YJqsrGrDk2nG86Jg6P8scA==
X-Google-Smtp-Source: APXvYqypJHq2l4JddRKTLGQYoBaQi50H6v6ua5DoaNSxfY+QhOPQKEG0nxcB70aofzLqklDnZychjQ==
X-Received: by 2002:adf:fa0b:: with SMTP id m11mr14965242wrr.98.1576276801693;
        Fri, 13 Dec 2019 14:40:01 -0800 (PST)
Received: from gmail.com ([5.102.220.98])
        by smtp.gmail.com with ESMTPSA id j12sm11889232wrt.55.2019.12.13.14.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:40:01 -0800 (PST)
Date:   Sat, 14 Dec 2019 00:39:58 +0200
From:   Dan Aloni <dan@kernelim.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Connor Kuehl <cipkuehl@gmail.com>
Subject: Re: Does anyone use RANDSTRUCT?
Message-ID: <20191213223958.GB31026@gmail.com>
References: <bf727420-b7bd-d3e9-a597-812922ba20a3@tycho.nsa.gov>
 <201912130943.A301DBF@keescook>
 <7514d477-3a27-0d35-d611-335a103290ec@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7514d477-3a27-0d35-d611-335a103290ec@tycho.nsa.gov>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 13, 2019 at 01:36:38PM -0500, Stephen Smalley wrote:
> On 12/13/19 1:05 PM, Kees Cook wrote:
> > On Fri, Dec 13, 2019 at 10:40:54AM -0500, Stephen Smalley wrote:
> > > See $(subject). If yes, there are some obvious candidates among the SELinux
> > > data structures for randomized layouts to avoid fixed locations for
> > > enforcing, initialized, etc.  If not, then no point in pursuing it. Doesn't
> > > look like Fedora enables it, probably because they'd have to publish the
> > > random seeds anyway for third party kernel modules.  But maybe it would be
> > > useful for some distros/users?  ChromeOS?  Android?
> > 
> > It is used by "in-house" kernel builders who optimize for high security
> > above all other things (I've talked to a few of them over the years
> > when finding out what defenses they've wanted). I've also seen Huawai
> > Android patches that seem to indicate they're using it as well, but I
> > haven't been able to determine if any released devices are shipping with
> > it enabled. I've also had several people ask after the Clang randstruct
> > port, which is ongoing[1] by a couple people (added to CC).
> > 
> > I think it would be very handy to add some more markings to sensitive
> > data structures. Please send patches!
> 
> Do you know if there is something inhibiting usage in e.g. Pixel devices?
> Performance impact?

In Android, the use of Clang for building the kernel inhibits it, as
RANDSTRUCT support for Clang is still in development. The move to Clang
for AOSP kernels is motivated for enabling CFI [1] and other features
such as SCS [2]. AFAIK the move to Clang is already in effect for quite
awhile in the kernels running on Pixel devices.

About performance, the gcc RANDSTRUCT implementation also includes a
performance-preserving feature where randomization takes cacheline
boundary into consideration. The Clang implementation is expected to
have this as well. It's a valid concern and definitely garners testing
for anyone enabling the feature.

[1] https://source.android.com/devices/tech/debug/cfi
[2] https://source.android.com/devices/tech/debug/shadow-call-stack

-- 
Dan Aloni
