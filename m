Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA68C433DF
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C43206FA
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 13:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgDCuZlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgHSNL0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgHSNLL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 09:11:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C3C061757;
        Wed, 19 Aug 2020 06:11:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x7so11185055qvi.5;
        Wed, 19 Aug 2020 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ow6DP5YKlPSxiKQIWxdVWz4BWaoxYYX3NXc+pEt29YU=;
        b=WgDCuZlCTSPVJ14+4FatM1GCxs88zL1Yu57fUA6ZqwJCE8sLovZJbRQPM4lv9/N9/Z
         gt7XVMN5qnTx866zfU87H4N1hH/EtVObggArQcXU1e+mmV/Nf6TsyAIDhQ8P/dA8qXKE
         R1Gtl4h1qXWTVya6GZJogtRIoaZOQje+6n5w0WmbiGZchfNAWU9+fiYiFPuZtVyMtMaw
         LGCthWdyZqO/Wydc2ySXeL6Zh5Ul8sHzGw5exllc07uqNUTW6jWzLsEMR0g/UPf8UEIW
         7DH/M0UH2NZ89Sm9g2Tf2gBoZ5osSN7snVv/imvFvy7FaunMmdV+XPbAfh7K9Wd8YIKl
         rJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ow6DP5YKlPSxiKQIWxdVWz4BWaoxYYX3NXc+pEt29YU=;
        b=uTpaSsHVq7E2H4RKY5T8BiyIQ44mAaUB3RBL8Iyb4ABktbGQaPhBXydQ+hfaENIUi/
         Pz6w8w1Z/JmmjkKDYJ8Ozy/kEhR3huKiGnhzqSHEQACYRLTKlbWkUaVN1AxFaKJ3vQct
         bSnMd+/oEo3UzsnCcW2g93WZnKQSQWUlS9625/IO6KSm9I2NTMKcRcgh6plbOfGLu7kv
         tIWKSf5XPQYFsoAwNN1SqsF1VNEPnBbTenFGUk1FovMjyuFqchMssdORUSIiZ4Cl6G/E
         +WYAHY8/mBuKBmlyOZYRc3E7hGAj/36QclC3cxP88CRu49VwG/hux8lc7Ogg3d27AmBr
         RGoQ==
X-Gm-Message-State: AOAM53146YPf8MeCX01CSyTiRd3kA4VUusB0I1upR9VeXlWXhkj7hDuN
        14O21gmwIRCYtUrNRrz+P8Q194ubOPE=
X-Google-Smtp-Source: ABdhPJwmI9U05SvdaDv/+Pgnw3CoOXb1l9WFX1XxnkobI9capGvu35l0s/rnagZ3Y4nDn6zHHqtVHw==
X-Received: by 2002:a0c:bd0c:: with SMTP id m12mr23968451qvg.49.1597842669970;
        Wed, 19 Aug 2020 06:11:09 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id x50sm28963887qtb.10.2020.08.19.06.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 06:11:09 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] selinux: add permission names to trace event
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     =?UTF-8?Q?Thi=c3=a9baud_Weksteen?= <tweek@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org
References: <20200817170729.2605279-1-tweek@google.com>
 <20200817170729.2605279-4-tweek@google.com>
 <0bb62de9-1020-a7c4-3a7f-48ae2f78e3b7@gmail.com>
 <20200817162933.79f69c66@oasis.local.home>
 <20200818120948.1a428da9@oasis.local.home>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <66e6d84e-20b5-1bd3-e107-322f42ce35d3@gmail.com>
Date:   Wed, 19 Aug 2020 09:11:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818120948.1a428da9@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/18/20 12:09 PM, Steven Rostedt wrote:

