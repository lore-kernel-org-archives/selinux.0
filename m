Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4640EC433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 17:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B30120709
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 17:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qriz8T3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgERRGV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERRGV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 13:06:21 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA9C061A0C;
        Mon, 18 May 2020 10:06:20 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id x13so5089271qvr.2;
        Mon, 18 May 2020 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RyhOgb/8Rufgb9hiOiGCtN26x5fPOfDFAQP3o8klQ4U=;
        b=qriz8T3G0SCi/XbYeLmYI9+XDLau22Sr+OTMKnnDrWllPxaGpWVTW4D2R5+di0etUg
         bj6aFvooloTmlcv/vUpw9s56Cnht60322gM7YvjJjUpecMlrS5Gui5gVN7vQMyrbxNx+
         o5Zep9lLoAhCmV4ryY5EWEGdbhqCGnmyxnUXZmzRJ6UebMIVs0IMaKyOhD+dvzvpxA4B
         iwgv1dP72/7l4wfNkvdiwHrDzNeYOuMKm3tPEQqBuyXt2yhxMOneCJqGcSruP4vUHOhx
         HgSX/bjYhYw+ScgneJvvWRyGvyMW+rh6A5aO6x4Zvk6ofHpHumpxLLsz0z7WrRgJgBBM
         Q/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RyhOgb/8Rufgb9hiOiGCtN26x5fPOfDFAQP3o8klQ4U=;
        b=rU/f2+OpDVN7nqLEafYida2l/nfQaAf98rb2mwo0ZedfwDck9ZeGvZoDvH1fy76bLo
         gujuJazoZ5cedpP/LYIvO2YTfdmGAj82IzhfS2oez1Dhom7fwGgyyhaLxl8L6Ce/fye6
         EL5x8zF+piY3UHA3trHHRrJEso97zcqrz/eNTiF+IONSKDWe1et1KcSoMUVracbMprva
         8XdON3EDEO7TWNkyQZgoWwve9JVMDbVnCQ98ToUldFB1l+UIfUx32YOX1F5+XaI/c27w
         MmRMhpMOqlXFkOm6jhzp80gvRrkAkbR3plTpTRP0iSkyWCKtbBQJO7jAC/dKHXsyyTjk
         /CJg==
X-Gm-Message-State: AOAM532CsPpO5a7Hp36yCeUPpfGzv2TzSXr9GUokcHwd/Nd9+XnIKtdm
        0nq4izpECWa89RVCR2fka2s=
X-Google-Smtp-Source: ABdhPJx/+/t4dva0vPDpptxjOT12dpLcDawkhaEFX5xcVh32Zgr0BFUiydU8X6lQWbB1K5FnjNicSw==
X-Received: by 2002:a05:6214:1248:: with SMTP id q8mr8107875qvv.130.1589821578106;
        Mon, 18 May 2020 10:06:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id z10sm5879075qtu.22.2020.05.18.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 10:06:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2AA2E40AFD; Mon, 18 May 2020 14:06:15 -0300 (-03)
Date:   Mon, 18 May 2020 14:06:15 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] perf docs: introduce security.txt file to
 document related issues
Message-ID: <20200518170615.GL24211@kernel.org>
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
 <290ded0a-c422-3749-5180-918fed1ee30f@linux.intel.com>
 <20200518155936.GG24211@kernel.org>
 <1f6eb4c7-dec1-355c-024e-8405f4ef7f3e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6eb4c7-dec1-355c-024e-8405f4ef7f3e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Mon, May 18, 2020 at 07:50:21PM +0300, Alexey Budankov escreveu:
> 
> On 18.05.2020 18:59, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Apr 30, 2020 at 10:16:34AM +0300, Alexey Budankov escreveu:
> >>
> >> Publish instructions on how to apply LSM hooks for access control
> >> to perf_event_open() syscall on Fedora distro with Targeted SELinux
> >> policy and then manage access to the syscall.
> > 
> > I'm fixing these up:
> > 
> > [acme@five perf]$ am /wb/1.patch
> > Applying: perf docs: introduce security.txt file to document related issues
> > .git/rebase-apply/patch:46: space before tab in indent.
> >  	wake_alarm
> > .git/rebase-apply/patch:47: space before tab in indent.
> >  	block_suspend
> > .git/rebase-apply/patch:48: space before tab in indent.
> >  	audit_read
> > .git/rebase-apply/patch:51: trailing whitespace.
> > 
> > .git/rebase-apply/patch:54: trailing whitespace.
> 
> This is output of diff utility.
> Hopefully it is still applicable after fixes.
> I will test this either jointly with the changes at 2/3.

So, I've pushed to the tmp.perf/core branch, after testing what is there
I'll move it to perf/core for 5.8,

- Arnaldo
