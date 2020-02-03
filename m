Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CADC35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2EE20838
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 21:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VoVkoj0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgBCVoA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:44:00 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:42144
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgBCVn7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 16:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580766238; bh=5UEIxHesn1CYyqtrmlrdK11oeUvkG+6+qWpDtU+p3/w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VoVkoj0Nt/uuQASxkN+b8byo9UVkMCu/MVqxflgoB1mREi68ptOD9UFdfbq3QQ8mM+npupiYHRICv5xSf8vjqL2yhfBDokP5EwzGdBeWFaoubmQYY+0g6so8pgQuISx9PGeeBoLqMgHMdxDLkdMS+LPyOgvbeILKPCEAL/OQfR6ZXEDMswyKF8U5Ydo1Ah7+udUbPt3m2JSQV1pM+XS6foSmRwOCmRNq1Oha0tUAG9v1SG+QCSvyvMUBjm3wlFckc3n6rQMXPepXeh1YD8V5bkakSUS22XJzFM55rBmqkKEyDMMp3fac2bvaBaRRDAMgR6oTohIxQsnoftOa6mhbig==
X-YMail-OSG: .piPnDAVM1kshKTzTTGflQZzAlqiYZialm1bqNtvKRXrh03Zg0VkbnNLHDHQxzR
 9CKVTyFUhkVcQzm4uKrCcfL8aAZjZQNGorvbhgdO9N1Fr_TholzkS6d0oA_ZJm0YlsbekM7JJE09
 sHmpXYRjBMQWwI1PBCntRRejTovgL.Vk0fbx.nm7UHGyE_mDZm6Ex.8bHXYrAywZhMki2a9lC5R9
 8SiY27RH4XLyDcWdPAmRGVoBGJG22Xbxp1DJcMD90PTxGdBPkQilaGlNu05E7mfqzRVRczgXOB2S
 2yFDKlkke6xOJZquGzeqXB5kPekAmBwQm7L7lCdWho3Ip4YBWuz0vWRGCuuBy6sAuOQnzjBNfRHy
 ufDiy5uMrY9HROrIMD47225UNX4Oos.40TpH3eIWeNBAq46feTOXEjlXP_0LFINj_ihHLiTFAvJa
 N.r57.GQ_nv_0PaiIDuGAeLcxVpZXMJJfSR2CbQp7uR6n_UjcQGWQVkeKD4Qk2cZyam.NpRdarbx
 .7vnnIgpN1ddwnnqNv4WjPg777zvT_elreBVTCBr44RST.1mS3HdZJsBTgD8v6It_oPwxrnkUMm9
 nwxXGOa1krrV7wMA4BMBsfJV.hEwATf.1_OlBXnP4zvjBlF74LxF7t9PZEFYSt1Ao5jzn9pgCD_z
 xLsXhfDqUXjFXZevzNbcGlooyu_2WuVaYyCCYy_0WXEcili89EarvC6dbG9Q3ExDofBF7Nwd40wm
 EGqdj3F24BEVC8fclO5Hpaf6yWq7n02fpp9YTquzbUaiGjBTR1YMBl4XRMzZMFnh8TO1x9L8T5TZ
 AeYB1VrX_r.5ViNDVGNnp3UfWnD4PGJpjbg25H1VbHfeyBk3hXBpWHS99a9YKw_WoxOCOLQogpHn
 oqD5TqtisBQ2kSDRlsgF1kFkJJbsnZTeqK5.qPnU100sRlY4w8YkemmLtTWWbW.CrCaqZw8Bt1qK
 XpePCp_RDBMsv9hBjK4KGEDJmY_Ng4glZNSZlJby0G8Zs.bgwqvqxc9YxwUNR3IkXemGERjhwnoy
 WG8CiYUb1R9wOQF0jrTC1LRwXa53yAFGd.unhZKH4lYg6jyUAf2u00Z7papieDMNmTrduCCdhKjC
 BTx6YhL5rq7yG5gSoBHDeoolqfBbrZz2vm1XUzScQFrVylH_LLJ8DgxWeBvrZS2y2bHW4Ihlm3RL
 cvmH1HNHV.HYl6zKxHAaZMausrOtk23yOttCJDydTrXTCM2kpYuYdWm65yv3x9N87bU_OSx4FQ64
 gMJolWcdb5lQ9G5TSdsV2IKM1NY8HwW5C21qAdv3x8sfxrhCIN5O26qGFm.b5cz.VMgji9sJqrBm
 P2C19qKqUK0pzEkKUod23IkRDApxcRXEhDyC6OJmLvYTXCl8o0bOYZLgGVVouRqg4sLFCEaG0UxN
 S5L3uggSGbAbBnWt5eaNA_XG5Y4.AWEvosO11Dfk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Feb 2020 21:43:58 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8c88873e8ef9666b09917812c204068f;
          Mon, 03 Feb 2020 21:43:54 +0000 (UTC)
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
To:     John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <cfb7a1c1-0e74-d012-7e88-c3879ddbf696@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ad8c9dce-7078-a53f-ac8a-56f069d7290b@schaufler-ca.com>
Date:   Mon, 3 Feb 2020 13:43:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <cfb7a1c1-0e74-d012-7e88-c3879ddbf696@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15149 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/2020 1:02 PM, John Johansen wrote:
> On 1/24/20 12:16 PM, Stephen Smalley wrote:
>> ...
>>
>> Aside from the trailing newline and \0 issues, AppArmor also has a whitespace-separated (mode) field that may or may not be present in the contexts it presently returns, ala "/usr/sbin/cupsd (enforce)".  Not sure what they want for the new interfaces.
>>
>
> It is not needed for the new interface. And if I could go back and remove it from the old interface I would.

So, what would the "context" for this case be? "/usr/sbin/cupsd" or "enforce"?

