Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AC2C3404C
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7146524654
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Z28Z+lfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgBRRKr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:10:47 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:22822 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgBRRKq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 12:10:46 -0500
X-EEMSG-check-017: 59486192|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="59486192"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 17:10:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582045842; x=1613581842;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=svvhASsR/0vspHCmj4LsO+taMXlzt2vCQhU+PGPm2qw=;
  b=Z28Z+lfWngniI83cs3MbvqVm9jyERw7gy6iFRpeFEEL+/2w5WPtxHmf9
   Al41OHR5cXFnZKKMWdhu15TKvLgPEo71LfWQrqYsSoz3cAFdWce/fcvN4
   iGayv2NuoIauRFti4iu5vX9nAspO+Jbi54bQijmCHfT4AE3245YxfATio
   SY7aETTxVUpzTHNYgWRASWDR5qOtwzeSZkPTz7ID3w1wPl8GKib7FB22y
   X1MhwKDfSoq86Gx7TI5H1AAFk98QCZUnI0b87uW8NKOSn4BZWbxd0kR9H
   ZQI6y1xkHjB2BRG7T6YlVkct/3Z+97ZqgRKIQ544/0ajMxzZOmGEWUG7O
   w==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="33163572"
IronPort-PHdr: =?us-ascii?q?9a23=3ALuOjsBCzChCcwwouPUFwUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP37pMuwAkXT6L1XgUPTWs2DsrQY0raQ7PCrCDxIyK3CmU5BWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRq7oR/Tu8QVjodvLqU8wQ?=
 =?us-ascii?q?bVr3VVfOhb2WxnKVWPkhjm+8y+5oRj8yNeu/Ig885PT6D3dLkmQLJbETorLX?=
 =?us-ascii?q?k76NXkuhffQwSP4GAcUngNnRpTHwfF9hD6UYzvvSb8q+FwxTOVPczyTbAzRD?=
 =?us-ascii?q?Si86JmQwLmhSsbKzI09nzch9duh6xHvh2uux1/w5bVYI6LMvp+Yrjdds4eSW?=
 =?us-ascii?q?ZYQ8pdSzBNDoa6YoQBFeoBOftToZf7qVUAsBCyARCgCP3rxzNNgHL9wK803P?=
 =?us-ascii?q?k7EQzewQIuAdwOvnTXotv7OqgdXuK6w7XHwzjYc/Nb2y3w5JTUfh0vo/yBW6?=
 =?us-ascii?q?97f8rLyUkoEgPIlkieqZD7MDON1uQCrW6b5Pd9W+KqkWEnrwVxrSavx8wxjY?=
 =?us-ascii?q?TJnZ8aykvf+CVlwIc6Od24SElhbd6iC5tfrTuWN4RxQsM8WmxlvjsxxLMBuZ?=
 =?us-ascii?q?6+ZicKyZInygbca/OZaYiI5AzsVOKLLTd/nnJld7SyjAux/0i40uDwS8a53V?=
 =?us-ascii?q?lQoidFj9XArG4B2hPN5sSdV/dw+Fqq1yyV2ADJ8O5EJFg5la/cK5E83LE9jo?=
 =?us-ascii?q?ETsUHfHi/un0X2kbOWel0k+ue27+TnZa3rpoOGOI9uiwH+L78ulta+AeQ+PA?=
 =?us-ascii?q?gOWHOb9vqg27H54U34QKlFjv0xkqXDtpDVOd8bqbKjDw9Q04Yj7w6zDzag0N?=
 =?us-ascii?q?sGgXkKNE9JdR2IgoTzO1zCPer0Aemwjliyijtn2ujKPrj7DZXMKnjDnq3hfb?=
 =?us-ascii?q?F460NE0wo80Mtf6olICrABPP3zWkjxuMbeDh8iKQO42ennCNJj1o8GQ2KAHr?=
 =?us-ascii?q?eZML/OsV+P/u8vJOyMZIgOuDb7Mfcq++DhgGQjmVADYKap3YEYaGyiEvt6JE?=
 =?us-ascii?q?WZZGLmgs0dHmcSogo+UOvqhUWZUTFNY3ayXqQ85iw0CY+9E4fDSZ6igKab0C?=
 =?us-ascii?q?e4AJJWfGZGBU6IEXvycIWEQfgMYjqIIsB9ijwESaShS4g52BG2rgD61r5nI/?=
 =?us-ascii?q?HM+iICqJLj0MF55+jUlRE17zx7Ed6R3H2KT2FxzSs0QGoR2qxlrE4171CY16?=
 =?us-ascii?q?Fzjv8QQdtW4OhPWww3HYTRw+xzF5b5XQeXOp+SRVKnRMi2KS8+Q8h3wNIUZU?=
 =?us-ascii?q?t5XdK4gVSL5yO3B/cwkLuRCdRg6qvB21DpLtt5jnPB07MsyVIhR50cG3ehg/?=
 =?us-ascii?q?tE6wXLB4PP236cnqKueLVUiDXB70+f3GGOuwdeSwc2XqLbCyNMLnDKpMj0sx?=
 =?us-ascii?q?uRB4SlDq4qZ04Yk5+P?=
