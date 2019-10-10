Return-Path: <SRS0=2qaZ=YD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA62ECE58C
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 02:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CF72190F
	for <selinux@archiver.kernel.org>; Thu, 10 Oct 2019 02:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbfJJCpH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:45:07 -0400
Received: from namei.org ([65.99.196.166]:53422 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbfJJCpG (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 9 Oct 2019 22:45:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x9A2i0Zt009033;
        Thu, 10 Oct 2019 02:44:00 GMT
Date:   Thu, 10 Oct 2019 13:44:00 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, rostedt@goodmis.org,
        primiano@google.com, rsavitski@google.com, jeffv@google.com,
        kernel-team@android.com, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Namhyung Kim <namhyung@kernel.org>, selinux@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH RFC] perf_event: Add support for LSM and SELinux checks
In-Reply-To: <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1910101343470.8343@namei.org>
References: <20191009203657.6070-1-joel@joelfernandes.org> <710c5bc0-deca-2649-8351-678e177214e9@schaufler-ca.com> <alpine.LRH.2.21.1910100912210.29840@namei.org> <2b94802d-12ea-4f2d-bb65-eda3b3542bb2@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 9 Oct 2019, Casey Schaufler wrote:

> On 10/9/2019 3:14 PM, James Morris wrote:
> > On Wed, 9 Oct 2019, Casey Schaufler wrote:
> >
> >> Please consider making the perf_alloc security blob maintained
> >> by the infrastructure rather than the individual modules. This
> >> will save it having to be changed later.
> > Is anyone planning on using this with full stacking?
> >
> > If not, we don't need the extra code & complexity. Stacking should only 
> > cover what's concretely required by in-tree users.
> 
> I don't believe it's any simpler for SELinux to do the allocation
> than for the infrastructure to do it. I don't see anyone's head
> exploding over the existing infrastructure allocation of blobs.
> We're likely to want it at some point, so why not avoid the hassle
> and delay by doing it the "new" way up front?

Because it is not necessary.

-- 
James Morris
<jmorris@namei.org>

