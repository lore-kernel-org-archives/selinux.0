Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1958C38145
	for <selinux@archiver.kernel.org>; Wed,  7 Sep 2022 00:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIGAjw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Sep 2022 20:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIGAjv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Sep 2022 20:39:51 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B241CFFF
        for <selinux@vger.kernel.org>; Tue,  6 Sep 2022 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662511187; bh=gD9x3DjdYEDSI7NFg6GvRdSoQ9DyzxzSpSGo9vNZC14=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NEXPdyLMNgZoEIGLIdVHwKTrk7qxwpM08ej3mKUIEjxLEFNLnfsNE5xJ2y+om5ndY3PG8nZz0Z6CUIBl3N4EiU5th2tEGF+7qU12pR9I+HBROTIM9DeVLwbpdb66IS36ETAYCMUEixhEheWQeFnndcsjl6PXBju9NYhweII/00Y7kSyl88l41eJ9oZEQhjq6I+innxp+mXU/PqAXzdN7uxataS436YyP7Uh9I6tgkTChvJLgCWFulLIGTgD4q8tHcdx2pAREHO67m6okG7Pcv0E1pIHRZYiggWxrZyb4g+zMI584zYKqJb9J5RJR9sUN12smLRv0O4NyKQ8eFKyO3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662511187; bh=87O5ovx+OH6roD6bV1e0SPfxlRb7iz849jUBEktmnyx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ijRSZrc5sZgg/GDhZ94XuHemH80dpBLmcw0Oilg2ws4tceeoCCtkuJQlVxV9uKiEsVnLAzqpu+AedBCUzWdenStgY7RNYTObJFf1aYvyxFenBeHLzxuwGNx/EzFwo9N1BFwYjp6XMy40qGsKSW0wwjEOBsfo8fUqIbcrckp6sIgcVuUniGySFG0q/Efq9StEQuGwIHDtzpUxHaamRYnFSwv4BmuUKv3zczMKYWwmZ6mPACesi0HpWRrEBu9yqHHhieH8mSP/ZKQHqjknxScfdufpikOBKphqQ1mfhD1ZZawyP1Ayfembuslfk9ZF6ZBOhoX/wd4Dbu6VMqxynvjsAA==