X-IPAS-Result: =?us-ascii?q?A2BeAgBiGkxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVAEgEiqEFIkDhl4DBoESJYlwkUoJAQEBAQEBAQEBLQoEAQGEQAKCJzgTA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwEBbIU3DII7KQGDAgEFIwQRUQsOCgICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCYz8BglYlD607fzOENQGBFINngTgGgQ4qjD55gQeBOAwDgig1PoQ1gyaCP?=
 =?us-ascii?q?CIEjWiJakaXcoJFglCEf48EBhybJo5tiHeUWCKBWCsIAhgIIQ87gjgBMxM9G?=
 =?us-ascii?q?A2OKBiBBAECh12FXSMDMAIBjiSCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Feb 2020 17:10:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IH9b43073792;
        Tue, 18 Feb 2020 12:09:37 -0500
Subject: Re: [PATCH v3] selinux: optimize storage of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200218112734.116064-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3fb25bb8-71f1-ecb1-4779-acd55cd45b8c@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 12:11:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218112734.116064-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/20 6:27 AM, Ondrej Mosnacek wrote:
> In these rules, each rule with the same (target type, target class,
> filename) values is (in practice) always mapped to the same result type.
> Therefore, it is much more efficient to group the rules by (ttype,
> tclass, filename).
> 
> Thus, this patch drops the stype field from the key and changes the
> datum to be a linked list of one or more structures that contain a
> result type and an ebitmap of source types that map the given target to
> the given result type under the given filename. The size of the hash
> table is also incremented to 2048 to be more optimal for Fedora policy
> (which currently has ~2500 unique (ttype, tclass, filename) tuples,
> regardless of whether the 'unconfined' module is enabled).
> 
> Not only does this dramtically reduce memory usage when the policy
> contains a lot of unconfined domains (ergo a lot of filename based
> transitions), but it also slightly reduces memory usage of strongly
> confined policies (modeled on Fedora policy with 'unconfined' module
> disabled) and significantly reduces lookup times of these rules on
> Fedora (roughly matches the performance of the rhashtable conversion
> patch [1] posted recently to selinux@vger.kernel.org).
> 
> An obvious next step is to change binary policy format to match this
> layout, so that disk space is also saved. However, since that requires
> more work (including matching userspace changes) and this patch is
> already beneficial on its own, I'm posting it separately.
> 
> Performance/memory usage comparison:
> 
> Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
>                   |             | (-unconfined) |           | (-unconfined) | (createfiles)
> -----------------|-------------|---------------|-----------|---------------|--------------
> reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
> rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
> this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file
> 
> (Memory usage is measured after boot. With SELinux disabled the memory
> usage was ~60MB on the same system.)
> 
> [1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
> Changes in v3:
>   - filename_trans_read_one()
>     - remove the 'newdatum' variable
>     - uintptr_t -> u32 (leftover from a WIP version of this patch)
>     - drop 'already_there', just goto out immediately
>     - allocate 'ft' using kmemdup() instead of kzalloc()
>   - filename_write_helper()
>     - move strlen() call outside the loop
>     - move declaration of 'node' outside the loop
> 
>   security/selinux/ss/policydb.c | 166 +++++++++++++++++++--------------
>   security/selinux/ss/policydb.h |   8 +-
>   security/selinux/ss/services.c |  16 ++--
>   3 files changed, 110 insertions(+), 80 deletions(-)

[...]
