Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40895C433F5
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 22:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiCCWeY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiCCWeY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 17:34:24 -0500
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4B13C3A2
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646346816; bh=t3A0SBOU3DBe7RgP85eL7GDHMVpdj43sTU6aZEn7g34=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=oFGFcI25YRszxNw5vgUznt0SvoHNOR9RrqZYnh2WoYoTox1KF0wC04ydC/4nIl7R3PF3Zzp2ECpWsWulCyq/eCNnl8eqQUr/YpmKbZh/LoC8bWt9TVmYV7ZpLNsd+QUvs0E5ggDXSc/z+oXqQ1N5JuGYdUfzy8GYSiYH7/qmUOTWazRvrs1P/57/7+lN82ix9RbFG7dF4eh9nUGNTOMPnxdLMu+TBTzg6hxWDmcGZMmnpG/q/wF0ZNIg5wsXJ2utYkNzQRheZ3Pw4HINmWyjCQTWE8zHEjTKfnLJiWkXloMyrIZh/Au106OuoTjOizVNQxCuMMxdUi64AE1YobiDZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646346816; bh=njodX3bGtSXoietVE+/pwlJtzS/LkhWOOCGxup5ahLn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HS4VbxgAbIIb6ELOTwLXaTdusJ6IKBV7Hl0UbGtamy9Kq+2aPt6hP3AtIPKYPSWnRzfdqyezzVyAAPv21LnLYuVRIyKEGgTm/ArVy+nRPqhyvlfCHn/xkd1//hbrNGPeJFSb0SeKUYyVTNMzkkW+UmX+AkBqJxsTsty/ytrRXW68Jx3fhCx3u8sRaj1FIdV2EM52rQ59PArelgIOwU5kAeOhvdn55zwObUmFJebW2oJNx2FtxoYEJBnVGdt+F1VOUJqYb58DunIVVbLIa2Gm+mOexVRx1fSGbFTCXmZJlH3FV8TTQGs9sXgV4tlntrm9m+c6Hfd4z+6yYaklUGn0Ag==
X-YMail-OSG: LrkpO.4VM1kmfETwH45jZS4XEGGrrf6Irk9_4bqn9u17Kq_mKdY_NDh8EEvW.hf
 wPNZ076IVlmfqwjQ9wwasVqYSxXJj_V_sMLM86cnd7_PCIs_XH2tYbWfZSFaDdsjrWBxtaTVRTej
 w0T.U74iWmxp.gdeRyXWl3l2jMnnq40PSbz4AMBrSLyXPsjmct.va0tUlcBVByvL8REmCdXTnIeT
 9uMP4IQEm24AuNpa3WsmKuBlcLuGRL3.IuaM2_Pri779BQvLMTYNEUX.S3etZvWZaper99bYhPWQ
 h9AkORW5TV8JLG.Zllfi6n_sMWLMGl9E_W.Y3_d5giG0fysF.6mLMYR_DJUlRGVO1MiConpZBE.l
 tilqkNk0o8kFI0UMqO389Gk507TwGmkJ5kRpIHLtvJN4yTjx9gYvL7GH.rzfehBIX1NfsoO9kYkB
 XzDO.6_6jJCg7gaOFoXdTXucnid6Lmiag1BDiudwen6m_Xty5NNWmBiPlcDNHjArZQwHte.7DpEz
 5dWnorOh4YRt0l7G0DdCwrE5q2geh4DKzEqnNTpXgW9qJhkBjmx6b55QycShSqMrZLBG4Wyh4ykt
 PZiAfjr6zhCPN5286pazs.5g3gu.lPy5hHuTJF0Zi.wRrWEWMieCdHQx8T7xQTWw67sNuLNYhuKt
 vPkaIqPl_QPWxQBwMC9FMEDSo9.H7fjmVNq075CTCHZBMYko7hY4pHPZzf0cklKKpXQ1LEciPECX
 7xhv4um8tGyI9KMu1STMRICrl4eFZG.dxoiUwwRAEefwcBhvVF0oUMHFT6BpGpcUppUSEQ0TTqln
 47Q2AtlZj.RYWFF9sHUvYlOzQk6p1mkzmY.T12t8T1Y0f2cXXegSF.cEsOW6joGvp1VV6CoiEuTY
 Rhgd.R21kNVEyWSGlJCbznmSs83FzWsQdX1h3ulueivs5BgfsIF9UA8eHZlaX7qDvFSEfVJHpobO
 Tx4GWSC11KN8EbqeSTgy_Dndqno1pZzQn6MP8J.PgK.SmDxC1U3sR4Odgr73p57bFYMbnG5g5eRW
 9M0nBJPel.4B4KK52v1X5vNGuQnuInYo24WNervgrkpEIeqhk97su294odIXuNk33k9DAlQTxxlE
 .s2stIj9gZWqm2qcnBUAM4gRHij11MuGAgqGpw7Gb0paxK01zis1SaGiwr9Cyf7ukXyuWOwapewu
 RH3c0iAZgul3_BKAy65T.0p86nEHESciA65TZ._jbxtuQtZEDd3ElO5q3Tq7vvTOI.jbaxhRRKe7
 gNDPqq5Nx1u3uk6ArGlVmlG3ro4pQZJQwm7R0015l0SXWhZer0JcB8i.K58BzFTRG5A.HOqKpuHI
 POr.SU.u9qV8WuPko8ygfBH4n9XDReW5asfIthifL3XI4oya1J4JL0yJhik8Bh.4V60q8nFWeZjT
 0SJA4ChHITQn.gLNnYKiAFMLi2GEKlLbe8twK2.qQ6tU2OhcbYv2GIU4_bxrKu4oHESOD7tYIPTE
 80bGQNkPoto7YGDqiHgmX77hCSrRzvYq4hpdrAaIuWmhhIK8pwE5kREe8.7ul2s09hK5uhklYZCW
 OVHimp8509xXhPIEqq5bExOuh.8SaJa8gj2pGzqqLWXRIw1MwYqrENvJffi1TTHiphmWfYI0bBJD
 CTto05WUcBS1.GyV1jVCa4z7s.kHlQlGWqpFesS9airAJNVkbwpuamXC6cwpfSHzn.Hv7N90kmWw
 TbobodKh4AfDTZtfDfY2iP44pMVZ41KTCnG6aNmixMvOnef2A3b5cRqFIapFU8K1FxnQGLFg3WPf
 UE762UQ2n0Bxf3woClavrufdret66jjtFKPlm7IraO5IkUmd03.urtgo8BMeDOsxCq9cdsH54FLb
 oQViimokrFEksPG1OhCgYgAvXGA3EVXmixHaIsF.aV4BBAeGbRZwy0z5CXLxvDNRNfEHcPtE_uWC
 C2hnOTWmiPy0VX.gxo7FZzEfQIBkd_4rpOe3g5tcMA7CdAtNj9Rri3RsAfjVwuLunbOpFYANpF.m
 rIxDWGXxQs3EBSbJUbrWovlPbdluej2ELnu9sdbEbCz0GTqy2aOv9sZ0GHFI1kXseiYVy5F.Sc7N
 LPxcUaroi2YjCOtYUST4dYdzgvmWRB5NgAggPErq7eA3TWq8_BV1ITzIGU_dQkHjno2eVmAOn2z3
 bxSgkrX4T1EYjKL3ZKZgqSE6ZQvh_cmC5OYUBwXqVuVR7UvWSXuxpQtXKN8nCJUjrBC6gmImKtBL
 9.7d.ijy_Wg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Mar 2022 22:33:36 +0000
