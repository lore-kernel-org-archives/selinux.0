Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56368C10F29
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 01:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1424649
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 01:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="co7rT9uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCJBOB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:14:01 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:37387
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgCJBOB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 21:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583802840; bh=HGmHkJxcHHUCpNHXVUn1uOpregn70VkgXG7Gxtggxvk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=co7rT9uklFiNu0otj6LylJ7yH0MO4vUqPGVp325L0J2Nsu8ym5gHLOQy6Qz1/RWVn1BNgrF0F82iwV+ogGyHJ/znwLHft9nbHbm3RJjmdHyqbMC7bMZGNYldpNWwUNmzCuR8PlHJCN9Ae6srqnJEMN7/4I6KuiTY+PKIyXcvasLiB/BZOdoI+pPRCWzfr59M+M7MOWmbymrSPc2WMkaMYqZLf0kFTP9ah2up0HvY4fDyMEDNVMgB2TxG/N8+cF0Y0bfqFTqRDesOYSpF62+EkZND7y+n+MvyJTcprWQ1QvfV/Uw8sb9sz+2J4Tl4JrviR1lukqyybCAwoehf2uJVsQ==
X-YMail-OSG: to9QNf0VM1kmjMXOEL7M3kmmNbZlBtBjxBdLoaytNZAxkwSct0677e8nMLz6WXD
 VyfCfDA_fJZv5nUILa5PwQIwVtHFFvm6mdJ1plmeiEX4sXIcriNTdwIB8LFe3D9ckSb6vRWEjpFR
 v7GUjL9rOjWbBxEwZ2FWaAVm0BvCKplbgjgzFY00UeUS8FGSUMG6Yk3KKTHjAeJ8um0dyFZHRUVs
 RLPyfUPp00YoOIpLjdy.hbJZC5KKxOfPLSOEbXupkINmulwULzlk0LvW3h_UeQ23cz_U_iPhiTOv
 GnFDtP0aIZIUqte.VHaIwFLQqyftuT6kAgnS4fl3y7V.b3wwlKegZ06eYVlX12EHa1JgYBGMX9S6
 wLQKbszrZWSo8sLQIijnei45h8YnGB3Tip7eXuI6vL01Uu.6hSZ3m66mV.2G3OzilTQpEpLJrnBC
 dXunJmYybetvFsFx4i12syqraBKJDv6Vu7iFx68HNzIhuBAs_HClB5er5o9GNxS0dbznpsMr3q49
 pNrIQ9c73z5_XmOZ7Z6JISrxGPDr5CnhY9ctyzTs171wXQLL9WE3qTOpc3PDaTK4cULawB5JObpC
 7lVWJHVpG8oaT.l8HlmY8DYRUIcL9yKfe6YT7lvKxsTVtR7j_vyH6zJMvDBPAQmqUXwFxY2hgGoq
 LbjCiTqiwRC2h41CsVP1RiE45NFpHwa4YhK3GpCdFi0HpZwrJy4iUwwkX1PpG_m0L7gWAyH3RydP
 kZQMjR_NOxN5Lq5LVa6igytAiZSqyGh1b652eRYkvhMOfWim15fOQYyZCWIQ6R.0cqIqItKf512M
 3zN11_cyxUDau6GctgN.u2tplm3L1PNt5FhfGai5gAPha8vpSzgBzlwzd4lv.c6Vx1KuH97N0Pqg
 _iapAWBe24ZPpfjRTr6axEUZ6ApvExdwcvgA2ZJgPff2eQwtPs453b0hWiOQtV117HoYYX5gzu1m
 HJtTZrruPI5uirAyPfeQ8Yi48dEk4IRFpA7x5ndHeUSB56IDIBiHIs3LrhxlLoOv77h1lDShH4NW
 .b6LaEl1THP8Xwl3UOvzkS4QelJDPPPZYI28mbdYe3nADUQcYI_44NVq6AQLnGBmqZA2Yknhv5Rn
 KoHV91W4W7QdGzgkJeWGnC_2q5cvpb1q6C0b2_W82_Tnnd7pw.S.y8ajZhOfPggPzQLJUMHj7lvH
 JthnswefddeejI9WV0EFik4lEVDMm20cP2Fg8uIRrUwy3wchqIDNwsbyWYhuf20jNKmkBbMctcCW
 h1o07lFiiZInXmGcYK8ZTyV7i3o8RJgeW6v33uWNm_.KcHq6lnifjXGxFevF7_0MQn2f21KxJ8bQ
 nFIeW33LxjSxGGS.8f6Km_kq_GcKpeKOWzbKLE51Bq_jEhMNj13SgChyC6_VhzQ1NS8xJ7Giu_5U
 NbffBmMBrPZvB1Nq8JoztOVD.T6cZI.pSyhvV1F96H.k.xDeO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Mar 2020 01:14:00 +0000
