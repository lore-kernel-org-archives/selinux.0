Return-Path: <SRS0=/6QZ=NM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210BBC6786F
	for <selinux@archiver.kernel.org>; Thu,  1 Nov 2018 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C532064C
	for <selinux@archiver.kernel.org>; Thu,  1 Nov 2018 13:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C532064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeKAWyE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:54:04 -0400
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:1627 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728449AbeKAWyE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Nov 2018 18:54:04 -0400
X-EEMSG-check-008: 156711961|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Nov 2018 13:50:59 +0000
X-IronPort-AV: E=Sophos;i="5.54,452,1534809600"; 
   d="scan'208";a="20153023"
IronPort-PHdr: =?us-ascii?q?9a23=3AHhU1ARZ1rh5r1mZuwFgvAU7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsi7bnLW6fgltlLVR4KTs6sC17KJ9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa/bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YcIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VesCGaMpF5QsIkQ2xwtyY6y6EGuZ?=
 =?us-ascii?q?6mfCcR0pgo2xnfa/mBfoOV4RzjTP6cLSp3iX9qYr6yhwu+/VK+xuDzSMW4yk?=
 =?us-ascii?q?tGoyxYmdfWrH8NzQbc6s2fR/t4+UeuxCiA2hjI6uFBPUA0ja3bK4M9wrIolp?=
 =?us-ascii?q?ocr0DDHijulUXqlqCWbEQk+vWz6+j9frXnpoOTN49zig3kNKQhhte/DvgiPg?=
 =?us-ascii?q?gLXmib/fyw1Lzl/ULnXLVHluA6n6bWvZzAJckXu7S1DxFa34o98RqzEi+q0N?=
 =?us-ascii?q?ECknkGKFJFdgiHj4/sO1zWO/D3EOy/jk+wkDZr2//GPrrhDo/LLnjYirjtZ7?=
 =?us-ascii?q?l960lCyAYr19BQ+4pUCq0dIPL0QkLxttvYAQEiPgyy2ennDNF92pkCVmKIB6?=
 =?us-ascii?q?+TKLnSvkOQ5uIzP+mMY5cYuC3jJPgh5v7ui2I5mFAGcKm30psYdmq4Eu5lI0?=
 =?us-ascii?q?qHe3rshMkOEWMQsgo5Vuzqh0WIUSRPaHaqQ6I8+jY7BZq+DYjZW4CthKeM3D?=
 =?us-ascii?q?+hEZ1LYmBKE1WMEXDvd4WeRfgAcj6dIshkkm9Mab/0aYgsnTensAuyn7hgI8?=
 =?us-ascii?q?LS8ykc85nk0Y4xr/bekRA06CxcEcuQySeOQntyk2dOQCU5j45lpkko8UuOya?=
 =?us-ascii?q?h1hbRjENVX4/5YGlMhOYX00/1xC9e0XBnIONiOVgD1EZ2dHTgtQ4dpkJc1aE?=
 =?us-ascii?q?FnFoDn10mb0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2B7AAAHBNtb/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFWBSpmf4QelC5QAQEGgRAliRCQFTAIAYRAAoM5IjgWAQMBAQEBAQECAWwcD?=
 =?us-ascii?q?II2JAGCYAEFIxVBEAsYAgImAgJXBgEMCAEBgl4/AYF0DQ+oIYEuhTyEWwWBC?=
 =?us-ascii?q?4phF3mBB4E4DIJfgxsChGWCVwKPNY9tCYZsihgGAhaBVI5/iT+DQowQIYFVK?=
 =?us-ascii?q?wgCGAghD4MogiUXg0iKbiOBNQEBikABAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 01 Nov 2018 13:50:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wA1DovaE031152;
        Thu, 1 Nov 2018 09:50:57 -0400
Subject: Re: '\0' termination on writes to /selinux/*
To:     Joe Nall <joe@nall.com>, selinux@vger.kernel.org
References: <E018DB57-F85F-4F0E-ADC6-520DEBC0AEC8@nall.com>
Cc:     Paul Moore <paul@paul-moore.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <45050053-62d4-9451-9714-25e1efa1d600@tycho.nsa.gov>
Date:   Thu, 1 Nov 2018 09:53:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <E018DB57-F85F-4F0E-ADC6-520DEBC0AEC8@nall.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/31/2018 03:28 PM, Joe Nall wrote:
> I was looking to mitigate https://github.com/SELinuxProject/selinux-kernel/issues/38 somewhat in our older RHEL6 systems for which a kernel update would be a big deal with a ENOMEM errno check and retry on the writes in libselinux. In looking at the code, it appears that whether the NUL termination is written out is inconsistent.
> 
> grep write *c| grep -v swig| grep strlen
> canonicalize_context.c:	ret = write(fd, buf, strlen(buf) + 1);
> check_context.c:	ret = write(fd, con, strlen(con) + 1);
> compute_av.c:	ret = write(fd, buf, strlen(buf));
> compute_create.c:	ret = write(fd, buf, strlen(buf));
> compute_member.c:	ret = write(fd, buf, strlen(buf));
> compute_relabel.c:	ret = write(fd, buf, strlen(buf));
> compute_user.c:	ret = write(fd, buf, strlen(buf));
> disable.c:	ret = write(fd, buf, strlen(buf));
> procattr.c:			ret = write(fd, context, strlen(context) + 1);
> setenforce.c:	ret = write(fd, buf, strlen(buf));
> 
> Is the NUL required inconsistently, not really required, or is this a bug?

The short answer is that the NUL is not required.

Historically, we originally required the caller to include the NUL as 
part of the security context (value and length); hence, the interfaces 
that are just writing a context are including the NUL in their size. 
However this is no longer required by the kernel; we changed our kernel 
code to accept it with or without the NUL when we migrated to using 
xattrs because the attr userspace tools did not include the NUL.  So in 
every mainline Linux kernel (>= 2.6.0), the NUL is not required.

In contrast, the other interfaces you mentioned above are either not 
passing security contexts at all or are passing multiple 
whitespace-separated arguments in a single string (which previously were 
separate arguments to a system call interface) and thus the contexts are 
being parsed out of that string.
