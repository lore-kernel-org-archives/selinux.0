Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9E7C433C1
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3311619D5
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 09:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhCXJ64 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 05:58:56 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:14978 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233163AbhCXJ6f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Mar 2021 05:58:35 -0400
Subject: Re: [RFC PATCH userspace 0/6] Parallel setfiles/restorecon
To:     Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>
References: <20210323170830.182553-1-omosnace@redhat.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <cd8c8721-0194-e2d3-b7a5-2f00834b5f60@sony.com>
Date:   Wed, 24 Mar 2021 10:58:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323170830.182553-1-omosnace@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fqOim2wf c=1 sm=1 tr=0 a=9drRLWArJOlETflmpfiyCA==:117 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10 a=1ofRuVqaXi316pVUBy4A:9 a=QEXdDO2ut3YA:10 a=fCgQI5UlmZDRPDxm0A3o:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/23/21 6:08 PM, Ondrej Mosnacek wrote:
> This series adds basic support for parallel relabeling to the libselinux
> API and the setfiles/restorecon CLI tools. It turns out that doing the
> relabeling in parallel can significantly reduce the time even with a
> relatively simple approach.
Nice! Have you any figures? Is it valid for both solid state and mechanical storage?
> The first patch is a small cleanup that was found along the way and can
> be applied independently. Patches 2-4 are small incremental changes that
> make the internal selinux_restorecon functions more thread-safe (I kept
> them separate for ease of of review, but maybe they should be rather
> folded into the netx patch...). Patch 5 then completes the parallel
> relabeling implementation at libselinux level and adds a new function
> to the API that allows to make use of it. Finally, patch 6 adds parallel
> relabeling support to he setfiles/restorecon tools.
>
> The relevant man pages are also updated to reflect the new
> functionality.
>
> The patch descriptions contain more details, namely the last patch has
> also some benchmark numbers.
>
> Please test and review. I'm still not fully confident I got everything
> right (esp. regarding error handling), but I wanted to put this forward
> as an RFC to get some early feedback.
>
> Ondrej Mosnacek (6):
>   selinux_restorecon: simplify fl_head allocation by using calloc()
>   selinux_restorecon: protect file_spec list with a mutex
>   selinux_restorecon: introduce selinux_log_sync()
>   selinux_restorecon: add a global mutex to synchronize progress output
>   selinux_restorecon: introduce selinux_restorecon_parallel(3)
>   setfiles/restorecon: support parallel relabeling
>
>  libselinux/include/selinux/restorecon.h       |  14 +
>  libselinux/man/man3/selinux_restorecon.3      |  29 +
>  .../man/man3/selinux_restorecon_parallel.3    |   1 +
>  libselinux/src/libselinux.map                 |   5 +
>  libselinux/src/selinux_internal.h             |  14 +
>  libselinux/src/selinux_restorecon.c           | 498 ++++++++++++------
>  policycoreutils/setfiles/Makefile             |   2 +-
>  policycoreutils/setfiles/restore.c            |   7 +-
>  policycoreutils/setfiles/restore.h            |   2 +-
>  policycoreutils/setfiles/restorecon.8         |   9 +
>  policycoreutils/setfiles/setfiles.8           |   9 +
>  policycoreutils/setfiles/setfiles.c           |  28 +-
>  12 files changed, 436 insertions(+), 182 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3
>

