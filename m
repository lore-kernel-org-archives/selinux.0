Return-Path: <SRS0=e/d8=CO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10784C433E2
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CD0206A5
	for <selinux@archiver.kernel.org>; Sat,  5 Sep 2020 18:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RFFR2yb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgIESNl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Sep 2020 14:13:41 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:38401
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728393AbgIESNl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Sep 2020 14:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599329620; bh=IT5Lui+8VatDwloIw2E25Klj8KCcVazo/j8v/GW2YRU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=RFFR2yb2aNIbsVYLOBcPN02UcKEA/slMU++lgl2QUr3XmrglkLYnuH1a+TOwFJB2HXl9MnGOJRJI9B9i5KY2R0bKLMUyFd8+fvrOdk0ECQIwPv5409k5CQr3xuwYWWDMPVRRTfPQroVZHf/r4nkrHb/pTdPornkqrUQT1uXflA5H6xI8gwMjwhglyaM4rUFrQG7JFJ2/f3NLinUfV5w0FAsYZlVxRayZvRuRESUCPbSMy8iYujblcQTzY/GmE207GiolvgrLzxWLWdiXWmuzxMAw7Z9A9LdNWv8nc8xF0wkDZdI8YSG6g1K7CiuzzosOalyYka84+s266ISLzikZoQ==
X-YMail-OSG: IFmoKMUVM1nizGgMYPYmhPubsKcpRdDtc5T2YgjJZpK8khILtvHF7f3XCGt8IaW
 _98sglczXQ.Amb3x8DpGqky0AcxjMZbttxR9JT626SjAAU33T_R1wMC4TVJ9WwImPgKYHT8sHuc_
 hgwyQSEveMiWb9K32dFL2LtkdKFyoDMX1A5Mbs.v7K1JnvbtrZ03MBq8LPP6ERePDOts.OuK0PTo
 cyBw9qczfoavT9dch41XX70XnnJ2R5vhIIhu7P75V2hUuX21jvN4RvQtNcgbKwwBz0twLqTNq.WX
 sxHND4NkXiBUU9Tlgg4qO5FHXdf6Nb1rWn7tOE2cRNx_oVr5Qz1A9M6rvPArD.VaBo2nBcTdCme6
 X_nBUDBSxWfHg0tO1Jy7MvHCkeZTCAboeiE3VpQcKowfg_EcLXddG404xhOJmtZ4PfNgOTRp3pCj
 nFWjI_DQEkPT_.MhvVWZP1anXxqBNJiwQUVTNu37mriUmL6agjH9Lo9mURG2vFTITIhPyyI0lBXX
 PHoglbo3ubmlOTjpFCqKIbDzrjep6UJXgQ1.8x8bsV7qde5UpAbx6iKDDzm5j_451S7tSaZ3ZPp3
 LeNUewJVRkEc_rlZT5v9jI5X9a0pPKgefG2bKT6RoIq1A6GV07fMK5.fbt_ucj31kbvwcZpJq022
 kBLi9EgkJXvOS6GulRu7i6ZOqW5uG8hUeyKFmnAhZRuAftilCuzIRqsLgLEIlXiTXn0tj1yA03et
 CCLvmygIPD6yV_seaNnDctSHxEwC3E9r22tDRoHhh7kNpu_eNdlFt24LowZ30HP52ahTJa2.DUp2
 7er9h3vcc6nI3peUuNBGs81kR_INnpJnPgZGuHvtQB4mSsAcXv.hDUolRSPywHNNIKtB8oNOyFJj
 s74fsiCtdQo5llmuoVRrhOYlmjL_qDwdKoD6eHrv1yrZwumjmGe8LDMg7vcAP2txiC7a0OW.BaLX
 gOjGGitC5FHFoZoySkoN4hS2paQyEIsXnK5hMNXMJKcpvVxBjU7rw4YP5FGu_qQhaqbbAFkeQDC3
 dh6dEPiLyo.4dhHg0vJPnbVfperroHcShValNnUTf6XsbdrNnIhQdZ5X_RPX1FCzd6bKMEgR9lIv
 SBn6gvv6rttcKoGR_PTyhvKerpQQy.hCTJWK7pI.9jq3h30u0.NPzjp8l5inPan.hJuYj6tF_90_
 3S.iC4lW3i.fOP_wLjZACYC8vU37BdoiW_Bb6UTNRwkvlSOAEZi6N6OX0uwZGrTE5jMuGz_BUNz3
 19IiY8V7vMT5JTmdoGdNhWbv9lLOnpVIJLq4XROcdh9wRhCWn9fjXQDdF7YHB9iI_m3LIMktqyYn
 GsZAET6tu7llHpJ5.mOWe.YxiwO3lT5kd9H6iCj6tozRL3ZYBZgfRfG8gX2RHLyW2kF5JU2Kb0q5
 sqwt0w5QzHVkvOG9FZk4QjXjpJEb6ECwDoP9c9RnR5lX4hg6Y3iRXFXO376P69aLsMzIQKpFPpaS
 uivj8PNafyiMUm0aFVJLPW90q8CPJ0zRhtNwXCTe56ilxTfvuzcgVa2LtHnYq1Cd8sOeDsYI7rpt
 jqCLNXKehiHVVYEX2OAKpye0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sat, 5 Sep 2020 18:13:40 +0000
Received: by smtp418.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8257eb48b2411bfbf1cddde3139cdf96;
          Sat, 05 Sep 2020 18:13:36 +0000 (UTC)
Subject: Re: [PATCH v20 05/23] net: Prepare UDS for security module stacking
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
 <20200826145247.10029-6-casey@schaufler-ca.com>
 <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
 <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com>
 <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
 <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com>
 <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <585600d7-70fb-0982-1e6b-ffd7b7c33e32@schaufler-ca.com>
Date:   Sat, 5 Sep 2020 11:13:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSu4qqKWsutm3=GF_pihUKpwjAtc9gAhfjGsGtKfz-Azw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16565 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/5/2020 6:25 AM, Paul Moore wrote:
> On Fri, Sep 4, 2020 at 7:58 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/4/2020 2:53 PM, Paul Moore wrote:
>>> On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 9/4/2020 1:08 PM, Paul Moore wrote:
> ...
>
>>> I understand the concerns you mention, they are all valid as far as
>>> I'm concerned, but I think we are going to get burned by this code as
>>> it currently stands.
>> Yes, I can see that. We're getting burned by the non-extensibility
>> of secids. It will take someone smarter than me to figure out how to
>> fit N secids into 32bits without danger of either failure or memory
>> allocation.
> Sooo what are the next steps here?  It sounds like there is some
> agreement that the currently proposed unix_skb_params approach is a
> problem, but it also sounds like you just want to merge it anyway?

There are real problems with all the approaches. This is by far the
least invasive of the lot. If this is acceptable for now I will commit
to including the dynamic allocation version in the full stacking
(e.g. Smack + SELinux) stage. If it isn't, well, this stage is going
to take even longer than it already has. Sigh.


> I was sorta hoping for something a bit better.

I will be looking at alternatives. I am very much open to suggestions.
I'm not even 100% convinced that Stephen's objections to my separate
allocation strategy outweigh its advantages. If you have an opinion on
that, I'd love to hear it.

Thank you 