Received: by kubenode521.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f153a8776bfc35ebb1bb13fb601b70ff;
          Thu, 03 Mar 2022 22:33:32 +0000 (UTC)
Message-ID: <4e4ef3e2-ab41-12fd-5cd3-77abfc98c6a2@schaufler-ca.com>
Date:   Thu, 3 Mar 2022 14:33:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v32 24/28] Audit: Add framework for auxiliary records
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-25-casey@schaufler-ca.com>
 <2f32ffa3-7165-f989-b162-4aab162b5027@schaufler-ca.com>
 <CAHC9VhSzaDJX0cxtorH0AvqUzSKsr0BSbhfGtHEJjFKDRWc7oQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSzaDJX0cxtorH0AvqUzSKsr0BSbhfGtHEJjFKDRWc7oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/3/2022 2:27 PM, Paul Moore wrote:
> On Wed, Mar 2, 2022 at 5:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/2/2022 3:53 PM, Casey Schaufler wrote:
>>> Add a list for auxiliary record data to the audit_buffer structure.
>>> Add the audit_stamp information to the audit_buffer as there's no
>>> guarantee that there will be an audit_context containing the stamp
>>> associated with the event. At audit_log_end() time create auxiliary
>>> records (none are currently defined) as have been added to the list.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> I'm really hoping for either Acks or feedback on this approach.
> The only callers that make use of this functionality in this patchset
> is in kernel/audit*.c in patches 25/28 and 26/28, yes?

Yes.
I think that the container ID record could use it as well.
I haven't looked deeply, but it should be usable for any aux record type.

