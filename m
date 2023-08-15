Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF1C04A6A
	for <selinux@archiver.kernel.org>; Tue, 15 Aug 2023 06:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjHOGYR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Aug 2023 02:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjHOGYK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Aug 2023 02:24:10 -0400
Received: from out-66.mta1.migadu.com (out-66.mta1.migadu.com [IPv6:2001:41d0:203:375::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1017910F4
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 23:24:06 -0700 (PDT)
Message-ID: <00809f4a-e7ca-bf53-7824-e22791ee6738@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692080644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXs3mjgqnXvJbDWmMqsJFyBV4L79LKcBz77qKeWFKs0=;
        b=n5Z7aeODmFnpxRq1tq/1towSY5Vnmq8J3If4HVdOILRY9tGldVJelfEK7OflTEghT2ylaT
        FwevqkJ08/wDoAnDCisAFJIVXCpY4HjTBwvs77ikhfhubWGREzp6Yk3cZTkumhx89307Ls
        TZY9i5fhGm35TwOvttEx3Cm5S6DlzyQ=
Date:   Mon, 14 Aug 2023 23:23:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next v13 4/4] selftests/bpf: Add mptcpify test
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
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
References: <cover.1691808484.git.geliang.tang@suse.com>
 <15a618b03f65177166adf2850d4159cd4b77dfb1.1691808484.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <15a618b03f65177166adf2850d4159cd4b77dfb1.1691808484.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/11/23 7:54 PM, Geliang Tang wrote:
> +static int verify_mptcpify(int server_fd)
> +{
> +	socklen_t optlen;
> +	char cmd[256];
> +	int protocol;
> +	int err = 0;
> +
> +	optlen = sizeof(protocol);
> +	if (!ASSERT_OK(getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen),
> +		       "getsockopt(SOL_PROTOCOL)"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(protocol, IPPROTO_MPTCP, "protocol isn't MPTCP"))
> +		err++;
> +
> +	/* Output of nstat:
> +	 *
> +	 * #kernel
> +	 * MPTcpExtMPCapableSYNACKRX       1                  0.0
> +	 */
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> +		 "NR==1 {next} {print $2}", "1");

Is the mp-capable something that the regular mptcp user want to learn from a fd 
also? Does it have a simpler way like to learn this, eg. getsockopt(fd, 
SOL_MPTCP, MPTCP_xxx), instead of parsing text output?

> +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))


