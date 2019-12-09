Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B7DC43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 17:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9542077B
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 17:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CFEaMF2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIRhl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:37:41 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:37844
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbfLIRhl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 12:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575913059; bh=6a2j4rz6Zfr0HYjlC1crjhNMOF9hgUXGdPrBFIBXE6w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CFEaMF2wKXMpW8M7MhHgqUUWCOgkWWJGdmTFmYPMnbBQR6MbMCCzDIlkxv47LtYmIR825ExIc0STmDFfw9fvRR3plcdCrE5mqUawaibXxYPh7BTi9uA10OO5+QwxKwIKOl6f6z3iXwv7AtwDLCJU8Pa4ux8q77UtFc0Cz4w7M3za91gVNeNH3Bw6d0SuAuUKLBScy4VdAhHK3heDN4i8FJTBBne9izHdHlSYsiWlkC8dVYLT90KxHtBUMPp9TTiPt4qHf14v6pBGjk3IJ9rOl/VsjiuqOBztHm9prZJon3gv8Bt0EQzblFCknFXwVtN9tAgFetAjtEapwOzge3TKgw==
X-YMail-OSG: VniK5JkVM1n9lqMNYHQ_rY9Vuq5aVZ_FjHb6sI6sQiooP.VdUFqEopk9nnDl1Sb
 vK6yKS1DPyhd0ivVscme_iPXPBCnnXZTxSpXaZZVIeVlCDIfcdBfCJE2Me4OIYcjKGjdY4XOnDse
 kFADcRgS5eyL9nzmzEAgWDGCMUXgNTuqzHFWZlwLqEIO3FE.W8nqlVn1_LDLkHIjfZqi5FUugWV5
 eweJ7sYwwKLRByK2ZlcU9XuqiXt.iekPLw4pk5NeVU_qLh3j8_0gGDPgPD60scdrYqx8ykBA7_Nf
 KB4e2nSoNMZoh4iIiCSWruHLpAhPOM4AXEgJHIRUP.1DZy6YiIXC9RwrgY5K1Z5BHZ6a6lDGM8mD
 v6gZUjPedgtJfdntViCTY.HiDvKrpmjM7OBLHPwMP2LSWimxTJcAKpF1E6kWiPLO.EXdpVnIiybO
 XAaewkSMBpQ7UQZhXIT7cqLfc6403m_KcGhuuatUpDScOPaDV65EVp8jdA_JQoYTPsyUSQUZPaRF
 g2hb3WRRB4F_Fp8bK03M6gHZTKYa_pjSK1hP66oFTHrjjry1FkksouQHxJBXr0QYd96h2TP1KAK6
 c7BrUdhrSQRwWx_x7MrMAWZO5dkaw1NzKqQusVWpkIgtasfIRAVv9_K0wPAKk20Y1VbVhIyBe_JQ
 .gTHHXrgjeFABTzsyo1UmP0rasNwb4yTsX63MJ2XFLLR81I7.ovkxtiZzgynXjyvCv_m7fI1RcYW
 k2Z4P57986j1kdiEqcXD19lfOnNGalycurq9m5Pn2krkkMhbjJzrt5Kk2WPO8Ld18KqLPffDMj.y
 b4R6sq7c6bjclCjQjWTc.0Vo69ClBhoNOjFPw..BE8wpIWomojvV0lJ1RaSSbx69RWSyAsgbrNHO
 8gSF3sPZviEhmDxmihrmUiW21M0fmq8MIMjdDsXYSwC6Wj0hnNYcOOIVUqEZiWAB3C545tLPU9qW
 zdhrcMIofJPXm.4h4wwD1Hao465cA7oQ6NwEmMhbn7Q1hmxuHPfvIDcWQZx8sbtTnk_ZELQOay3R
 M.JvtRTRMX_5W9fu7RVrJNknEbfK.lcQ9cVc64QKnVUhIGTP63.8HTb6reDn8JWXYM0IYiTj1ile
 5pRobhgqJrBCMOlJvnxNZtRQz59oL1sfRi0x6Hp2DmXVbmjkZlqDSud.ZtQmRh9NA09sRbRbrJKB
 vPk75E7QrxlPFhIIWpxjrhkQupfidwdItkwasXIUwS0778qb4vIzwTAIh49JtDyIM6yTfvp5hm0B
 8hms_OVFzpIdt09g2DJs12fXsZhQX_67FAIdem5Xl6jSBhQ6FKfVOhscZU2VpsMn6ueJnsJFhglr
 2JRjM84wh.E9jYRO6bJbE9tGQ9sN2NYa6gkBzecD0Yc1.z25.DIUUVWm7GRSczgLEhdqF8uzqt_W
 WiqDvpvhLtaLh6x82kClyd6l.8tYiH14-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Dec 2019 17:37:39 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID da8323d882945f542bf46eeb71e810da;
          Mon, 09 Dec 2019 17:37:34 +0000 (UTC)
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less
 broken
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191209075756.123157-1-omosnace@redhat.com>
 <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
 <3285ac79-5d26-71bf-6fd7-dc1895ee7bbc@schaufler-ca.com>
 <CAOSEQ1pHnxrMyn1qYXzJPaT6Smf1ycVOfHQ7-gkDpzYiq9S=Cg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <95a6c581-f1f2-2f82-732b-90503278ad97@schaufler-ca.com>
Date:   Mon, 9 Dec 2019 09:37:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1pHnxrMyn1qYXzJPaT6Smf1ycVOfHQ7-gkDpzYiq9S=Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/9/2019 8:40 AM, Wenhui Zhang wrote:
> As Casey mentioned.
> When changing this order, would you take some default stackable modules=
 in consideration as well?

The order in which another module sets things up ought not
affect your module in any way.=20

> I personally is writing a module for my course work, and I am using Sel=
inux and Integrity implementations as a basis, while stacking some new ho=
ok implementations on top of this.
> If the underlying Selinux and Integrity module changes the order, would=
 it affect my stacked one please?
> Maybe a centralized memory security blob garbage collection module shou=
ld be written, such as garbage collection by refcount of the security blo=
b?

The security module infrastructure does not do garbage collection.
Modules are encouraged to not create garbage.


