Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E1C2D0CD
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C175C2146E
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="erdSkVl8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfLQPLy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:11:54 -0500
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:9217 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfLQPLy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 10:11:54 -0500
X-EEMSG-check-017: 61338931|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,325,1571702400"; 
   d="scan'208";a="61338931"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 15:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576595512; x=1608131512;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0UxVfkbV/9rIhsNSs5BFhK0LH6XsXzqjSgOsVNIAGoM=;
  b=erdSkVl8bo4RwKSwWRglQx7XPAhYkUfxKRLIdIc2U+lzAR8cTCSpG7DV
   4VkVh7FA7F4Fn16L635aGH0MCjaM8gja8NXOCs3DIhUb5QtYFf60P2nNf
   bATki4fMdemTnm2/xY3JuHgqec+XtamEwhKbwLPTqxgx+eRBuOM9VEVDy
   A14DkQsc2+Trde7CyD2hfkg5bonlMDs2rY+9cxqN0lj1jsmsHKmq40bOp
   CKnnyQtmgBZgra0tjRDTYuyGQ5vK01Ht/O03VJQszgZlkfjiCkXcamLR3
   C/l1+DO9XadOgg6z3laybGynOCXfTKedV+4koXKBUfr5FqnI7FWl9R4zg
   A==;
X-IronPort-AV: E=Sophos;i="5.69,325,1571702400"; 
   d="scan'208";a="31184762"
IronPort-PHdr: =?us-ascii?q?9a23=3AJNIR5hEAtJBQi9VREmvnDZ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7ypcWwAkXT6L1XgUPTWs2DsrQY0rGQ6fi/EjNZqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswndqssbjYRgJ6os1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBu6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwr82lp?=
 =?us-ascii?q?odtkTDBTH5l1nsgK+KdkQr5uio6+P9brXgupCcLJN7hhv7MqQvnsyzGeU4Mg?=
 =?us-ascii?q?4QUGiH4emwybLu8ELjTLhKk/E6iLfVvZ/EKcgBu6K1GwpV3Zwi6xa7ATemyt?=
 =?us-ascii?q?MYnXwfIVJeZR2HlJPkO03OIf/kDfe/hE6gkDFwx//cJLHhDZLNLmbbnLf7Yb?=
 =?us-ascii?q?l981JcyBY0zd1H/5JbEKwBIPboV0/prtPYExs5PxWxw+bgD9V9zJ0RVXiTDa?=
 =?us-ascii?q?+eNaPYqUWI6f43I+mQeI8Vvy7wK+M76P7qjH85n0IdfKay0JsJZ3C3AO5mL1?=
 =?us-ascii?q?+aYXXymNcBF3kFvg4kQOztkl2CXiZZZ2yuUKIk+jE7FIWmAJ/ERoCoh7yBxy?=
 =?us-ascii?q?G7EYdKaW9YEV2MC2nneJiEW/gWdCKeONNukjsBVevpd4h07RizsEffzL19I6?=
 =?us-ascii?q?KA4iQFsbr73cVxoujUkgs/szdzCpLO/XuKSjRPgm4QRzIwlJt6qEh5x0bLhb?=
 =?us-ascii?q?N0mNREBNdT4LVPSQ58OpnCmb8pQ+vuUx7MK4/aAG2tRc+rVHRoE4M8?=
X-IPAS-Result: =?us-ascii?q?A2CXAAD07vhd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgW0EA?=
 =?us-ascii?q?QELAYFzgW0gEiqEBIkDhnIEBoE3iWqRRQkBAQEBAQEBAQE3AQGEQAKCPDcGD?=
 =?us-ascii?q?gIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCegEFIxVBEAsYAgImAgJXBg0GAgEBg?=
 =?us-ascii?q?l8/glMlrjmBMoVPgz+BSIEOKAGMMXmBB4E4D4JdPodZgl4ElwxGlzOCPoJCk?=
 =?us-ascii?q?0gGG4JDmAaQE5sXI4FYKwgCGAghD4MnUBEUm3YjAzCSAAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 15:11:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHFBWGr073851;
        Tue, 17 Dec 2019 10:11:32 -0500
Subject: Re: [PATCH v4] selinux-testsuite: add lockdown tests
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
References: <20191210153945.20635-1-sds@tycho.nsa.gov>
 <4d40e7cb-f191-2327-7160-333c2c100f57@tycho.nsa.gov>
 <CAHC9VhRU8qgHkKnhTAKZWz1CPom5pgV0AqAcNtizR39mbbtX3g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f1ec6c57-e652-0a5e-1e5b-962903ed5c01@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 10:12:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRU8qgHkKnhTAKZWz1CPom5pgV0AqAcNtizR39mbbtX3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/17/19 8:11 AM, Paul Moore wrote:
> On Mon, Dec 16, 2019 at 8:47 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/10/19 10:39 AM, Stephen Smalley wrote:
>>> Test all permissions associated with the lockdown class.
>>> Also update other test policies to allow lockdown permissions
>>> where needed.
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>
>> Barring objections, I will merge this tomorrow Dec 17.
> 
> Thanks Stephen.

This is now applied. As a reminder, these tests won't be exercised until 
Fedora updates its policies to define the lockdown class (and ditto for 
other recent additions, e.g. perf_events, fsnotify/watch) unless the 
tester manually patches the declarations into 
/usr/share/selinux/devel/include/support/all_perms.spt and inserts a cil 
module defining the new class/perms for the kernel.

