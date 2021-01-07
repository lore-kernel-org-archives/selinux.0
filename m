Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58459C433DB
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 03:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E2E221E9
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 03:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbhAGDGf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 22:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbhAGDGf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 22:06:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D7C0612EF
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 19:05:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t16so7716916ejf.13
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 19:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSUsWf76Ym0VoANrRHrfG8/N3sNNdbLhBCzibzDQLgQ=;
        b=jzcK6Cm4FLAHY6hu7Ywcx91MTihZUhUT4alDFfGGpy2OI2jruYUMwtMsV2Wc1QvBVj
         +VdUrk1WN+XglSmpIKB92NTYYak68JExk3D9+huWoZ/eBfo0xv3wRVyOwuJzzCXE4r9f
         eJ8IZCIwG+aTnvZ5+cwzVFMxJ/HDFPDnJhx7Q9qc/+HZY+3VsGbXWM0SvVaYUrWY1Mjy
         l3AyzVVBTEwKS78Oiebo2664+u+voD6vBdkl18mgx9ZfdDseA9Sbqs+ix8ZAMrtWkrub
         Ws8bQQ9E3w37PTz+GDe01/zjrtwfGQTvYyyCeVloOJl/678G9+5Orx6vwAvamNRpBAMP
         Ho8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSUsWf76Ym0VoANrRHrfG8/N3sNNdbLhBCzibzDQLgQ=;
        b=KlbTRHdLyivlU+J+7ppJtxtvxt3le1h8Y7t+AplFy2GrgcnLKcc181F6j3sz18kmVJ
         O9tq0ajuWEz27hKsHlTvMk9xNiTiiz69njZqezvOM1HSpq98aHX5jcqbnTy7gOvmgVmy
         6JE1C73W8CBne1bzX14yA+EjIYnhKvTknw1neW5Ft9PXCK74zPDM41srQyqnwvR/I2yn
         7NztBiZaJ/9CNKEtvCTxRaAore4sTC4bsznkZYX2X4UVrqlgojqdAJgxUaOtBWvYwI3L
         gh2D9fiKE4FgcOtsXGeH7RdPVb7p8dM+UVurVTyVUYLVEEN7s0fa4pxB2qWZiloJEJAz
         fTBw==
X-Gm-Message-State: AOAM532saSpqCtvOBFAhZxp9dn0kcL2xhnKr24GGCzFQdsOasci5DXjX
        8akZFdZj38+8XYfQfWcls6MjUxCSief0aYkrwMSt
X-Google-Smtp-Source: ABdhPJzgjmqgSpNil4HfGt5R7VIJWNzi+EIBFt1ZTPt5Iiqemj9MXy/gnGidF9P6nTkpbXAI3b6IhBo/OGNCSFMHEGY=
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr5049512ejc.178.1609988747833;
 Wed, 06 Jan 2021 19:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-3-lokeshgidra@google.com> <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
 <f7dfe33a4d0f9c27f3e25f72a988201a@dancol.org>
In-Reply-To: <f7dfe33a4d0f9c27f3e25f72a988201a@dancol.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Jan 2021 22:05:36 -0500
Message-ID: <CAHC9VhQhvqtfF0m3BgObjQaT7WSLfqT8v0SJsKiTxfF0GxQU7g@mail.gmail.com>
Subject: Re: [PATCH v13 2/4] fs: add LSM-supporting anon-inode interface
To:     dancol <dancol@dancol.org>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 6, 2021 at 9:42 PM dancol <dancol@dancol.org> wrote:
>
> On 2021-01-06 21:09, Paul Moore wrote:
> > Is it necessary to pass both the context_inode pointer and the secure
> > boolean?  It seems like if context_inode is non-NULL then one could
> > assume that a secure anonymous inode was requested; is there ever
> > going to be a case where this is not true?
>
> The converse isn't true though: it makes sense to ask for a secure inode
> with a NULL context inode.

Having looked at patch 3/4 and 4/4 I just realized that and was coming
back to update my comments :)

-- 
paul moore
www.paul-moore.com
