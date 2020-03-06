Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B3C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF912072D
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 13:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qfPVo3Dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCFNj7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:39:59 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39369 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFNj7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 08:39:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id m13so2546404edb.6
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 05:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IG3r16fkEHrLo+LwndhCs2CnyZCTrGdp0Zw4qK9eHgY=;
        b=qfPVo3DvGc4BQfOItf9Afh+7rDv7VSqKJ/O0I/7LMQn1NfrP29IAJal7bw3NunzpQP
         gQUa6uUqIOIN8ttaCrHeVKhgC5QqqchyxN9nsd6eLTIqzAPNGFRdyGoa1TVJMyQkbIIt
         YDipNL4WaDxML1XXyWmmk3aJutjsVS42PC2kdl8QSTUl/MfjdC51StIiQZ9oyRghbb49
         5leGWhLyYvmlEuIBwr7Mtq+NUfQu+zRbKQLdfYpmwt4ZUREX/+Vcn+s2LvAzZZtau2dj
         tDLCuJm1Qw/UTieAHsndsGUxb4CvqY5kUIkHgEAfxVl/ZwZZq4n96Q6t4F/vOuoJOyye
         ztxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IG3r16fkEHrLo+LwndhCs2CnyZCTrGdp0Zw4qK9eHgY=;
        b=ryhCbglEPbdt4jZLVvh1+XMK5vv4OQVpwoqAt5TVN3SVVf5COPzRxdkB1+xPJ9wbwo
         T5jW0GPsbCUIqrobQyaVq7N/Qyd61Iyp02noHjcB+VfIBZpI6/N/pcWLmQUxu/qoguLz
         pui0i4hzDVkewcFWngltA5PHPGsNKrGy4/bRxxUfQsR681q/kngT+VU07DZKMYY+IJQ9
         HwhalVPIakGQewe1LFsArUiwBeKmT52T8rHfJMNOdQy/rodF23NGT+UuwiaEwHHvCU0j
         wYPE0O+uXhFIAQheXYEmB8Lemezcn9khV+cY920XljMtyoEdkavxodX2CQEKKhQdj/3f
         9U4w==
X-Gm-Message-State: ANhLgQ2G+bME0jd0WOypSoTN74/4PEVUdt2sJZwO6kaiY0mKs4UT96K5
        6XfJeGPulrYbCeYq0j758MFBlkxRGKWbNpr2Dqj6
X-Google-Smtp-Source: ADFU+vvue0w0VEw5/x1MustiqWWGClXQvDLHLjgveDuMTpxaq8H3gm8bfchXXFJzzoEwUZ33eDjqUZPYJLmFGitzmiY=
X-Received: by 2002:a05:6402:309b:: with SMTP id de27mr3139834edb.269.1583501997217;
 Fri, 06 Mar 2020 05:39:57 -0800 (PST)
MIME-Version: 1.0
References: <158343867316.158870.5386750405980710812.stgit@chester> <CAFqZXNuy8VjV8v8O5-zr3N7zq+Tntu6WBvaTFQ-+VUUyUqOHeQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuy8VjV8v8O5-zr3N7zq+Tntu6WBvaTFQ-+VUUyUqOHeQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Mar 2020 08:39:45 -0500
Message-ID: <CAHC9VhTMx0CoDZJZa1CDgYNeb7QJLsK+gGjhS38v+WmKa=PW_A@mail.gmail.com>
Subject: Re: [PATCH] selinux: avtab_init() and cond_policydb_init() return void
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 6, 2020 at 5:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Mar 5, 2020 at 9:04 PM Paul Moore <paul@paul-moore.com> wrote:
> > The avtab_init() and cond_policydb_init() functions always return
> > zero so mark them as returning void and update the callers not to
> > check for a return value.
> >
> > Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> This was originally suggested by Stephen - you should credit him, not
> me :) I only expressed my preference to still keep the functions,
> since Stephen was considering removing them completely.

Ooops, sorry Stephen!

Fixed in my local copy, and assuming I don't hear any objections in
the next few hours I'll go ahead and merge it.  It's a pretty trivial
patch anyway.

-- 
paul moore
www.paul-moore.com
