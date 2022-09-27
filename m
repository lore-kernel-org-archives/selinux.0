Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F2C07E9D
	for <selinux@archiver.kernel.org>; Tue, 27 Sep 2022 20:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiI0Uy4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiI0Uyy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Sep 2022 16:54:54 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774D54B49D
        for <selinux@vger.kernel.org>; Tue, 27 Sep 2022 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664312087; bh=Ujm949+aSdtj0k6isn++nGysJGWdjT65eGzuh7Vm7so=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Az+SrtyHIh++oUPbE8huv5ft5eKj96PxnQRM7mO4f2OAxKv+HLV+nX0dNF7LaCSH0q5Vqi9bDr9dmmtVWr+gvEP7yFASyXDPC+PknAebcQnkUxkh1x9pQWkMwnQPfHjIACK5z2PA+Chma1oxy4QTbdROZ+h7bdYn92JXt0yjpO4+SDN0Som8yejYKDDJ5jybmm5mk/Xe6EGiXoBuLpBWelk5jdGdM7S9URHI0Y81vuMsU7Bwpd0QL+Ss1VDCO60bDrmdjXFmQ2QM20Jn0dsCN0/w+YYLSVFQIPutzYgev3WW12f8n7sAUTs+Xce3TAlGpHpxDep+yNJgsq2UbWQ7yw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664312087; bh=m6oLV7Huf4LAiNg3ALTDW14ukEmJMvrB4LIaHcLio5A=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JVCfem15u9LYfg4ulQuGw7AXodo1Ra2K8zGeShNwjVTGYMS8dM2TDJqc4tscThEx+QjPkf3zyQ13dG8brGz/Yh/Gv9VitrshDvymx6gmhfTx8AmYCFY86j+VkGxNXHruyxMst1fSDY3vbOQQXXxHbuCKYvyVsmWtX19NSlyKkBnasWxmnvQ3XSqNAcdI3/3VcymXd80j7SZgXJEUjTsuW7b6oZbeY8I9FsX7oKbwTOKqi8ClDjyYpTCED/wA3RJijD30ZMsGmsiYfcJoCOvpVJqh2dWKXvny+hXadU2vHVq6nXmDa3oDkHgYKAOgGHWiKv3nxSFXtBBiav6yOfUNew==
X-YMail-OSG: jB7WtT0VM1ltgsSoQlpJ6Nb_nKLEjsT78ByBKsDkbBSeZd2KtM.Z72lUbJpa_73
 ToNubpErIwiaSTtmrDFj99oZp3Z0RqMjnWZb0sES6dE19qzTWDfmNO0I_0VuGgasZGolCASfNUPP
 NdEr3VDWJfvYHvwLdqaL3HwqurM4KvFloo4txNW4UmYBEFat4Ho5wYc6SiQh5X2Gjt9lXjNDThk3
 kBVbWYWBfWiUV3g802tHgVpHBFbape4n6p5pRk0_OtZ3V.8d9UdEBPzn_1ivzTxx3P_MRCbTUalF
 BtoVPFts3hpqiYgx0cB2JSO9qevqQIKo.Vg_W1mJfGjHrFbwSb4VS9YBLtqk4vk9QoxRVaAtRRuw
 ezUEDuEiZ0HQjgKaUs2iT.0EJ0buqGSy81vCbfwJOh.Z8ER8PWPjsJj8O7_SJ2WhTOTo69ba9m9p
 jLccN59xsJnm.A.ZCDz0m67PIzAmTt9d1gM5H0qx5xaaEKcU06ynD4L8RnRrJqYqqp9uzf7C1xjG
 7t3jD5Uu2N5sLtg3yM9Ezrkev2FogAQEK.EEGwDMtM9vLmvEUfFfEjgWHFjz3e4qLUs89IIaGI5h
 dOwbqH4IGg1hvQQydw.7RLVCXB6SEsoWgALIToS3qNJYcaarRTp7hYaJZ9.v4hDjtIk5YcEXzTDs
 Vn8BGroVx3wEeTfXSnUQk6uuhc0q0JTh75m5kardmS3bCQQqSzXkkHS0l6g85O.ckb_yr7WB8MBS
 ScWxtJc92ExGefhlqxQaoWr0cpIETuYi5DgU8zXrln3ptgzF4T_j66ltyvUdBbl4sR_FM9dQQWtz
 lzvkER4WHerfUa105P3uiMqNdSpCpMd2nXeESJh4FCeiPfS2vGcta4aEV8ogGGh_dPsHVgbD3hFu
 j3fhdf6sWwTlI7qr0USuQsWLRzWNQ6O6QsubyFjTFvDwTqsLz.latsUW_COEdQ.t6IgED_RiG37p
 i4hvtjRESIlS6qSlzeFUX22daQerKWk4OGlpFFpgbgFjWSaXQRHOVMtgYRA6UjkjqbIT8WQ1bDu4
 1D1nD.pvsGxFNCvFe25JiTHemL3PK2clq7wJTvMU5VuF.eXmwZYSCQtHvBSMv.gYPI7e1LNNf9O9
 NL0At4CrBmpActivp5az8olLuDFw6LOfiC2xA4SdjFZKd5Gb4Rwl1OAZJqTe3V3yKcgLuYEYy_vx
 RCc_uvf9bHIs.WFyBhig1FvtO7OfIo0vrojASHlwE6hQc78kWV0GZvUqUjdKYPJxhxt_dJwXH0uL
 Ta_3qEF.ZP5PaEKU7Vdcs9.tcG9ARTy1rX1f2g5uOP2lf1N6uI2gY6SKhRK1GXbtCx1kdcTio35j
 imeIteAhYJR36GTAghk6j_D.ygAW2JvYackX7luUOUdxoWg8mi5k924ySzRONdbvPTU6oY9Vb4Hw
 K3rr85B5Wc0Jv8ZXyzt1jYdBTfvP0mU9rBYu8bC6trEUSyiVXD5qH.aDaan69DoiNCq9JI4rzuVj
 PIQLptU8u_SZsEwkz8luhly8RS1d7SrPSaaNYLXpFKFFBl3Ul4dSHYY_OicZB_b2NtA097QmD2_M
 BWyD_GFeL13faOILKtm0L75HkRlQLhZFcRbxfI6rZlrS6adb4jHP5mco9Xjaxcw.YgDKLNWT9_J7
 A7Hf57T04_0lwrlQB0VUw683DIQ9KAg6j0mwW0jFWscPHP5KsENnm1v2vV8IFguVGlrK1b_P2GPn
 1m8Z1BwK50lTONfp9zMt_da2GoMwu4i4sNjta5Zux6hxN4QvGxeguiSOivFSZiT1rQrV2ZkoSgy5
 nSbfDQUC3OGVbWHu3nu6DOBbnPuaxOtYhZ1xkuPxkDCP_LaTJW2wQbEaJo2d8p_Oh9OkqhIkOIo5
 cciHNpcRsXL2wKutaSFRK1_HGyzo1V5thc8mJhHTVEyrWBiyZaHOaJ0wgfSx01Ucn3ySu7xEFTBn
 Yv5dXRgiMcIYOR1a26MZYPJwyqejnq66fT2ft.XCDOrfAVvnb8eMyC66jJKv7gYiY6pWEgOIleFd
 agQwYbXbhtde9Xk4xrWMugdTV7DBVwyXdicawzZFDHiIDCNt6bEGEBPg5Ywh4D_WA0leLjFmtZbF
 Vnd2HBbvXj7EUuiqY5y2ObM_9LrLaj96gf4.FiZhiwnQAyR3EarJM5AtxeFa7rtQnWW6APaJQGdD
 VKrzUuHKusGeUwEfbmBQ2wUmnOl5FFaiCqC6JYoNYYZK42guCG7hvwpAk7bwKE.0yW6YNXOSuOvf
 UgslwZMLh3GcZ3EBQGPrDZ6oC59os.MW5q0e7Swsux4N1aWuNLyEMxVM4QDFfpjGdYL6iORZvKbl
 fgMsbWI8v3Enpq2wVWKjHYKM-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Sep 2022 20:54:47 +0000
