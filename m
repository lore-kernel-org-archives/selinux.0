Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD0C433E6
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AB764DF2
	for <selinux@archiver.kernel.org>; Tue, 23 Feb 2021 22:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhBWWlm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:41:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37036 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhBWWiS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Feb 2021 17:38:18 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 011C320B6C40;
        Tue, 23 Feb 2021 14:36:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 011C320B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614119814;
        bh=u8xSV6mboWtDGea5Rur1TvDYanYtddwU8NnszQ/n/XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/juN9thNxAd+EYyH2zmk6LCkANs5rgZ751fxC58hTY839paqQO8z7oWj+iPq/kUB
         MQ5YVFmUd5adAA3Ysaepwv+AUZWmU8DDrNvSjgf/zge+oqVPplWvj9VfM1CnK9pUWQ
         b4TajhAW7wa29NG/JafB93KZ2bPQuMyrm6+R0hFg=
Date:   Tue, 23 Feb 2021 16:36:52 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race between policy reload sidtab conversion and live
 conversion
Message-ID: <20210223223652.GD6000@sequoia>
References: <20210223214346.GB6000@sequoia>
 <20210223215054.GC6000@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223215054.GC6000@sequoia>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-02-23 15:50:56, Tyler Hicks wrote:
> On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > I'm seeing a race during policy load while the "regular" sidtab
> > conversion is happening and a live conversion starts to take place in
> > sidtab_context_to_sid().
> > 
> > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > then another policy gets loaded ~2-3s into boot. That second policy load
> > is what hits the race condition situation because the sidtab is only
> > partially populated and there's a decent amount of filesystem operations
> > happening, at the same time, which are triggering live conversions.

Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
change here:

 https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/

I'll put these changes through a validation run (the only place that I
can seem to reproduce this crash) and see how it looks.

Tyler
