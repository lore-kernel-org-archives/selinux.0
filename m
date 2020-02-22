Return-Path: <SRS0=hfZQ=4K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C1C35666
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 21:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B93120707
	for <selinux@archiver.kernel.org>; Sat, 22 Feb 2020 21:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SFxN8Jib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgBVVds (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Feb 2020 16:33:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44099 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgBVVds (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Feb 2020 16:33:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id g19so6981790eds.11
        for <selinux@vger.kernel.org>; Sat, 22 Feb 2020 13:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5AaB/5Rxid4xbRiER0IWBTV/tQmyXidioy8cpSd3kM=;
        b=SFxN8Jib/Y1+nBhZ1eHW+3RwldBZt1gcRrgF1kwE/YrXX4/Pj5z7m9yocoqay9Ip1t
         NvAT3g1vEVkR0GUReC6P4PoZQH6LzydU2Q8VL7p4FZD3hHMWAVoYzfUATG7adkCDkENM
         34fHrkyo2BudlUC3Qn+1eiaDfLZmexz999Qpv6AUyQpbHRWp5ibixJAjFUe0FBYmXswO
         sYgwzkIbjMHv+hIT8Mfckxqi7MxwRcbbPp1wy+Vz+9+HHELDdMnspalFbek9H/JYuJcz
         7Jp83StmOamXbz2OxXOabZWCAaIdDRU9hP2WqYys5udtDTRJbWxTKepgdZunlZxAWnm5
         CCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5AaB/5Rxid4xbRiER0IWBTV/tQmyXidioy8cpSd3kM=;
        b=Q1CmYLxZ4b/0VLRxdJR/p7RGlogvD0LZXMCjmgSLJVdb9/hAeaVxX2TiH1pQE0BuZT
         y21NKvZqu8276S0ey99XIbLWv0UJ5rITafhzQrTob8p10gKNHFvSjTL287518DiL0MBx
         gz7geOIFn5d2AlMWL91Zxd7zYujA6Q9452g5RlEXrYKeJiZ+Ocbgo9aGsdLu2WWGnVZo
         yMIiTMStqJruF4YwV2U+ZmdUunRoFphsakQFcqL3oQqVcY+H3EOzeWPPIS+IPqVbm0aL
         dlKfl/MgnUmvoHn17Zbl0zeZAwbf+h9jnHNXLwEpUyN0PdJDGNdGOWOQaKDgY2XnY8Kn
         f68A==
X-Gm-Message-State: APjAAAVtPRiUFZIgH6ItGVbBnuvhNUBf+PSY9jzT3X+QWTRAHZpfA0Qt
        lHbUwNA0RIOXgDepc+bHrD9x4DdA/v9z5QUYrV5Y9PXv3zZ8
X-Google-Smtp-Source: APXvYqwz2xjkWe28PLhjs1c5+xlwyMgz2ZHIqhA+456jHvVDDqkdUft0tPT8UKibrE964FFTudOgryBQvB7YKit9vyA=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr38578069edr.164.1582407225167;
 Sat, 22 Feb 2020 13:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20200129164256.3190-1-sds@tycho.nsa.gov> <CAFqZXNsk_fyPuLDz-jtjtjzJR5rZmBAKgFzPk3Z0y35ahyaeRw@mail.gmail.com>
 <f9f12adf-51b1-3ba5-fef2-f290b69d974e@tycho.nsa.gov>
In-Reply-To: <f9f12adf-51b1-3ba5-fef2-f290b69d974e@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 22 Feb 2020 16:33:34 -0500
Message-ID: <CAHC9VhQ8W4id4_v+YN9qXwzp-baa+57bcaqm3vSkZ4QaxkKVQg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve handling
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 14, 2020 at 8:22 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/14/20 7:46 AM, Ondrej Mosnacek wrote:
> > On Wed, Jan 29, 2020 at 5:42 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> Fully decoupling the policy and kernel initial SID values will
> >> require introducing a mapping between them and dyhamically
> >
> > Nit: s/dyhamically/dynamically/
>
> Ah, thanks; will fix if I need to re-spin.

Normally this would fall under the category of something I could
fix-up during a merge, but I think there are a few changes, mostly
documentation, that we should add to this patch.

First off, I know MLS is the policy everyone wants to forget, but it
*is* used so let's not cause them any more pain then they are already
feeling.  That should add a few initial SIDs back into the list, but I
think it still frees up plenty.

Second, when we load the initial SIDs, in policydb_load_isids(), you
show an error if one of these isid's is assigned a context:

+ if (sid == SECSID_NULL) {
+   pr_err("SELinux:  SID null was assigned a context.\n");

... I would suggest that we also display the SID number like below so
that policy devs have a better idea of which isid is causing the
problem:

+ if (sid == SECSID_NULL) {
+   pr_err("SELinux:  SID null(%u) was assigned a context.\n", sid);

Lastly, and most importantly, there is a lot of good discussion,
including a "roadmap" in the GH issue, let's try to capture that in
this patch description (maybe minus your retirement plans Stephen
<g>).  I have no idea where GH may be in a few years, but the git log
is FOREVER ;)

-- 
paul moore
www.paul-moore.com
