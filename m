Return-Path: <SRS0=yrd7=PT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E8FC43387
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 20:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822EE2133F
	for <selinux@archiver.kernel.org>; Fri, 11 Jan 2019 20:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547239932;
	bh=mB/HNUB3OlOhA4EvxKzaoN/3otu+foKb3gs1+VkrNwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RNoSpLFEDCSG2Nm5HtqVN5/3Soc1PIbuxjAiOvBxmAidMlFxjoxPO8Gw3yUqhrLIU
	 7WGAXm0df1edoTh7+XptPpaUhJCz+WLdo+nKesFxsqQOF/zqp9NuNyowkXyLtrq8OG
	 y6gLeVkbNDeSsVG0CSQwv7uKJay+YsTAyJA546Vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfAKUu7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:50:59 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35193 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfAKUu7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Jan 2019 15:50:59 -0500
Received: by mail-yb1-f195.google.com with SMTP id f187so6364465ybb.2;
        Fri, 11 Jan 2019 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARzq762nZGleiy7BAASMkU8Lxv6RU9NVCFeYGkeeSso=;
        b=CtWyW/mlj1sjtuoqmU4zwa+lvNZF2haZFIctvQbEFT6LPKh5YErhkXxuLmxFt+6+7K
         1x9BYu29842YM1WHbiZmCGb3RPk+6m7ffCQLzGMAPtAdFTPrtLPhbGmtd2Fzf5C6NIVm
         Xn4mIQmAfux2e6GzTF9+UTeQUif/WsnBZFIQKvtDs7AcumD6FA+otd4QmAG3ekkQ91jF
         hz+I2vVgzfhqAcv/Q1ywN42mepHBbtOxWzqYbXTmA0A4nv3MiRnn6FcMkBICYlq/uwB0
         liu+isF8PE+6cy/qnYp8XX+uA5vtsYwcmLl+iBffNIo0m/c5RkrzRRwgV2GPQrzQNmL1
         PVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARzq762nZGleiy7BAASMkU8Lxv6RU9NVCFeYGkeeSso=;
        b=dRY/ckLiTJpwZUqsdELwz01S8whfsNUuQNDGQ86bxzHUHRsRczy0ZY4eSz3N8d95Ut
         2NeZ3Bam11SVeSptitHvMlpMNb79ppS/2nNonBKHcOOxzUgT1ct7KSvBFzUCC1xL+CFX
         +fsvRtJyhPrd2onjxtNvBEBJkokRrvk5ByJ2MZSrewoK/uTUkYXWtl5Adf05f6kt3kjG
         LYiGCAZfdoNVdOSDF54ENI15C0jt5dyh+XktTjfNPDsSERt9Bta5ZplfHY+QTfVbpttw
         V8nV5fKEgg0IZWEjy4TnrARLbCbTtJZFJZ50HXn/Sshee9k6grWi240idSXF4Q541lRJ
         nnGA==
X-Gm-Message-State: AJcUukfCMfdoDUT1FOgtjRXDkbKeCIFnVNVbKgM8kdINulcU2FQXNWgk
        61JoFtb2v9960i6Y8h9LgCk=
X-Google-Smtp-Source: ALg8bN4JE97v4oK11m5AFPz8LN+PHdrJYIUQer8S5RWQScS4SH6nmjbOg2yKW8xlURVLgCF/+5r4Vw==
X-Received: by 2002:a25:1c2:: with SMTP id 185mr15764273ybb.288.1547239858170;
        Fri, 11 Jan 2019 12:50:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:1af2])
        by smtp.gmail.com with ESMTPSA id z2sm27008075ywe.32.2019.01.11.12.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 12:50:56 -0800 (PST)
Date:   Fri, 11 Jan 2019 12:50:53 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
Message-ID: <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
References: <20190109091028.24485-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109091028.24485-1-omosnace@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Wed, Jan 09, 2019 at 10:10:25AM +0100, Ondrej Mosnacek wrote:
> The main motivation for this change is that the userspace users of cgroupfs
> (which is built on kernfs) expect the usual security context inheritance
> to work under SELinux (see [1] and [2]). This functionality is required for
> better confinement of containers under SELinux.

Can you please go into details on what the expected use cases are like
for cgroupfs?  It shows up as a filesystem but isn't a real one and
has its own permission scheme for delegation and stuff.  If sysfs
hasn't needed selinux support, I'm having a bit of difficulty seeing
why cgroupfs would.

Thanks.

-- 
tejun
