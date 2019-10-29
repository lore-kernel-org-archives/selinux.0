Return-Path: <SRS0=nm5n=YW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EF0CA9EAE
	for <selinux@archiver.kernel.org>; Tue, 29 Oct 2019 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DCD3208E3
	for <selinux@archiver.kernel.org>; Tue, 29 Oct 2019 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389404AbfJ2OoN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:44:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51742 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388712AbfJ2OoM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Oct 2019 10:44:12 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:3aba:f8ff:fe58:9ca1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smcv)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4617D28FC84;
        Tue, 29 Oct 2019 14:44:11 +0000 (GMT)
Date:   Tue, 29 Oct 2019 14:44:08 +0000
From:   Simon McVittie <smcv@collabora.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v10 13/25] LSM: Specify which LSM to display
Message-ID: <20191029144408.GA26815@horizon>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
 <20191024205228.6922-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024205228.6922-14-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 24 Oct 2019 at 13:52:16 -0700, Casey Schaufler wrote:
> Create a new entry "display" in /proc/.../attr for controlling
> which LSM security information is displayed for a process.

It still isn't immediately obvious to me from the commit message whether
the "..." stands for the pid of the process that will read LSM information,
or the pid of the process whose LSM information will be read.

I believe the intended meaning was the former? So perhaps

    Create a new entry "display" in /proc/$reader/attr that controls
    which LSM security information will be displayed when the process
    $reader reads LSM information.

    (Note that when $reader reads /proc/$subject/attr/current for
    $reader != $subject, it is /proc/$reader/attr/display that controls
    what is displayed there, not /proc/$subject/attr/display.)

The commit that introduces /proc/.../attr/context could probably
benefit from similar treatment - maybe it could be referred to as
/proc/$subject/attr/context?

    smcv
