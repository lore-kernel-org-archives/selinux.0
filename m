Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C715C4646C
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC42204FD
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 21:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aF2BTJOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfFXVu5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:50:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37758 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFXVu5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 17:50:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id y8so3321pgl.4
        for <selinux@vger.kernel.org>; Mon, 24 Jun 2019 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+rlxmfsfLRZdoFZraG0UuaKe6x1JTTGtjUbay1pTm4=;
        b=aF2BTJOupFLBn6E+5BkU4/RcHuBtAgMQPQ3fzl9h6emtM1WPtVr5Js2DaxVODWYbrS
         +RnD2MhJhA2Uhop6rBk5Aw2m+bWOxKUN2ASRLyroGFmefCicJjtxhjcXQEaDxSNae7U4
         slpRI9NdmrT0qaWMTrjnyO2agpR3TJT/msH54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+rlxmfsfLRZdoFZraG0UuaKe6x1JTTGtjUbay1pTm4=;
        b=nmypou39asNQ4nJexxCoR9gwtQ3/EmpOGy+unFCj8r7PPHZg2jUD6dH77RZTxMfFHJ
         l3rPMTf/9qAI60yHyw1DfxMG6ChM+A1o3IYpmxcwAWlbz6mXiQRZ+wn7FTEFGu1kAwg3
         IgHbgnmQbQejLdkPn57TFSuQdTNt39qCELRaqzvBxWhtEfYfbK/CHDJnyldmnEAu5gTr
         oQcWKQLfIkmkikpyifbdNs16WfHF+GTD9VviEyLs4/tGSLnJJC7Jk52TIuKOMB/EqC+N
         9ZqJmHnw3NGNqnBQVJMCjZfgEnm+Ht9XlJygsrA+xrXzFWGxYEz1dhwvYFTX5kRUOmr3
         v0CQ==
X-Gm-Message-State: APjAAAVp1WKerSRb4QkVBvtEsWlQd0zoNTgExsrfNhcGEpeeYkS+lV6l
        JnCoZBzzQSRZOQnzrwd9iQYT9Q==
X-Google-Smtp-Source: APXvYqyO4DtoT4TxMWaOYdauSD+wXxufja3r6Uh43fW/mthpOkBks89Qedk12HxsICsBRUdOk8OhKA==
X-Received: by 2002:a63:4f5b:: with SMTP id p27mr34468308pgl.273.1561413056207;
        Mon, 24 Jun 2019 14:50:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v185sm16624626pfb.14.2019.06.24.14.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:50:55 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:50:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v3 22/24] LSM: Return the lsmblob slot on initialization
Message-ID: <201906241443.D26B2FF07@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-23-casey@schaufler-ca.com>
 <201906221613.3443FA528B@keescook>
 <6d18ee4f-fe1b-39ae-dbe6-59ff120112c4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d18ee4f-fe1b-39ae-dbe6-59ff120112c4@canonical.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 24, 2019 at 02:39:23PM -0700, John Johansen wrote:
> On 6/22/19 4:13 PM, Kees Cook wrote:
> > On Fri, Jun 21, 2019 at 11:52:31AM -0700, Casey Schaufler wrote:
> >> Return the slot allocated to the calling LSM in the lsmblob
> >> structure. This can be used to set lsmblobs explicitly for
> >> netlabel interfaces.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > (I have some thoughts on refactoring the slot assignment, but that
> > should happen after this series -- it's nothing more than a storage
> > optimization.)
> > 
> > -Kees
> 
> haha so do I, now I am curious as to how close they align

My plan is to create a __ro_after_init "LSM State" structure to hold
various things that are needed after init time. All of the lsm_info
structures are __initdata, so they can't be retained after init
(currently). As far as I can see, there are already a few things that
are retained after init:

LSM name (currently a pointer in every hook)
enabled state (technically optional, currently known internally to each LSM)
blob size details (currently known internally to each LSM)

and now we'll be adding the "slot". So I was thinking something like:

struct lsm_state {
	const char *name;
	int enabled;
	struct blob_sizes lbs;
	int slot;
};

And then change the hooks to each carry a pointer to the lsm_state
(instead of a name pointer). Also I think it'd be cleanest to define
and export the lsm_state instance it via the DEFINE_LSM macro, possibly
instead of the existing blob_size pointer. It's possible that lsm_info
should just gain some fields and no longer be __initdata, too. We'll
see!

-- 
Kees Cook
