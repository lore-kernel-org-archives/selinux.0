Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D3C4332F
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 17:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiKWRWH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 12:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiKWRVw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 12:21:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8873B8E
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 09:21:50 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so2677571pjs.5
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CDIhkLpaEhOrndeRMcT6oBAEna9EiAVCKKFkhQssZk=;
        b=lFrgzW6CO+Kzpc8MumJWmvNtmRK37WjPd2QsRbdhPjxEO9DT37CPHKYB19L+uevXiM
         AS+ErFE9Vlgg74WsWDLkOEy4AgQDmjJdd23ygVUWifopc0T+bwb5R8Q4a8hAcsqBsPQw
         39Us67f6MudsZdhjNR7l1URXeNafYHDAMqlu5DNGCXF80JCYwCvExB27+q0tdwFcFd7j
         ub5BK8qsKC4dUMc+nYq5q8y1MrLqgQMuwUsgQXDp3IQevXkAUL+nGxBbyXY1exkZp0CA
         zFDit79T6cinGmsllJLdO0Dq/Ez/pI5Ln2/cXbaaHwTjkV2Kc8gsRvE7OZj0P2B31tNm
         47Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CDIhkLpaEhOrndeRMcT6oBAEna9EiAVCKKFkhQssZk=;
        b=DJjERAD2lcqQRGh22nOzgoXUhq63xWMA8Es+Wy/DWgzPyvebyD/BriC7T2WxQPAeK5
         kg33YNHVOYE/AIO25vtkFwlAASv+mJmPamkg0coAnmQVsG9cp4x53iitzg2RiZbXvkCk
         qmQLrjnCBA1BEjh0eylcKy6IG6k2zv/YMfvEnfCDR5LVg9HNwcV/TkdidSU7aQDCQGO7
         FrmTVBP1aLqNNk3GmZtJxUCSBD5XzCw1JHw6dE2ZvC/oOWY3Klq3jQGl4raNFBWdXF1U
         FhCrS0w1/ka77eN2X9BMjc7pCMtkQM0yrd8vHTQm6Gz3IffJ/qJlbP9sp8qgL+cx5GVu
         hu4A==
X-Gm-Message-State: ANoB5pk92wJO6bDKWvTKjr2Oa8uYIdCywdsGqHXQ5vUve0OKFDP1nBYV
        KHkSXGwCK59qrQZXYqGFTANn74RBQPPaF+blIkS3PgfX0g==
X-Google-Smtp-Source: AA0mqf6B97DxKk0ieg2CMK047rVZbvRie6TxJaBP0+UKB3gQKTzKrc5TtFXtF8vJgo3cj3wck1cmKleAAnX9Y7LW2sY=
X-Received: by 2002:a17:902:9892:b0:186:c3b2:56d1 with SMTP id
 s18-20020a170902989200b00186c3b256d1mr10718671plp.15.1669224110195; Wed, 23
 Nov 2022 09:21:50 -0800 (PST)
MIME-Version: 1.0
References: <90976d10374046f198e6777609554b23@quicinc.com> <0fad7bb5f511433ca59140a813e2d200@quicinc.com>
 <CAHC9VhRdj7irdtsFktGHT4rvUJhiHrs0g+K2mpyKtmZjLE8K1w@mail.gmail.com> <10b9088cc8d442008e4972ad0c828329@quicinc.com>
In-Reply-To: <10b9088cc8d442008e4972ad0c828329@quicinc.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Nov 2022 12:21:39 -0500
Message-ID: <CAHC9VhT-GnmsQTeR7tZUO0W1bz4jM8vYffPW15wv3Hs6+s6RPQ@mail.gmail.com>
Subject: Re: Kernel Panic while accessing avtab_search_node
To:     "Jaihind Yadav (QUIC)" <quic_jaihindy@quicinc.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 23, 2022 at 7:52 AM Jaihind Yadav (QUIC)
<quic_jaihindy@quicinc.com> wrote:
> Hi Paul Moore Sir,
>
> Thanks  for quick response .
> Please find the additional information below.
> We are using 5.15 kernel in Android T.
> We have not applied any additional  patch to the kernel .
>
> I am replying on the same thread again because in that email I attached call stack frame with locals  images to explain the issue better after loading the dump in t32,
> but It converted the images in base32 due to plain text format and made it unreadable . Sorry for inconvenience caused.
>
> Please let me know if more information is needed .

Hi Jaihind,

Thanks for the additional information.  Unfortunately Android has been
known to carry a large number of kernel patches in their kernels so I
would suggest contacting the Android team for additional help on
resolving this issue.  If you can reproduce this problem with a plain
upstream kernel we may be able to help, but I don't recall seeing
anything similar in any of our upstream kernel use/testing.

Good luck,
-Paul

