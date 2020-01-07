Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7386BC282DD
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 21:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358282072A
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 21:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UmO9zuAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgAGV6W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:58:22 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:44402
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727078AbgAGV6W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 16:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578434300; bh=ZgM16S+yzcU3D5IdNk85pdQI4EK0GOciCYzwwibnpjY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=UmO9zuAPeTh1M21SpUh+xeslsYNOUWNydk+IEnqwJUpuat5zDqlVMLG/GrHqIR4yP4swg56PE2eZOKlmW2QcmRQTZInychjc9jgLVpEQTE08RgvjFCvEl29Hq1JFB7VKzMDqSgO6YsxYwWfFLOE9+HOhunjADz4gzX3UWWfItcXyJ5kaZr/tXhTlYt4OQL4/H4U5qYD3dA1P1EY1sC8562gLM2EWMPiinawhVsQMZZV69fEwsuvBCZN4fZejn3cIxEZ4ljhqmmUHKkmBOS4Bw2gZj8wfLr6NnPm/RbmJuQ6T0CR34rWPL5pmO39hDOJsOzegu2a5VdTV03bupClmbA==
X-YMail-OSG: pfthcRIVM1lwDDp0xw778UXa125OJhJQCvtihXqRbw.q2U1nLB6ynS2GYj5NdgJ
 z_gXVMPHgOoaJJ3Dpv2xZP_f535enrGGpCqH_b9Tj4w0EaH_J4ojXo_wWF8s5Ocz5_Eh0fL3TFL.
 ukK7UOGA6a664ygQtDskWzw6.hxVx8M.icTP8JaG5LgfVkxcp_xVGmDgjCFeKfFTj7Nhabgel8R4
 94diGl8BUMwZvcsskS7dQWkQLnLElWrQQv0dlckYFU5CUpq0Xk18pxaet6LKlXg1waGtzl6Y9cs0
 QzNkbrMZSWGkEImaR.dRV.ykfH3vBWXPyVBwecbmmMUS2_RHYsAOa.GMm6uQiEOce0K6HNuQYkmW
 Dky11eGyoynzCTK81sXHf8qYgnf2IilaZA6eYLyAuPCmA3UxoQhU.qrWTMKxY90oeztmVSYQ9y5B
 gHlb1Wx7rui.C5KQllcmRZpVXyxijn1XLX8ljxolB080o8bkp5jPzo8EZqBtgEImr6GcCErwBqTW
 kvZGK1WgVVOjsD064G9ggVIL3kYNm8vhi_mSyOBdM1EIcVzgnSApyj4H_unmn1Gi.NpsC_ImJOzS
 DMrUsOyHJDnHk8FmW.10bVvLPTfKEcTupU4vchKdQ5SjfENSZxHwBcu0OVkKpnEKeC79TLFuGnbC
 EBi4Onisw3rfkxMz9Pw4srks8ZeUh1CZz4tpLrzcIGdQPn7mo4GEAniBZkAi.inP4PwJj4mH88Nc
 A79tbeqaKeIGR7VRJ5DjqclBZXy6YsRrGnnd6cn9lHDFWu.nZIFx_KCnCPjx8Rmy5vRXn8nFruqo
 OcDA4N01KrcdWDp.pjoGcF0qwvwmrk.K1R4afV6zW8._uXlHDNwSh.FBOfGYjRsQn9O8S3fFFeZx
 XQsb36jZaX6.7NLUA8P3BFuE6Gk0ujssWiCRh2r0UB7CJKn.50DiLDIAjlrIT4B55SMwp_xrAYQg
 k2AOGYJNkmajDREOnnQl8837O8_jqlhdegGH6e32LN3_W.7M1EZAIOgXwqqO9VKvc8vsQA.GN1fl
 7yXAW4oKllzLUVgaNDs1vvAssJr.Boz2UiCGbm.XOHb1ZZkiqkEzITkqLDqq4hDunlkeOz3xnDEE
 2.MK1pg2Fp63bZXHTpkJzv4AwjgjKQZCqZsnvRvwEQ.Xylddu5vMB6ANf_sTTLiQ1m.d3RRnvFrw
 _F5s2q8qPol8yqhRrRrL7AkDpV927rvEQ5pHtDtcKfzY5gnm.IVWR6pR9jsMhHFnadHjyeaPY2iz
 IweYnEYWVCTOQrSuHkw9iDzCS0kE6jYP.Swt0HaH5T6QSOLV7byO_CAQQSXebyApuu30AKTC2uJ4
 mdxJkIF4Sm6iasO8hxoytGTw5HnxOT6dyluErmViNG6hzBghIzF7YWnjap.CztgPodG5sFncGsoM
 LLmYZSZowJCVSrmiEDKevZMCFvBsc9XQkh2hrJC2EsdnmgY9K6x0z
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Jan 2020 21:58:20 +0000
Received: by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98cc31e78a274a6596c0686b5b76bc10;
          Tue, 07 Jan 2020 21:58:16 +0000 (UTC)
Subject: Re: [PATCH v13 19/25] NET: Store LSM netlabel data in a lsmblob
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-20-casey@schaufler-ca.com>
 <9e114536-36be-9395-ef00-cd1059d710ac@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6df1dd00-061b-234f-02c2-40e3fbb8cd0d@schaufler-ca.com>
Date:   Tue, 7 Jan 2020 13:58:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9e114536-36be-9395-ef00-cd1059d710ac@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/7/2020 11:25 AM, Stephen Smalley wrote:
> On 12/24/19 6:59 PM, Casey Schaufler wrote:
>> Netlabel uses LSM interfaces requiring an lsmblob and
>> the internal storage is used to pass information between
>> these interfaces, so change the internal data from a secid
>> to a lsmblob. Update the netlabel interfaces and their
>> callers to accommodate the change. This requires that the
>> modules using netlabel use the lsm_id.slot to access the
>> correct secid when using netlabel.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>
> Why is this needed for stacking AppArmor?=C2=A0 AA doesn't use NetLabel=
, at least not upstream AFAICS.

Netlabel uses LSM interfaces that provide/require blobs,
security_secid_to_secctx() and security_secctx_to_secid()
in particular. Either the data maintained needs to be converted
to blobs or it needs extensive scaffolding. The scaffolding would
require a mechanism to identify the lsmblob slot to be used in
netlabel. You can't always use slot 0 because it would be possible
to put AppArmor on the module list ahead of SELinux or Smack. That
would be the only case where the slot number is needed outside the
security sub-system. Since converting the netlabel data to blobs
will be necessary eventually anyway, I want to avoid having to
provide a mechanism whereby netlabel can identify which slot to
use. This is especially true since Paul has nixed the idea of
assigning netlabel to a particular security module.


