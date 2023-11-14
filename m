Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAE6C4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 06:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjKNGXP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 01:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNGXO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 01:23:14 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574E1BF
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 22:23:09 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-da041ffef81so5792921276.0
        for <selinux@vger.kernel.org>; Mon, 13 Nov 2023 22:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699942988; x=1700547788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LA3bLOVOCt3JsWrjnHBPhqNexHhp5WmYyZrkIx2FGI=;
        b=VSAFGe0u25SB/eV/T0cDvbXS95ggBTm2ssh+gUbfC0yoMnLtdSTHlNexA/WBkQvRqj
         s0Q38bb60YkDQ5qCxXGQEhSgY0M98QvCM2oP3iHWX3ru9ie7PeQib7mPgvLNVaJlzE4J
         572bt+4on9Evh1R5jN1ZEjEVrvOW/kmoIZ8puXdDmeXDeLBaTJWfVbUnFrbDdwga1M8w
         6BQvxxeYIC/7QT/DqSUbjIbofW/Afiqp4vbmoUqv4CzVhyiRWIoMQ/9yXorcBdrtQ/dp
         IVpdnKgLi6t/tkbVOE2q5jgnOFuGYiCq4XOgeqHU14v6/fW+GwkZnzOx9z3LpvdMN35Y
         GG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699942988; x=1700547788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LA3bLOVOCt3JsWrjnHBPhqNexHhp5WmYyZrkIx2FGI=;
        b=qylPfhBjlyFNBIFd8XtdxRhHwWFQt+dcjCjVEZnQ4xdTqJ36Xt0jGr91m1YBytyIt7
         V+CqzbTzYrOFUd+XjqdiMjuIty0dsuC9E/5izIzMxNbx4Zqv7uzr1hRGOQTEpHo19pdA
         kN6BHdGxBs1ompGWH2CzGJHGmWmQhtdd+QHCB+CIJKYOK4crRYhVxN6ohYyesVfmDkPY
         xqWNIdEo6TpHXp2JTljTs7haiWV0s0JlTFTxzraU+mlfBnMzvvr5Ojj5ukLs1xWlsspY
         3eOT6zLoCQB4FfiVHIMhV7+d320ixSqWUkaYXwfIP66SdXZxak5Y6B6ezNtYXaA+A0O6
         jq+A==
X-Gm-Message-State: AOJu0Yzkfj+PNhfoVUEm17js7E56QHgFMQ0hG2Ms8KepbYpkS35JEKzJ
        R+382vq1qZ7bIltndB9fRZkg3PTRceiwJeXVOlZ3
X-Google-Smtp-Source: AGHT+IGAUvn6hX1soZcVAOsjFObZwFiNP8EgtFr+qtBnFMeqkbUoi0lss9ae2IUzbXRqSqDqKCxJC0npCgwSB2XBsO8=
X-Received: by 2002:a25:db90:0:b0:d7f:1749:9e59 with SMTP id
 g138-20020a25db90000000b00d7f17499e59mr9080141ybf.11.1699942988399; Mon, 13
 Nov 2023 22:23:08 -0800 (PST)
MIME-Version: 1.0
References: <da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com>
 <CAHC9VhSfTDoPee5_qXyh0QpjeMSsx5RmWOQgmk1NGC87kn0nsg@mail.gmail.com> <CAEjxPJ7xw=qN9n6qH3=b1a1khisUVVL79pt9tpi319ZViL57mQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7xw=qN9n6qH3=b1a1khisUVVL79pt9tpi319ZViL57mQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Nov 2023 01:22:57 -0500
Message-ID: <CAHC9VhTBDQuEfnt3s8V+U_J3WTsYKfztcK9FnUVQvxxor=YMBQ@mail.gmail.com>
Subject: Re: Proposed feature: fine-grained file descriptors in SELinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        SElinux mailing list <selinux@vger.kernel.org>,
        brauner@kernel.org, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 13, 2023 at 10:35=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> All that said, I am not entirely sure how useful the current fd use
> permission is, nor how useful these finer-grained checks will be.
> Fedora policy by default allows every domain to use every other
> domain's fds (controllable via domain_fd_use boolean, default is
> true). Android I think is more selective.

I think we want to be careful about judging the merits of an idea
based on how a small handful of publicly available SELinux policies
are structured.  I think as long as we can reasonably argue that a
policy could be created that would be able to make use of such an
idea, then I believe the idea is worth considering.

--=20
paul-moore.com
