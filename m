Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E522ECAAA1
	for <selinux@archiver.kernel.org>; Fri,  2 Sep 2022 21:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIBVas (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Sep 2022 17:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiIBVak (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Sep 2022 17:30:40 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74EEA8A4
        for <selinux@vger.kernel.org>; Fri,  2 Sep 2022 14:30:39 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11ee4649dfcso7961975fac.1
        for <selinux@vger.kernel.org>; Fri, 02 Sep 2022 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wpvqLTbY51ingQhStK6KRkMK43oBsyhc78pHfJrs+Z0=;
        b=MRL7lsYjVNrBYlSv0ESbPmtcweds79pvuHaiTSwFLQl0QzbYVarYPMcjmSUfkW6dLh
         Gl3ezhNVmRMmeOWcWFC1W3yl+/c2dpMHUmBYrboGIWsRoo2zYwiiATOnMqNN7hwif443
         c3BizoXtyZd2nwp8cWaWiDQe1rVfFBGedzkifRNxlIEsKALDqZ4MvckLPVvGqSrJ6Yv6
         Nm+kb79jWVu00dKPBs6E4m0DtQAoHFpvkatO8oMGSZaPGzUw8AmHob7aLgoGxUnqrh9y
         kuqUxdrajxtHErGM1KehC2Kkzv63/vg5y4k6Ba/p9t4JbXTKTS1pFv1Fx5/N+qvruVMW
         mqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wpvqLTbY51ingQhStK6KRkMK43oBsyhc78pHfJrs+Z0=;
        b=ZzR4jGn+YHglFpWxP1wO8BbCl+3LRYWnfN9oE7R9AgP2cTlimN2if2L5uBhWnnrP3Z
         Kso/ti/YuBhFmjisS+3gEJ8R5fmxkOiftQVAq2VPboSLVXnlUK4ugmhJSAsezwdYwgs1
         STKn8ODdRWm+CmNS7roEdXj3Yyr7xlSvhsyGz9aQ2riMYs88NywHpdY+3RDA+J/PEH0v
         wmfr9pACUqHC0rs1WuZ6J82mdNURCbWGc36qxfLLLOEicnA6oxeWqjNlg/yo7etmCdsI
         JiA9LcmBEVBDQxPBwv3mU29rIb7c8MbMgcBuBoz6fMePuvA1oSHcoAgGmn2S9VGxBsjj
         Vo2A==
X-Gm-Message-State: ACgBeo1/iUrVXkkwsR/p/UM5+upGdoFOcADuXDXowVTIPkGcgpTpz1l0
        7mvpOYbyKgI3JHv4Vo556Lur7eghm9g63+mAo2HY
X-Google-Smtp-Source: AA6agR7Wc70UT4e7fFlX/GCll60DV/uWbZKPPaNIbnSSDFl+1w075BMpSWZet2WlOX7jwymG6jPcBsAyq0P9AZyFgGs=
X-Received: by 2002:a05:6870:f2a1:b0:122:3d83:b14d with SMTP id
 u33-20020a056870f2a100b001223d83b14dmr3370674oap.136.1662154238464; Fri, 02
 Sep 2022 14:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com> <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
In-Reply-To: <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 2 Sep 2022 17:30:27 -0400
Message-ID: <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
Subject: Re: LSM stacking in next for 6.1?
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 2, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Aug 2, 2022 at 8:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > I would like very much to get v38 or v39 of the LSM stacking for Apparmor
> > patch set in the LSM next branch for 6.1. The audit changes have polished
> > up nicely and I believe that all comments on the integrity code have been
> > addressed. The interface_lsm mechanism has been beaten to a frothy peak.
> > There are serious binder changes, but I think they address issues beyond
> > the needs of stacking. Changes outside these areas are pretty well limited
> > to LSM interface improvements.
>
> The LSM stacking patches are near the very top of my list to review
> once the merge window clears, the io_uring fixes are in (bug fix), and
> SCTP is somewhat sane again (bug fix).  I'm hopeful that the io_uring
> and SCTP stuff can be finished up in the next week or two.
>
> Since I'm the designated first stuckee now for the stacking stuff I
> want to go back through everything with fresh eyes, which probably
> isn't a bad idea since it has been a while since I looked at the full
> patchset from bottom to top.  I can tell you that I've never been
> really excited about the /proc changes, and believe it or not I've
> been thinking about those a fair amount since James asked me to start
> maintaining the LSM.  I don't want to get into any detail until I've
> had a chance to look over everything again, but just a heads-up that
> I'm not too excited about those bits.

As I mentioned above, I don't really like the stuff that one has to do
to support LSM stacking on the existing /proc interfaces, the
"label1\0label2\labelN\0" hack is probably the best (only?) option we
have for retrofitting multiple LSMs into those interfaces and I think
we can all agree it's not a great API.  Considering that applications
that wish to become simultaneous multi-LSM aware are going to need
modification anyway, let's take a step back and see if we can do this
with a more sensible API.

I think it's time to think about a proper set of LSM syscalls.  We
have avoided this in the past for several reasons, but over the past
couple of decades the LSMs have established themselves as a core part
of Linux with many (all?) major Linux distributions shipping and
supporting at least one LSM; I think we can justify a handful of well
designed syscalls, and with Landlock we have some precedence too.
While I realize syscalls are not the only kernel/userspace API option,
but given the popularity of namespaces I believe a syscall based
kernel/userspace LSM API has a number of advantages over the other
options, e.g. procfs/sysfs, netlink, etc.

Further, I think we can add the new syscall API separately from the
LSM stacking changes as they do have standalone value.  This would
help reduce the size and complexity of the stacking patchset, which I
believe would be a very good thing.  Introducing the syscall API
sooner would also allow any applications wanting to make use of the
crazy new stacked-LSM world a head start as they could be modified
while the kernel patches were making their way through the
review/update/merge/release process.

Thoughts?

To help make things a bit more concrete, I put together a quick
strawman this afternoon to get the discussion started.  I'm definitely
not a syscall stylist so please consider this more as an idea and
discussion starter at this point; if we agree there is value in going
this direction I can put together a proper patchset to introduce the
new API ...

/* LSM_ID_XXX values 32 and below are reserved for future use */
#define LSM_ID_SELINUX 33
#define LSM_ID_SMACK 34
#define LSM_ID_TOMOYO 35
#define LSM_ID_IMA 36
#define LSM_ID_APPARMOR 37
#define LSM_ID_YAMA 38
#define LSM_ID_LOADPIN 39
#define LSM_ID_SAFESETID 40
#define LSM_ID_LOCKDOWN 41
#define LSM_ID_BPF 42
#define LSM_ID_LANDLOCK 43

/**
 * struct lsm_mod - LSM module information
 * @id: the LSM id number, see LSM_ID_XXX
 * @flags: LSM specific flags, zero if unused
 */
struct lsm_mod {
  unsigned int id;
  unsigned int flags;
};

/**
 * struct lsm_ctx - LSM context
 * @id: the LSM id number, see LSM_ID_XXX
 * @flags: LSM specific flags, zero if unused
 * @ctx_str: the LSM context string
 */
struct lsm_ctx {
  unsigned in id;
  unsigned int flags;
  char *ctx_str;
};

/**
 * lsm_enabled - Return information on the enabled LSMs
 * @lsm: individual LSM definitions
 * @count: the number of @lsm elements, updated on return
 * @flags: reserved for future use, must be zero
 *
 * Return information on the different LSMs enabled in the kernel.
 * On success, this function returns a positive number representing
 * the number of @lsm array elements, which may be zero if none are
 * enabled.  If the size of @lsm is insufficient, -E2BIG is returned
 * and the number of enabled LSMs is returned via @count.  In all
 * other failure cases, a negative value indicating the error is
 * returned.
 */
int lsm_enabled(struct lsm_mod *lsm, size_t *count,
  unsigned int flags);

/**
 * lsm_current_ctx - Return current tasks's LSM context
 * @ctx: the LSM contexts
 * @count: the number of @ctx elements, updated on return
 * @flags: reserved for future use, must be zero
 *
 * Returns the calling task's LSM contexts.  On success this
 * function returns a positive number representing the number of
 * @ctx array elements, which may be zero if there are no LSM
 * contexts assigned to the caller.  If the size of @ctx is
 * insufficient, -E2BIG is returned and the required number @ctx
 * elements is returned via @count.  In all other failure cases, a
 * negative value indicating the error is returned.
 */
int lsm_current_ctx(struct lsm_ctx *ctx, size_t *count,
  unsigned int flags);

-- 
paul-moore.com
