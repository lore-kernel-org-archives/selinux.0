Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F4C4363C
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CD120739
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 15:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgJHPt1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:49:27 -0400
Received: from namei.org ([65.99.196.166]:33834 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbgJHPtX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 8 Oct 2020 11:49:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 098Fm0VN010198;
        Thu, 8 Oct 2020 15:48:00 GMT
Date:   Fri, 9 Oct 2020 02:48:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
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
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v9 0/3] SELinux support for anonymous inodes and UFFD
In-Reply-To: <CA+EESO4eS4KsqgjmDWdwMozK36GbgTvJsKsC_5NO-pQA3huDWg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2010090243400.9736@namei.org>
References: <20200923193324.3090160-1-lokeshgidra@google.com> <CA+EESO4eS4KsqgjmDWdwMozK36GbgTvJsKsC_5NO-pQA3huDWg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 7 Oct 2020, Lokesh Gidra wrote:

>  Is there anything else that needs to be done before merging this
> patch series? I urge the reviewers to please take a look.
> 

It looks generally fine to me from a security POV, we really need some 
feedback from VFS folk.


-- 
James Morris
<jmorris@namei.org>

