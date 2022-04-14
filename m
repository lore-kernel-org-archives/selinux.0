Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6279EC433F5
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 21:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242328AbiDNVOs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 17:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiDNVOs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 17:14:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1F2D64C6
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 14:12:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b15so7892744edn.4
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dIxD75HlRhK9dvg3Jrnvh4a24d0xEHcxhgbmK4swPAw=;
        b=CARh2eY7bMvXUi6pGeUg9MEDIPW6FDXczs6WtNAbNtbldHDMJ0lZxr2sXtaSg3iIHA
         iaG+46mnAOeJvJhahuE7uVA847Xlgb9JIXqJLZWA467lc8hLP206QmWXwaTz5pxNuOoo
         Z8f5ud454dmVGvGNKYyYAu9ox6RBLNShW31tmf2p+Yl/QrFcgWCv3jR2u+1HV7IR1ICt
         DAp1c4Bt1ognXAjmA6h3IXVB0bQt3AnRdFHdUsTzT8+9YNJpC2yJv8r2xatgT77bfS8b
         Jl9tR5QYB5twGG5HGaQ2y63zqeNlgLU5JJhkrw6uuu3flomYiDWIUs+re5xC8jWqPMf5
         KcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dIxD75HlRhK9dvg3Jrnvh4a24d0xEHcxhgbmK4swPAw=;
        b=HRXJ9dqZuAVc+L+5//9IX8aUbHrXxU2zGaFQMt17aJRO0nIh0uerm+6RiumCFSGqlD
         8w5GMCBpGaR46amn3UVNYuRBE4uHzyHBatWU/3bPI9uwzl974nzmIcXoWF97L08bUA87
         d7jtqwiy6zntljvghIaJfAUOUdi56YH71UQAALTk8O78wsc39d5rQGJP7YhFMPhfIN7p
         ggUNbjbzbB7/lmEudVGdaEF0bZSvX/P8g6bPoLDxlMzw5dCPFsjnvL2ZNAevRN0qT4K+
         z3VUK27/u8XE0HzMbLbKmqnFhnAq7HobL08VYsmpp48uNRH9g69nhK0l9DV3ghQlacn6
         vEHg==
X-Gm-Message-State: AOAM531sDasjZ4wgDhmMfERKX3eZ94LToxY/ucoMqp0ZzyVtjNbNgdLt
        u07lXqehgWZSHBU/nJXJK4wHR+lv5ofX3DTPSQto
X-Google-Smtp-Source: ABdhPJzBzR4t15eQ46EX2SAURneoKPQbFQcLpc0v/dYwgz/qHaKpPAMyeGKVDGvxQqG0stDMfw5tfgapIgZa1NhwP3g=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr5077974edc.232.1649970740322; Thu, 14
 Apr 2022 14:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220414184325.GD21485@fieldses.org> <CAHC9VhR_-Gjh0=2GPhWXEkCPcgHuK4pqxia=ZH8EDLODGe63=w@mail.gmail.com>
 <20220414205624.GF21485@fieldses.org>
In-Reply-To: <20220414205624.GF21485@fieldses.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Apr 2022 17:12:09 -0400
Message-ID: <CAHC9VhTc6ZwO0Pog1bgJq8fcdAs2w5qpWLHt8N7uPqrXYgakLw@mail.gmail.com>
Subject: Re: boot failures as of "selinux: checkreqprot is deprecated, add
 some ssleep() discomfort"
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     selinux@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 4:56 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, Apr 14, 2022 at 04:38:13PM -0400, Paul Moore wrote:
> > Jokes aside, I'm sorry that caught you out, but thanks for reporting
> > it.  I thought I tested all the combinations, but obviously I missed
> > one.  The obvious fix is to move the ssleep() call out of
> > checkreqprot_set() and into sel_write_checkreqprot(); you'll still get
> > the error message on the console, but you'll only hit the sleep when
> > toggling the flag after boot, at runtime.  It's similar to the runtime
> > disable deprecation.  I'll work up a patch as soon as I'm done with
> > this email.
>
> Sounds good.
>
> > However, a couple of quick questions: this looks like a custom/hand
> > built kernel, yes?  If so, is this an old kernel config that you just
> > keep updating via 'make oldconfig' or something similar?
>
> Yes, exactly, I've got scripts that take a known old kernel config and
> run make oldconfig.
>
> > I'm asking
> > not to critique your kernel config choice (although this particular
> > Kconfig knob *is* going away), but rather I want to make sure there
> > isn't somebody/something out there still enabling this for a large
> > user base.
>
> Got it, no, these are just systems I set up for nightly regression
> testing of the kernel's NFS client and server.

Okay, thanks, that's good to know.

Since you're already building your own kernel you should be able to
just add the patch I just posted to your pile, it should solve your
immediate problem.  I would also strongly encourage you to drop that
Kconfig tweak too.

-- 
paul-moore.com
