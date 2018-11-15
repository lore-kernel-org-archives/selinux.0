Return-Path: <SRS0=eoah=N2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A31AC43441
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2665C20815
	for <selinux@archiver.kernel.org>; Thu, 15 Nov 2018 13:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2665C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeKOXTh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:19:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43967 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeKOXTh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Nov 2018 18:19:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id j202-v6so16639342oih.10
        for <selinux@vger.kernel.org>; Thu, 15 Nov 2018 05:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LKSpNiw1BnbowZhyyj0Fd5vdZM7pFuI1SE3rUyRxeE=;
        b=IPUzFu5yJjccLgSOgnz+1Qxlr7K6vFUUe5RAYJn/J0zW9txNmLDnKBcbUcm5l/yZsF
         6FYjmo8Rsjadk4bnsmfhK91GLq57Uxxpj7IetIX53nmvJ2rkRDUGy1aePSBbWbG2a2BH
         yLeLU0iUsL3EyE/n5EjYKg8DT12o1+202IQB49tKndNcTaw1k2Gk2HcdCTMacnhdMr4h
         ha6b+qSLW1G8czfaF/2Ly2Zcnk8NEDaUFF0ScP1LUtfMlVJQf/u/zBsmP2lknyO60Qv2
         qGmsyL7ZyFCdZYoUJonRSEQHsjM8ZPxHVezyrNZY4ovbTsEddkTIAtQuXM+PZsfxlyLK
         mubg==
X-Gm-Message-State: AGRZ1gKYzBp9FsPVa9i+Eg7sU+aJook3x3F0jT13TMMlxcssHQe10XuJ
        /BnGAh7cJPWPyMVaxxeWh0EsIpRA5fshmEecm+bd5A==
X-Google-Smtp-Source: AJdET5dckBNUOAEw8XSDGO6fEXhoWLmpWQTtmPTbOwS3bJwqIc/UEph7IQ5EbcEXG6nj0M1Q7SP/RKVIdHbxp/ka1sY=
X-Received: by 2002:aca:5ac5:: with SMTP id o188-v6mr3364169oib.146.1542287508903;
 Thu, 15 Nov 2018 05:11:48 -0800 (PST)
MIME-Version: 1.0
References: <CACikiw1uNCYKzo9vjG=AZHpARWv-nzkCX=D-aWBssM7vYZrQdQ@mail.gmail.com>
In-Reply-To: <CACikiw1uNCYKzo9vjG=AZHpARWv-nzkCX=D-aWBssM7vYZrQdQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 15 Nov 2018 14:11:37 +0100
Message-ID: <CAFqZXNtDbRhPUw3HsQq+yn9h==_GUDXrNb3s+odD_uLgBq8=hw@mail.gmail.com>
Subject: Re:
To:     nxp.ravi@gmail.com
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 12, 2018 at 7:56 AM Ravi Kumar <nxp.ravi@gmail.com> wrote:
> Hi team ,
>
> On android- with latest kernels 4.14  we are seeing some denials which seem to be very much genuine to be address . Where kernel is trying to kill its own  created process ( might be for maintenance) .
> These are seen in long Stress testing .  But  I dont see any one adding such rule in general so the question is  do we see any risk  which made us not to add such rules ?
>
> 1.   avc: denied { kill } for pid=2432 comm="irq/66-90b6300." capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
> 2.   avc: denied { kill } for pid=69 comm="rcuop/6" capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
> 3.   avc: denied { kill } for pid=0 comm="swapper/1" capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
> 4.   avc: denied { kill } for pid=4185 comm="kworker/0:4" capability=5 scontext=u:r:kernel:s0 tcontext=u:r:kernel:s0 tclass=capability permissive=0
>
> This is self capability any one in kernel context  should be able to do such operations  I guess.

The reference policy does contain a rule that allows this kind of
operations, see:
https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules/kernel/kernel.te#L203

It is also present in the Fedora policy on my system:

$ sesearch -A -s kernel_t -t kernel_t -c capability -p kill
allow kernel_t kernel_t:capability { audit_control audit_write chown
dac_override dac_read_search fowner fsetid ipc_lock ipc_owner kill
lease linux_immutable mknod net_admin net_bind_service net_broadcast
net_raw setfcap setgid setpcap s
etuid sys_admin sys_boot sys_chroot sys_nice sys_pacct sys_ptrace
sys_rawio sys_resource sys_time sys_tty_config };

Therefore I would say it is perfectly fine to add such rule to your
policy as well.

Cheers,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
