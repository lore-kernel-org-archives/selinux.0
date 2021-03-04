Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ECBC433DB
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 02:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB8464E38
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 02:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCDCWk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Mar 2021 21:22:40 -0500
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:44157
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhCDCWQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Mar 2021 21:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614824490; bh=GauxFWHH7BSa4HSwvumEyj3KtfguMrXE5rXngG/j6+g=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=DDol84tDoPae0DYHOdcY9TBUy5JjlZyj52yuTtH0heYJni7UdLF7cRVUXh7Qa6C/zgQH/j0umMh0b5p9JUSZkGikftKRaCvyk1JwVJnkB0jSGUg7W2sP93Z4v3x1RpEibBBWHqDCvpfbq5KiJaL3+uajrVuj7j9PfLEvVwo7T3WmWb9EInsotB6UDJtAqAlWyw8f4yrDTLxNT6/AMp6xV/paya2RRENo6sJfJbbMMLnl/ntQwGrC2tyueTPPebsE9hHlksqOzODJAPHxzW2kRU61tD6ha+vHvAUNDovNSj8AXw0CrfDFxEp7VkxGmoHWL3aQWEBsSgefarwnzesORA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614824490; bh=PEEADSrf2YojUm64+zD/As+QFIFaYIpdE7V3m3JaBs8=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=MYvOSV7jeZMgKjJu8Huf9wtWSh3tfpOFVXSCYIDRO2l7JqtLoYwC8+owl/27vFc3UCBpfq8ubV3MFqP6Fb2ou/PQZD5/gNIgZCHrFMNV99yx8edB61uZoHNgi6IWnGOek1Ic/rxlpOu7Yf4DzUP+eKDjOrt30bUV0VKuynKH2OQQ6ScmhOD8dkxbotvxsw7OKzVHtz2Cu+ze+zGDBVeX+LZUrEE4i8izhmUxwTPwb+1Vxsg5pZMwtv6pVc4g+Qdxpd2M+asjI4s4+QD39rHkLBmkm67v5sZhL3qMbQtct+V/xtH86Il7mNFmr1cgPM8qK8NVz2btqEnGFh4Pm1O1rQ==
X-YMail-OSG: kxTVuS4VM1lGUVUNgzq8reFeDyN_WE0hHKMAp30NniEK3tkBuSW.ao2PijmyFA0
 TlZMm6GqcfIMiMSODwyx0sEqOp0kWzPPE0Xdj9_M8vQbZ07YpS.UbHu_zRmsCwO0aIY0xIduVi9E
 tz8fJ5cpXfPw0QynpVZ__WIzUz_n4jtjRT7Au_tZAK34oGfW50vW_zCjlRYrsjGU5zBxXdUVOwHU
 00x_Lm0x6xPS1XC4yGwNm8t90bNNHZ.Dk7TQSxx.7rA2y.pC5YfA_omHdhnYa4WqHHtcuhr2fF8l
 fiLvIiHV6NpGExPZNptjmuWtERln60uDm4y.dG1ZHPohx.IhngnpRKNOjxSTsIO8UadxXEtT53WV
 Ft8VeZ7jt8atXSDUWKCDJF_LG4XWTM8c7iXmHhAgCkYtzPpEHttaFYXoRz1wSbnNU0tSZgPtTryV
 ZOJFTB86z2SZMSpEO99fsPXp6hqcLRlHZi1RoNRdTVuG3sEg0DHgLmomrfDA1tvIYV0idd07m1VE
 z5dizIIDoz5CCOsK4M2Esu27GVehdFqxpVcUa7X8mFrBCnIRnPuzZHBUmOgcrR2lixe0TjPd0YW0
 POF0nXsK.dtN_a53ygf4SwaJrMB6kZEBgjcGVSjoRreum9uyLaIJ3pHefVoOipibzZahYda0lONc
 eEmwIZq5KKrM_7j9IEiNHgVrfdGeENIW4_pWJ6BMn6Lnr3mkavd6W_7YllW8I2cRxbM_O4ecSK3B
 8bdJbYCcqGz9l99QKk2kuz7nhURz13qRH94o5R7PyS5tWBwOoKiz69ZDZZDFz64SvjkQ7VjpiWac
 5eJCCdjU4wBtpZCrfVum91P53Et6TdfMPoPt0CewMiuk6eN5GHcaRMpcCJ_ja110xxkBCmYy3aPq
 8bflazrTUKscUvPJq3iIR_as3O4yOFtM_afTnl82EXXGY0llnuDciXuxYT5As7oMEyHXR6hC9oJs
 vfrFz3zAwqqIhfoJ_B94xV6YotLjOrm1R2CQ963OnXNt3uKmWis5FWUANxylTlZdea6OrNkP1onQ
 HuGx66kNS4.JvB.4am201rXXDBE2.hX6FD9cGfTFie2nBxNz.SSTZdjQhJ666psYmmQ0SsbKW5pA
 4t9W6wiEIdYf7bOCbsAaD_Wmi.wBt5nIjxOsbeqFBWEacWGOGtTp8EtZW3ydc8OcbBjrdTaOwrwC
 MrJUQAU1891sgamg5zG_cQBLtmy3ZlYbNxf9vUsArCmPLYSk.8vSECO5CNxkvufxgDBdvLnusUsT
 ALsbX_Nj6CfMyaDPaAUHhjiiVp822TIa6niAT6XO2vZJXB4QNw_UGZvCDuRAz1YzNb1h9Vc_ymHr
 usCfjqIS6msFQYOZevl9Tf6tXjwC9XEIQPoebnFFROUD5AuX.tVWPu0OmaMvRASir2RHkjzB6MCW
 EgvwkvMrQKc0veS16QUpldBG5doD7EwA6jPzM8WqyGjMZnynNZ0cS28deV..WrN0ypCLE__Epbtl
 b9UpJXdRs1SiNNMv6qtKG0mBo280CIl1.IYsiFNA7hi2M6_4LQul03EOM302U7LpIMwpiNsqM3jx
 geNp8ClTdoTL9Ofn7lhcsRePhbpFrHa9AJVYncrGj1u2iOW6AiTvI9MhT3hcbmquDlkqdz1Z.e5n
 tHg6paElDXnf0Z8SVzqTWFNqnTUb_ssWbiLCfORjwyWvIhwBmVCuJf.vBR0BBWMI9sXgpZ.iHsyH
 RE8fWkRL5SpHc5YUNu2gmGX2dR24B.BOCnXCA.upN8ykfq..swtf7.4i7B6A8.qmqijtySN.y2n5
 MP732yY1kTh07PfYs11JLmCUEQEYn9w5WH374KqAjSKHnr9W694FoBEASj3rISgrTOlzneKWvY66
 9DmNyXkV6xd3Jb5eAP_5ntHJc7D8ObFt5Cich12z8RCRWQOpAcnfr6a8DwHWOXyBqBZ7LZ5m.Z4M
 _It2Fj3PVqRlSp32Ml3lO.50b1FeEZ4KLXVDGamhz0qCfke.4jPl0Wk_mR006kQaQ6OaFiFgBZfj
 cmYfGQPJ9UEO91sR8II0VnraiSP0dO6pT.T5pOHNKxb6QDJbITIXLCbiXkG7TGqn8l6i89O6olcM
 YWLAc6rlSrIaV3IqNXlagrj1WZC2cGEdq8We2RNSsWn1WE_UF.UmQkdxTxWZY0OhCgj3rUZ51fbo
 KnkKnGAkdRpDc1WePR4eRRxzyH65y4ntXgbLYo9fdyiwsCQY7bG.WEDscwb1uCpXLJ8RhJjqKRkP
 iY6VLIzBAI43p2Z78Ucum22vrA8bPHuPs0H6UkpzA1m.dRnY9D31SHGgjkf4vMFph2N1PkhBBDUD
 L8Lm.tnjM8n.4h5aEBGkaJpA1I41Q2lcf6SUFZgBnTsXbAYazyq8cd0us4_2Q7sk7af2hV0gYmIq
 .A0P7j761CuuNN6NATLdfzAVVIcDU80pwfRe0rcEOwxnFlhGKE.UqjC4FtYmg8q3ytsYjQOGeYUr
 ts5d8_KFmK__7wmVnydsVWYkg8yX0NVtsuNxuktR14REMXcBPrQ.kSH0XXPrl3oCFGLEuyvwyXrp
 3MA1bWwE8xrhl8Co.kCPXyP0MStDuX8sH3deykI6Qd3R5tUFAgZUJN0vrfmhhZtrAx55ktWT_BEg
 Y3scCNSdBjIA5fBE3TukWOc2mdCBk.fqkxS9WD.re4xYvx1vQhlj3R5cg5MH.n1ZoJ5Guqtl4glm
 zHtdacnlkb2t9fsTTrOZzO6P9Hv51aewE7K_Md.LUdAXzK24Y4djo7ji1Rcej_aVsOiz6ftRtMBH
 Q4Mc8XqEnhNqGr7X2oYW9bPEsdEuveYV3Xsrbo9XGd5xzepzNMD4RTE7.TgesHjUBWVpfV78HWvB
 rINvc1Nz33JUveG6lOjPkMXUR.8qVGFq9O7.mghJ73B5POCUBI9SpGKkoz5bJLq_XZu.vGCEiEit
 5stAVnkTrKjGK_Ezr6kA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 4 Mar 2021 02:21:30 +0000
