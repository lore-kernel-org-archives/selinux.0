Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815FEC3F2D1
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561E320848
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 13:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI2XQzim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCENJd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:09:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37885 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgCENJd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 08:09:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so5589921otp.4
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqySBfsw/X9Rn2lYIY5YDz+vhyJzudnyB6NQL+DBZBw=;
        b=TI2XQzimeUc5QEvkU+jefEHt7wb4gqOZttEAQye74rair1qQvBh78grAGivcxJi9WF
         8zGlsNz9CIRH5JwaqHQugbmLbqt/W/5GYwCUV0fkaNcQZ6mRPGoeEYS/S3n5Mrm15GyB
         KEFCnRPnB2D5Jp8dQvPRnoOgxeze75rM3KGEoW+h9AvBkZoSSLL5Z9a4M66uitMrQ1U9
         7SNz6KXhe4dLX0QNqf8P2Ynd10L0S5JzwRe5AC+mwtpR/R1wDroBMFL0AuwitbVrS2bC
         ec24Yr5kOuuclpJNUpEBQfuawE9Qa2a4saqfs01jllJBL7IoXGjdwabJo8QWW2PbFoRb
         LDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqySBfsw/X9Rn2lYIY5YDz+vhyJzudnyB6NQL+DBZBw=;
        b=B1dDIC0vDfawPi9jX+oyPbfLma++r5cYXayuYu65g/z1a8s+kGoB3158VzrY8k6q/B
         TBfZ8DPwmhUokasNyyzhiMuzHBlGgrl8WUK/p0MMfBO9qJqbQGVaTjZZDZw3HgBPthAU
         WED4f4yC+yyJaI5jQKk5KyBRu2l+I5FbIZAlQb2cD5/IkKxKGxfI7pwR9a5OlXdYf/fj
         vRRpwZlovhCibgyBCWf2E1i+ABm11wJmliEzkHpnt7feI80n8PL/Vg8jRIFnc3iV8X+A
         mky1Fp5Q7qjnc8o6eUUi9qbOUCW4UyC0tKXzKaQRq7ujkB5oT3F8sHjRJbGVG90+Azbt
         hBdQ==
X-Gm-Message-State: ANhLgQ1tmVICFZdcy2diaGFBSdU7emkXU0K0M1AuUFi1cM4bqpU0Tg/+
        Ei/yNQIhr8zbLfT6skUPqXmsIF/F+0KEXcFoH90=
X-Google-Smtp-Source: ADFU+vvFsrN0Jgbo9shZjde0Y4av1WENq8hX06J95TfM5pdetMrUub1P+oQQTUn+5MVXFW6TEGUBSr84WpGuI+s3cK4=
X-Received: by 2002:a9d:6e85:: with SMTP id a5mr6300804otr.89.1583413771278;
 Thu, 05 Mar 2020 05:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com> <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
 <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com>
 <CAGB+Vh69hcAjRG7aoDbCO6RyATWFoOBzEBcAYyGRWWHkE9RSFQ@mail.gmail.com>
 <CAEjxPJ6w+n=1XvA72FKPOnQSDjA+tKsUZRfY5HUd+_RxgBkosA@mail.gmail.com> <CAGB+Vh6sup6enGinZXc6p3rf2JrmfDP1sAHyNh+5pREVFrQDvA@mail.gmail.com>
In-Reply-To: <CAGB+Vh6sup6enGinZXc6p3rf2JrmfDP1sAHyNh+5pREVFrQDvA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Mar 2020 08:10:44 -0500
Message-ID: <CAEjxPJ7csH_5j=v=-uhbGz+oP+p=eqy5wW9uH4jCw29+M7pFUA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 4:42 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> > - Ondrej's uses the more compact (range c0 c1023) notation in the cil policy.
>
> Easily fixed, obviously I didn't know range c0 c1023 was valid in
> sensitivitycategory statements. Pretty nice actually.
>
> > - Ondrej's checks that checkpolicy supports policy version 32 in
> > addition to the kernel, necessary to build the policy.
>
> I suppose that should be added.
>
> I'm not currently set up to re-test this but could fix it up next week.

Ok, if fixing yours, then other items I noticed:
- Ondrej's test script is more readable because he separated the MLS fields.
- No need for ; in test_glblub.cil.
- Some extraneous whitespace in your patch; try fixing with git am
--whitespace=fix or fix by hand.
