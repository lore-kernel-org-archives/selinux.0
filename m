Return-Path: <SRS0=3kls=PW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AC4C43444
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFDE20896
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547481025;
	bh=1Xz8ydEQvH07197m1Yo8/TIkaWWXflrKEiQ1AUnMSAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YrtyZqGlTI86ApSPR2tHpYJv3iF9uaVLFcZ8IugpGIhhYlbHn7t6ek3NmmmBkHsUg
	 mfCY0VW40OzPfQcDcBFkVi0tcP8bW4dWv/CaXY0sBO6fTg4emzESfSqSI8cPGTY6/1
	 sTOKV5md3X0VND/Zw3HDrWc4qF2umauTLyvClIbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfANPuY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:50:24 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38986 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfANPuX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jan 2019 10:50:23 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so8775364ywa.6;
        Mon, 14 Jan 2019 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BzYQ6MAnGX/tiizkzMXmGb9jm+EZ4e6avgzl/jfjHRk=;
        b=u9iHFFAuaSFhkpl4uzoxHAMlrAYcGrzwJapUvdy3w9EqZN0KwReGDWbYKGLkB+Wx0g
         EeUXDXNVyh8chOA4R54hetuzcV1rgr/amKNBL2X8AaO/IDzrncQOVkN+HupY98Mi+BNf
         oZU4LsYpE5TPX9oo5McKE5pGUFz+bVzrJEd/7Jj0b+RqkC89J0LJ9HiKIYzKQxhSKXWA
         oa/aZP0oM1D7k8AERaMnTaJUsi/29E3I/a0Kp28+UQCjgKlWoAse6uDTJ0nZRLwLXh2u
         BvEPAD0kbQ/admB69r2WDWX4YguOzrNlI2Ub5w21j1kYR3AD4/T+gxqMnbgASI7YlzDh
         nJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BzYQ6MAnGX/tiizkzMXmGb9jm+EZ4e6avgzl/jfjHRk=;
        b=YUvxkM7PjnqIOYZ1t9gQQGwF4Wo/XqSbdC5bZCQS2B8ZWdlZF26hECeVU77u5UR7hk
         tsIuHQwpX9qjYCePMQOXstrrhgymPEIA7qxzm9buUm814bFQKBnJdbF5g9gJwbTMZTrT
         el31sXwPGkz2VOx1jxqPyuMThOBlfIfILZQkiOBVluoWYtms7hIzSwLLx/6diZflEFOx
         eXTUOPBAu9ltvg+6zJB9KBtoRFTCz9BWRFKdVcITlDJTtds5dZRVslWuOez3TA6omcSF
         82ocZ69rpzn2MnyF3S6La5xokf2A463Yi9SlxD7BZdv06MLJJ8x0Dq3PEIz1U4C9ArnT
         tntg==
X-Gm-Message-State: AJcUukeSMo3UOntdc+fHxSRJf/x+7zEfujsVHYuxyb+h7o19svQgxZzV
        D0wa0UxtMXRb7WBcKRNdJHQ=
X-Google-Smtp-Source: ALg8bN5qKrEryMAvH4L7plYvtgRUAMYPdE660JVkxAYspFh2JteCrDkyntVYIgnw7uFGQqgzOq4hOQ==
X-Received: by 2002:a81:5744:: with SMTP id l65mr23511415ywb.91.1547481022397;
        Mon, 14 Jan 2019 07:50:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:525f])
        by smtp.gmail.com with ESMTPSA id x1sm235566ywf.94.2019.01.14.07.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 07:50:21 -0800 (PST)
Date:   Mon, 14 Jan 2019 07:50:19 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Daniel Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
Message-ID: <20190114155019.GA168429@devbig004.ftw2.facebook.com>
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
 <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Mon, Jan 14, 2019 at 10:14:32AM +0100, Ondrej Mosnacek wrote:
> I'm not sure what are the exact needs of the container people, but
> IIUC the goal is to make it possible to have a subtree labeled with a
> specific label (that gets inherited by newly created cgroups in that
> subtree by default) so that container processes do not need to be
> given permissions for the whole cgroupfs tree.
> 
> I'm cc'ing Dan Walsh, who should be able to explain the use cases in
> more details. Dan, this is related to the cgroupfs labeling problem
> ([1] and [2]). See [3] for the root of this discussion.

Let's wait for Dan to respond but I'm pretty skeptical that this is a
good direction.

Thanks.

-- 
tejun
