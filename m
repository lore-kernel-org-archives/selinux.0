Return-Path: <SRS0=HWKQ=Q2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DA2C4360F
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603B321773
	for <selinux@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550586081;
	bh=QUlWggWhQejOP5hSyZPRrPO4kyu/P7mmrwE4MKPUnw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+bj0UQBGMtnlZy6lRkUot76yAxdKSX/d1s0EYV+dFqUja70R6pRkDqDjAgTSNEbr
	 x3ONsMYr5zJnAgo6ySHxni4e2ekMEjtm2J3hAZGAz5Ou0T1mFOkS8Bk0ZTTJlEejgD
	 9CMgoej3byBfDKcB8i7RfahYhsVRbTpcinFXJuZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfBSOVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:21:19 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39010 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfBSOVT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Feb 2019 09:21:19 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so7807695ywa.6;
        Tue, 19 Feb 2019 06:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FzUuZsIyioAFwFFokciRkCKFvI45u5I0D3t3GesC1Fs=;
        b=nTPTspo8QErOAbJP9wLkYbH3pd+8YJuwCtRPFzR4/9+stZmwKRE1FE8OXS8unJ+GV+
         czWxyBP5NKmm6zO9JSeMeuX1VQOUAKIROoVQDR5Jf1ChAKxt7wcjr6WVkabssUrwW+9o
         wOOmnxKPsNvJMpxwVNPa2sNo55BmeRpEqomqYDcyfm4dRdCSRD84VLVEeqg0znHgchKA
         9EZYpiB2WCVAjP3wjPfMClaSPoJ3RPKzFUPJSEAwP2NcHLFcVAYl8LyLM1BDDvubcfzE
         53il6cm9D1vyhbXRkA/mVe0ec4XcW0AheXaGg2/NkWKDuVbZIODCQoXnh+3QOCtivMxs
         k7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FzUuZsIyioAFwFFokciRkCKFvI45u5I0D3t3GesC1Fs=;
        b=k6F/WLreCAiXcC10E0USKopcZtj/HCpK3YSchjeK+HuEgb3/iW2G46DLAxyeYwjiXD
         /1IC19W7bw7tfMGSt4sKZuQRqOBuv3xhn8R+kE9Iza6kWSHjgbiaZDxtl17+zb03ygSp
         MEow6HyZXQ9vJhUCSX5Zk1Je/93S4flh6wrqXeAuWZFBlQk5AtLDRDVmyNStdY1hFHhN
         imY5lrQh5bL05d9wDDNJlPsuxpJFeD7HvskAnJ6hPZ6DyZlVSHKfjc1QiDQaI7Hch4mm
         cxP1Wl5HBbLpcCL46fds0qaPUArWPqOwQEBEMK5uqxMs86IcROI6dJiTsleHvPvXQAso
         6qRw==
X-Gm-Message-State: AHQUAubsBKz6DzgqswCS6K1JKmd0MsvzkAiZjBqsy27+Y9dzcZWzHRKE
        wkl5nU0aEhpvmE8QLkqnftA=
X-Google-Smtp-Source: AHgI3IahJTjtObdrIgRPzYCICienRwSLX7SKRNoIR1FmFmL36jh5FH44LL6j6i08a5wtr/JTrhSnVQ==
X-Received: by 2002:a0d:cc85:: with SMTP id o127mr23500153ywd.332.1550586077418;
        Tue, 19 Feb 2019 06:21:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:2c70])
        by smtp.gmail.com with ESMTPSA id e64sm7248781ywd.40.2019.02.19.06.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 06:21:16 -0800 (PST)
Date:   Tue, 19 Feb 2019 06:21:14 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
Message-ID: <20190219142114.GU50184@devbig004.ftw2.facebook.com>
References: <20190214095015.16032-1-omosnace@redhat.com>
 <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com>
 <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
 <20190215155014.GP50184@devbig004.ftw2.facebook.com>
 <CAFqZXNvVb75K9ZemVObcBB+rntL38_VfY5P6jyAbuwjymt6MQQ@mail.gmail.com>
 <8c1ddde8-c7aa-7dca-3a0f-2d425c6879b4@schaufler-ca.com>
 <CAFqZXNtJFrtAqnu=CmoSPnPM312DKF73ALkLeekMk8Me5ojntw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNtJFrtAqnu=CmoSPnPM312DKF73ALkLeekMk8Me5ojntw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Tue, Feb 19, 2019 at 03:10:30PM +0100, Ondrej Mosnacek wrote:
> Well, maintaining a global variable sounds even more yucky to me...
> And I don't understand why you'd consider a simple one-line function
> to be "an awful lot of infrastructure" :) But at the end of the day it
> is up to the maintainers - Greg/Tejun and James/Serge (who I forgot to
> Cc on these patches, sorry) - what works better for them.

As long as the cost can be avoided for folks who don't use the
relevant features, I don't have a strong opinion on how that's done.

Thanks.

-- 
tejun
