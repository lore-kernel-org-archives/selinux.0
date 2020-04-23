Return-Path: <SRS0=BxL9=6H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F07C54FCB
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D962208E4
	for <selinux@archiver.kernel.org>; Thu, 23 Apr 2020 13:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeaT55Sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgDWNWJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726780AbgDWNWI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Apr 2020 09:22:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6A6C08E934;
        Thu, 23 Apr 2020 06:22:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so6327225qke.2;
        Thu, 23 Apr 2020 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cfSJ/n7+m5NIf3p98KEiW2LshWNCIUPwffj22cRtE+A=;
        b=QeaT55SyqVcIQ7WBkkNii9JSiVqmvsk7W6SEPdaXHSRPgjtMOdOPtUWWCmu6f7104I
         UW1zvQTFSI8nHcex0kAXCgvJTOM265EX8G4rVD9Z2dxGogbBgUDQL/35DScsSZ1VNnrG
         ih7JMde8AgfVA4DxmUB1FJ996x/xH68j69zzjLumM+3y0g/AJdbbF5tKtpUFLl1+oBNd
         Q4B+KhuueCa5YeLv9qrrCCGl8xnnQrDoOGkbhmz47wYoVnA8pUNDl+KcNc1zg6uDVXFV
         1/MQGfIPF/U4FCt1jYbMV+5rv4b0DLLAbRSLfh6BbaSQQ4Uv8wx0+8Dji2re6KGtkmIw
         Kb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cfSJ/n7+m5NIf3p98KEiW2LshWNCIUPwffj22cRtE+A=;
        b=QzKTWNNdp9rmZDIyj+SBLaKL/T2Sz+DNAaPRh7ZBSRxjxe2sgRHaoXr8mOSo06dqn1
         MnP9ap/gkoGfRD+U4jygT8hIwVzBLF38A8kCpL/ijncf9gssOC+Nf10YAWZSMXQWKH2t
         7QnMpceXA6ATUY8P+cNKMHYRSQokMpGFSqGSVNe80SsYNEvH289XFs3O9wQW3I/LdlX0
         iVz3QU/uzjw7wGnM3E02hTJT0JNp4Pso1uBryzCoK08MWhuMZNm7F/8u7c0bjRuTWEz8
         Qv4PGQRsFjXNmbQhehn5ZXKStmhty8spXMnliRYbheje6zp0c6Jp0Flc3ZdniO9HMfEn
         XSvA==
X-Gm-Message-State: AGi0PuZIHDzVpwIPqcBlsIIjwmE0rLtDhRPF4GXy/s8DRTAKFxM/ZpdX
        vqG0loXT9OLYGkON6D/ZT50=
X-Google-Smtp-Source: APiQypLIlJIjbI0Sz0htU7mo5gYbQ5yhlssITmswaWusPAXt0p4NFJNphZpfZkTmJ09ustzF2tzx2g==
X-Received: by 2002:a05:620a:7fa:: with SMTP id k26mr1822673qkk.289.1587648126553;
        Thu, 23 Apr 2020 06:22:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y6sm1467644qky.133.2020.04.23.06.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 06:22:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B9B7409A3; Thu, 23 Apr 2020 10:22:01 -0300 (-03)
Date:   Thu, 23 Apr 2020 10:22:01 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] perf docs: substitute CAP_SYS_ADMIN with
 CAP_PERFMON where needed
Message-ID: <20200423132201.GB19437@kernel.org>
References: <66f2975b-4a69-b428-7dc5-d9aa40b3c673@linux.intel.com>
 <f1b48de9-e2b7-d20b-3686-3a15b73ef45c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b48de9-e2b7-d20b-3686-3a15b73ef45c@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Wed, Apr 22, 2020 at 05:44:53PM +0300, Alexey Budankov escreveu:
> 
> Substitute CAP_SYS_ADMIN with CAP_PERFMON in the docs where admin
> is mentioned. CAP_SYS_ADMIN still works in keeping with user space
> backward compatibility approach.

Same issue as with the previous patch, the documentation is for the
tool, that may be used in older kernels, so we need to clarify that
CAP_PERFMON requires updating libcap and the kernel, if that isn't
possible, then CAP_SYS_ADMIN is needed.

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-intel-pt.txt | 2 +-
>  tools/perf/design.txt                      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index 456fdcbf26ac..176597be0755 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -687,7 +687,7 @@ The v4.2 kernel introduced support for a context switch metadata event,
>  PERF_RECORD_SWITCH, which allows unprivileged users to see when their processes
>  are scheduled out and in, just not by whom, which is left for the
>  PERF_RECORD_SWITCH_CPU_WIDE, that is only accessible in system wide context,
> -which in turn requires CAP_SYS_ADMIN.
> +which in turn requires CAP_PERFMON.
>  
>  Please see the 45ac1403f564 ("perf: Add PERF_RECORD_SWITCH to indicate context
>  switches") commit, that introduces these metadata events for further info.
> diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> index a42fab308ff6..6fd879440c40 100644
> --- a/tools/perf/design.txt
> +++ b/tools/perf/design.txt
> @@ -258,8 +258,7 @@ gets schedule to. Per task counters can be created by any user, for
>  their own tasks.
>  
>  A 'pid == -1' and 'cpu == x' counter is a per CPU counter that counts
> -all events on CPU-x. Per CPU counters need CAP_PERFMON or CAP_SYS_ADMIN
> -privilege.
> +all events on CPU-x. Per CPU counters need CAP_PERFMON privilege.
>  
>  The 'flags' parameter is currently unused and must be zero.
>  
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
