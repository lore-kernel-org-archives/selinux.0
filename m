Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BEFC001DF
	for <selinux@archiver.kernel.org>; Thu,  3 Aug 2023 23:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjHCXUw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Aug 2023 19:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHCXUv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Aug 2023 19:20:51 -0400
Received: from out-100.mta0.migadu.com (out-100.mta0.migadu.com [91.218.175.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F82E12B;
        Thu,  3 Aug 2023 16:20:50 -0700 (PDT)
Message-ID: <b201f66c-9588-a234-f5c9-892ec421c93d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691104848; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5F7GF8sJENfzg5tPE4ksqW1Gvi/kE7aeGP7cD2s9CwQ=;
        b=aX3o94De9+NKcU1rdxpRzj1Osng+xGpXSc163vnpFQdXs2TR+qLUiZLYYvrFdiTmTQ1AiF
        IQizslfbptnH6HhnTs/PEvB2WPcnc8KqA8LRzwZSJACyRNPs5p911rUnjRU7OrFlnoziBa
        BLHnXlSGfolTq1qT+ASfB7R8rerws0g=
Date:   Thu, 3 Aug 2023 16:20:37 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v9 2/4] selftests/bpf: Use random netns name for
 mptcp
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691069778.git.geliang.tang@suse.com>
 <54307a065383fd3171a6306ddf30395b686aaccc.1691069778.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <54307a065383fd3171a6306ddf30395b686aaccc.1691069778.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



On 8/3/23 6:41 AM, Geliang Tang wrote:
> Use rand() to generate a random netns name instead of using the fixed
> name "mptcp_ns" for every test.
> 
> By doing that, we can re-launch the test even if there was an issue
> removing the previous netns or if by accident, a netns with this generic
> name already existed on the system.
> 
> Note that using a different name each will also help adding more
> subtests in future commits.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Yonghong Song <yonghong.song@linux.dev>