Received: by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9f0f0e06df660171fbdf33b7ad8e8851;
          Tue, 10 Mar 2020 01:13:59 +0000 (UTC)
Subject: Re: [PATCH v15 06/23] Use lsmblob in security_secctx_to_secid
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
 <20200214234203.7086-7-casey@schaufler-ca.com>
 <CAHC9VhQyXEhU+2+Js+7B2AuebnD2ZQDT+5bHU-gO4FshvcFzGQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9d3334a9-d1c2-8acf-9970-76efd578db36@schaufler-ca.com>
Date:   Mon, 9 Mar 2020 18:13:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQyXEhU+2+Js+7B2AuebnD2ZQDT+5bHU-gO4FshvcFzGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/6/2020 4:58 PM, Paul Moore wrote:
> On Fri, Feb 14, 2020 at 6:43 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> Change security_secctx_to_secid() to fill in a lsmblob instead
>> of a u32 secid. Multiple LSMs may be able to interpret the
>> string, and this allows for setting whichever secid is
>> appropriate. In some cases there is scaffolding where other
>> interfaces have yet to be converted.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/security.h          |  5 +++--
>>  kernel/cred.c                     |  4 +---
>>  net/netfilter/nft_meta.c          | 12 +++++++-----
>>  net/netfilter/xt_SECMARK.c        |  5 ++++-
>>  net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
>>  security/security.c               | 18 +++++++++++++++---
>>  6 files changed, 38 insertions(+), 20 deletions(-)
> ...
>
>> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
>> index 951b6e87ed5d..e12125b85035 100644
>> --- a/net/netfilter/nft_meta.c
>> +++ b/net/netfilter/nft_meta.c
>> @@ -811,21 +811,23 @@ static const struct nla_policy nft_secmark_polic=
y[NFTA_SECMARK_MAX + 1] =3D {
>>
>>  static int nft_secmark_compute_secid(struct nft_secmark *priv)
>>  {
>> -       u32 tmp_secid =3D 0;
>> +       struct lsmblob blob;
>>         int err;
>>
>> -       err =3D security_secctx_to_secid(priv->ctx, strlen(priv->ctx),=
 &tmp_secid);
>> +       err =3D security_secctx_to_secid(priv->ctx, strlen(priv->ctx),=
 &blob);
>>         if (err)
>>                 return err;
>>
>> -       if (!tmp_secid)
>> +       if (!lsmblob_is_set(&blob))
>>                 return -ENOENT;
>>
>> -       err =3D security_secmark_relabel_packet(tmp_secid);
>> +       /* Using le[0] is scaffolding */
>> +       err =3D security_secmark_relabel_packet(blob.secid[0]);
>>         if (err)
>>                 return err;
> At the very least it looks like the comment above needs an update.

I can see that.=20

> However, I would really like to see an explanation in this patch,
> either in the comments or in the commit description, about how you
> plan to handle secmarks.

Yes. It should probably be spread between here, 0017 and the introduction=
=2E

>   If your plan is to always have it be the
> first LSM, let's admit that and document it appropriately.  If there
> is something much grander coming later in the patchset I guess
> "scaffolding" is an okay term, but it would be good to mention in the
> commit description that this will be replaced with something better
> later in the patchset.

You are correct.

> I'm worried about the case five years from know when we are changing
> this code, either due to bugs or new features, and we stumble across
> this commit.  Was it always intended to be this way?  Or was this
> temporary?  Right now I don't know.
>
>> -       priv->secid =3D tmp_secid;
>> +       /* Using le[0] is scaffolding */
>> +       priv->secid =3D blob.secid[0];
>>         return 0;
>>  }
> ...
>
>> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel=
_unlabeled.c
>> index d2e4ab8d1cb1..7a5a87f15736 100644
>> --- a/net/netlabel/netlabel_unlabeled.c
>> +++ b/net/netlabel/netlabel_unlabeled.c
>> @@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff=
 *skb,
>>         void *addr;
>>         void *mask;
>>         u32 addr_len;
>> -       u32 secid;
>> +       struct lsmblob blob;
>>         struct netlbl_audit audit_info;
>>
>>         /* Don't allow users to add both IPv4 and IPv6 addresses for a=

>> @@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_bu=
ff *skb,
>>         ret_val =3D security_secctx_to_secid(
>>                                   nla_data(info->attrs[NLBL_UNLABEL_A_=
SECCTX]),
>>                                   nla_len(info->attrs[NLBL_UNLABEL_A_S=
ECCTX]),
>> -                                 &secid);
>> +                                 &blob);
>>         if (ret_val !=3D 0)
>>                 return ret_val;
>>
>> +       /* scaffolding with the [0] */
>>         return netlbl_unlhsh_add(&init_net,
>> -                                dev_name, addr, mask, addr_len, secid=
,
>> +                                dev_name, addr, mask, addr_len, blob.=
secid[0],
>>                                  &audit_info);
>>  }
> Same as above, although this time with the peer label.
>

