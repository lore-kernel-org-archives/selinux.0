Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2281C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7D52192D
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550245820;
	bh=CAIig8PUERhXRJGQpDBjlmgQ3YeLE3VkY0ViUwAkvQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sVqpBtbRSk9prqQ9Pdo0EQtXbTHj7TIXm4h9v0G6S1k+qaIFSn8N0xNTTd1D9odkP
	 KX6aO4P3Kh9xCXxT42aM2QEnWW1I05Uu0uMO55FJ5j/qHS6u3VYZ1gtDhcvK5U5Sj6
	 1W1+do8GKmXuW54HKmECe9JzJH56UmpQwqVURfWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfBOPuU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:50:20 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46528 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfBOPuU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 10:50:20 -0500
Received: by mail-yb1-f194.google.com with SMTP id 7so3930649ybp.13;
        Fri, 15 Feb 2019 07:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgrhECn1nXRRLs8srQZV/Qr9SLLlA2Knfhd8ON2h60I=;
        b=Bh9lhmpPOsVnYHm4IQAatpZd0ssJLtDYUc8rRQhd3y5UwFJkq02vuvd/seO6xaVZhR
         UK1ZwDMcu/DpCq/w/K7Y7AHGRQC9ITGiZI/gfkf2TNEshD5faLSEFZRl44TOezdqdeGk
         Z7ZRjyh8FvI45vktKtHdLUGxkEcB90NLyGZRZgWL9UK5ED6JqtNFsScEADbDA/vnwdN/
         QCO9mSyDiN+slTC+P96bqnGpI6adJTOpq8mxDFR9TH/taOJXeRs1FsF7tEM1H0+CuD8l
         PTV7TpkI6Dtyq7D08gp1cgGgIWYxhnlLYMyP3SXc5srXt55lq51WzRWg5UG7zpzxGpNk
         E0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgrhECn1nXRRLs8srQZV/Qr9SLLlA2Knfhd8ON2h60I=;
        b=L/qraJZX+7HwDxLa1BlMYTv9F0nD9HkuZFc8QGw+REv7AESac0mwME6rHn47nCGdGu
         UTFTKVFb3uc29i7FsWDePbsjQELkbyCKid1JcGh80Zs2nkSrQMqe3RnmaR3UIs+H4IkM
         0piFsLo7CerDuc1U18iv+3EYsq9Q+88nxnJt253CjtPhJ6zp0y4881J0BGJ0oaF6BtBq
         IEQT0v06SZnjYE9YGt2LuQFdXu4Wcql39AFUj/oPkVLi4uR5bdRyqc3yLXQGjRckUWW1
         XdDs/qiDobHteaKziSTAwHxm1HLDaAhP6ernDS0TCPc81VQkXZcIiLPv4Ew0owJJTfJR
         m3bg==
X-Gm-Message-State: AHQUAuYt3MLUPJfSFL9LBJFbnLfvsQQIQOseSgQ+RlNxomiwzrlouu4M
        ugu+e3K6k6IobMYHFGGsflw=
X-Google-Smtp-Source: AHgI3Iacfx/iSfYxUWD8XotxSL2fO/RF3Gkj1xaH5nOlulElLJjQjUDsS1AVqXYb32CGJIbY6IQSSQ==
X-Received: by 2002:a5b:348:: with SMTP id q8mr8227739ybp.479.1550245818326;
        Fri, 15 Feb 2019 07:50:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:2c70])
        by smtp.gmail.com with ESMTPSA id b65sm2164873ywb.29.2019.02.15.07.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:50:17 -0800 (PST)
Date:   Fri, 15 Feb 2019 07:50:14 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
Message-ID: <20190215155014.GP50184@devbig004.ftw2.facebook.com>
References: <20190214095015.16032-1-omosnace@redhat.com>
 <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com>
 <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 15, 2019 at 04:45:44PM +0100, Ondrej Mosnacek wrote:
> On Thu, Feb 14, 2019 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
> > On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
> > > +static int kernfs_node_init_security(struct kernfs_node *parent,
> > > +                                  struct kernfs_node *kn)
> >
> > Can we skip the whole thing if security is not enabled?
> 
> Do you mean just skipping the whole part when CONFIG_SECURITY=n? That
> is easy to do and I can add it in the next respin (although the
> compiler should be able to optimize most of it out in that case).

So the goal is allowing folks who don't use this to not pay.  It'd be
better the evaulation can be as late as possible but obviously there's
a point where that'd be too complicated.  Maybe "ever enabled in this
boot" is a good and simple enough at the same time?

Thanks.

-- 
tejun
