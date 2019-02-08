Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FEAC282C2
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 02:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08320869
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 02:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="R3GJZdzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBHCac (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:30:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44535 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBHCac (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Feb 2019 21:30:32 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so1643351lji.11
        for <selinux@vger.kernel.org>; Thu, 07 Feb 2019 18:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01LhTx0fUTG92aTYXeA9cBEGqewzlSLLIiArylpo9Tk=;
        b=R3GJZdzkUbOY8ESsa9AOvJ8nGBHlCUN+oGeiNgB0vxvuOB1Dc1771hLyTeDZcBICSA
         iyltbeaj+GmmwNvCZ6hYYcxmvPq2UwQwJuLuo9uoPAsFxO8PhOkQ2QnmaGf0oD/yd0jH
         yBcbXjzbzhX4LNpRldDx5koIscqqH9LqzaL9NFOAbSiYaJzCTcJUypREOPmVnLIZxhxB
         ABqxIRwZ9ATJv5q/CyYRM75WdI77Jx3ys6cKpssmo31UCNG+7e/9NGjkrpWbmGBbg14b
         tC+pQc37cLjUaKFB2/ucM/DVWQa6XkkI/wMCM/dYW6NkW1SBHY1gsoqh61gHnic7xc3C
         2Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01LhTx0fUTG92aTYXeA9cBEGqewzlSLLIiArylpo9Tk=;
        b=REz9j+drj/r+OJfaDC+75O7qEoYVGW4Ps+LotQvafSidcRPkgmk0mBOfmnrnofYvpp
         KzUbdDP3Rv+l7ErFz+TDCCcFAaQkHDxTKyAe7PBjvkEhH4KriF8XfvPTo5NIbb7j8amm
         9/uis8s9nYKA2RzxAXAmztEptZsV005nRvVQeM2tuXf8b2S6V3MEVYegu5LLgqcXDh1j
         zlBbvG1RyUIYBYr8/o+sCry/Ue9gQSVhjpPk/HMs309FdWSViT147z7RpujxV0ES9Zj/
         LrfxhcSJBui4nmZJbRj+RTeZco9P0RmbvIaeT+y0jDO/gkzoqPTB/EVq/Ffo6WhtbZey
         VGNw==
X-Gm-Message-State: AHQUAuYfzY4Pvb5MI9FGK4nyEzbvCyg7Mo4nFgXUofa8eR0tnkYaPYyR
        S7v/rYv8+wuy+zBxDJQw8UaAJZ7pq7VeaI8Ysq84
X-Google-Smtp-Source: AHgI3IbCMg87g7g1qa7Fq7xV+10YbEZpc2zcXHBxtSSqL7R3al3XdsulClswfbE5nncw7hGUCkuq1g45ec3ktwOrLeE=
X-Received: by 2002:a2e:9586:: with SMTP id w6-v6mr8581043ljh.5.1549593030355;
 Thu, 07 Feb 2019 18:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20190206041747.11377-1-william@wkennington.com>
 <cebc12f0-5fb0-218c-331a-a785e2eece70@tycho.nsa.gov> <3cee3c78-348f-1b10-b687-9d1ab5837716@tycho.nsa.gov>
In-Reply-To: <3cee3c78-348f-1b10-b687-9d1ab5837716@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 Feb 2019 21:30:18 -0500
Message-ID: <CAHC9VhR6p8L1Pd_u37Rhh0jhD2zyrgWsJuqXKjyLCt+XHRrLMg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix classmap for BPF
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     "William A. Kennington III" <william@wkennington.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 6, 2019 at 9:33 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 2/6/19 9:04 AM, Stephen Smalley wrote:
> > On 2/5/19 11:17 PM, William A. Kennington III wrote:
> >> Entries in the secclass_map are expexted to be null terminated. The BPF
> >> entry was added without the NULL terminating and incosistent formatting.
> >> This patch cleans that up.
> >
> > Thanks.  A few minor nits:
> >
> > A couple of spelling errors above (expected, inconsistent).  Also, per
> > Documentation/process/submitting-patches.rst, rather than say "This
> > patch cleans that up", say "Clean that up" or similar.
> >
> > Can add a:
> > Fixes:  ec27c3568a34c7f ("selinux: bpf: Add selinux check for eBPF
> > syscall operations")
>
> Although I guess there isn't really a bug here; this is just a
> consistency / style issue.  secclass_map[] is defined as:
>
> struct security_class_mapping {
>          const char *name;
>          const char *perms[sizeof(u32) * 8 + 1];
> };
>
> struct security_class_mapping secclass_map[];
>
> So even if you were to omit the terminating NULL from each permission
> list, any remaining slots in the perms array should be initialized to
> NULL automatically.  We only truly need the explicit NULL terminator to
> end the class list.

To clarify this William, if you can make the changes that Stephen
suggested I think this is still a worthwhile patch, even if it doesn't
really fix a bug in the code.  I would add some comments in the patch
description indicating that this is more about consistency than fixing
an error.

-- 
paul moore
www.paul-moore.com
