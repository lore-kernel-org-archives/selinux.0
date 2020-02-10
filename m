Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCE7C352A5
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 14:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A290E2082F
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 14:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OnyjQ/Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBJOfN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:35:13 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:31714 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJOfN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 09:35:13 -0500
X-EEMSG-check-017: 57547256|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="57547256"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Feb 2020 14:35:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581345308; x=1612881308;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=qAndqAlfCaeKb5sYTSO4FstGvCY0AOjNaq8NHNUKVcc=;
  b=OnyjQ/HysUo1azr/Po/PqHjgkzZx4FoZ4P2RaUXsf/xxeBZLUg9Q2uF0
   PCtqH/j4bwAza2fxVr2CIDAS/xsmG4MotsMfUdf4hTLlUI8UpNm8TrDLK
   a58hFJflK+0zPAYBMVnk8s24Z5IrVGBFhY/R5IHCCetcWIXwEqava6LTe
   6m9k3aNugorFro05yoTcpzW8mT5ZcDSvQrfFD4H/BPxsgzM9nHzENeAUG
   ER+81fMIP8sGeJFGl/Dt+LO88mJNEu6ufkCKkaTDWZjs75KevP5udhPVp
   yiyVaKKgEliwRAEcowXr28HAIqH8UQqU5QrjwTBweeOJI8M9I3k7LI4of
   w==;
X-IronPort-AV: E=Sophos;i="5.70,425,1574121600"; 
   d="scan'208";a="32867121"
IronPort-PHdr: =?us-ascii?q?9a23=3A7Be98RPrRoGrbsqsRgEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I//zrarrMEGX3/hxlliBBdydt6sYzbSP+P65ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4K6s91x?=
 =?us-ascii?q?TFr3pVd+9LwW9kOU+fkwzz68ut8pNv6Thct+4k+8VdTaj0YqM0QKBCAj87KW?=
 =?us-ascii?q?41/srrtRfCTQuL+HQRV3gdnwRLDQbY8hz0R4/9vSTmuOVz3imaJtD2QqsvWT?=
 =?us-ascii?q?u+9adrSQTnhzkBOjUk7WzYkM1wjKZcoBK8uxxyxpPfbY+JOPZieK7WYMgXTn?=
 =?us-ascii?q?RdUMlPSyNBA5u8b4oRAOoHIeZYtJT2q18XoRejGQWgGObjxzlGiX/s2a0xzv?=
 =?us-ascii?q?ovHwfI0gc9G94CqXrZodHwOKoUTOu7zrTHzS/bYv1L2Tnz9obIfBMvr/6CUr?=
 =?us-ascii?q?1/c9bex0Y0GgPZjFids5DpMy+b2+kPtWWQ8upuVfioi24iswx/vySvydk0io?=
 =?us-ascii?q?nJmI0VzE3P+zh8wIkvId24TFB0YN65G5ZXrCGVKpB2T9g+Q2BopCk6yroGtY?=
 =?us-ascii?q?S9fCgR0psr3RHfa/uZc4WR5B/oSeWfIS9giX54d7+yiAy+/Ei9xuHmSMW530?=
 =?us-ascii?q?hGojBYntTKq3sDzQbc6tKdRft45kqh3DGP2B3N5excOkA0kLbbK4Ymwr4tip?=
 =?us-ascii?q?ofqUTDETHymEXxlKKWal8r+vKp6+T6ebXqvJ6cN4l6igH5KaQhhNCwDf4kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/ULlW7VFkuc6kqzYsJDePcgbp6i5DBFJ0os79hqyADir3M?=
 =?us-ascii?q?4YkHUaNl5JZh2Kg5bzN13TOPz4CO2wg1WokDdl3fDGObjhD43WLnfei7fsZq?=
 =?us-ascii?q?p96k5AxwozytBT/ZRUCqobL/7pVU/xs8LYAgcjMwOo2+bnFMl91oQGVGKIB6?=
 =?us-ascii?q?+ZN7jSsVmS6e0zPeaBf5UVtyjgJPgl/fHukWU1lkMafamsxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhmswBHnkOvgo/SuzqlVKDXCVNZ3a9Qa08/Cs3CIG4AofZQICinriB0D?=
 =?us-ascii?q?28Hp1MaWAVQmyLRFDue5+JWb8pbzmUK8RskXRQUr2mUIko3hyGrgL2y7N7aO?=
 =?us-ascii?q?HT/3tc/Ynu0Nlz+v37ix4/73p3At6b3mXLSHt7zU0SQDpj57xyuUxwzB+41K?=
 =?us-ascii?q?F8h/FJXYhI6+hhThYxNZmayfdzTd/1RFSSLZ+yVF+6T4D+UnkKRdUrzopLOh?=
 =?us-ascii?q?0sFg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D6AgAYaUFe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBWJA4ZkAQEBBoESJYlwhXuLUAkBAQEBAQEBAQE3AQGENgoCgmo4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGDAgEFIxVRCw4KAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJjP4JXJadagTKIb4E+gQ4qjD15gQeBOAwDgl0+gQ6GTYJeBJdCRpdqgkSCT?=
 =?us-ascii?q?pN4BhuCOAGYVo5knTYigVgrCAIYCCEPgydQGA2dASMDMI5oAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 10 Feb 2020 14:35:06 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01AEYBK8263049;
        Mon, 10 Feb 2020 09:34:11 -0500
Subject: Re: [PATCH 2/2] Travis-CI: test that DEBUG build works
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20200206131901.535779-1-omosnace@redhat.com>
 <20200206131901.535779-3-omosnace@redhat.com>
 <6fd93c7d-e5fe-b5ce-d5cc-b11125b9c587@tycho.nsa.gov>
Message-ID: <df62aa07-b071-6160-f913-e7b25242744e@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 09:36:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6fd93c7d-e5fe-b5ce-d5cc-b11125b9c587@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/20 4:27 PM, Stephen Smalley wrote:
> On 2/6/20 8:19 AM, Ondrej Mosnacek wrote:
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Both patches applied.
