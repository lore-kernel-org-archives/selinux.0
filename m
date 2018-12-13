Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B8C65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF9420851
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544716994;
	bh=F2Yt1LzgjiVngisMOjSzBuApXf/peebp36UohFPRd54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GCorknPj9LR1PLeGnbRO8DW8NIqiRarkUvRLw7TO9HldpWy4cKd/ttnzzHuCo3krF
	 PGRyZewzjxmI03l0ojciWd89cgGSA4/hZKvf+4X43e7bNjAY6CMC3OVa4DL30jovkZ
	 pCUq92XaBdIIOlRP/EKYL6bxnd7UldwQ3+H7z4Mc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF9420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeLMQDO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:03:14 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46216 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeLMQDO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Dec 2018 11:03:14 -0500
Received: by mail-yw1-f68.google.com with SMTP id t13so992073ywe.13;
        Thu, 13 Dec 2018 08:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YkAoSxUh4hH/P1CZfumbzrBY8vsOuIZCsPfUjR7dZr4=;
        b=mOJK+2M8X5MFr4JM2vnzMvwTJYPh8dp0RMl5cU6E9CyClMA+IWDWZffmpCai6aEEFz
         gZLtCeouQE4o21rC63oOfC02vjHqtqyDj5g/cIJGF2QGmM+Y0pg+AjMtT+zG/k58x1/6
         9wyHPHTqR1YHQ+G6WD+Vx/WS4NJMNTt//Vh/cQjY52Du+70Gq52uTOvSxoqJlDX8oWNn
         T0hR9NieX+5p7pynXugdcWdv+xejCGDb5S67i6Wnbq0U+NXXF/IVhs7DSU7lV+7yr9sm
         XDcManZNPT2bzM/mDODDbPGxNbyoiGoBgETOTMcMUGJnv/vmX9mr1lryTXAOD30cehqC
         jQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YkAoSxUh4hH/P1CZfumbzrBY8vsOuIZCsPfUjR7dZr4=;
        b=DKuORvIUnlkgzgNxHLVnLYoDGiLPT0QVGqzNOAZaj2uQ7PiBsCNgHhIoTVHyROzTB/
         3a1ojAu7lMX0+DSosCncZeMqikvdUKVOv8jcNm2OLD/TPeBIcmL5Mv9GWgc9h9uuX9XO
         3r610OG1irKmo1AsSJrveTsb6+Q/d3YeRDnSmIN3Z5/mfcm8G1TaPDaKgK2vxR57aZBP
         r0RngDgZFbeCBUHB4l4JgzgtIMtG1CSjZFL15etDV0zxetlnhTeGiAm7v6dvNv7qZhxY
         r0XOvFD+n3t/6O/ai3bUScM1iFiXQ3puJGzxJmOZjSDLcO4ACDTiG3yZ3LrDZ2IJR6A5
         XSWg==
X-Gm-Message-State: AA+aEWasNykaRmG/W89W6g1zaZOke1XK0NaXczqiWR0wl/QeQbQDcCWb
        d1+SD/0bM2FsTOnCMnrPNDg=
X-Google-Smtp-Source: AFSGD/U/ULFiZQRgKFpH/KC4vfYjE0hohzYjCIcowdQ4U9g1yf+7wgcepwCd6T0eAfwLpgdJoTvFDw==
X-Received: by 2002:a81:ad27:: with SMTP id l39mr25475611ywh.301.1544716993021;
        Thu, 13 Dec 2018 08:03:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:b482])
        by smtp.gmail.com with ESMTPSA id y83sm689516ywd.65.2018.12.13.08.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 08:03:12 -0800 (PST)
Date:   Thu, 13 Dec 2018 08:03:09 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        cgroups@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 1/3] cgroup: fix parsing empty mount option string
Message-ID: <20181213160309.GT2509588@devbig004.ftw2.facebook.com>
References: <20181213141739.8534-1-omosnace@redhat.com>
 <20181213141739.8534-2-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213141739.8534-2-omosnace@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Thu, Dec 13, 2018 at 03:17:37PM +0100, Ondrej Mosnacek wrote:
> This fixes the case where all mount options specified are consumed by an
> LSM and all that's left is an empty string. In this case cgroupfs should
> accept the string and not fail.
> 
> How to reproduce (with SELinux enabled):
> 
>     # umount /sys/fs/cgroup/unified
>     # mount -o context=system_u:object_r:cgroup_t:s0 -t cgroup2 cgroup2 /sys/fs/cgroup/unified
>     mount: /sys/fs/cgroup/unified: wrong fs type, bad option, bad superblock on cgroup2, missing codepage or helper program, or other error.
>     # dmesg | tail -n 1
>     [   31.575952] cgroup: cgroup2: unknown option ""
> 
> Fixes: 67e9c74b8a87 ("cgroup: replace __DEVEL__sane_behavior with cgroup2 fs type")
> [NOTE: should apply on top of commit 5136f6365ce3 ("cgroup: implement "nsdelegate" mount option"), older versions need manual rebase]
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Applied to cgroup/for-4.21.

Thanks.

-- 
tejun
