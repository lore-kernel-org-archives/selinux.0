Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09ABC169C4
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A56218AF
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548944570;
	bh=J8+yKNX4+YfxTYfWs/+pldcdyqOwRR4sdEgpT/77Zv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WlCqYbYhScTBxiXUqYf+xHKVgrd08k0bmsRSV7NU7lgxAnuGo/+CHKNl2YIyfZRiP
	 joCZnspWV1Iyc0h3gcvKIrIL+MdOeKtjKH7uxcS+EXM2UpiW0ZmNU3UajJDTDK0RlZ
	 rORd7dHHbf3xvpAu9olfsl9Pzcn7fMvvH1f09Ggs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfAaOWt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:22:49 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42691 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbfAaOWt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 09:22:49 -0500
Received: by mail-yw1-f65.google.com with SMTP id x2so1309899ywc.9;
        Thu, 31 Jan 2019 06:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gH04YLr8KCODOOxKnT/DDcO/U+6S3AnfQvySFCkoUQM=;
        b=V1qEgw2wemqP+e8WUvfItePlczr7nh44Yd3gODVym7hTEUPame3FNOWTVFAapGCNve
         BuaaJ8vEqnVXiEBknU9zPkLQmWKk4+4CHBRD0E6XTfx5Fd8L3ucDsEltdmpDwYgWyACy
         E+CDtNvY46XDwN1rmmnyoGaL68keJIi2I19vQ+kv4+++7QDmjmgcUHtt+aj2LIaq1NIo
         3etJWIz80VNDZ4kosdB+L97AqH1FA9EERwcj02nnru29+kqAavWVmEXpCQuOs8h6he9X
         jrSTf0xquRt/rW2QakjDXpqUga4WNabMdV90hwtcutUeLaVIckuKMhXkoldfQ9xkKGfe
         2NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gH04YLr8KCODOOxKnT/DDcO/U+6S3AnfQvySFCkoUQM=;
        b=VB8BSwy0QLtutq3LcLgHeYWO6g1FB8haOTqYKBH5lxpLNV33yb2DDJFXg7jwdYkEmC
         TxDRNd4KpGmzLASR9o7AdOQlixL6fqg849/EdeGZ9F4VIguYyI2PMqFCnglQuN/WCGzt
         lCUE6IjOZ1KAkMNVha2XRR2YiW0AMr/DSsCplEJyVvrlY3HFWy9MNwgAhYebrP6bJ7rn
         +L+BOOIaJ2pdq9G8eBQGcTGfVgTDfPCeXZw6TEcnY5unDpCtBo7G0w91GAW+OMPLl1WW
         gcEgKmZP/8eMBXNSf7PMGb6c7spnl529MPZz2hQPPFbJ0F1wR2qqUpS0vB9hlTSi6IRt
         iSKA==
X-Gm-Message-State: AJcUukcdYtqTmvK9yPCsRtMCRMsWb6XMTJvftUnXzx5FRaLAIaXh8mew
        P4UpXSEnB29nEAW2TmFdv3U=
X-Google-Smtp-Source: ALg8bN6xRddb2LF8NKONSf+vT4pZ4YNmH87YoiFiK1WU5QmPoshjtg2//8qnRkT69baIuFAxIST6bA==
X-Received: by 2002:a81:a691:: with SMTP id d139mr34201423ywh.278.1548944568012;
        Thu, 31 Jan 2019 06:22:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:b53a])
        by smtp.gmail.com with ESMTPSA id 136sm1693010ywm.28.2019.01.31.06.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 06:22:46 -0800 (PST)
Date:   Thu, 31 Jan 2019 06:22:44 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 5/5] kernfs: initialize security of newly created nodes
Message-ID: <20190131142244.GB50184@devbig004.ftw2.facebook.com>
References: <20190130114150.27807-1-omosnace@redhat.com>
 <20190130114150.27807-6-omosnace@redhat.com>
 <20190130170911.GZ50184@devbig004.ftw2.facebook.com>
 <CAFqZXNt0jNg2-bNbtsCX2=7bcb_GaxCnHfSyck=GksXBTkWJ-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNt0jNg2-bNbtsCX2=7bcb_GaxCnHfSyck=GksXBTkWJ-g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Thu, Jan 31, 2019 at 11:20:57AM +0100, Ondrej Mosnacek wrote:
> Hm, I see... basically the only thing that gets allocated in
> kernfs_node_init_security() by default (at least under SELinux/ no
> LSM) is the kernfs_iattrs structures, so I assume you are pointing at
> that. I think this can be easily fixed, if we again use the assumption

Yeap.

> Technically this might make some LSMs unhappy, if they want to set
> some non-default context even if parent is all default, but this is
> already impossible now and in this case I think we have no better
> choice than sacrificing a bit of flexibility for memory efficiency,
> which is apparently critical here.
> 
> Tejun, Casey, would the above modification be fine with you?

Generally looks good but maybe it can check the attr to see whether
there actually are things which need inheritance?

Thanks.

-- 
tejun