> -----Original Message-----
> From: Paul Moore <paul@paul-moore.com>
> Sent: Tuesday, November 22, 2022 11:53 PM
> To: Jaihind Yadav (QUIC) <quic_jaihindy@quicinc.com>
> Cc: selinux@vger.kernel.org
> Subject: Re: Kernel Panic while accessing avtab_search_node
>
> On Tue, Nov 22, 2022 at 6:22 AM Jaihind Yadav (QUIC) <quic_jaihindy@quicinc.com> wrote:
> > Hi Selinux team,
> >
> > We are getting kernel panic due to invalid memory access from avtab_search_node @231.
> >
> > 165.187593][T21313] Unable to handle kernel access to user memory
> > outside uaccess routines at virtual address 0000000081000000 [
> > 165.265699][T22438] pc : avtab_search_node+0xe4/0x138 [
> > 165.265710][T22438] lr : context_struct_compute_av+0x260/0x908
> > [  165.265715][T22438] sp : ffffffc0330a3920 [  165.265717][T22438]
> > x29: ffffffc0330a3a20 x28: ffffff804097ea40 x27: 0000000000000360 [
> > 165.265725][T22438] x26: ffffff803acab190 x25: ffffff803acab138 x24:
> > ffffffc0330a3b60 [  165.265732][T22438] x23: ffffff804097ea40 x22:
> > ffffffc0330a3b48 x21: 0000000000000361 [  165.265739][T22438] x20:
> > 0000000000000360 x19: ffffff80409d3608 x18: ffffffc02ba1d070 [
> > 165.265746][T22438] x17: 000000008f58b13b x16: 000000005bbbfbe1 x15:
> > 00000000e6546b64 [  165.265753][T22438] x14: 000000001b873593 x13:
> > 0000000058a5459e x12: 0000000000000061 [  165.265760][T22438] x11:
> > 0000000000000707 x10: 0000000000000361 x9 : 0000000000000361 [
> > 165.265767][T22438] x8 : 0000000000000002 x7 : 0000000000000000 x6 :
> > ffffffc0330a39ac [  165.265773][T22438] x5 : ffffffc0330a3b60 x4 : ffffffc0330a3b48 x3 : ffffffc0330a3b60 [  165.265780][T22438] x2 : ffffffc0330a3b48 x1 : ffffffc0330a3960 x0 : 0000000081000000 [  165.265787][T22438] Call trace:
> > [  165.265789][T22438]  avtab_search_node+0xe4/0x138 [
> > 165.265793][T22438]  security_compute_av+0x18c/0x3f4 [
> > 165.265798][T22438]  avc_compute_av+0x84/0xe4 [  165.265804][T22438]
> > avc_has_perm+0x188/0x1f4 [  165.265808][T22438]
> > selinux_task_alloc+0x48/0x58 [  165.265812][T22438]
> > security_task_alloc+0x84/0x150 [  165.265816][T22438]
> > copy_process+0x51c/0xe98 [  165.265823][T22438]
> > kernel_clone+0xb8/0x684 [  165.265827][T22438]
> > __arm64_sys_clone+0x5c/0x8c [  165.265831][T22438]
> > invoke_syscall+0x60/0x150 [  165.265836][T22438]
> > el0_svc_common+0x98/0x114 [  165.265840][T22438]  do_el0_svc+0x28/0xa0
> > [  165.265843][T22438]  el0_svc+0x28/0x90 [  165.265848][T22438]
> > el0t_64_sync_handler+0x88/0xec [  165.265852][T22438]
> > el0t_64_sync+0x1b4/0x1b8 [  165.265858][T22438] Code: f86bd980
> > b4000260 79400c2b 1200396b (7940000c) [  165.265862][T22438] ---[ end
> > trace 78d0a75f861b1c77 ]---
> >
> > Kernel panic is coming while accessing cur @231 line from below code snippet.
> >
> > 218 struct avtab_node *avtab_search_node(struct avtab *h,
> > 219                                                             const struct avtab_key *key)
> > 220 {
> > 221        int hvalue;
> > 222        struct avtab_node *cur;
> > 223        u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
> > 224
> > 225        if (!h || !h->nslot)
> > 226                        return NULL;
> > 227
> > 228        hvalue = avtab_hash(key, h->mask);
> > 229        for (cur = h->htable[hvalue]; cur;
> > 230             cur = cur->next) {
> > 231                        if (key->source_type == cur->key.source_type &&
> > 232                            key->target_type == cur->key.target_type &&
> > 233                            key->target_class == cur->key.target_class &&
> > 234                            (specified & cur->key.specified))
> > 235                                        return cur;
> >
> > In the above code null check are properly handled So I am suspecting the hashtable is getting modified by other thread/process when it is accessing the code.
> >
> > Can you please provide your expert opinion what could be the issue here and how to fix this issue .
>
> Hi Jaihind,
>
> We need some additional information to help understand the problem.
> What Linux distribution are you using?  What kernel are you using (version number), and do you have any patches applied to that kernel?
> What SELinux policy are you using?

-- 
paul-moore.com
