Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85000C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A0E2075D
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bud8Nho3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgAXOGm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:06:42 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:54220 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgAXOGl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 09:06:41 -0500
X-EEMSG-check-017: 48300488|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="48300488"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 14:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579874800; x=1611410800;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=AB9mNVrfYwfxlw8OFgsYu+Nr58e3ZhBVmE8LhyAefXQ=;
  b=bud8Nho3odTEhvomL2lVu+yUCG5HsK+3F1GbEhqRqBCYnX/XexH7LQS5
   BueoM5J/MV0g+/gfGRaje7rcoWrt20N6UZZlpzjTCzZ73S/At3g5No0z8
   CRgAGk0vt4UI8WWzI2HvvT7FiggTThzyWdTkwq26hx4u3D3yAq/8h6cg7
   9+Pf55KQAMCwH6yhjoxfFBJ9xq95NO8waUULlQzSxATJgYsr0eDQz2yKw
   yXl393eRkS+VrlDaP7mHvA2w8Pu9H7+EUip+H7+j40Dar/18geozp4coo
   bVbcQnlGaye86Gm1z0ZwdGsfaGPzUlQg1bTCCuv7HuEYVlqdR3lTLkmJu
   g==;
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="38203331"
IronPort-PHdr: =?us-ascii?q?9a23=3AsYlgnBxDogF3LITXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2ukVIJqq85mqBkHD//Il1AaPAdyHragYwLeG++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMn4dvJak9xx?=
 =?us-ascii?q?vKr3BVf+ha2X5kKUickhrh6Mq85oJv/zhVt/k868NOTKL2crgiQ7dFFjomKW?=
 =?us-ascii?q?c15MPqtRnHUwSC42YXX3sVnBRVHQXL9Qn2UZjtvCT0sOp9wzSaMtbtTb8oQz?=
 =?us-ascii?q?Si7rxkRwHuhSwaKjM26mDXish3jKJGvBKsogF0zoDIbI2JMvd1Y7jQds0GS2?=
 =?us-ascii?q?VfQslRVjRBAoKiYIsJE+oBJvtTo43kq1cTsReyGQygCeXhxT9Sgn/9wLM03e?=
 =?us-ascii?q?IvHwrb2AAsBtwDvXDRoNjzKawcU/26zLPQwDvecf1W1zfz5ovGfB8vrv6DX6?=
 =?us-ascii?q?5/f8XKxEkzFQ7IlEmcpZDrMj6X0OkGrmiV7/BnVeKqk2Mpth1xrSa3xscslI?=
 =?us-ascii?q?bJgJ8exE3B9SpjxIY1IcO3SU5matOjC5tfqjqaOpBqQsIiX25ouCE6xqcAuZ?=
 =?us-ascii?q?6gZicG0psnxxnBa/GedYWD/xHtVP6JLDtli39od6izihav/US61OHxWde43E?=
 =?us-ascii?q?xXoidDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2kLWZdl8l+ui18OTreLTmppmSN49zkQHxLLghltajAeU4Lg?=
 =?us-ascii?q?cOX2+b9f661LL/5k32XK9Gjvg3kqndqJzaJMIbqbClAwJNz4ou5BmyAy2m3d?=
 =?us-ascii?q?gFh3ULMl1IdAydg4T0I13OJer3Dfa7g1SiijdrwPXGM6X6AprQNXjOi6vhfL?=
 =?us-ascii?q?Zh5E5czwo/19Zf54lOBb0bL/LzXVHxuMTCDhAlKwy03/rnCNJl24MGQ22PH6?=
 =?us-ascii?q?uZPbjKsVCS++IvJ/CAZIoSuDb6Mfgq+eTigmM+mV8YZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWHsjckFEWcLuAo+UePrhUacUT5ceXmyRbgw5jIlB4K8C4fMWIStjKaG3C?=
 =?us-ascii?q?ehEZ0FLlxBX2iFDHOgUoKDQfpEPDqbP8tJijUZUf2kTIg72Felswqsj/J8I+?=
 =?us-ascii?q?7V/DAInYzs2cIz5ODJkxw2sztuAJezyWaIGlpok3sISjl+56V2pUhw2x/Xyq?=
 =?us-ascii?q?Rjq+BJHtxUofVSW0E1MoCKnL8yMMz7Rg+UJoTBc12hWNjzRGhqH98=3D?=
X-IPAS-Result: =?us-ascii?q?A2CVAAD49ype/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYF8gW0gEiqEEokDhngGgRIliW+RSQkBAQEBAQEBAQE3AQGEQAKCRjcGD?=
 =?us-ascii?q?gIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCeQEBAQEDIxVRCxUDAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJjP4JXJat2dYEyhUqDRIE+gQ4qAYwweYEHgTgMA4JdPodZgl4ElzRGl?=
 =?us-ascii?q?16CQ4JMijqJKwYbmnwtjjOdHSOBWCsIAhgIIQ+DJ1AYDYgNF45BIwMwjVYBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 14:06:38 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OE5txg229288;
        Fri, 24 Jan 2020 09:05:56 -0500
Subject: Re: [PATCH] selinux-testsuite: move variable definitions out of
 binder_common.h
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <157981918030.502116.11086856862222322471.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a07232e1-9536-3020-89e5-c76f45cd35dc@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 09:07:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157981918030.502116.11086856862222322471.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 5:39 PM, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> Move the definitions of variables out of binder_common.h and into
> binder_common.c in order to prevent compiler errors.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   tests/binder/binder_common.c |    4 ++++
>   tests/binder/binder_common.h |   15 +++++++++++----
>   2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
> index 224238b..7cf6c74 100644
> --- a/tests/binder/binder_common.c
> +++ b/tests/binder/binder_common.c
> @@ -16,6 +16,10 @@
>   
>   #include "binder_common.h"
>   
> +bool verbose;
> +enum binder_test_fd_t fd_type;
> +char *fd_type_str;
> +
>   const char *cmd_name(uint32_t cmd)
>   {
>   	switch (cmd) {
> diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
> index f0245f3..f60860e 100644
> --- a/tests/binder/binder_common.h
> +++ b/tests/binder/binder_common.h
> @@ -1,3 +1,6 @@
> +#ifndef _BINDER_COMMON_H
> +#define _BINDER_COMMON_H
> +
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <inttypes.h>
> @@ -42,16 +45,20 @@ enum {
>   #define TEST_SERVICE_GET	290317 /* Sent by Client */
>   #define TEST_SERVICE_SEND_FD	311019 /* Sent by Client */
>   
> -bool verbose;
> +extern bool verbose;
>   
>   const char *cmd_name(uint32_t cmd);
>   void print_trans_data(const struct binder_transaction_data *txn_in);
>   int binder_write(int fd, void *data, size_t len);
>   
> -enum {
> +enum binder_test_fd_t {
>   	BINDER_FD,
>   	BPF_MAP_FD,
>   	BPF_PROG_FD,
>   	BPF_TEST
> -} fd_type;
> -char *fd_type_str;
> +};
> +extern enum binder_test_fd_t fd_type;
> +
> +extern char *fd_type_str;
> +
> +#endif
> 

