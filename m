Return-Path: <SRS0=qSAh=YB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA28C10F14
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 14:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A6206C2
	for <selinux@archiver.kernel.org>; Tue,  8 Oct 2019 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="P3YrfKSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfJHObt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:31:49 -0400
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:25428 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHObt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Oct 2019 10:31:49 -0400
X-EEMSG-check-017: 37024082|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,270,1566864000"; 
   d="scan'208";a="37024082"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Oct 2019 14:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570545099; x=1602081099;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=KcCUOS7NDAiW9yWqqflbE1eQqF+q97SySKf6LrWGGWU=;
  b=P3YrfKSQuPE1Niv52NiMYTcRH8pACrPghuHew1WQna7Nj69FtlUGcfw6
   o1P7qEmoB9ZGkYnBkK8X41ojDz9jcskUf5OdNjkM/TbuTtnnafo6FHveR
   eoOjEH1AvV7Cbi2wRsEw5sVSfxiOBEvaYQpsJNB3+OMwtMUM6jNrMpI0K
   K4Y8KCqWWAhNEpqx/QdbGOXd6gOXQTKfqwbu1+S2KW9f0mBGdMBDqX+7l
   oKhGR7Jy0p9y88++WQbnB702twzNXtMz7wgG8RJCw/BUspI1GrFz/Bt8Y
   QyMueXSmFMsVva7AuQD+RIJ3WXUDnG540mW5p1H1vjq6DABpgN19B80F4
   Q==;
X-IronPort-AV: E=Sophos;i="5.67,270,1566864000"; 
   d="scan'208";a="28764656"
IronPort-PHdr: =?us-ascii?q?9a23=3A4WjM9RN4fQ04YCdGY0Ul6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0IvT7rarrMEGX3/hxlliBBdydt6sfzbeH+P+xEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oLBi7qQrdu8sSjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0QrNEAjsoNW?=
 =?us-ascii?q?A1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVT?=
 =?us-ascii?q?i+6apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSG?=
 =?us-ascii?q?xPUcZLUyxKH52yYY0BAeEcOepUtonwql8LoRa4GAKiBv7gyiVQi3Hr3aM0ze?=
 =?us-ascii?q?ohHwLI0gMuEN0BsmjbotruOacOUu241rXEwSnNYv5U3zr29YjGcgomofGJRb?=
 =?us-ascii?q?9+bNbRxlc3FwPFkFqQr5HuMS6Q1usXt2ib6/RvVOKygGMgsAF+vyOvy9wwio?=
 =?us-ascii?q?jJmo0VylfE+T9/wIYuP9K0UkF7Ydm6EJZJsSyRKoh4Qts6Tm11tys3xacKtJ?=
 =?us-ascii?q?6mcCQQ1pgqyADTZ+aaf4WO/xntTvyeIS1ii3JgYL+/ghGy/lW+xeDkTcm01U?=
 =?us-ascii?q?pKrjJCktnRqnABzxzT5daDSvt65kqhxSyA1xrS6uFZOkA4j7bbKp49zb4wkZ?=
 =?us-ascii?q?ofq0LDETPtmErqlqOWc0Qk+uyw5+TmZLXpuIOcOpdphgzxPakigMyyDfkiPg?=
 =?us-ascii?q?QQUGWX5/6w2KD78U38WrpKj/k2kqfDsJDdIMQWvrW5DBJO0os49xa+Dyup0N?=
 =?us-ascii?q?QfnXUdKlJFYwiIg5LmO1HJPvD0Fe2/jEi0kDd32/DGOaXsA5XXIXjGirjhYb?=
 =?us-ascii?q?F95lVGyAUt0N9f54hbCq0bLP3vXU/xscTSDgUlPAys3+bnFNJ925sFWW2RBq?=
 =?us-ascii?q?+ZMaXSsUKH5+80PemMa5EauCznJ/gm+fHul3k5lkEZfaWz2psXcn+4TbxaJB?=
 =?us-ascii?q?C8aGHlnt4CHC87ly8XcMui3EyLVDdPYF6oUq487y19A4WjW8OLXY2pgbqczA?=
 =?us-ascii?q?+lEZBMIGNLEFaBFTHvbYrXde0LbXepPsJ5kjECHYOkQosl2ADm4BT20JJ7P+?=
 =?us-ascii?q?HU/Wserpul299rsb6A3Sou/CB5WpzOm1qGSHt5yyZRGm47?=
X-IPAS-Result: =?us-ascii?q?A2BOBAD6nJxd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBd?=
 =?us-ascii?q?CqBPwEyhE2OYk0BAQEBAQEGgTaJeJEuCQEBAQEBAQEBATQBAgEBhEACgkUjO?=
 =?us-ascii?q?BMCDAEBAQQBAQEBAQUDAQFshTmCOikBgmgBBSMPAQVRCQIYAgImAgJXBgEMC?=
 =?us-ascii?q?AEBgl8/gXcUkiubcYEyiHqBSIEMKIwOGHiBB4E4gms+h1GCWASNBZ9PboIsg?=
 =?us-ascii?q?jCSZAYbgjqLeosMji2bRyKBWCsIAhgIIQ87gm1PEBSQMSUDgTYBAZBjAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 08 Oct 2019 14:31:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x98EVbJR002264;
        Tue, 8 Oct 2019 10:31:37 -0400
Subject: Re: [PATCH 0/5] dispol: add batch execution mode
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
References: <20191008064500.8651-1-yamato@redhat.com>
 <6065d682-8226-ebd3-ede2-3a8ddab3ba4f@tycho.nsa.gov>
Message-ID: <795edc71-bcd9-99b8-30e4-b108b00b0b34@tycho.nsa.gov>
Date:   Tue, 8 Oct 2019 10:31:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <6065d682-8226-ebd3-ede2-3a8ddab3ba4f@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/19 8:48 AM, Stephen Smalley wrote:
> On 10/8/19 2:44 AM, Masatake YAMATO wrote:
>> dispol command requires interaction, and is not suitable for using
>> in a script. This patch set introduces -b that is for running
>> dispol in non-interactively.
>>
>> An example:
>>
>>      $ ./dispol -b 1 /sys/fs/selinux/policy
>>      allow deltacloudd_log_t tmp_t : filesystem { associate };
>>      allow kern_unconfined sysctl_type : lnk_file { ioctl read ...
> 
> What is your intended use case for this support, i.e. how do you 
> envision using dispol in scripts?
> 
> If you just want to decompile policy, I'd recommend using checkpolicy 
> -F/--conf or checkpolicy -c/--cil, ala:
> checkpolicy -M -b /sys/fs/selinux/policy -F -o policy.conf
> or
> checkpolicy -M -b /sys/fs/selinux/policy -C -o policy.cil

Or you could just use sesearch -A if you wanted to just dump all allow 
rules, for example, or seinfo -b for all booleans, ...

dispol/dismod have always just been test/debug/developer utilities and 
predated the ability to decompile policies with checkpolicy, so I'm not 
sure if they are even still useful to keep around.  Is anyone still 
using them?

> 
>>      ...
>>
>> Masatake YAMATO (5):
>>    dispol: extend usage() to take exit status
>>    dispol: add an option for printing the command usage
>>    dispol: introduce a local variable representing the input file
>>    dispol: introduce -b option to run commands in batch
>>    dispol: add the list of commands for batch mode to help message
>>
>>   checkpolicy/test/dispol.c | 96 ++++++++++++++++++++++++++++-----------
>>   1 file changed, 69 insertions(+), 27 deletions(-)
>>
> 

