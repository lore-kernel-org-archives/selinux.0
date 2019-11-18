Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB76EC432C3
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10E72190F
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Vfrbfof3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRPwT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:52:19 -0500
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:22148 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRPwS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 10:52:18 -0500
X-EEMSG-check-017: 51795913|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="51795913"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Nov 2019 15:51:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574092309; x=1605628309;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=TVt9seT7al8ZL92/23YF/+Pl+VEg9U+3w2vKi1wNzf0=;
  b=Vfrbfof31Z3b967Fb6OL2653VHRWS/jvNvkKI3gJ3WBXfTbTAOwwgXlu
   W2uzBzM1BlYcLDmsiWO51x2b9jz9Gp9/om1OS+KcWyktaf1G5Du65jYmO
   HM4/8O8iqG3bw/Z1T4YBACGJlX8OGT0QFvDjpPNVMmu5B8iFg0YWG0Oev
   9jEn1ox1+sUjM4R3scuFGNdsNMWjWr+Bt02YKOi6idr8Df4Je7dlsk+/n
   nNLFYbLfiFYEwjpEqLiZUHf5UU/h1lON5lgKMGCmADhW6t242RgAIJfyB
   oKyRXmCFedjwKgc1GA3zqVZUZrRrLbHG8UUhfwuN7JmJKZVLogCJlh70e
   g==;
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="30216127"
IronPort-PHdr: =?us-ascii?q?9a23=3AjkChJRGn+rDrS9yQJ3JNyp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yrs6wAkXT6L1XgUPTWs2DsrQY0rGQ6vy+EjFfqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAncucgbjYRiJ6sz1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwqIwl5?=
 =?us-ascii?q?UPsUTDGTX6mEPqg6+Nakoo4O2o6+XjYrn+p5+cMZF7ih3mP6gzlcGyDv40Pw?=
 =?us-ascii?q?gTU2SB5+ix26Pv8VfkTLlSi/05iKjZsJTUJcQBoa65BhdY0p0+5BakFDqmzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZPpNEvULPD3Cve/nUygkC13yPDeIr3hHpLNI2DEkLfker?=
 =?us-ascii?q?Z98EhcxxAvwt9B/J9UEK8OL+/zWkDrqNzUFAM2Mwuxw+z/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7Sq16I6f4vI+aWfo8apS7yJOQ96P7ul3A5mFkdcrey3ZYMc3+4AvVmI0?=
 =?us-ascii?q?OFYXXymNcBF3kFvhYkQOP2j12CVCZZZ2yuUKIk+jE7FIWmAJ/YRo+zhLyB3S?=
 =?us-ascii?q?G7HoBZZ21dFFCMHmnnd5+eV/cPdi2SOMlhnSIAVbS7TI8hzx6u50fGzO9AKO?=
 =?us-ascii?q?bO9y9QkJX40tF+6u6bwRY38idyBs+Q+3uAQ2F9giUDQDpgmOhFoEd9w02PmY?=
 =?us-ascii?q?hxgvpVDpQH/fJCUg4gOanX+OxzCtb/QSrLYtaPVFu8RNi6Rzo2S4Ri7cUJZh?=
 =?us-ascii?q?NGB9i6jh3FlxGvCrsRmq3DUIc46YrAznPxIIB70H+A264/2Qp1CvBTPHGr0/?=
 =?us-ascii?q?YsvzPYAJTExgDAzPen?=
X-IPAS-Result: =?us-ascii?q?A2BNAAB8vdJd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsgUABMiqEKo9bBoE2iWaRQwkBAQEBAQEBAQE0AQIBAYRAA?=
 =?us-ascii?q?oIjJDgTAg4BAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjFUEQCw4KAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfP4JHAwklsFiBMoVOgyWBSIEOKIwVGHiBB4E4gms+ghuFOoJeB?=
 =?us-ascii?q?JZbRpcIgjSCN5MSBhuaEY5InBkigVgrCAIYCCEPgydQERSffiMDMIEFAQGNV?=
 =?us-ascii?q?gEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Nov 2019 15:51:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAIFpkcN018783;
        Mon, 18 Nov 2019 10:51:46 -0500
Subject: Re: [PATCH V2] selinux-testsuite: Add kernel module tests
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <20191115114429.18566-1-richard_c_haines@btinternet.com>
 <CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <068a7a76-02c8-a30f-18ec-2a692e3e157b@tycho.nsa.gov>
Date:   Mon, 18 Nov 2019 10:51:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAFqZXNtm_X+YssnX_3_5ThkVZY+9SBeQC5Qo78s+geSsBok8=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/18/19 4:10 AM, Ondrej Mosnacek wrote:
> A couple comments below...
> 
> On Fri, Nov 15, 2019 at 12:44 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
<snip>
>> +########### Allow these domains to be entered from sysadm domain ############
>> +#
>> +miscfiles_domain_entry_test_files(finitmoddomain)
>> +userdom_sysadm_entry_spec_domtrans_to(finitmoddomain)
>> +miscfiles_domain_entry_test_files(initmoddomain)
>> +userdom_sysadm_entry_spec_domtrans_to(initmoddomain)
> 
> It seems that the finitmoddomain and initmoddomain type sets are
> exactly the same except for names - can they be merged into just one
> set of types? The AVC denials should be still easily distinguishable
> by the comm= field if that's the intended purpose of the separation.

Do you just mean coalesce the type attributes together or coalesce the 
individual types to which they refer?

If the former, then the denials will still be distinguishable based on 
individual types; the attribute names are only used in policy not 
denials.  Coalescing the attributes makes sense to me too.

If the latter, the individual types differ in that test_finitmod_t is 
only allowed module_load to a specific file type (test_file_t), i.e. it 
can only load modules from files with that type via the finit_module(2), 
whereas test_initmod_t is allowed module_load to self as the fallback 
when using init_module(2) and hence can load a module content at all. 
So coalescing those would detract from testing.

