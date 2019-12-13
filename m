Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C5C341CA
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798DE246D0
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jnOAusWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfLMPkn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:40:43 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:27216 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfLMPkm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 10:40:42 -0500
X-EEMSG-check-017: 37972976|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="37972976"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2019 15:40:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576251639; x=1607787639;
  h=to:from:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=Xc3upDaeB/J6AIPf0MSlx5dX2IlALdZ8hDRa0LVy8Qs=;
  b=jnOAusWotxLbnnQkclFVSIfeCk7UEW8rV25uvJNXfEk9xkLDt/QmKoOX
   rlAHOa/Xwf2fZJD5idB1m/7ygY2iQo6OKmVp01iXM6IAenc0ljN9ROy2h
   tWOedQwlruYbMtuSbkdWt+11ffygtp9gHOFtLMjlC8gpWQNKtV/+XABqI
   X27IPAxlQpRt/yG0rfIYn/LdXiYY8eZ5aSjRu38lEgBLY3IMQf1bYdTuz
   GaoCVJp7naqsv1fUGiieGAz3M3Lm98ogDDtyww3dkdF7oDtcgijXJhuTU
   WQ/fS1nccCmEukrGo3qR9iD0OEM46SFKLr95XeL7yREi4SdNtaZPvCyAZ
   A==;
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="31083500"
IronPort-PHdr: =?us-ascii?q?9a23=3A07jxRxD8/73K/3RxvwHaUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36r82wAkXT6L1XgUPTWs2DsrQY0rGQ6vGxEjNQqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAncss0bjYRgJ6sy1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBu6CAWpAu7k1z1GiWLs3aAize?=
 =?us-ascii?q?ovERzI0g8uEd0Av3vbsNr7ObwOUe231qTE0SnPYv1U1Dr79YPGcgohofaJXb?=
 =?us-ascii?q?9obMTR1VcgFxvFjlqOr4zuIi6b1uEXvGif6+pvS+KugHMgpgFqvzev3dwhip?=
 =?us-ascii?q?XJh40JylDE8j91wIAuJdKiUkJ7btmkEIVJuiycKoB4QdsiTnl1tCs1xbAKo5?=
 =?us-ascii?q?62cDUQxJg5yBPTdeaLf5WO7xn+TuieOy14i2hgeL+nghay9lWvxfPkW8mv1V?=
 =?us-ascii?q?ZKsjJFkt7RtnARzxDT6taISv96/kq5xTaAzRrT6uBZIUAvj6bbKpghwrA3lp?=
 =?us-ascii?q?oIr0vMAjX6mFn2jaCKdkUk/fKk6+L7bbX9upCQLYp0igD6Mqg2m8y/B/o3Mh?=
 =?us-ascii?q?QWUmSG9umx26fv8E3kTLlQkPE7nbfVvIrHKcgDo662GQ5V0oIt6xalCDem1c?=
 =?us-ascii?q?wVnWIaI1JeYx+Hk4joNE3OIPD/F/u/hU+sny1xy/DJOb3hHI3BLmLfn7f5Yb?=
 =?us-ascii?q?Z990lcxRIrzd9F+pJUDqoMIOrpVU/ssNzUFxo5Mwuzw+b9FtpxzJ8RWWWKAq?=
 =?us-ascii?q?WBKqPdrUeI5v4zI+mLfIIVoyjyK/wk5/7okH84lkQQfbem3ZQJcnC0BPdmLF?=
 =?us-ascii?q?uDYXrqnNgBFX0Gvg0kTOzlkFeCSyJcZ26uX6Ig4TE2EIGmApndSYC2nLOB2y?=
 =?us-ascii?q?C7Hp5Na29aClCMC3Dod4CFW/cRbSKeOMhhkiYLVbK5UY8uyQmutBPmy7pgNu?=
 =?us-ascii?q?fU+DMXtZzt1Nhr/ODTmhYy9Tt7D8SZzW6BVX17nmQNRzUuxqBwvVR9ykuf0a?=
 =?us-ascii?q?h/m/FYEtlT5/RSUgc8L5HT0/J1BsvoWg3fY9iJSEypQsm8DT4tSdIxxoxGX0?=
 =?us-ascii?q?EoI9y/iljm2C2wDvdBj7WWALQs+7/Ymn32INxwjX3B0f9lx2ILZspJKH3u0r?=
 =?us-ascii?q?Vy8wnVGp7hjUqUjeCpeL4a0SqL832Mmy7Gn0xVS0ZbVqLGFSQca0bNptP+5W?=
 =?us-ascii?q?vJT6WpDLU6N01G08HUbuNoZ9Pnl1hXDMnqPtjTeSqKh2C9HV7cxL6CYpTCdG?=
 =?us-ascii?q?Ia0yHQTkMDllZXtVGAORIzBG+EpHnYBTdjFhq7ZEbr6u93o36TVEI4zwiWKU?=
 =?us-ascii?q?Zm0uzm1AQSgKmnV/4L3r8C8BwkojFwEUf1i8naEPKctgFhe+Naetp771BZgz?=
 =?us-ascii?q?GK/zdhN4CtevgxzmUVdB566ga3ikR6?=
X-IPAS-Result: =?us-ascii?q?A2CXAwAqsPNd/wHyM5BlHQEBAQkBEQUFAYF+gXSBbSASh?=
 =?us-ascii?q?C2JA4ZuAQEBAQEBBosgkUYJAQEBAQEBAQEBGxwBAYQ2gj84EwIQAQEBBAEBA?=
 =?us-ascii?q?QEBBQMBAWyFQ4I7KQGDIxV2AiYCXwEMCAEBgl8/glMlrSeBMoQOAYFAgzKBS?=
 =?us-ascii?q?IEOKIwyeYEHgTgPinSCXgSNFoltRpcmgjoDgjmTNwYbgjIBmA6OS5xOIoFYK?=
 =?us-ascii?q?wgCGAghD4MoTxEUmyEBVCMDkEsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Dec 2019 15:40:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBDFeKMr253513;
        Fri, 13 Dec 2019 10:40:20 -0500
To:     Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Does anyone use RANDSTRUCT?
Message-ID: <bf727420-b7bd-d3e9-a597-812922ba20a3@tycho.nsa.gov>
Date:   Fri, 13 Dec 2019 10:40:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

See $(subject). If yes, there are some obvious candidates among the 
SELinux data structures for randomized layouts to avoid fixed locations 
for enforcing, initialized, etc.  If not, then no point in pursuing it. 
Doesn't look like Fedora enables it, probably because they'd have to 
publish the random seeds anyway for third party kernel modules.  But 
maybe it would be useful for some distros/users?  ChromeOS?  Android?
