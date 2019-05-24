Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440F7C072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1613520665
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 13:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="B5fVOKFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391064AbfEXNAS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 09:00:18 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41685 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391045AbfEXNAS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 09:00:18 -0400
Received: by mail-pf1-f170.google.com with SMTP id q17so453049pfq.8
        for <selinux@vger.kernel.org>; Fri, 24 May 2019 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xdP47CLWytB147ZuIXgFr8vVZlx8SGssLAsN2y69dFg=;
        b=B5fVOKFk86LMY5vVvp0yryP++4b7gV3DNhUNYu1xaC61ih+QvlywjuP5XisUVaDeYT
         jXdeZ8Ds5ATiMxajO1c1myFEQ5UUsbpsflVD1op4f0hxTXShobD3lTo7x6mPVt/lpyiM
         1FXzSOOwJARy+R8755I5V3/tzi6o0IG6o2DPjd9z8qLK/Jk9b9cOpubXWSojIX8zkFUi
         yjBPC0rs2y9ttdoG9TnvbYenX/XDJel/G1yMtM+AX3+gkzMiW7rj3NUbdyzX0+SPzXq+
         8kLNEejf33xR8HEQqaNBpupu5E1eTktFzEV1GkkBiBYcpm82hqBIwXcQzHf1xt2i9ErP
         cs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdP47CLWytB147ZuIXgFr8vVZlx8SGssLAsN2y69dFg=;
        b=XZOLAY3SjPTRJInlvbg6dofx9x2j9far9GMge2cAlNtRtiIyh/k2QrxV5MlHq9QtK4
         XgKU0eoQcre6ASTPWyjZofY9429yLaEDPJ+/OXNKD2XI6awOLkNjR56aw86yJz6Ph9kD
         PjEnG8NBWonkG0tr4nj+bJEgWjXs0qXtDXiC8avOv+X1nlm9zWm+Q4TeAnHBkbHNzBhx
         OBe9jgOdVyioAM7X7ENT6wTtAx2ySTb+HnqLnPpE98ryCPHXDM64FbkweojM2vjBXkgR
         zMzKRobIz2+8XgjQcR7AnMAhXtxWvsd4vItyhLraqdMgH597SXBOIXeQgCIxM8bWl3HF
         qKUQ==
X-Gm-Message-State: APjAAAVSbuIArFChjOIuoC99oGwpPWCTbRItcCvh0d15FBJj4HZY1yWl
        2k73uTKZ/djT8TvhBQu20hMw4l6Lpr4FVw==
X-Google-Smtp-Source: APXvYqwhdVC0cqnFSXA8nUVBco1z5BWKZAzf65f8nSDFGTgBf42/PaR3CrxFH9vBvrhOWPF40ZKbkg==
X-Received: by 2002:a62:d244:: with SMTP id c65mr75042861pfg.173.1558702817754;
        Fri, 24 May 2019 06:00:17 -0700 (PDT)
Received: from localhost ([2404:e801:2003:875:c789:3654:bf11:9d87])
        by smtp.gmail.com with ESMTPSA id d24sm2266422pjv.24.2019.05.24.06.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 06:00:17 -0700 (PDT)
Date:   Fri, 24 May 2019 21:00:15 +0800
From:   Jason Zaman <jason@perfinion.com>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org, 929063@bugs.debian.org
Subject: Re: SELinux integration in sysVinit
Message-ID: <20190524130015.GA25786@baraddur.perfinion.com>
References: <8cef19ba-5055-39fd-873f-73c7ba13cb8e@debian.org>
 <20190524125522.GA48358@baraddur.perfinion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524125522.GA48358@baraddur.perfinion.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Bigon asked me to forward this so its part of the bug tracker.

On Fri, May 24, 2019 at 08:55:22PM +0800, Jason Zaman wrote:
> On Fri, May 24, 2019 at 01:17:00PM +0200, Laurent Bigonville wrote:
> > Hello,
> > 
> > There is currently some discussion at [0] about SELinux integration in 
> > sysVinit and the fact that somebody wants to delegate the loading of the 
> > policy to an other binary than PID1.
> > 
> > Has somebody a remark or an objection to that proposal?
> 
> I object too. There is a *huge* change in functionality. Originally if
> you boot with SELinux enforcing, there are only two things that can
> happen. Either you end up with the policy loaded or the machine halts.
> 
> In the new patch, an attacker can just chmod -x /sbin/selinux-check then
> next boot there will be no selinux enabled.
> 
> if (access(SELINUX_CHECK, X_OK) != 0) fails, the machine will continue
> to boot without SELinux enabled. There is no difference between a user
> without /sbin/selinux-check on purpose and an attacker just chmod -x'd
> the tool.
> 
> SELinux does not protect /sbin anywhere near as much as /etc/selinux
> (and doing that would probably be impossible). You'd need to check if
> selinux is enabled and enforcing before skipping the loading ... which
> is done by calling is_selinux_enabled() which needs linking to
> libselinux. The important part of the original design is not
> selinux_init_load_policy(), its is_selinux_enabled().
> 
> If someone really wants to run sysvinit without libselinux then just
> switch to Gentoo, if you're on a non-selinux profile then you dont have
> libselinux.so. But I'd definitely not want to have this patch in Gentoo
> either.
> 
> -- Jason
> 
> 
> > I already gave my POV regarding SELinux integration in debian.
> > 
> > Kind regards,
> > 
> > Laurent Bigonville
> > 
> > [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=929063
> > 
