Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D5C10F29
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 00:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8818424655
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 00:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uJJRy8MX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgCJANb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:13:31 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:34405
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbgCJANa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 20:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1583799209; bh=IZ4PmzmrWhj2QI2hiH2mbH1wcS9QIVhHrNxHZN9ONvM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=uJJRy8MXJsxmtmxTwRAXNYvv+pXEVaa+a2UdjegC7VFMNJH9bQFlpfwGmk5V/NC3M8Z7/AEj6c1+sbJPCS/5Od4UShPP8NKpGaXVR3JsMNbRNyv7g0VpMS+5baNQNNAe3E0apRW5XSnxcdX0NMPuVOC0UMpuzfnr11CcZ4zkTxuDJy3NXeqFnoPzrLprpcw4sBLnZhK/ba8rEtSkKGh2F0SWqa3l0VAlh4jFGMcMJ/ANoYXor4mvYRfFLC0Jc9FbWUl4RaxESVYggoIcoVv8C5WESxiIPj1ASVvVSpecum6ckruD8RFmnyex1ouKm4h8TIYYg1K3rTHC6eFgeu+drQ==
X-YMail-OSG: XH37gn4VM1m7IaSCuW.5CmmaqggTnvPnTTUEFWnPyL9PS6nbbUBnxoaU8XFeBy7
 .GGI9EjWUGKKKKhM62khZ6XWiobCTlAX1p_1FlGBQ55Bt15au5s9FfZhhnWbYX9.gIT2vVPQqow6
 LpgjELtIENOJ4p9uzv.Bw10OJ_iwPybjHRpfntCo6vMJVg9FFTwkBbwLOz9Lrg.avi7GJyKJEGYr
 wME8SKYDNCiVwkSOH7Bi1qYTCoEXBRT8_3WbnxrDJQMIPCB1WviAfgph6FAlyH1kZjK0AXl6TI1n
 ZNea2hODUq38x2e7GCim4r5VYyJ.UM3TlsFvZOxvFed5A2pT8s09X4uz7iZOnqkNUomp9PiaejLS
 gOWZy0YddmKuo7dz5cTxHzHW9R1B.O_buC4M0NDCtH81HX8jfzFJNXGsV6lBF7DW9zu77LwgkwTA
 pFOsXisQ5HURZgIO76THFj1MlyN20e1Jj5Dre_7fPyCEn_9.iqIDWvpauqTVTpp73tMI6_vq51Kx
 m8a0UkZUQq6Uthpsa8ozvbFr62eFEnUe.CnN4.e9qm1Oj2HrL7IzOF8f.VzsDWRV99EE28Fq5AzG
 m_wMqwLERe11uG1lfgfzqoeRgMQJWmhJecPlrjjDhA9.5wifD9TudDdkYgGxljQ94tfzoF6mob7I
 Pr8P9JuGDsj7Whzarcy1hZ7qgNr53CGiflgJToI0ZQRCheCSDY9c3yQkrSlGlL9RmYhQotLYSUTu
 gm6Vmhr3CReA7IM5b9me54gosl3LJwNcw4mbUJPbIGnWN4uf8Mi94zym1WQcBwVHJCAx6K5IS5kg
 266HEh_bb1jkdACXhuXZ7hIXAr8YCEQHowiiRidxNudiSB93VsW5OHGYYbfBXKS3p4M1iOHvgWqO
 .P9DKHsaoMZmlc9AXqH9K3cPVFruKrP8HlhIY3DH0Mgk6XGu7F8Mwpl4Bpprw0iUSevF4tvuVqTf
 rutIkM82Jm10dnyjPqkLk.Nq_xeACBpmTtxFWfuoD3yaU92TsRhmiR5k7dibmeM5INj1pW6YEWJ8
 pvZteZqEk4Tsuc7zlUfJLOhu7KKRaHtSR6hBDL5eORAAVD3UeqCHV6tkFswIqEDxfQwkUKVHQ9R3
 .nH8kXc7c_cstDXPGyJ35GBuKK.pHr6kQsV2INuk1N7HSfVwSGwWWGPNTIlSW9VHfNy9tNNIAo3_
 HnG7_x84p3IqnJwqf.7gCHJEl3kslsbFJSuLMTqrQWdPVlHuvl1ZMKQxBUlH.mJjYyQp0_9agQuI
 xMV6tfmdTOce7d4pLf0LmgwpVS0_vJNF_CenRI1nUUVRmuhOAqyDh5CrMv90o8VxiAeC7qkMdV0_
 3rkiMR12VKqmSdquoWV3dzuKchBCv1wFdV0kkRrVjop4VQx4AbQanz1fk4FQv6XZQujVRQL5OP.U
 tHTMy.Hb7ZaQ_bVw8yw7JmIpG9kHbEmDPKekj6.OAHvMzV7w-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Mar 2020 00:13:29 +0000
Received: by smtp415.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70d268739a7dfb93c1d92dce8d21242a;
          Tue, 10 Mar 2020 00:13:24 +0000 (UTC)
Subject: Re: [PATCH v15 05/23] net: Prepare UDS for security module stacking
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
 <20200214234203.7086-6-casey@schaufler-ca.com>
 <CAHC9VhQzSqbEh_RN3zqnhOqVMCjrKwGhyBXnYb8Du4LUq7=txQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <50b463c1-1ff1-caad-3e4c-6e822e1c4a7a@schaufler-ca.com>
Date:   Mon, 9 Mar 2020 17:13:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQzSqbEh_RN3zqnhOqVMCjrKwGhyBXnYb8Du4LUq7=txQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15302 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/6/2020 2:14 PM, Paul Moore wrote:
> On Fri, Feb 14, 2020 at 6:42 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> Change the data used in UDS SO_PEERSEC processing from a
>> secid to a more general struct lsmblob. Update the
>> security_socket_getpeersec_dgram() interface to use the
>> lsmblob. There is a small amount of scaffolding code
>> that will come out when the security_secid_to_secctx()
>> code is brought in line with the lsmblob.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> cc: netdev@vger.kernel.org
>> ---
>>  include/linux/security.h |  7 +++++--
>>  include/net/af_unix.h    |  2 +-
>>  include/net/scm.h        |  8 +++++---
>>  net/ipv4/ip_sockglue.c   |  8 +++++---
>>  net/unix/af_unix.c       |  6 +++---
>>  security/security.c      | 18 +++++++++++++++---
>>  6 files changed, 34 insertions(+), 15 deletions(-)
> ...
>
>> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
>> index 17e10fba2152..59af08ca802f 100644
>> --- a/include/net/af_unix.h
>> +++ b/include/net/af_unix.h
>> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>>         kgid_t                  gid;
>>         struct scm_fp_list      *fp;            /* Passed files       =
  */
>>  #ifdef CONFIG_SECURITY_NETWORK
>> -       u32                     secid;          /* Security ID        =
  */
>> +       struct lsmblob          lsmblob;        /* Security LSM data  =
  */
>>  #endif
>>         u32                     consumed;
>>  } __randomize_layout;
> This might be a problem.  As it currently stands, the sk_buff.cb field
> is 48 bytes; with CONFIG_SECURITY_NETWORK=3Dn unix_skb_parms is 28 byte=
s
> on a 64-bit system.  That leaves 20 bytes (room for 5 LSMs) assuming a
> tight packing *and* that netdev doesn't swoop in and drop another few
> fields in unix_skb_parms.
>
> This may work now, and you might manage to sneak this by the netdev
> crowd, but I predict problems in the future.

Do you think that making this a struct lsmblob * instead would make
the change more likely to be accepted? It would complicate the code
but remove the issue.
=C2=A0


