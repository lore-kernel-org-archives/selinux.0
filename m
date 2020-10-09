Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE925C43457
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 04:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5266220732
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 04:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602219144;
	bh=AWh7jy1elBn6ER7r6NPZnVFUCbofZZculIjGmS2y/T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pjKeezGfeCkIyeUuYe9QgUjV/poWT9qJzNAMXcspH/Crg3HJnH7DofeaRqEKQxSw5
	 Ko9MuW9/BjFLNmcodgxwKUEFy5jHrADm9VmlnAroAPGnrziq1YB+21ceUYln1Fi9O/
	 EU9dLo24YOUIyzAEZ/0GP59xwrALiHr1NS9NqX+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgJIEwU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 00:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJIEwU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 9 Oct 2020 00:52:20 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272422223C;
        Fri,  9 Oct 2020 04:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602219139;
        bh=AWh7jy1elBn6ER7r6NPZnVFUCbofZZculIjGmS2y/T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHbaO0oIKVf2TvFT7sliAuYrSoqtno4MGVizzxp9cdJkQLYiSN/sEt81NcsnisBfX
         M00Gfrhg2rqp2QbpOSjIBwJXhaNy/jD1nzwKDYFKuBAULaR9BvrRD22nQ5zNrUAjym
         mvVz7ywUx2v2DR9qf5GUyPDD8774pBQ03ZiMrB+4=
Date:   Thu, 8 Oct 2020 21:52:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v9 3/3] Wire UFFD up to SELinux
Message-ID: <20201009045217.GD854@sol.localdomain>
References: <20200923193324.3090160-1-lokeshgidra@google.com>
 <20200923193324.3090160-4-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923193324.3090160-4-lokeshgidra@google.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 23, 2020 at 12:33:24PM -0700, Lokesh Gidra wrote:
>
> [PATCH v9 3/3] Wire UFFD up to SELinux

Seems that this isn't a very good description of the patch, since it isn't
SELinux-specific?

- Eric
