Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCDEC04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2514320867
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 15:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2514320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeLADJl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:09:41 -0500
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:49435 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726769AbeLADJl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 22:09:41 -0500
X-EEMSG-check-008: 234697024|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Nov 2018 15:59:52 +0000
X-IronPort-AV: E=Sophos;i="5.56,299,1539648000"; 
   d="scan'208";a="18307666"
IronPort-PHdr: =?us-ascii?q?9a23=3AdG6AYxSG9dutnDSg2XD+m/JJMNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZhOFt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepGs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+ZL4t7Wt4uTm5ntSogyrAKpI?=
 =?us-ascii?q?S3cDYFxZg53RLTdvqKeJWS7B35TuaeOzJ4iWpgeLK4mhm971Ctyvb5VsmoyF?=
 =?us-ascii?q?ZKqTdFksXUunANyRPT7s+HR+Nh/ki7wzaP1h3T6vpeLUAolavUN54hwrkqmp?=
 =?us-ascii?q?oVrUvDBTP5lF/zjK+XckUo4umo6+L5bbX6vpKQKoB5hw7kPqkuh8CzG/o0Pw?=
 =?us-ascii?q?cQU2SB5OiwzLjj8lf4QLVOgP02iK7ZsJXCKMQAu6G5GBRY0poj6hmjDzem18?=
 =?us-ascii?q?4UnX8cLF1fYh6HgI/pO0/WLPDiEfi/m0iskCtsx/3eML3gDIvCLnnGkLj/Z7?=
 =?us-ascii?q?Zw8FRcxxQuwtBf/Z1UFqsNL+70Wk/0rNbYFAM2MxSow+b7D9VwzpkRWXqXAq?=
 =?us-ascii?q?CDKqPStFiI5vg0LumIZY8Voyr9K+M/6/7zlnA5hFkdfbW03ZcNdH+4GfFmKV?=
 =?us-ascii?q?2DYXXwmtcBDXsKvg0mQezuiV2CVyNTZnmrU6In+D40FJ+mDZ3CRoCxgL2NxS?=
 =?us-ascii?q?K7HppLaWBbDlCDD2zld5uLW/gSciKeOMxhnSIeVbinVYAh0QuitAjgy7poNu?=
 =?us-ascii?q?DU4DEXtYr/1Nhp4O3ejQoy+iJwD8Sc1WGNUm51k3gWRz85wq9/u1ZxylSd3q?=
 =?us-ascii?q?hihfxXC9hT6+lOUgcgOp7W1/Z6BMzqWgLdYteJT06rQtGnATE3U9IwzMYCbF?=
 =?us-ascii?q?xlG9WjlR3DwSWqDKEPl7CRB5w77Ljc337vKMZ50XrG07Mhj1Y+SMtVKWKmnr?=
 =?us-ascii?q?J/9xTUB4PRiUqZjaCqerkH0SHX7meDy3eBs1pCXAFtT6rPRWofaVfOrdTl+k?=
 =?us-ascii?q?PCSKejCbQ/MgRb0sODK6tLasHujVVcXvvsJNPeY2fi01u3UDiMwamNZYyiRG?=
 =?us-ascii?q?gc2SjHQBwKjA0S+HucHRIzCieovyTVCzk4URrme1vl6+x5slu/T1Qo1EeXZV?=
 =?us-ascii?q?Bny6fz8RkQwbSYSvUOzvcftSw8sTRoDRO42N7LD9eouQVsZuNfbMk77VMB0n?=
 =?us-ascii?q?jW80RmM5ihKb1yrkARfh4xvE700RhzTIJanoxiqHIs0Ro3ILqZ+E1Oeine3p?=
 =?us-ascii?q?3qPLDTbG7o80OBcanTj2rC3c6W96FH0/Exr1HurUn9DUY522l22NlSlX2H79?=
 =?us-ascii?q?PFCxREAsG5aVo+6xUv/+KSWSI6/Y6BkCQ2aaQ=3D?=
X-IPAS-Result: =?us-ascii?q?A2COAACRXQFc/wHyM5BjHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VopgWiEIJQhTAYGgQgtiR+OPYFmOAGEQAKDNCI3Bg0BAwEBAQEBAQIBbCiCN?=
 =?us-ascii?q?iQBgmIBBSMVQRALDgoCAiYCAlcGAQwIAQGCXj+BdQ2mM4EvhUCEbYELiw8Xe?=
 =?us-ascii?q?IEHgTiCNgcuhEWDQIJXAo9wNpAPCZExBhiRH4h7kT4igVUrCAIYCCEPO4Jtg?=
 =?us-ascii?q?iYXjjshA4E1AQGKfASCSQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Nov 2018 15:59:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wAUFxo8A028088;
        Fri, 30 Nov 2018 10:59:50 -0500
Subject: Re: Security modules and sending signals within the same process
To:     Florian Weimer <fweimer@redhat.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <87lg5asilo.fsf@oldenburg.str.redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e754fa24-899b-f77e-f226-0f070ebad132@tycho.nsa.gov>
Date:   Fri, 30 Nov 2018 11:02:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <87lg5asilo.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/30/18 10:14 AM, Florian Weimer wrote:
> Is it guaranteed that tasks in the same thread group can always send
> signals to each other, irrespective of their respective credentials
> structs?
> 
> It's not clear to me whether this is always possible based on the
> security_task_kill implementations I've examined.
> 
> I want to support per-thread setresuid/setresgid, but we also use
> signals for inter-thread communication.  This is mainly for thread
> cancellation; the setxgid stuff isn't needed for threads with private
> credentials.  I wonder if I need to disable cancellation for threads
> with such credentials.

(fixed selinux list address, which moved to vger)

Looks like commit 065add3941bd ("signals: check_kill_permission(): don't 
check creds if same_thread_group()") skipped the uid-based checks if the 
sender and target were in the same thread group, but not the security 
hook call.  One could argue that the security hook call ought to be 
skipped in that case as well using the same rationale given in that 
commit.  Nothing appears to guarantee the property you state above for 
security_task_kill implementations, although none of the in-tree users 
are based on uids or gids so setresuid/setresgid shouldn't affect them.
