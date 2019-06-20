Return-Path: <SRS0=BfFT=UT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB4C43613
	for <selinux@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE492083B
	for <selinux@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYfI+7Se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFTRZl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:25:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44890 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbfFTRZc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jun 2019 13:25:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so1911610pgp.11
        for <selinux@vger.kernel.org>; Thu, 20 Jun 2019 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FeK+nLArey4tfBc6iMdmQYlLriZPZ+YeTBb4vv7Yha8=;
        b=TYfI+7SeXp7cHo8lNldWo5BCTONFWWLyFs24BWkZUqahiMMLt/fB89ov2dj08ZFGCL
         +7DGWfZ+UeX9S41IJPHyeq4r/RUt4kA8OV+F5XNnq/ymAiDXwFtEUEQYv00iJKfbhTo5
         8+RBY4bMBGGLASnreup2VT6SVkuSzHV0Br97U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FeK+nLArey4tfBc6iMdmQYlLriZPZ+YeTBb4vv7Yha8=;
        b=Rjbp+9UMwnFwzBUIj7gya+O+HLxOYyJYnb9jw2Ddy0qk0wOrE7FTydNlj5lXdWpyO6
         q2PfMxrmeDzYV9BB3c4tDAYlznoGcE3cPAkWcxt8h2wD2Q+E/K8k+85p6a1yef0BWK41
         LUj3T2UhqqD1njvZTst5w7h9e0n0c5hNWKQpqDa/10RlaTdxEjSG5Z3RbFxYQrCIN4gY
         4rMkMspzwfchoK3OnAmIej4u8eoBhgrhW1V0a96nDjbX5xn3FwhKkAIzvL8ZQJDy806e
         FNnyVaQykfgOSdRzoTGrG/mO3JLtkLKy0NPTT7TC5wK4j6sehi0a6J6Zc8sd7wvDDN0q
         b/yA==
X-Gm-Message-State: APjAAAWLo3M50Ad34omk5tUtIdFGD3u+cprLlo8r+tNKMcRClEIgllIZ
        SlOoQvB7pclWCe+y2d2qfAKZrMC4Y/w=
X-Google-Smtp-Source: APXvYqxHPYIUFtNR2r7v3ZEED9Y1rHrLpjpj7qih/o54cvgcyyoub60irZ9yFSf5ccbr7qUHIzInlw==
X-Received: by 2002:a63:445b:: with SMTP id t27mr13770852pgk.56.1561051531529;
        Thu, 20 Jun 2019 10:25:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm85264pfo.19.2019.06.20.10.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:25:30 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:25:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 18/25] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <201906201024.C5936F66C@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-19-casey@schaufler-ca.com>
 <201906182238.4EBF8C17DB@keescook>
 <063644f9-be64-175e-0bf2-cfa1afadc3d7@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063644f9-be64-175e-0bf2-cfa1afadc3d7@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 19, 2019 at 10:31:45AM -0700, Casey Schaufler wrote:
> On 6/18/2019 10:41 PM, Kees Cook wrote:
> > I think this is wrong: for NUL-terminated strings, "context.len" isn't
> > currently including the NUL byte (it's set to strlen()).
> >
> > So, if kmemdup() is used here, it means strlen() isn't correct in the
> > context init helper, it should be using the "size" argument, etc.
> 
> Would all be true if the context where being set by lsmcontext_init,
> but it's not. It's coming from the dentry_init_security hook, and
> the one instance of that, selinux_dentry_init_security() sets the
> size to strlen() + 1. The kmemdup() will include the terminating NUL.

Ah-ha! Okay, thanks, yes. I see now. Carry on! :)

> I too wish that the hooks and their use where more consistent.
> My sincere hope is that this revision of the infrastructure will
> help that to some extent.

Once these changes land it should be much much easier to find ways to
refactor for greater sanity. :)

> > Should label be set to NULL here and len reduced to 0?
> 
> It wasn't before, and I'd hate to make too many assumptions
> about what might be fragile in the NFS code.

Gotcha.

-- 
Kees Cook
