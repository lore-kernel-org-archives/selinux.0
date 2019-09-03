Return-Path: <SRS0=4h59=W6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D542FC3A5A7
	for <selinux@archiver.kernel.org>; Tue,  3 Sep 2019 14:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE05822D6D
	for <selinux@archiver.kernel.org>; Tue,  3 Sep 2019 14:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pQr0IzxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbfICOxJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:53:09 -0400
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:25329 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfICOxI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Sep 2019 10:53:08 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 10:53:08 EDT
X-EEMSG-check-017: 5169117|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,463,1559520000"; 
   d="scan'208";a="5169117"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Sep 2019 14:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567521956; x=1599057956;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=RspCxWiSp15RKlzzWOJZJQc9bjGUd2cCK6g8r7w94pQ=;
  b=pQr0IzxOecokbSuCr9l5cSVhOrctUnviH+O9i7ImBpnAfOLBwsg98B+f
   8MaCIwTvkS7FHqDNypr2uyTpTVGupBvv+R+seiVj5Co8SLPtm2fWxvAQb
   0F4altPFhbwt9uec91kTl4OV88SMDbELFKZJM4+mdOGMko921Ex9PuCU1
   VIoWAa9M6H7tnHv5RqLZV/g7XJYku6oHyo6PoMVry6/Od0vvnbbqnKWC5
   iQYr5Jqp6H32IlEXJzCNPHQbNrPFs/EDoOOv3WOXGTl9dm7cHwCiwK9ZC
   L+P3Oll0KGFDDPJJrPwf7YEmwCLCec4dunT8UyCwfo0p/fBJ4EHZCnbOM
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,463,1559520000"; 
   d="scan'208";a="27449165"
IronPort-PHdr: =?us-ascii?q?9a23=3Ad0uQJRZgr91R4L8D8r8kIpH/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps+9YR7h7PlgxGXEQZ/co6odzbaP6ea5BjdLvcfJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MQu6oR/MusQUj4ZuJak8xx?=
 =?us-ascii?q?/UqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmtiE6yrgctp?=
 =?us-ascii?q?66eigH0I8oxxnYa/ybd4iI4xTjWPyNLjd/gXJofq+0iRWq8UW41+HxWca53E?=
 =?us-ascii?q?xKoyZYiNXAqH8A2wLJ5sSaTPZ2412v1iyV1w/J7+FJOUU0la3GJJE/2rMwjZ?=
 =?us-ascii?q?8TsVjbHi/xhUX2kLeadkU69eis7OTqeqnmqYWGN491lwH+Kb4imtC/AOskMg?=
 =?us-ascii?q?gOWHKX+eKg27344UL1WrBKjvwykqXBsZDaI9oUprKhDgNI3Ysu5AyzAje73N?=
 =?us-ascii?q?gCg3UKI0xJdAiag4TxPlHBOvH4DfOxg1S2lzdrwujLPqb8DZXWNXXDjLfgcq?=
 =?us-ascii?q?p9605b0gYzy8tf6IhOBrEOJ/LzRFf9tMbEAR8hLwy03+HnBc1g2YwEX2KPA7?=
 =?us-ascii?q?GWMKfQsVKT4+IgPe2MZIsPtzb7LPgk6OTigmM+mV8YZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWLsjc0cEWcOpQc+VPbliECGUTJKYnayWKU85islB468EYjDQYWtiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHfzaYqEX/YMaCSPIs5uiTEES7ehRJE71R20tw/11aBnLu?=
 =?us-ascii?q?zK9S0cr57j08J15+LLnxEo6TN0F9id032KT2xshWMHWTs23KF5oUxgxVaPyL?=
 =?us-ascii?q?J4jOJWFdxL4PNJVgY6OoLczuFhFdDyVRzOfs2TRFalXNqmGzcxQcw1w9MUZE?=
 =?us-ascii?q?Z9AdqihAjZ3yW2G78Vi6CLBJss/6LYwXjxPdxyxG3Y26Y9lFQmWNVAOnCmhq?=
 =?us-ascii?q?Fl6wjfHZLGk0Kcl6yyb6QTwDbN9HufzWqJpExYSBB/Xr7bUnAZZ0vWsdP561?=
 =?us-ascii?q?jDT7CwF7soLBFNycmYKqtFOZXVigBqTfHiNdCWQX+rlGq2Hl7cyrqKbYfueU?=
 =?us-ascii?q?0Y0SHZAU4Dg0YY+nPQcUAGDzql60fZCyZjXQb3al7o2fF3tXf+S0gz1QzMZE?=
 =?us-ascii?q?pkgf79sAUYgf2aVuM7wL0JomEipi9yEVL72MjZQZLUvAdlfaNBcfsj71pdk2?=
 =?us-ascii?q?HUrQpwOtqnNa80whZUaAlzvkXzx1BtB4tYlswrp2IC0gV/M+Sb3UlHejfe2o?=
 =?us-ascii?q?r/cPWDMWT2/Raye+vM11/G19KX8bYn9vs1sRPgsRuvG05k9G9ohZ0d92af74?=
 =?us-ascii?q?6CMhAbW5/6GhIz6QJzrbzRSjMw64PdyTtnNqzi9nfp28goH6MdxzytedZDN+?=
 =?us-ascii?q?vQDAL4HssbG8+GKeEnlh6udB1Sb85I86thBN+rb/uL3uaQOe9kmD+3xTBc7J?=
 =?us-ascii?q?tVzlOH9y06TPXBmZkC3afLjUO8Sz7ggQL54YjMkodeaGRXRzHuxA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CIAAAxfG5d/wHyM5BlHgEGBwaBVQcLAYFtKm1SATIqh?=
 =?us-ascii?q?CGPD1ABAQEGgTaJb48rgXsJAQEBAQEBAQEBKwkBAgEBhDUKAoJ2IzYHDgILA?=
 =?us-ascii?q?QEBBAEBAQEBBgMBAWyFLgyCOikBgmcBBSMVNhsLGAICJgICVwYBDAYCAQGCX?=
 =?us-ascii?q?z8BgXYUD6o9gTKECQGBQIM1gUMGgQwohQCGeBh4gQeBOIJrPoQdgzKCWASVS?=
 =?us-ascii?q?JZRgimCJ4RMiRmESQYbgjMvlgSNdoE3hj6SUwongVgrCAIYCCEPO4Jsgk4Xg?=
 =?us-ascii?q?0+KHAFSJAMwgQYBAYxqglQBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 03 Sep 2019 14:45:55 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x83EjrM2024982;
        Tue, 3 Sep 2019 10:45:53 -0400
