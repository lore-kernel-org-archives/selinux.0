Return-Path: <SRS0=WWIK=RZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3725BC4360F
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE2121925
	for <selinux@archiver.kernel.org>; Fri, 22 Mar 2019 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bOC62TCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfCVRuV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:50:21 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:55620 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727801AbfCVRuV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Mar 2019 13:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553277020;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=iIgmAU/fmwNi3T/2GQAeg5SnVOfELTKSk9Yud2RNxkA=;
        b=bOC62TCM7G6uxAcMzaA+xU+tnbuSdATCmTtXQo6j8wnQxuRyiSrmNIhyUKo9JFTY
        SlFgTxD26wFebqplJoWTJBWgdn7/NN/ihuQsM3VsuSdOiZK3UA2D2b75/n0QWbExOut
        IbCYs+QHKy29Mvnk1COekXG0qSFVOAJCSoPueu6w=
Date:   Fri, 22 Mar 2019 17:50:20 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Waiman Long <longman@redhat.com>
cc:     Oleg Nesterov <oleg@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 2/4] signal: Make flush_sigqueue() use free_q to release
 memory
In-Reply-To: <d9e02cc4-3162-57b0-7924-9642aecb8f49@redhat.com>
Message-ID: <01000169a686689d-bc18fecd-95e1-4b3e-8cd5-dad1b1c570cc-000000@email.amazonses.com>
References: <20190321214512.11524-1-longman@redhat.com> <20190321214512.11524-3-longman@redhat.com> <20190322015208.GD19508@bombadil.infradead.org> <20190322111642.GA28876@redhat.com> <d9e02cc4-3162-57b0-7924-9642aecb8f49@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.22-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 22 Mar 2019, Waiman Long wrote:

> I am looking forward to it.

There is also alrady rcu being used in these paths. kfree_rcu() would not
be enough? It is an estalished mechanism that is mature and well
understood.