Received: by kubenode513.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c39e16dc03d51039c9c6e9030a47cdad;
          Thu, 04 Mar 2021 02:21:25 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] Split security_task_getsecid() into subj and obj
 variants
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <9ea5259b-fd84-e176-c042-c52a1c4fcc27@schaufler-ca.com>
 <CAHC9VhQBbep2WkD6JkCemtcXFLq7j5=AQeM9vVJ4_gmvi7hPQA@mail.gmail.com>
 <1ab6d635-53af-6dd9-fc29-482723c80c6a@schaufler-ca.com>
 <CAHC9VhR3=dNpxHXSo7TgJD6bCezgzfS-iT32f-jAZJgzCsNA3w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ac0bf135-a103-57a7-f358-d54219749768@schaufler-ca.com>
Date:   Wed, 3 Mar 2021 18:21:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhR3=dNpxHXSo7TgJD6bCezgzfS-iT32f-jAZJgzCsNA3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/3/2021 4:46 PM, Paul Moore wrote:
> On Mon, Feb 22, 2021 at 6:59 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/20/2021 6:41 AM, Paul Moore wrote:
>>> On Fri, Feb 19, 2021 at 8:49 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 2/19/2021 3:28 PM, Paul Moore wrote:
>>>>> As discussed briefly on the list (lore link below), we are a little
>>>>> sloppy when it comes to using task credentials, mixing both the
>>>>> subjective and object credentials.  This patch set attempts to fix
>>>>> this by replacing security_task_getsecid() with two new hooks that
>>>>> return either the subjective (_subj) or objective (_obj) credentials.
>>>>>
>>>>> https://lore.kernel.org/linux-security-module/806848326.0ifERbkFSE@x2/T/
>>>>>
>>>>> Casey and John, I made a quick pass through the Smack and AppArmor
>>>>> code in an effort to try and do the right thing, but I will admit
>>>>> that I haven't tested those changes, just the SELinux code.  I
>>>>> would really appreciate your help in reviewing those changes.  If
>>>>> you find it easier, feel free to wholesale replace my Smack/AppArmor
>>>>> patch with one of your own.
>>>> A quick test pass didn't show up anything obviously
>>>> amiss with the Smack changes. I have will do some more
>>>> through inspection, but they look fine so far.
>>> Thanks for testing it out and giving it a look.  Beyond the Smack
>>> specific changes, I'm also interested in making sure all the hook
>>> callers are correct; I believe I made the correct substitutions, but a
>>> second (or third (or fourth ...)) set of eyes is never a bad idea.
>> I'm still not seeing anything that looks wrong. I'd suggest that Mimi
>> have a look at the IMA bits.
> Assuming you are still good with these changes Casey, any chance I can
> get an ACK on the LSM and Smack patches?

Yes. You can add my:

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

to both.

