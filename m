Return-Path: <SRS0=yfq3=WM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E82C3A59C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDE22086C
	for <selinux@archiver.kernel.org>; Fri, 16 Aug 2019 14:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Sa0za/A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHPO5V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Aug 2019 10:57:21 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:64420 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfHPO5U (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Aug 2019 10:57:20 -0400
X-EEMSG-check-017: 10424400|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,393,1559520000"; 
   d="scan'208";a="10424400"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Aug 2019 14:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1565967432; x=1597503432;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=f9cJ1EV/ZEc9UZyyx/O5Ft2nbRY5eW+mwi7zmkGYiw0=;
  b=Sa0za/A0HQOaZwcygDdRF1MsAO/nWGN3KRHPS9Y15bzvQ5hpXKaaO3Yh
   T/0StzUHbm6aykjAXJkzLmpkdHtwV4ZB2RJ0NKV/UopL9MOWRNSWJPiYP
   r8+hVuyW5RfgYzfNuBapltflewGY5WA39GY283S++wZeIRrjqXoRzXItp
   03nvm3nBsBdNVSy7H8WeiCkEf07If1TEHBc0wiV3TFuaCr9p3vrYnrnq1
   yz413/R70LrFljcVYm/6Q7UFcMdux1i0XBXdMRJqYqL0mQOI+nJntudSw
   I/2DqssoTN98ac/GwYVL9osFoS+DNz0EtrMtuwS5mDvLI/wx3rS5/TTj6
   A==;
X-IronPort-AV: E=Sophos;i="5.64,393,1559520000"; 
   d="scan'208";a="31567925"
IronPort-PHdr: =?us-ascii?q?9a23=3AnOW3WhUDxjj5GRMGxiGK+8MIE6XV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZReBtKdThVPEFb/W9+hDw7KP9fy5AypZus3K7yBKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBvdutMLjYZsJKs9xR?=
 =?us-ascii?q?nEr3hVcOlK2G1kIk6ekQzh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q79FAjk4Km?=
 =?us-ascii?q?45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWT?=
 =?us-ascii?q?S+6qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSX?=
 =?us-ascii?q?NcUspNSyBNB4WxYIUVD+oFIO1WsY/zqVUTphe6HAWhBOfixjpOi3Tr36M1zv?=
 =?us-ascii?q?4hHBnb0gI+EdIAsHfaotv7O6gdU++60KbGwC7fb/5Uwzrx9JTEfx4jrPyKQL?=
 =?us-ascii?q?l+cdDRyU4qFw7dk1uQtZLqPyuV1usTtWiQ8vduVee1hG4jrwF+vDiuzdorh4?=
 =?us-ascii?q?nSm40V0UvJ9Tl5wYkpJd24T1R3Ydi/EJRKrS2aOIx2Qt07TmxupS00yaUGtI?=
 =?us-ascii?q?amcCUFx5kr3R7SZ+Gdf4SW7R/vSvydLSp+iXl4YrywnQyy/lKlyuDkU8m010?=
 =?us-ascii?q?tFoTRdn9nXs3ANywTT6s+aSvth5kuh2SiA1wTU6uxcPUA7j7DbK588wr4rjJ?=
 =?us-ascii?q?YTrUTCETP2mEXxlqOWcFkr+vO05Oj9Z7Xmp5ucO5d1igH4LKsuhtSyDfk3Pw?=
 =?us-ascii?q?UBRWSW+fmw2Kf98UD2XrlGlOA6nrHcsJ/AJMQboqC5AxVS0oYm8xu/FCqp0M?=
 =?us-ascii?q?8DkHkbLFNKZBKHj4/zN1HIO/D3F+2zg1urkDd13/zGJKHuAo3RLnjfl7fsZb?=
 =?us-ascii?q?R960tbyAop19Bf5olUB6oHIP3pX0/+qt3YAgU+MwyuzObtEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUeS6eIyJ+mBf5cVtyzgK/gh/vLuiHg5mVgHfaa3x5cYdHe4HvF+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmVuzqh0aNXCVJZ3msQq085is0CJ68AYjfQYCthaSL3D?=
 =?us-ascii?q?2nEZ1OemBGFleMHG/td4WDQfcMdCWSIslkkjEfSbehS5Uh1RartA/71rpnK/?=
 =?us-ascii?q?DY+ioCtZLszNJ1/fHclQku9TxoCMSQy2ONT2Z0nmMOXTM23qd/oUxnxVeFyq?=
 =?us-ascii?q?h3nfpYGMdP6PxTVAc6Mpjcz+1mBN/oXgLNZMuGSFGjQt++GzE+Usoxw8MSY0?=
 =?us-ascii?q?Z6A9iilQ7M3y6rA78TiryKC4c58rzT33fvPcZx0XXG27c7j1kgXMRPMXeqhq?=
 =?us-ascii?q?ll9wjcH4TJiVmWl762daQA2y7A7GODzXeSvEFfSwN/S6DFUmoDaUTMtdT551?=
 =?us-ascii?q?/CQKWqCbg9NAtO19KCILNQatL1lVVGWOvjONPGbmK1mmewAwuIx7yVYIrxZW?=
 =?us-ascii?q?oSwDjdCFIFkwAP/XeKLA0+BiC8rGLDCDxhC0niY13j8eZgsnO3VEw0wB+Qb0?=
 =?us-ascii?q?1nybW1/gQZhfuGS/McxrgEojsuqy1oHFah2NLbE96ApwtnfKVBbtIx+U1I1X?=
 =?us-ascii?q?/EuAx8IpytNLpiiUADfAR3pUzuyw97BZlHkcgvtHkq1hZ9KbqE0FNdcDOVxY?=
 =?us-ascii?q?vwNaPNKmn94h+icK7W1Uva0NaS+qYP7u40pEnkvAGsRQIe9CBF2txYyDO54Y?=
 =?us-ascii?q?/QDRFaBZD0VVwt9gNSobjfbyh74JnbgzkkGKCutTmK9NUoCOYhgkKpdNhYMa?=
 =?us-ascii?q?+JPBPjGM0dQc61IaolnEb/PTweO+UHz7I5J8OrcbO93aevOOtx1Ga9gX9v/J?=
 =?us-ascii?q?F20kXK8TF1DOHPwcBWkLmjwgKbWmKk3x+aucftlNUBPGxDEw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AFAgCww1Zd/wHyM5BlHQEBBQEHBQGBVgUBCwGBbSqBP?=
 =?us-ascii?q?gEyhEmPWwEBAQEBAQaBNolqigSHHgkBAQEBAQEBAQE0AQIBAYQ/AoMaIzcGD?=
 =?us-ascii?q?gIFAQEBBAEBAQEBBgMBAWyFM4I6KQGCZwEFIxVBEAsOCgICJgICVwYBDAgBA?=
 =?us-ascii?q?YJfP4F3FKl5gTKFSIMsgUmBDCgBi2gXeIEHgREngms+h0+CWASUQl2WMQmCH?=
 =?us-ascii?q?4IhkgwGG5hCLY0qmhUigVgrCAIYCCEPgyiCeY4pIwOBNgEBjhoBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Aug 2019 14:57:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x7GEv4UT030102;
        Fri, 16 Aug 2019 10:57:05 -0400
Subject: Re: [RFC PATCH v3] security, capability: pass object information to
 security_capable
To:     James Morris <jmorris@namei.org>,
        Aaron Goidel <acgoide@tycho.nsa.gov>
Cc:     paul@paul-moore.com, rgb@redhat.com, mortonm@chromium.org,
        john.johansen@canonical.com, selinux@vger.kernel.org,
        luto@amacapital.net, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, nhfran2@tycho.nsa.gov, serge@hallyn.com
References: <20190815202357.4238-1-acgoide@tycho.nsa.gov>
 <alpine.LRH.2.21.1908160817300.22623@namei.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cebacde0-5c53-c414-8f27-8d81ed928dfd@tycho.nsa.gov>
Date:   Fri, 16 Aug 2019 10:57:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1908160817300.22623@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/15/19 6:32 PM, James Morris wrote:
> On Thu, 15 Aug 2019, Aaron Goidel wrote:
> 
>> In SELinux this new information is leveraged here to perform an
>> additional inode based check for capabilities relevant to inodes. Since
>> the inode provided to capable_wrt_inode_uidgid() is a const argument,
>> this also required propagating const down to dump_common_audit_data() and
>> dropping the use of d_find_alias() to find an alias for the inode. This
>> was sketchy to begin with and should be obsoleted by a separate change
>> that will allow LSMs to trigger audit collection for all file-related
>> information.
> 
> Will the audit logs look the same once the 2nd patch is applied? We need
> to be careful about breaking existing userland.

It was already the case that the name= field in the AVC audit record was 
not guaranteed to be emitted in this case, since d_find_alias could 
return NULL.  And it was only a hint, since that name might have nothing 
to do with the name used to look up the inode in the first place. So I 
don't believe userland could have ever relied upon it being present 
here.  Removing it also fixes a problem with AVC audit generation under 
RCU walk; we should be able to drop the code that skips audit generation 
in that case with this d_find_alias call gone IIUC.

With the ability for an LSM to enable collection and generation of 
AUDIT_PATH and other AUDIT_* records (which is made possible via the 
other patch), we will get more complete and relevant information in the 
audit log.  It won't look exactly the same (there will be separate AVC, 
PATH, ... records that can be correlated based on timestamp/serial and 
ausearch does this automatically for you).
