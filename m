Return-Path: <SRS0=ZoZM=PZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8955C43387
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 16:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE020855
	for <selinux@archiver.kernel.org>; Thu, 17 Jan 2019 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547741726;
	bh=HIfnWvjJx1XbbbnFAkh/KOSTB2ZU7DTZKtdKA1Ftftg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gXOHZ66BtRjWGNkN1uT/6AnoUC8RDX3bf7cDmNbgomWu0LhW6Ehlfvbx+cs/eWwKE
	 ZP0DRiH7bPFRewLEJ1KEetF1tJQphKMC9BkOBqsALHYcwfliAxVq3bZwqQp5B3bQtG
	 Zj5ScJ/Y6c0IziRLfQVOZ1r4Ahi0YsfGwdFvEKKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfAQQP0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:15:26 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35935 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAQQPZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Jan 2019 11:15:25 -0500
Received: by mail-yb1-f194.google.com with SMTP id a190so3211301ybg.3;
        Thu, 17 Jan 2019 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RqL0AEOOBDO3n45l+z2WTVuBS8xl6jVyCQzl3EMFoow=;
        b=Fl6LDEEB5XmogMl5LiLRgs7JXcWSvByTi+ef8+DHWWpuEuT8tAxmDuZjeWI9x5heiv
         Ttt2knqPOu2ave85iu/FkuXl7tqo8CaLU4gN55gVBD2s/lbjRabQlD00eLVnKe27jzeG
         EB+wqmRqNC3Va/8x0nE/f68YWpGPOWKhPREXipgCdGTZ+fFE1d8O12Jk2GYqAMIghlAk
         H3htO3NSCuKvvuEmuQdGY+PvaTylQRkOkTaf21mTDJdNHDy2sooNS0PSSxrsOgopZ3JP
         BvEvsNSXYRNYcEQ+vGRkqtk73NmgeRHIQwHmLv8L4NZiMIu8PheWjjhpg1XPDPc1W6Zs
         DJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RqL0AEOOBDO3n45l+z2WTVuBS8xl6jVyCQzl3EMFoow=;
        b=Oi2NVb5jgtTYI/MjwnY/ahI24OxjQYz/BCUGTOLQz4ekj2MqFEHEbrZbWlg4zxN76G
         mqNWcISkRHWdLhKAaZKGNvkg9Rui6DWwKeYEkAWhqjZez3ZJ7QZsJVWcN2bbNJLIAeT6
         zx4XgCWxcfbEmg9d9Hj5PYplwR/sipUbzM8gumVG0M6tx99LMh8StpIJbLvKMPmICYy2
         alLykSXif9mdog8dxQNwEG1BfnqM0sJtpUOuFDY6l4217Jg/hn3wppkeRkLetC9Nah/Q
         dquncFSKvS17/4yVGMrvEy25k24AbhyljjXOMIFllSzAb254HVkdGHUZuLyKSUt+wBjP
         aSkg==
X-Gm-Message-State: AJcUukfJejBeE2fMO2zlQIuHLIZejtuyj81zawFr4xUl+OBj05b+Zhat
        cy6Y4YM2d3zdxJY+wit7ZFQ=
X-Google-Smtp-Source: ALg8bN62O9M6awgXozA782ttAFtFs74TJPWdsLOuQE4ktvb74Vv0ftusuvTmD04VzYOPsqD4BXvyCg==
X-Received: by 2002:a25:424b:: with SMTP id p72mr2483857yba.19.1547741724232;
        Thu, 17 Jan 2019 08:15:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:106a])
        by smtp.gmail.com with ESMTPSA id f203sm873514ywf.105.2019.01.17.08.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:15:23 -0800 (PST)
Date:   Thu, 17 Jan 2019 08:15:21 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Walsh <dwalsh@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
Message-ID: <20190117161521.GA50184@devbig004.ftw2.facebook.com>
References: <20190109091028.24485-1-omosnace@redhat.com>
 <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
 <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
 <CAFqZXNsxVpxXHQ4qOZQpnpck24O5ofskLgU-B0ahbDK8MgxGCA@mail.gmail.com>
 <64977013-e2a5-809d-7a3f-bffbda9276aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64977013-e2a5-809d-7a3f-bffbda9276aa@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Thu, Jan 17, 2019 at 10:01:23AM -0500, Daniel Walsh wrote:
> The above comment is correct.  We want to be able to run a container
> where we hand it control over a limited subdir of the cgroups hierachy. 
> We can currently do this and label the content correctly, but when
> subdirs of the directory get created by processes inside the container
> they do not get the correct label.  For example we add a label like
> system_u:object_r:container_file_t:s0 to a directory but when the
> process inside of the container creates a fd within this directory the
> kernel says the label is the default label for cgroups
> system_u:object_r:cgroup_t:s0.  This forces us to write looser policy
> that from an SELinux point of view allows a process within the container
> to write anywhere on the cgroup file system, rather then just the
> designated directories.

Can you please go into a bit more details on why the existing
cgroup delegation model isn't enough?

Thanks.

-- 
tejun
