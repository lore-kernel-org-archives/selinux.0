Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA254C33CAA
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1B21569
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 22:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rtypvF0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWWK4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:10:56 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:36325 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWWK4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 17:10:56 -0500
Received: by mail-lj1-f171.google.com with SMTP id r19so98797ljg.3
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 14:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=v6d7GiUA+n6AAdiFTa9bQuLte3l7XMlcwgXw/7oAey4=;
        b=rtypvF0VFM+X4y9KAs91/wPvm5GUJPmVVEOg2CBEoiordHOk1RypWngX0aOrLThtm4
         ahJHZn/OFlpPSA5/MFpbbsAkyQ0EZGC+N4K0KD+pC2emW9z+bUjAShzXFizplbSGM7Gf
         vQ+ls81si94N1ieX5HmMfVQ+nweJdgtFpqKzSWuIOExijAB1wm40VvUdcLuCvSUhsAQ4
         l7R0Pq1qDTnwCW/Z7NVmIMfMu76F3V2W7a35gIR4VK3HopdMyJw8C6UEQL9uhHYe10/R
         KOpZjZhq0wTJ/FR9lOxX1cEL4h2SwTjWl4W0ExfDURcxbW2XilAPQgtlOltqxixxQK5D
         hnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=v6d7GiUA+n6AAdiFTa9bQuLte3l7XMlcwgXw/7oAey4=;
        b=JmAFIH1Ivjid8KzJu+U61sarpIWrNfAPDQPq2xkngFTfd04HwYWIrDJ6pH1/5IRHKn
         qcREK5BLoic7TYewQbDUDk0+8Qgs7LgUnhBM/bEx3WFqvAP1K6ie+ZGDq0SXUPu+77jK
         G3I8Dk6/xA5PhDG2yecnMkH2Dwwuk3bJ/jclbnXmOXKwA+0cPXPqNkSGL+EZZi5DMgIA
         ATbrehXzXRk8+bAAWYca84Xw4Edr6q59Q63cqzN5eQXrj5/gd37km7N6I2dLMxgiJ4PI
         nLJPnHM/HSS+bEV69nEzDbKpBJad8xBrgipindwNd2AY6nmfFPYqWvw61PxDcGBUqSCZ
         bO1w==
X-Gm-Message-State: APjAAAVV9Byh3Jf5qMZJoMZcZOONNUEPxmVxRHXUkmHp52sQb+qIB+DS
        3SJ9ojJF21e9qWnDZWmfl8eYasUm3FQ8yv/c2jaOaC4=
X-Google-Smtp-Source: APXvYqyuJyx5NvoNt4M0CSEzCTALW8cdISHHM1PS8aDMgix9y0nqwFO+oU5AGsXBvYg4KA0I5Gf8AyWow4hDpXHKqpQ=
X-Received: by 2002:a2e:8e85:: with SMTP id z5mr334350ljk.212.1579817453585;
 Thu, 23 Jan 2020 14:10:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhR=SFfWz6OC72fBw=Y9+6LpkZg-ZY=2iZzF-0-QLAedhA@mail.gmail.com>
In-Reply-To: <CAHC9VhR=SFfWz6OC72fBw=Y9+6LpkZg-ZY=2iZzF-0-QLAedhA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 23 Jan 2020 17:10:42 -0500
Message-ID: <CAHC9VhS3D+nr=Fsnn06m8ts=aVxSPRPbPQ=ce8NWnOnf-0eG9Q@mail.gmail.com>
Subject: Re: Problems with the selinux-testsuite and GCC v10?
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 23, 2020 at 5:08 PM Paul Moore <paul@paul-moore.com> wrote:
> Is anyone else seeing the failure below?  I haven't dug into it too
> much, but I believe it happened when my test system was updated to GCC
> v10 (Fedora Rawhide).

Aaaaand nevermind.  It appears to be a legitimate problem with the
test suite, expect a patch shortly.

-- 
paul moore
www.paul-moore.com
