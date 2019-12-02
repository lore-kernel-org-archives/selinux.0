Return-Path: <SRS0=5g5+=ZY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D0C432C0
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 20:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C334C214AF
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HLMKnGEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfLBUEh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:04:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40223 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfLBUEh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 15:04:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so937835ljs.7
        for <selinux@vger.kernel.org>; Mon, 02 Dec 2019 12:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4a9wd3LK/WMXQxJZI+b/CD+KV3p6tmfSnKjb/oWhht0=;
        b=HLMKnGEUW1I50CjZUFs++L/3XtSbERJUSs7q1SDbofRafls4/cGo40Tcg+rqmXb815
         YMnW0sbaC0GrD4fci5jcEykZTeybN9wN18htoKxwscueQrHffsfp0qytycXK04Lz/xOj
         NYOqXcoDqSI/7VsoMORawMJulxa67lt439mQ/O+iu/EAtKasnj37jc+1C9lUPjmBDHZs
         h6gO7dtaibtE7jX+EQdQpi+jFOvgGfbR9J57IJvbzrnSAYPwkhmjvB6Xtc+8r6dU1XhX
         9BxO0iiuZ9zf+fAKtDl3uKdZadS8rQ+5g6vwz6MB+MP363jVxCDA1r66AvBzdex/Sdcc
         QcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4a9wd3LK/WMXQxJZI+b/CD+KV3p6tmfSnKjb/oWhht0=;
        b=dfQxfDMroQSBv3nPLD2dTvWsSMzAkwl9wwOu9O44KM0u9jPMiVjWs0vqCUp0oYzySs
         +N0m7MffC+jDvErtsyNPntUPf+Fycy4WiS4/3MmtRJLU8IOAZIUSG6eqz9nyaLYSVkab
         EkJWv4aUd12nZxluxItxMay3TbazcbtzVjNPwqe+6nn0muhUl0bQ3hMhxJJYx8+KjAPw
         3zYOTxIYvvJ1TSj6bUYL8qT8yT0QByd3I/lI9c/xSgK03jfno9YIz55vw4TgC9yHVcC9
         HaWPRCPqrkq/BMqSDhfH3Rg2el3eYpBrKezKdQFVlAJ+1Z52dwiXwyYM93PVNrM0Rdly
         ceiw==
X-Gm-Message-State: APjAAAUPYiKojx4tJNx3DksFQMKq6sQAgRlL50tw5Z+wSQLeIrzfbKKw
        obu7nlZGxcqfAl2bCiCkZA924eHNFShQvTZjK2ix
X-Google-Smtp-Source: APXvYqyDK/Pn/gNjm8YlA5sp2FKiD8lD+p3tLP4A6RnfpI01vux9roHpZ0OZtreCFn0pev+lOHmkJ563DiGQNxhvUm0=
X-Received: by 2002:a2e:85d5:: with SMTP id h21mr313937ljj.243.1575317074980;
 Mon, 02 Dec 2019 12:04:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRj-vx8AnP5tKcq9joNqWSHRv1bk+3e7DGU9mxjN+fVFg@mail.gmail.com>
 <1575302310.4793.379.camel@linux.ibm.com>
In-Reply-To: <1575302310.4793.379.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Dec 2019 15:04:24 -0500
Message-ID: <CAHC9VhRkosCVR+4qyf=GPKQuQoJzwjZZJ_z7rhE-qiL-TNbtPw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.5
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        initramfs <initramfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 2, 2019 at 10:58 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> [Truncated Cc list, adding Roberto and the initramfs mailing list]
>
> Hi Paul,
>
> On Tue, 2019-11-26 at 16:24 -0500, Paul Moore wrote:
>
> > - Allow file labeling before the policy is loaded.  This should ease
> > some of the burden when the policy is initially loaded (no need to
> > relabel files), but it should also help enable some new system
> > concepts which dynamically create the root filesystem in the initrd.
>
> Any chance you're planning on using Roberto's patches for including
> security xattrs in the initramfs?[1]
> [1] https://www.spinics.net/lists/linux-initramfs/msg04771.html

I'm assuming you're not asking about me personally? ;)

However, just in case, I'll probably wait until it is picked up by the
various distributions; somehow I haven't yet found the time to roll my
own distribution for personal use ;)

> Any help reviewing his patches
> would be much appreciated!

I would love to help, but given my current workload I'm not sure how
timely the review would be, I would suggest reaching out to the
distributions who maintain the userspace (and have asked for this
feature).

-- 
paul moore
www.paul-moore.com
