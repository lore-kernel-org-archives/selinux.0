Return-Path: <SRS0=5g5+=ZY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D1FC432C0
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B182084F
	for <selinux@archiver.kernel.org>; Mon,  2 Dec 2019 14:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Om1CxJ6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLBOTS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:19:18 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:33382 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfLBOTS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Dec 2019 09:19:18 -0500
X-EEMSG-check-017: 55962506|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="55962506"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 02 Dec 2019 14:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575296355; x=1606832355;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=9ScSN4ZyTSHXQ74RFbX4+AThjwVE4V/yNBp752pX3sc=;
  b=Om1CxJ6NAo+1AR5PWS+m8oYglqWtqV0aZsGHHU+1LxN0NZmyqeRKGc2e
   QlLZn0VU0ZLBnj8OXQxRusPbA2l38pA5W1jPowaFRxajOTyq/K0vMhRbV
   FDb9aCPcMG5ds1iy9mNZCeZCnQpZcOHX6uR8Ejg+wr1V9jMASRsRzNObn
   78LecMEn7x7ngAfuNWGOfCTi3SeCqEboHH3p1vF64w+u+8/r+qv0TarqH
   8O3Ozudyc0y5pCrWEFWiJjbpL1/4jG4UEgMWPDvXWicg8cr/DdSmioQzt
   EKKYzip0mpeK74y9hmLYJL+C7g9tosuWVU9468P1k5MfidWRa4w5QUn+X
   g==;
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="30636451"
IronPort-PHdr: =?us-ascii?q?9a23=3AMxL6ARPBnorsCsISIGcl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/j7rarrMEGX3/hxlliBBdydt6sfzbOJ7uu+AyQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oAfRu8UZgIZuNLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YOqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHN09KeAmcgoj1O1DBPPD4DfClj1Sqizdk3erKPrLmApXTNnTDiqvufa?=
 =?us-ascii?q?5h605Azwo+1cpf55NIBbEBOv3zQFL+u8TEARAhMwy72efnCNNj2YMFQm+AGb?=
 =?us-ascii?q?OZMKLUsV+U+O0vOe+Ma5EJuDrnN/cl4Pvuh2cjmVABZampwYcXaHegE/R9PU?=
 =?us-ascii?q?qZZXvsgtEcEWYFpQc+UuPqh0OYUTJJZHa9Qbg85jclB4KiF4vDQZqtgLPSlB?=
 =?us-ascii?q?u8S6dXbWBPEFzEMX7pcYifE6MWaSmSK9VtpTczVbGgTYI6/RuytQnmxqBhI/?=
 =?us-ascii?q?aS8Sod49arz9Vx5uvOhTks+jFuSceQyWeASydzhGxbaSUx2fVEvUFlylqFmZ?=
 =?us-ascii?q?N9ivhcGM0bs+hFSS8mJJXcyKp8ENm0VQXfKITaAG26S8mrVGliBuk6xMUDNg?=
 =?us-ascii?q?MkRoSv?=
X-IPAS-Result: =?us-ascii?q?A2CGBAAPGuVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgX4Cg?=
 =?us-ascii?q?XKBbAEgEoRViQOGWwaBN4lpkUQJAQEBAQEBAQEBNwEBhEACgi85BQ0CEAEBA?=
 =?us-ascii?q?QQBAQEBAQUDAQFshUOCOykBgm4BBSMVUQsYAgImAgJXBgEMCAEBgl8/glMls?=
 =?us-ascii?q?XmBMoVPgyaBSIEOKAGML3mBB4E4D4JdPodZgl4EjQeJYEaXEYI4gjmTGgYbm?=
 =?us-ascii?q?iOOSpwpIYFYKwgCGAghD4MoTxEUm0ojA5F+AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 02 Dec 2019 14:19:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB2EJ5mr254500;
        Mon, 2 Dec 2019 09:19:06 -0500
Subject: Re: [RFC PATCH] selinux-testsuite: Add TUN/TAP driver tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191127094702.3418-1-richard_c_haines@btinternet.com>
 <41aca6c1-7284-0226-3f20-6eb15f437c48@tycho.nsa.gov>
 <2f41698ed14a640481fcc82476cd9c725e3d17e6.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1be772e5-2c78-2f00-b996-04ae1592001a@tycho.nsa.gov>
Date:   Mon, 2 Dec 2019 09:20:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2f41698ed14a640481fcc82476cd9c725e3d17e6.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/28/19 7:53 AM, Richard Haines wrote:
> I'll change this (I try to avoid interfaces in tests as you need to
> lookup what they really contain and it may be more than you want, plus
> just plain allow rules are much clearer (but that's just me))

I'd agree if the interface is a poor match / overly broad but I think in 
this case it works well.  I am sympathetic to the view that refpolicy 
interfaces are harder to use than raw policy rules (hence the almost 
complete lack of interfaces aside from common macros in the Android 
policy), but the one advantage they should carry is greater portability 
across refpolicy versions since they should automatically pick up 
changes in the base policy (e.g. if a type is renamed or split or 
coalesced, if a new permission besides the one being tested is 
introduced and needed for the abstract operation, etc).  And if/when we 
transition refpolicy to a truly higher level policy language on top of 
CIL, then I would anticipate them providing greater benefits as first 
class abstractions rather than mere m4 macros. But I guess only time 
will tell...