> On Mon, 17 Aug 2020 16:29:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Mon, 17 Aug 2020 16:13:29 -0400
>> Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
>>
>>> Does this require a corresponding patch to userspace?  Otherwise, I get
>>> the following:
>>>
>>> libtraceevent: No such file or directory
>>>     [avc:selinux_audited] function avc_trace_perm_to_name not defined
>> Yes, we need to add a plugin to libtraceevent that will add that
>> function.
>>
>> I could possibly write one up real quick.
> Something like this (this is patched on top of trace-cmd, but will work
> for tools/lib/traceevent too).
>
> With CONFIG_TRACE_EVENT_INJECT enabled (to test events), I did the following:
>
>   # echo 'utclass=1 audited=1 denied=0' > /sys/kernel/tracing/events/avc/selinux_audited/inject
>   # trace-cmd extract
>   # trace-cmd report
> cpus=8
>             <...>-1685  [005]  1607.612032: selinux_audited:      requested=0x0 denied=0x0 audited=0x1 result=0 scontext= tcontext= tclass= permissions={ compute_av }
>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> ---
> diff --git a/lib/traceevent/plugins/Makefile b/lib/traceevent/plugins/Makefile
> index 21e933af..13cbcb92 100644
> --- a/lib/traceevent/plugins/Makefile
> +++ b/lib/traceevent/plugins/Makefile
> @@ -16,6 +16,7 @@ PLUGIN_OBJS += plugin_scsi.o
>   PLUGIN_OBJS += plugin_cfg80211.o
>   PLUGIN_OBJS += plugin_blk.o
>   PLUGIN_OBJS += plugin_tlb.o
> +PLUGIN_OBJS += plugin_avc.o
>   
>   PLUGIN_OBJS := $(PLUGIN_OBJS:%.o=$(bdir)/%.o)
>   PLUGIN_BUILD := $(PLUGIN_OBJS:$(bdir)/%.o=$(bdir)/%.so)
> diff --git a/lib/traceevent/plugins/plugin_avc.c b/lib/traceevent/plugins/plugin_avc.c
> new file mode 100644
> index 00000000..76af23b9
> --- /dev/null
> +++ b/lib/traceevent/plugins/plugin_avc.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <string.h>
> +#include "event-parse.h"
> +
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +
> +typedef unsigned short u16;
> +
> +/* Class/perm mapping support */
> +struct security_class_mapping {
> +	const char *name;
> +	const char *perms[sizeof(unsigned) * 8 + 1];
> +};
> +
> +#define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
> +    "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"
> +
> +#define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
> +    "rename", "execute", "quotaon", "mounton", "audit_access", \
> +	"open", "execmod", "watch", "watch_mount", "watch_sb", \
> +	"watch_with_perm", "watch_reads"
> +
> +#define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
> +    "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> +    "sendto", "name_bind"
> +
> +#define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read", \
> +	    "write", "associate", "unix_read", "unix_write"
> +
> +#define COMMON_CAP_PERMS  "chown", "dac_override", "dac_read_search", \
> +	    "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap", \
> +	    "linux_immutable", "net_bind_service", "net_broadcast", \
> +	    "net_admin", "net_raw", "ipc_lock", "ipc_owner", "sys_module", \
> +	    "sys_rawio", "sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin", \
> +	    "sys_boot", "sys_nice", "sys_resource", "sys_time", \
> +	    "sys_tty_config", "mknod", "lease", "audit_write", \
> +	    "audit_control", "setfcap"
> +
> +#define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
> +		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf"
> +
> +/*
> + * Note: The name for any socket class should be suffixed by "socket",
> + *	 and doesn't contain more than one substr of "socket".
> + */
> +struct security_class_mapping secclass_map[] = {
> +	{ "security",
> +	  { "compute_av", "compute_create", "compute_member",
> +	    "check_context", "load_policy", "compute_relabel",
> +	    "compute_user", "setenforce", "setbool", "setsecparam",
> +	    "setcheckreqprot", "read_policy", "validate_trans", NULL } },
>
So we'll need to update this plugin whenever we modify 
security/selinux/include/classmap.h to keep them in sync.  Is that a 
concern?  I don't suppose the plugin could directly include classmap.h?  
I guess we'd have to export it as a public header. It isn't considered 
to be part of the kernel API/ABI and can change anytime (but in practice 
changes are not that frequent, and usually just additive in nature).

