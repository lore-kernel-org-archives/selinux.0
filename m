Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7C6C49ED7
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 13:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D34C20665
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 13:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dQoSwvTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfITNC1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:02:27 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:20498 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfITNC1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 09:02:27 -0400
X-EEMSG-check-017: 30111135|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="30111135"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Sep 2019 13:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568984546; x=1600520546;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=kxMekgaSt0IgxiB301DjyJRt6p3snWh6CavUysS3Ko4=;
  b=dQoSwvTsWvJef4DgRrzd3PJVNKcWON17mZ3cSnmoI+FlkbQc13nDiVxS
   uEfuhL4lKYGvYuykSCSqlWb9qyN/kGPI96oPwj07auxcPEjni2aYw2AKp
   AURc6SUw4OmZvVE9DMZ3Ghf1lO8dRy++VAQxwO1hNEf0ebqzvS0JP0MlF
   IOI8cIEXaSAUTWgk1nDw5a0q6NXSytf8F9F56ylu4fJ9zxdOguLinEGfd
   MjHl02n8AnLRl7COC9uHiuXjXFi6C5kti6ssbXlRhhLcoHAziP/n3QHga
   9G/42HOXc+cq+EOfbzwa0Hdtf0AVEl0jytPGerZjkU/sxbMtim2l7cvUH
   w==;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="33127185"
IronPort-PHdr: =?us-ascii?q?9a23=3AytT1Mxx6XeO+VJDXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoTKvad9pjvdHbS+e9qxAeQG9mCsLQe0aGL7eigATVGvc/b9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMuMQam5VuJrg+xh?=
 =?us-ascii?q?bJo3ZDZuBayX91KV6JkBvw+9m88IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sAvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudzfCx85NBe0w+D9B9phyIwTQniPDb?=
 =?us-ascii?q?GEP6PSq1CI+vgjLPWLZI8QoDz9MeQq5+byjX8lnl8QZbKp0oUTaHC5GPRmPk?=
 =?us-ascii?q?qYbGHygtcOD2gKpBAyTO/0h12YVz5ceXKyU7g75jEhB4KsFZ3DSZy1gLydwC?=
 =?us-ascii?q?e7GYVbZnpHCl+QEXfnbZ+EVOoUZy2OOsBhkiYLVbmnS4A/zhGjrxT1y6ZmLu?=
 =?us-ascii?q?rS5i0Xq4jj1N5r6O3Pjx096Tt0D8HOm12KGkZyknkFRXcT27t5qEdwyR/X1q?=
 =?us-ascii?q?1/mPpRHtF7/f5FUg4mc5Xbyro+Q8v/XgPHY8ehVlmrWJOlDCs3Q9Z3xMUBJw?=
 =?us-ascii?q?5HGt6ihwrPlwqjArkYjPTfHp0/8qvG00/6EMZ0ynDLz4Erk1ggXsZVM2C6wK?=
 =?us-ascii?q?V48l6AKZTOlhCii6uydakalBXI/WOHwHvG6FpUSyZsQK7FWjYZfUKQotPnsB?=
 =?us-ascii?q?CRB4SyAKgqZ1MSgfWJLbFHP5iw1gRL?=
X-IPAS-Result: =?us-ascii?q?A2ANAQD3zIRd/wHyM5BlHQEBBQEHBQGBUwgBCwGBbgUqg?=
 =?us-ascii?q?UAyKoQiiByGfE0BAQEBAQEGgTaJdY8tgXsJAQEBAQEBAQEBNAECAQGEPwKDC?=
 =?us-ascii?q?SM0CQ4CDAEBAQQBAQEBAQUDAQFshTmCOikBgmYBAQEBAgEjFVELDgoCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/gXcFD6w6gTKFTIM1gUmBDCgBjAgYeIEHgTiCaz6HT4I2I?=
 =?us-ascii?q?gSWApcLgiyCLpJWBhuZJo4amxE4gVgrCAIYCCEPgydQEBSQLyQDMIEGAQGON?=
 =?us-ascii?q?gEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 20 Sep 2019 13:02:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8KD2PZY020560;
        Fri, 20 Sep 2019 09:02:25 -0400
Subject: Re: [PATCH testsuite] tests/Makefile: check if BPF library is
 installed
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
References: <20190920115019.23144-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b8968a99-e780-d530-9e90-9650a7da70fc@tycho.nsa.gov>
Date:   Fri, 20 Sep 2019 09:02:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190920115019.23144-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/20/19 7:50 AM, Ondrej Mosnacek wrote:
> Check for the existence of the <bpf/bpf.h> header before enabling BPF
> testing. Otherwise building the tests fails in an environment where
> the kernel and policy support BPF, but the library is not installed.
> 
> Fixes: 8f0f980a4ad5 ("selinux-testsuite: Add BPF tests")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   tests/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/Makefile b/tests/Makefile
> index e5bdfff..e8cf008 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -43,10 +43,12 @@ endif
>   
>   ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
>   ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
> +ifneq (,$(wildcard $(INCLUDEDIR)/bpf/bpf.h))
>   SUBDIRS += bpf
>   export CFLAGS += -DHAVE_BPF
>   endif
>   endif
> +endif

I think Richard had something like this originally and I told him to 
take it out.  The rationale was that he added libbpf-devel as a required 
dependency to the README and we don't want to silently skip tests 
because someone forgot to install some package; I'd rather it fail at 
build time.

>   
>   ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
>   SUBDIRS += infiniband_endport
> 