Subject: Re: IB pkey policy problem found via the selinux-testsuite
To:     Daniel Jurgens <danielj@mellanox.com>,
        Paul Moore <paul@paul-moore.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "selinux-refpolicy@vger.kernel.org" 
        <selinux-refpolicy@vger.kernel.org>,
        Lukas Vrabec <lvrabec@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
References: <CAHC9VhTuYi+W0RukEV4WNrP5X_AFeouaWMsdbgxSL1v04mouWw@mail.gmail.com>
 <CAHC9VhR1ZNyZqGB3Si-z77zLwaTBf-pkQk19rVqofs4P_oVtFg@mail.gmail.com>
 <CAHC9VhSKxgCB_j-eT65tSvqFDbBe_Wu_b+XsvN0Si2eDrEROMQ@mail.gmail.com>
 <5817f158-9ba2-420d-3a9e-59ee43be3472@mellanox.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9048b292-b9fa-49f7-d66e-1f0ceaa39290@tycho.nsa.gov>
Date:   Tue, 3 Sep 2019 10:45:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5817f158-9ba2-420d-3a9e-59ee43be3472@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/3/19 10:30 AM, Daniel Jurgens wrote:
> 
> On 8/27/2019 12:24 PM, Paul Moore wrote:
>> On Thu, Feb 28, 2019 at 4:58 PM Paul Moore <paul@paul-moore.com> wrote:
>>> On Wed, Feb 13, 2019 at 4:35 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> Hello all,
>>>>
>>>> On a fully up-to-date Rawhide system you need the following line added
>>>> to the policy/test_ibpkey.te file to get a clean run of the
>>>> selinux-testsuite:
>>>>
>>>>    allow test_ibpkey_access_t self:capability { ipc_lock };
>>>>
>>>> The breakage doesn't appear to be due to a kernel change (previously
>>>> working kernels now fail), or a Fedora Rawhide policy change (nothing
>>>> relevant changed since the last clean run), but I did notice that my
>>>> libibverbs package was updated just prior to the breakage.  I haven't
>>>> had the time to dig into the library code, but I expect that to be the
>>>> source of the problem.
>>> Just to be clear, I don't believe this breakage is limited to the test
>>> suite, I expect any users of the SELinux IB hooks will run into this
>>> problem.  I believe we need to update the upstream and distro
>>> policies.
>> A ping to bring this issue back to the top of the mailing list.
> 
> Hi Paul, I looked in the libraries and don't see explicit use of mlock. Maybe there was a change to use that access control for get_user_pages? That doesn't really jive with previously working kernels no longer working though.

It would be useful to see the audit messages for that ipc_lock denial, 
including the SYSCALL record.

There are a number of kernel operations that can trigger ipc_lock checks,
https://elixir.bootlin.com/linux/latest/ident/CAP_IPC_LOCK

Several of those are infiniband-specific.
