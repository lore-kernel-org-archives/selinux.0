Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8869FC433DF
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 12:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638BF207BB
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 12:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8x8INlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHUMPY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHUMPJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 08:15:09 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8AC061385;
        Fri, 21 Aug 2020 05:15:09 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b22so1314262oic.8;
        Fri, 21 Aug 2020 05:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgDeAg08mFvRbn4SjuUaCVJq4IHVZKTa47Sz3vQfoKs=;
        b=r8x8INlmyoCzm36Urkdb25+9EjQbty79MyCXhHD4WJgt8+yVVYQmfWfgAp1UDWhSUb
         +pBbuDrG96hyTxqhc+G82AEVHgcjUujjGYtSnpTHMG9eEKZiPMhVnVHusgJO2rSfBGuG
         rx0u1eNVG0UGKF7SxsYUFmx6CD/XZKxvflGTRPCuAoWd3b+sMhJaLZxUW+FZkhQALX5j
         W69WVCxXx7DkgC8AAvw6vhgkyBpuEjrBltShJgyLqNhI83ChtmwU3G8W7PASStp7FcOK
         NU0liX9OhQEgEq+skOTTXtxtq/61gS/Kq2TXt30gcDHL81J4zRy5gO3gTl3a5+3+FEBB
         fZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgDeAg08mFvRbn4SjuUaCVJq4IHVZKTa47Sz3vQfoKs=;
        b=ZPLjrjdzWfDEr+TT5QP1NAZOI3XnlUS/ep4IMq+ohcYYV3rmAkcb4i2Nw/EZdbZhq8
         LQZSEudSqoDyaSpmXl8ZBc+O4KDfmKD+6I133WezLOtybF6pc3ESGzbL9Ap9MmGx6JlT
         BJBGCF3kyuOKM5v5K/T9MH4UpdFPTWM5c1hxmRkUZ4XduD1P+hVsBAAcn2tEUjS1I0pH
         xU+E1DwJLNPj0tpz6K0juw99FF7Cez1rvPZMy0jaSE/PGoeAzXEGPkx8gXDZAlo0TfCW
         g1NDP4jHSu18ka8YHezP0bCWcUQ+oII5KAJBqZq2F1q1arfkCkhkfmOrowtaDSpMjADy
         ubMg==
X-Gm-Message-State: AOAM530Bd9SPEwE9CT3kjz/Zikm7HZ9Aj/5D2hEIm+EWBsuoIq2vi3lX
        61AwkuBYeUjEdmM8qNNXzy3xrSYXFHZq1Zphgtc=
X-Google-Smtp-Source: ABdhPJwqYOgGah6oEeIswNAXNbOLsxR3uQsaMcOo12hqgyH94QEQAHgDjoKbOhk6XEyWk3bo7Wq+sBSj5x7TzoApk1Q=
X-Received: by 2002:a54:4817:: with SMTP id j23mr1532133oij.140.1598012108392;
 Fri, 21 Aug 2020 05:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170729.2605279-1-tweek@google.com> <20200817170729.2605279-4-tweek@google.com>
 <d8b1d7a2-2b8e-c714-77b6-d4e7f3fedf08@gmail.com> <6730ec4a-d11b-5c05-b64f-380104a86dab@sony.com>
 <CAEjxPJ7k648nQxCDzcHc0h1vEfNhAJShG5iKmD52nuO5s9phsQ@mail.gmail.com> <CAHC9VhSYJUAacvzp1hR4RMChTctJ2sFb5+oy_wbsigaWMGTYHg@mail.gmail.com>
In-Reply-To: <CAHC9VhSYJUAacvzp1hR4RMChTctJ2sFb5+oy_wbsigaWMGTYHg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 21 Aug 2020 08:14:57 -0400
Message-ID: <CAEjxPJ73t1p9K_FbDKOTRPZn-bz8p7KVOB48UzfzELsMhx5MPw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Paul Moore <paul@paul-moore.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        Nick Kralevich <nnk@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 10:22 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Aug 18, 2020 at 8:14 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Aug 18, 2020 at 4:11 AM peter enderborg <peter.enderborg@sony.com> wrote:
>
> ...
>
> > > Is there any other things we need to fix? A part 1&2 now OK?
> >
> > They looked ok to me, but Paul should review them.
>
> Patches 1 and 2 look fine to me with the small nits that Stephen
> pointed out corrected.  I'm glad to see the information in string form
> now, I think that will be a big help for people making use of this.
>
> Unfortunately, I'm a little concerned about patch 3 for the reason
> Stephen already mentioned.  While changes to the class mapping are
> infrequent, they do happen, and I'm not very excited about adding it
> to the userspace kAPI via a header.  Considering that the tracing
> tools are going to be running on the same system that is being
> inspected, perhaps the tracing tools could inspect
> /sys/fs/selinux/class at runtime to query the permission mappings?
> Stephen, is there a libselinux API which does this already?

There is a libselinux API but both it and the /sys/fs/selinux/class
tree is exposing the policy values for classes/permissions, not the
kernel-private indices.  The dynamic class/perm mapping support
introduced a layer of indirection between them.  The tracepoint is in
the avc and therefore dealing with the kernel-private values, not the
policy values.  The mapping occurs on entry/exit of the security
server functions. So there is no way for userspace to read the kernel
class/perm values.  We'd just need to keep them in sync manually.  And
one is allowed to insert new classes or permissions before existing
ones, thereby changing the values of existing ones, or even to remove
them.
