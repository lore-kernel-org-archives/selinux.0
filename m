Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5ADC35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8AF2051A
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 19:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="AvTWym5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgBCTm6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:42:58 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:45650 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgBCTm6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 14:42:58 -0500
X-EEMSG-check-017: 53626107|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="53626107"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 19:42:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580758973; x=1612294973;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=GoQUNcmcIWUkWfiDFHWEoGJxkyQu8gIEFiGBIRvzFJ4=;
  b=AvTWym5QXb4kcGDQkdL2At1KuwniOJsufQ8iZ7jpQl3J+2fxBPILWFhj
   uy9ZfnNuq/Tuv6zYpSEd3Sxc8rU0ybjiXeGVhTp1MEA0lkJ7F9Czenn5Y
   M3ySIju3wSkrASPmx448a2tHLURYNNjXBTH3SSt6WTFN/N4G8wBaiIffK
   sbvy8I/ozToygaUx5p765hDW75ul7jDNOx0vdxsku4Wt/iPRjmwXOf4m3
   so5q0IPyrAS6ZQtVOU/g6xm7msrx/MQ831Dg9evI3ythoKovHzlUsA5jC
   dyvM0/S2GMpT0DPbNIzEGu7n9+QBxcPeHJu1yf6cGSJLyIKPeBj8NiKFz
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="38610274"
IronPort-PHdr: =?us-ascii?q?9a23=3A/T/MZRA5q/aGKIYRyfO5UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX/r8bcNUDSrc9gkEXOFd2Cra4d16yK7Ou5AzZIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrw+xx?=
 =?us-ascii?q?bLrXdEZvpayX11Ll6Xgxrw+9288ZF+/yleof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FMRdhaWTBfDYygbosPF+sBMvher4nhvFsFsB+yCRCxCO/z1jNEg3n70qMg0+?=
 =?us-ascii?q?QlDArIwgouEdwTu3jQtdn4NKMfXeWzwaLVzzvMculW1C/g5obWfBAvofKCU7?=
 =?us-ascii?q?x+fsXey0YgCwzLg06MqYHnJT6ZyvgBvmaZ4udmSOmhi3QnqwZ0ojW3xMcthJ?=
 =?us-ascii?q?XGiZgPylDY6yly3YE4Jd+2SUFne9GkCodQuz+BOotqQsItX2FouCEgxr0Aop?=
 =?us-ascii?q?60ZjIGyJsgxx7BcvGKdZWD7BH7VOuJPDt1i31odKi/ihqv60Ss1OLxWteu3F?=
 =?us-ascii?q?pXqCdOj8PCuWoX1xPJ78iKUv59/kC81jmRzw3T8eREIVwslarcNp4h3qY8lp?=
 =?us-ascii?q?oNvkTHGS/7gFn2g7WMdkUl5+io8P7rYrTgpp+SMI90kR/xPbg0lsyjAeU3Lg?=
 =?us-ascii?q?gOX2+B9eS6yLLj5lH2TK9Pjv03lqnVqJHaJcIFqa6lGwJZz4ku5hmlAzqmzd?=
 =?us-ascii?q?gUh2cLIV1bdB6dkoTlI1TOL+r5Dfe7jVSsijBrx/XeM73jDJTCMmLMkK39fb?=
 =?us-ascii?q?pj8ENc1Aoywsxf55JTEL0BJunzVVXruNzXCR85LRS4w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?eEP6zMt1+I5/kvI+6Xa48Ppjn8Kvsl5/nwjXIill8deLOm3ZoTaHyiAvtmJE?=
 =?us-ascii?q?CZa2L2gtgdCWcKohY+TOvyhV2ZTzFTY3eyX6Qh5jA0E4+mE4jDSZ63gLCb3y?=
 =?us-ascii?q?e0AIdWZmZYBVCIC3vocJ+EW/hfIB6Vd+NslD0fHZ+rUYIz1haw/Fv2xrxmNe?=
 =?us-ascii?q?3e4CAKtpX9/Ndw7uzX0xo18GowR9+Q12CLUnFcgGwFXXk10bp5rEg7zU2Mgo?=
 =?us-ascii?q?ZihPkNF8NY7ulVCE9uN4HXxvZmUfjuSwnBeZGPU1/gTdK4V2JiBuktysMDNh?=
 =?us-ascii?q?4uU+6piQrOim/zXu4Y?=
X-IPAS-Result: =?us-ascii?q?A2BwAADgdjhe/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF7gX2BbAEgEiqEFIkDh3klmzgJAQEBAQEBAQEBNwEBghOCLQKCW?=
 =?us-ascii?q?DgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYMCAQUjFVELCQ8CAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgmM/gnysfYEyhUqDTIE+gQ4qhR4MiFBAgTgMA4IvLj6HW4JeBIE/AYwUi?=
 =?us-ascii?q?WRGe5ZpBoI/ljoGG4JIjFaLao5hnSsigVgrCkGBaIFOUBgNjlWOLCMDMI8JA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Feb 2020 19:42:52 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013Jg1m6082409;
        Mon, 3 Feb 2020 14:42:01 -0500
Subject: Re: [Non-DoD Source] rangetranstion in cil fails and doesn't produce
 explanatory output
To:     Denis Obrezkov <denisobrezkov@gmail.com>, selinux@vger.kernel.org
References: <6a4178fa-72fd-22af-519b-16cd2ec6c3a1@gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <94ba5f15-2615-cbd3-1e00-222c7bbb6bf7@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 14:44:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6a4178fa-72fd-22af-519b-16cd2ec6c3a1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 7:21 AM, Denis Obrezkov wrote:
> Hello,
> 
> I am trying to make rangetransition work, this is my cil file:
> (type foo)
> (type bar)
> (allow foo bar (file (ioctl read write create getattr setattr lock
> relabelfrom relabelto append unlink link rename execute swapon quotaon
> mounton)))
> (rangetransition foo bar process s0)
> 
> Now, I am trying to install it:
> semodule -i lximage.cil
> 
> Failed to resolve rangetransition statement at
> /var/lib/selinux/refpolicy_mcs/tmp/modules/400/lximage/cil:4
> semodule:  Failed!
> 
> I use Debian Testing with refpolicy enforced. Policy type = mcs.
> What is wrong with my module? How can I get more explanatory output?
> 

For more information you can use semodule -v -i lximage.cil

In your case, CIL is particular in its syntax and wants:
(rangetransition foo bar process ((s0) (s0)))

Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