X-YMail-OSG: Mx1kUzYVM1km_69YEiIpAoE9fuOO66qiO.mKmqjlnDypsXSXVPbDlXYs9T8eLe8
 rmpIufPMHik_f4jSNPb_CERU4av6hw.u7DpKuFh9dRKQg3qL722R0lS2xCu_eZwLCMzLdwLbTV_d
 709WM0scQ.lHO408Q5V5UmzhrJjciH8PEmOz7SKiJnJao_M1XfXJ7vbeUHEQsq9FR.vtnNbiyhmr
 5S8KEo1hsYUwB7pHTTaBMDe.qJJBGjeJ13wzhDQkK93rIE1Nzxtyd7rMC9NOhY7hmsFLRxmiDm7S
 sZETfSP1JRKumyWlsgJAqgZBprxT9FhkW5vUjP4dn1gCSV8FJElOtfRl3mFdcj9K_ISPNoi_tITQ
 pDfBppH6MhIeeVWAK.5Ce2F_Q.zAE5deNvLvBDTrpoegkgpQG0Zl9sxgAkqio3m5Da40yLA95dTg
 LoXkQbiGRjzGbC5Agl9eQ2f3lvAcd4pkuYejYvX1MAtW5bQypwF.KD.l8shBk0286cNM3JJCBC_D
 VoM.kYjkiMTkzJUvaQvg9ZnSCbLZYqsEMCVZPVt0si.cFNHpgL5nZJno6SWNuAoOOPMvxZAsvT19
 N26O8sypYOUmaONqd.GlY4IDkQWdk5M8N45ylfZNrmE6Le3Cp5bstlt0gYqqFcwSzVwvShX.8mxd
 Ffn4Gr8tbQ4vGJu2v0Uj5PwcutGjoT5daCJgLqqHARuh07y58WfryKDQH15Fi.aryblq3DNPMzzj
 6VfFQNeYGuMVSPJf7_MnAf9iaFS6ej2XiFvtdynD3toh9OSEun5BJvB.uiA9WH.4PoF0NIULjtL8
 NHBu2ZB_fMLU423LGFE0gFXBtjHQdsG9LRNlKIJNF4MQA1ZXcYJL3HZ74HXeyMfUG3gVRx85nTAD
 y3GEsvsfvm3FSUAay40.g1j.y0Pho1k0A8OZyjOi7R59KZVvckEpTaLixexLZSsYjUOTvD_STvMD
 KEGaXWkuQD_1c0X6bO6P_wlmH.Ua7q_cTn3r6v7B7juy4qOuarazsqt82DTQoPkBJFtoRm7ebxTR
 ZuVCgg5rTYQGfv.CY5a5xArDLin6m3vz0gSvVfltdULxloU64v8_q14sQVpFsfHyYKTWW65tTchU
 1zbNAAqdQZE6BBDTudP2hFXxZ10wcebWj0rmTMwxCnu0_obZBQUG4Fjc7267WxzuCmC0NcU6oLdW
 qO0oFSbCeOPkDHfO3yTkZZfAdHftvYRPrmKl8NEMFDt0Mam3m0IzsIXwG_RxwStMuviIf1ew88GJ
 iyp4XjWqJwXZVCe7qhq75.ETZOJLkuaYdN9jzAofW3aXXOkKP33n_bqa9jeBQYAi2PTNEnZWtPdQ
 XcZNGJw3OWOxeGCf65ObMi8gIDBk2B69UdLQLBIsBDp90.xDe7TfUpZ_zmr5uGVqh_GLo32iRr7H
 IU2qMlLmX_b.umAr1v8mgn3qE6L31brf4rdRehx6kZzxSoQ9ULw0jlUAdWdHhFCF.JBNe0wD1ciI
 9xsvdFOCDMbu3P_ynb9K.U3RjXRPvaXFiYkbmjPKl.wIUf6qysL5y6ijhaRKU1L5NNrNc8zII6P5
 HgHRj7pbaDtQCCb1FqymAhaUdCfqLFpg0d0x6YDUFCZvtKWzmssESJDAtzBIpAO4ckHf5xe7_MVt
 NuDfXT6wBNTgHB2nRyqcfG3c2URyr1vDshzpKOg374S30ctLlRTtkx2tDLxdF3URaNPQ2gjWGlHW
 OeCKzYjzI60AgdNojYwG60nm09swrTgddXKZYJBUnRBY2GPriVT691tDtObpdHsv34i9nLIVZBJA
 W_xZ.x5DsPa1RbtMUiqdli2XXlCYgZkalmAyVV5PXJuIaCuVo3jHJXHEpB_yZjDqRFIXRd41dqv0
 3I0MeXduw8GOVgX4SSQq8ewpygrEGvVC8H4LmYqoiqOT16FZR8dOg5SXycCHJa2nRSN6yqJiQlxO
 rR5eYWYjW.4nrUnX0UJswOp6dLSyL05Ki8wnB6DWDVo7Wyq.OG7rDb4TJj3a9.J_47ZMrcyv4xAP
 fZk9tkq.YbxFlhrX00lm2C1Ju7XK4kvk06e_Fvh_Y3jQ96TBasZZ.QsUebgwY_O1sYtVdAvegQvm
 dXl3UpRiITDsB2_luct9oN_OoH1JowuyBNJtK90Thylx0WEyHSl5GfEt5Hx3Cys6MU7KuPZKCYIW
 XitLWxxoYpc1sPCRQllBVTd0ok7Ke6HPOmGIJ2giqsbr.fVmG4xbE2JxTZA0El.jVa2TfimFKPLK
 bNMNvjrPRDeNoAx_L2G8eVgZxxViLx_FNUgwE2gms32s-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Sep 2022 00:39:47 +0000
Received: by hermes--production-ne1-544744cc75-mbjj6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4b397c4737c45baa73178e7833941665;
          Wed, 07 Sep 2022 00:39:46 +0000 (UTC)
Message-ID: <282b66ae-ac7c-533d-75dc-4973fe440fea@schaufler-ca.com>
Date:   Tue, 6 Sep 2022 17:39:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/6/2022 5:10 PM, John Johansen wrote:
> sorry I am wayyyy behind on this, so starting from here
>
> On 9/6/22 16:24, Paul Moore wrote:
>> I can't currently in good conscience defend the kernel/userspace
>> combined label interfaces as "good", especially when we have a very
>> rare opportunity to do better.
>>
>
> so I am going to grab and hold onto
>>>> Further, I think we can add the new syscall API separately from the
>>>> LSM stacking changes as they do have standalone value.
>>>
>
> what I think Paul is saying is we can move the LSM stacking patches
> forward by removing the combined label interface. 

Do you mean /proc/self/attr/interface_lsm? /proc/.../attr/context?

> They won't be as
> useful but it would be a huge step forward, and the next step could
> be the syscall API.

