Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13659C282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 11:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D4420882
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 11:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfA1LF4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 06:05:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfA1LFz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 28 Jan 2019 06:05:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA6692D7E9
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 11:05:54 +0000 (UTC)
Received: from workstation (unknown [10.40.205.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E8BC17DDB
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 11:05:53 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     <selinux@vger.kernel.org>
Subject: Re: [GitHub PR #118] Add russian translations for man pages
References: <pjdzhrqtj2d.fsf@redhat.com>
Date:   Mon, 28 Jan 2019 12:05:52 +0100
In-Reply-To: <pjdzhrqtj2d.fsf@redhat.com> (Petr Lautrbach's message of "Thu,
        24 Jan 2019 12:02:18 +0100")
Message-ID: <pjd8sz5t52n.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 28 Jan 2019 11:05:54 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> There's a github PR - 
> https://github.com/SELinuxProject/selinux/pull/118
>

Merged.


> ---
> From: Aleksei Nikiforov <darktemplar@basealt.ru>
> Date: Tue, 25 Dec 2018 18:25:27 +0300
> Subject: [PATCH 1/2] Add man pages translation by Olesya Gerasimenko
>
> Signed-off-by: Olesya Gerasimenko <gammaray@basealt.ru>
> Signed-off-by: Aleksei Nikiforov <darktemplar@basealt.ru>
> ---
>
> From: Aleksei Nikiforov <darktemplar@basealt.ru>
> Date: Tue, 25 Dec 2018 18:25:05 +0300
> Subject: [PATCH 2/2] Allow installing translated man pages
>
> Signed-off-by: Aleksei Nikiforov <darktemplar@basealt.ru>
> ---
>
> Dominick Grift did a review using google translate and it's going to be merged
> in 2 days if there's no other objection.
>
> Petr
