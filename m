Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B15FECAAD5
	for <selinux@archiver.kernel.org>; Thu,  8 Sep 2022 03:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiIHD5p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Sep 2022 23:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIHD5p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Sep 2022 23:57:45 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A6FC650D
        for <selinux@vger.kernel.org>; Wed,  7 Sep 2022 20:57:43 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11e9a7135easo41175498fac.6
        for <selinux@vger.kernel.org>; Wed, 07 Sep 2022 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=v/PyPwHqUQPLfPDgKYprPAlWEPQ3t7z/tBxe7FZmbM4=;
        b=mP8sAvo6CUp7OkOsxLCb/DImKvt8wx5qKUsixqOLKWwji6xKTDLStHPQfSpLSQG3Qk
         HP4fSQTWtAeKC5Kp5HY5GccGaDWyBjrgcQ1tXbV9d9jiq/ZZJGyOTIs2utrh2e1kvY9i
         w8nSarAd8J16GznhnhX/1YpgHlkDl8SiUR7u8FrP++WxfHbXaXVtmu0XTs3OlZH27NIJ
         tdQSQAaTpbuczvJQCzZGuM7VRttl12C8cWE6Em0Z8+G2gWlSAQzkOPKc4JKigOEbRf5S
         fpUV4bhXdUjIDHPeWAmZcpMj9GIFqVIdnc0FCV+gYZ1OHVoJ+YYfYqQ9z8CGHiLwqSBd
         XDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=v/PyPwHqUQPLfPDgKYprPAlWEPQ3t7z/tBxe7FZmbM4=;
        b=25QbYgBtqL6nycEIe5SOFLhMT4MQ3E5eR1j94C421G/ZwvFbn96YIk6xEB7PoMqRX+
         EdCVPFw6wc3q0ODnMLkDd7VpJxLZAgveTlKYbTdA/dx1GedW5S0sIfS3J2wsL2ylEDCB
         dvAzxFqq5nQ1B0alaYs1o+Xeb8N0TwnYbIo2qtP3Q5qC6kdg6Ev6rhYEj0CPbXIRvRf2
         jGLoYSy3snmeoWuceIV+OOf4ZTlaxNYck75aD9DXQer5UmDI9fvnN4DqjGN+Psy01f04
         OhsqgVE/0eRvg9BjmmoLXFq5WQMITNL6Tl6KowSKC5OrO5BgkwCV9qc8ectRrF/nLE2N
         jhaQ==
X-Gm-Message-State: ACgBeo3x1IO//ccdp5acTo+6iQA0E5sZdOW3FEtx8ZMATws34Al1VfrV
        BzXrGLK9fpV3bopCDldNti5UBAG7MzvLJMoQu6kNlnsIqX51
X-Google-Smtp-Source: AA6agR4Bs29rduHYmr/u6vMKVGgaSFXTpIjTVewqiAxKhrtsXbfQOeVvMRugiQ31wDqmaEHiWupMLK/gPvXsAOhXCHk=
X-Received: by 2002:a05:6808:bd1:b0:345:da59:d3ae with SMTP id
 o17-20020a0568080bd100b00345da59d3aemr679826oik.136.1662609463054; Wed, 07
 Sep 2022 20:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com> <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com> <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com> <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
In-Reply-To: <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Sep 2022 23:57:32 -0400
Message-ID: <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 7, 2022 at 7:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/7/2022 4:27 PM, Paul Moore wrote:

...

> >   I
> > just want an interface that is clearly defined, has reasonable
> > capacity to be extended in the future as needed, and is easy(ish) to
> > use and support over extended periods of time (both from a kernel and
> > userspace perspective).
> >
> > The "smack_label\0apparmor_label\0selinux_label\0future_lsm_label\0"
> > string interface is none of these things.
>
> In this we disagree ....

I think we can both agree that there is a subjective aspect to this
argument and it may be that we never reach agreement on the "best"
approach, if there even is such a thing.  What I am trying to do here
is describe a path that would allow me to be more comfortable merging
the LSM stacking functionality; I don't think you've had a clearly
defined path, of any sort, towards getting these patches merged, which
is a problem and I suspect the source of some of the frustration.  My
comments, as objectionable as you may find them to be, are intended to
help you move forward with these patches.

> >   It is not clearly defined
> > as it requires other interfaces to associate the labels with the
> > correct LSMs.
>
> The label follows the lsm name directly. What other association is required?

You need to know the order of the LSMs in order to
interpret/de-serialize the string.

> >   The ease-of-use quality is a bit subjective, but it does need
> > another interface to use properly and it requires string parsing which
> > history has shown to be an issue time and time again (although it is
> > relatively simple here).
>
> There was a lot of discussion regarding that. My proposed
> apparmor="unconfined",smack="User" format was panned for those same reasons.
> The nil byte format has been used elsewhere and suggested for that reason.

Based on what I recall from those discussions, it was my impression
the nil byte label delimiter was suggested simply because no one was
entertaining the idea of using something other than the existing
procfs interface.  It is my opinion that we've taken that interface
about as far as it can go, and while it needs to stay intact for
compatibility reasons, the LSM stacking functionality should move to a
different API that is better suited for it.

> > Once again, the syscall example I tossed out was a quick strawman, but
> > it had clearly separated and defined labels conveyed in data
> > structures that didn't require string parsing to find the label
> > associated with an LSM.
>
> True, but it uses pointers internally and you can't do that in memory
> you're sending up from the system. What comes from the syscall has to
> look something like the nil byte format. The strawman would have to do
> the same sort of parsing in userspace that you are objecting to.

Then we change the strawman.  That's pretty much the definition of a
strawman example, it's something you toss out as starting point for
discussion and future improvements.  If it was something much more
fully developed I would have submitted a patch .... sheesh.

In case it helps spur your imagination, here is a revised strawman:

/**
 * struct lsm_ctx - LSM context
 * @id: the LSM id number, see LSM_ID_XXX
 * @flags: LSM specific flags, zero if unused
 * @ctx_len: the size of @ctx
 * @ctx: the LSM context
 */
struct lsm_ctx {
  unsigned in id;
  unsigned int flags;
  size_t ctx_len;
  unsigned char ctx[];
};

/**
 * lsm_current_ctx - Return current tasks's LSM context
 * @ctx: the LSM contexts
 * @size: the size of @ctx, updated on return
 * @flags: reserved for future use, must be zero
 *
 * Returns the calling task's LSM contexts.  On success this
 * function returns a positive number representing the number of
 * @ctx array elements, which may be zero if there are no LSM
 * contexts assigned to the caller.  If the size of @ctx is
 * insufficient, -E2BIG is returned and the minimum required
 * size is returned via @count.  In all other failure cases, a
 * negative value indicating the error is returned.
 */
int lsm_current_ctx(struct lsm_ctx *ctx, size_t *size,
                    unsigned int flags);

> >   It was also self-contained in that no other
> > interface was needed to interpret the results of the syscall (well,
> > beyond the header file definitions I guess).  Finally, it made use of
> > flags and "reserved for future use" token values to allow for
> > additional data to be conveyed in the future.
>
> Can you describe potential flags or additional data? Planning for the future
> is a good idea, but throwing fields on "just in case" seems contrary to
> what I'm used to hearing from you.

Adding flags to a syscall is a fairly common practice.  If you're
making the mistake of confusing this with the discussion that is
ongoing audit/fanotify discussion, you can think of the flags as
similar to adding a type/length field to a struct (which I support).

-- 
paul-moore.com
