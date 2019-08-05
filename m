Return-Path: <SRS0=PMFh=WB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BF1C433FF
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2936920C01
	for <selinux@archiver.kernel.org>; Mon,  5 Aug 2019 20:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="n4XENoxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfHEUzF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:55:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45710 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbfHEUzF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 5 Aug 2019 16:55:05 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so20359993lfm.12
        for <selinux@vger.kernel.org>; Mon, 05 Aug 2019 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2j3t8NO+BZnfM1IyywkrEt6BjmlYLRaG2vu5DUYBsyM=;
        b=n4XENoxQfW/zzboIDep4L2KXmJ2b631xQX1bJbccKVN3V4EkNpUTULF0D1rYlqnVew
         KzBj1vg1uX6MrZIfNoCetQkux+RYF5tV6dujX7wAY3DAeboH4ZMKrUD+K2Uk6NnJzg0L
         /N/1HGHbmQpE/1i4IOumtkcnAuE8krT/fTamkm2dhuF/5u78a8WcGPkLssrrBo5rJ4d1
         L2/59Ih/+AthiUiqMMunPNhsanoiuqUz4urc6HV6I88rQnwjjNjfSct0z0KpRWE3QMnp
         35ngbPxPRTONPa/dfY1cqClhGPj2xl+hvrrDaggk483VZ5sqXSfvNtTamMlofwxG7jtc
         LLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2j3t8NO+BZnfM1IyywkrEt6BjmlYLRaG2vu5DUYBsyM=;
        b=gNyvn1PF8Wt24ehWQEaF8agrdmKFLVulh9ZK/77IqszdfLx+rwEojvIx0asGEiS7jj
         +dRqYKio9opoNCuMeYGGSYZxDrJ1GUOsbx/5s34FGfKULR7NyOJxQO1gEt/dA/95kw+l
         VBXTgZDgpajaTOdvB+fKrI/wZKmrD9LUHpvodWJKm/8r8YVOu68O34vOGya/igRP59fM
         yxgLOOthC55gI5GfRjBPS1PMyC6dOybCuJh11+sPuVdQg2eE6O39WKMhCpRM/BnVIpGd
         uOEPThbXVSwzcra5LTGLFzNlWe4+inBg00l5Kw0TChBTuH+zdyP3tDV9//4oW/niFZNV
         wIYw==
X-Gm-Message-State: APjAAAUcMCZsrocIIZFb67ZP+yalqwBTn2Zwr8gr8DbMJdb/yoMok+DB
        JTLe+nHIXroVE8SsE3Loodwhmo9HdCjmNZaVihqE
X-Google-Smtp-Source: APXvYqxWMIvrxke8FAzfq1ENQqhOwnwTeHvQeTkc2XFEwF1O4RTNuOLmY9W8h+HL4hVO0QQUhpNg+DGNTEFKFGsWzVw=
X-Received: by 2002:ac2:4c37:: with SMTP id u23mr58033241lfq.119.1565038503207;
 Mon, 05 Aug 2019 13:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <156469650636.3483.8884306975486053452.stgit@chester>
In-Reply-To: <156469650636.3483.8884306975486053452.stgit@chester>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 5 Aug 2019 16:54:52 -0400
Message-ID: <CAHC9VhTEcjEqxFkKy+cH0cC6186-pN8FKSh8Ds1NhroRrc8qxw@mail.gmail.com>
Subject: Re: [PATCH] selinux: always return a secid from the network caches if
 we find one
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 1, 2019 at 5:55 PM Paul Moore <paul@paul-moore.com> wrote:
>
> Previously if we couldn't find an entry in the cache and we failed to
> allocate memory for a new cache entry we would fail the network object
> label lookup; this is obviously not ideal.  This patch fixes this so
> that we return the object label even if we can't cache the object at
> this point in time due to memory pressure.
>
> The GitHub issue tracker is below:
>  * https://github.com/SELinuxProject/selinux-kernel/issues/3
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/netif.c   |   31 +++++++++++++------------------
>  security/selinux/netnode.c |   30 ++++++++++++++----------------
>  security/selinux/netport.c |   24 +++++++++++-------------
>  3 files changed, 38 insertions(+), 47 deletions(-)

No objections here either so I'm going to merge this into selinux/next.

-- 
paul moore
www.paul-moore.com