Received: by hermes--production-bf1-759bcdd488-g2m8t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c0f7fbfb612a7787fa755968879301d1;
          Tue, 27 Sep 2022 20:54:46 +0000 (UTC)
Message-ID: <e53a88aa-8fe9-0e0f-ae41-0df17df86a77@schaufler-ca.com>
Date:   Tue, 27 Sep 2022 13:54:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <CAHC9VhSF8hWg=7tbFiCrizNF61vpwJcU3793LcStiu-anW4i1g@mail.gmail.com>
 <CAHC9VhTDGwO789t59EyOV0SwnwGrdyBhRiuJpoY7cB4MSe02BQ@mail.gmail.com>
 <e2b6ae44-1037-666f-5012-6abd4d46c0b7@schaufler-ca.com>
 <CAHC9VhQ+UcJw4G=VHNE8wMa+EBG-UcoZ7ox0vNqLHoSKAd9XZQ@mail.gmail.com>
 <269014c6-5ce6-3322-5208-004cb1b40792@canonical.com>
 <CAHC9VhRrOgDMO9fo632tSL7vCMAy1_x3smaAok-nWdMAUFB8xQ@mail.gmail.com>
 <1958a0d3-c4fb-0661-b516-93f8955cdb95@schaufler-ca.com>
 <CAHC9VhQPvcunvBDvSnrUChwmGLen0Rcy8KEk_uOjNF1kr4_m9w@mail.gmail.com>
 <6552af17-e511-a7d8-f462-cafcf41a33bb@schaufler-ca.com>
 <CAHC9VhQMeyxQJSAUuigu=CCr44WtpJg=LEh1xng_bPfCCjqq6Q@mail.gmail.com>
 <5ef4a1ae-e92c-ca77-7089-2efe1d4c4e6d@schaufler-ca.com>
 <CAHC9VhQRpeOMkeEfy=VRPnpuYMUDYgLp56OjQZPYwoXmfHYREQ@mail.gmail.com>
 <c679cea7-bb90-7a62-2e17-888826857d55@schaufler-ca.com>
 <CAHC9VhQ-FqURHeuq_3YNH8NixJiGZ9bEEdydu49kC5tLan+FoA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQ-FqURHeuq_3YNH8NixJiGZ9bEEdydu49kC5tLan+FoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20702 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/14/2022 6:42 AM, Paul Moore wrote:
> On Thu, Sep 8, 2022 at 6:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> I am going to start playing with these syscalls. Please help me understand
>> where I have suggested something stoopid.
> Thanks for posting an initial patch that we can use for further
> discussion.  Time is a bit tight this week due to LPC/LSS-EU so I'm
> not sure I'll have the time to provide any meaningful comments, but if
> nothing else it's on my todo list for next week.

With a full understanding that the 6.1 boat has not only sailed but has
subsequently been sunk by pirates I've posted my v38 stacking patches.
I would have liked to wait for some amount of "discussion" on the proposed
syscalls and prctl() options before posting, but it seems that isn't
going to happen on its own. In spite of the radical change to the user
interface I am pushing for -next for 6.2. If there has to be discussion
about the interface we should have it. I'm going to be (mostly) off line
the first half of October, and was seriously hoping to have any issues
identified before then. If that can't happen I need some idea what can
make it happen on some sort of timeline.

