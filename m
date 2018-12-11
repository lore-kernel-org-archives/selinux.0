Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E22AC07E85
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 10:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050012082F
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 10:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050012082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLKKmY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:42:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbeLKKmY (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 11 Dec 2018 05:42:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17646368E7;
        Tue, 11 Dec 2018 10:42:24 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-82.ams2.redhat.com [10.36.116.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16E61608F7;
        Tue, 11 Dec 2018 10:42:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Security modules and sending signals within the same process
References: <87lg5asilo.fsf@oldenburg.str.redhat.com>
        <e754fa24-899b-f77e-f226-0f070ebad132@tycho.nsa.gov>
Date:   Tue, 11 Dec 2018 11:42:20 +0100
In-Reply-To: <e754fa24-899b-f77e-f226-0f070ebad132@tycho.nsa.gov> (Stephen
        Smalley's message of "Fri, 30 Nov 2018 11:02:15 -0500")
Message-ID: <87d0q8z6nn.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 11 Dec 2018 10:42:24 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Stephen Smalley:

> Looks like commit 065add3941bd ("signals: check_kill_permission():
> don't check creds if same_thread_group()") skipped the uid-based
> checks if the sender and target were in the same thread group, but not
> the security hook call.  One could argue that the security hook call
> ought to be skipped in that case as well using the same rationale
> given in that commit.  Nothing appears to guarantee the property you
> state above for security_task_kill implementations, although none of
> the in-tree users are based on uids or gids so setresuid/setresgid
> shouldn't affect them.

Okay, thanks, so it looks like I don't have to do anything special to
support thread cancellation.

Florian
