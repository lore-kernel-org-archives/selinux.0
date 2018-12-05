Return-Path: <SRS0=kQjT=OO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDBC04EB9
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3160B20989
	for <selinux@archiver.kernel.org>; Wed,  5 Dec 2018 21:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dXEDvEel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3160B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeLEV6r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:58:47 -0500
Received: from sonic312-28.consmr.mail.ne1.yahoo.com ([66.163.191.209]:37006
        "EHLO sonic312-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727679AbeLEV6r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Dec 2018 16:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544047125; bh=hSnsh+fGa9sW82HW1zgE+NRx74A5RFN4ktDxDWVJipA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=dXEDvEel1QARFUdYNVmh8raeoulj8/6DtzEdkdaLFcpbGohFWJsc1lNnTrN2mvlf23f6G6lRGGti3w+B3xFN3uoXT+9EorY9CSmch7gDvk1+N8c0OTGnikI4OydkPLT2X6pe1A6oGRn+znQs1hVn6142hfCwdq5D7mWN/xTU6p876RvOdULSmAu80gR0BqSc/595lakHrqVQTQg7fnVY8+L6CE3FtL/U/GIweYR27qF3RRaDzOMVgHfrqliijo0f+pmIFlD6Ec1acysGGmcVbjghUWWerOs4fj7ETDAKEGF/UDH+v65sPfPbO2JbKJOflb1s4e2aEYNbLZtrMdK6jg==
X-YMail-OSG: 57JlH0oVM1kWazq4FsAo9pOVcJ5p17YHHQEMT0SJOITwP.tlFSAR7reZUOiv80c
 wXV04SjotuIMqptGbFVTFc2B_k6jHG11DBYdRYfptQxNxWEk8EaFcC_XkAxcwVQUIPzoc0HS72pv
 uweVN6mCDWQq4s6EylrNxtq5neKLekCVxHcYEtK6h5X7Vvy88TmNOzXgJqDP9VXLyuttosrW94xi
 1SKUvteqlaxVAxFjbBzY0QopI1_qz_gmhv7DNpyutF6eFuH74NibBSgQSZm6jbPz7XDZtBEqA9BT
 hwsmmWsde2ydjBa4P4fGPFTpEwDaeyyCXqgjo662fDzMpwW8YhNjWz3a_X_dEXmA0Eseb6cvmjaq
 xmBOfaHvm9gxVum0lXRdkRAVC1jHdJlEJXj_i3TZOHADTCYoxmJBF5R5NtGzSqe34PJWZHxr7Uq4
 Je_.z4Vh50sWBTv_XKl37jghIgXu70_ZTu.VH_gvEROxHI2gHryORF2a7V8byKW7G8X4XC95zVv7
 iL34_TISmXdEOrr283Doqgbx8ZM5ioskr4_nUGV.O47RBrA8Ae56002UY8WMju2fWnOyTQXsI_kF
 qHTRL5Od12JfxnqBIy5HbvwgxXg0zBJixlrw76JmDupg_XD7mDOUza3QAOHMPCUFWYanWlp3Nyy1
 EeOLoKpWTRgKYm3w6eOKKew.a_QZ35cMkCJeYg8x1_wfx25RmmyM_viU_ZL_HIcvU2tFH7_Rd0RU
 BGn4fiwE6FwiX4rzKL9FCnuco_bqi4IK7dGDdxnhcEQm1F4hCBZ82aMdKNr_xZhkmoKRqEMJCE0A
 uRhTjg012nm9NQsYGdUfcG764g4QnNFnnhJa16t8i4f0F0Fx8r4yAZHxQjCmcT8u4Gnm2Aehpy__
 GKB5zIfK9ofJd9yekTeHRYEcPSLjlCXyQZZDP8oorqXw_3Mf5PF4oiJYwXiaD3c_Z2e5_kpIqWh_
 54zn6T0Yd5MA9fnZ3kbYQZTNdpKAu3KcmLSMq6XQQ5.P.woHQHOHK8WojbMUUmfA0butB4vyvr6n
 N4p_ShmbSPhlDEEPqkXNJPGV2os0cmck_c39Qim2f5tsQIt0JC_pvUkoNSMPnxGm.CaYfIzLMDZn
 OVElk.JUK3Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Dec 2018 21:58:45 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 862d5638bdfe479fabff1c6cfd7039ee;
          Wed, 05 Dec 2018 21:58:44 +0000 (UTC)
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>
References: <20181127115246.00967523@canb.auug.org.au>
 <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au>
 <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
 <CAFqZXNu_=MxcX5jvX4y=5nrCqi7_btOGVccbH1NZ=xm3TGvaYQ@mail.gmail.com>
 <CAFqZXNv642dfT0PpB0M7sO5J90cAM7Luv0A8nX7JtEXqw=yu1w@mail.gmail.com>
 <CAFqZXNuv_mF8Yt50J3giZjxzZX_WwCOePZeEtmR-G_m+vRyPrQ@mail.gmail.com>
 <20181203215639.GV2217@ZenIV.linux.org.uk>
 <CAFqZXNvSOzyhnTUxF2mP4BTFMVQ8H1uh-Yyn2fH2K=4yRDX-tQ@mail.gmail.com>
 <20181205161601.GW2217@ZenIV.linux.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <eae92504-4c1d-2430-4d5b-b5b1f4af45ce@schaufler-ca.com>
Date:   Wed, 5 Dec 2018 13:58:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205161601.GW2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/5/2018 8:16 AM, Al Viro wrote:
> On Wed, Dec 05, 2018 at 10:37:56AM +0100, Ondrej Mosnacek wrote:
>
>> I just tested the Q28 branch rebased onto a recent Fedora rawhide
>> kernel (4.20.0-0.rc5.git0.1) and that code seems to be working fine.

Not so good with Smack.

	# mount -t tmpfs -o size=512m,smackfsroot=Pop tmpfs /mnt
	# attr -S -g SMACK64 /mnt
	Attribute "SMACK64" had a 1 byte value for /mnt:
	_
	#

attr should have reported a 3 byte value "Pop".

