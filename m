Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CDC43461
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B490C208C7
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DfcJGLWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgIDVfz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:35:55 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:34756
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727951AbgIDVfy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 17:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599255353; bh=YR4RRJuCj83k7P8RCedqYAVYp/idYXmrk/qZWoFdJlg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=DfcJGLWmz+df66zaPOIAm6KLjgTz6M5d773bx361V/Lg/AlRkjHZurgiB0PdT3q0lRN7l+dJy6V9JkfCCZqTZgcOuF+VrKSfonfK320zTiejLNE9CRXGwLs0ekt/XtTQjYV1YTmtvhpCISO+G7944rFBICieVcYvQs9DsSpvEga+xyvANxA0RK2dXfwGQagKEK6s07meq0v9h79i/khBoOBIT+hI7gVY3oTy71IIzaWUlYmAAeH1ncFrT8MZvc7hfzmO42njVlRxkkuLlbdXa4H9XZJF5V/xU4MHbZ9fEHNzhexHFaoWYeA8XAMKMdnZ1EyBZfRSBLhwLm1WN3VlFg==
X-YMail-OSG: 1EjBP5cVM1lbvmcFu9d_EBfAWbgG.AQm6MlzsNCjf2tdF72gAJHgBU5ImoTz_yt
 Zbg5wlYbot5o3ofQIoYiUGhk6KX_V9fGYveMGY71BaJRmntW_E56a3Uon4txUJ_z7N8Re5q_G69S
 Xd90pJ2bXS68DRDwCxMEVs3mUh7uIm0zPoKS1HMGN0LUnZgqeZowfoLdSKxdAdCE308aN.S71ayo
 AOu2nZINsOZTHWNLwzct5fqmhTGGc9RZcnMqq418BHk32zWeVrUg2PYu.72Ruy1xCDgDzyx3h1c_
 6FNZmbqw9uNyEJyHI5znAAjpFNpsT4Nm54hrAwqyMLOpldgW8DqON6woyrwpYsCe5LNtvcjoA31z
 2V2Z.v5Cp1Q70FAQHNX_P_iWIQMm05PMbEUELBsaJM_Mj4jL45qPB7EVWE7D8GC31iYmrxmxseWc
 NgA.9vjH7YfLadvk80PdZ3ABNcdKrPdbBLPzPf7x9braMcNTEsD4oDUSY5.une5JM0oK55M4vj99
 5fJx.YbsFStOKkfdemOU7PuFLT8RfFsRUIZn7vEnFkuGQhibhD.hD2.YSipKByg6GNZ.pfwUL_Mi
 0kUADno11G0hJ0vbatR6Vg8aW17lv2bJGqDwTpPgvlcoTmaA3pF4Pg2D01j8Dmz5YcJ5O_Wkt6F1
 fR9aVJrKgUICP6dTieO9trniucPdSZINvpl4yUMS3.iFHa6h3OtP0hdQAbILo7sIBsalmrY1T6Y7
 PvGYMMev0iV9qWQzadh61UO7ENZkgWbICsfcEu9loT6L1S28xwhT5C91uKJ9euyXRRmHZp20J5h8
 ha.F.LsXyeUMaWsmEx2BFQdnDE1_ohNGzzXIyTMoD_0lQr8QXuzYQTscTH62g1QxVGQjg5JEev5h
 FRlW6DGjVSONdDhdj4CEVHCIi1AyBAn.z1lOBYd8oZz3nH7QHlL4iJSMorbSWqU7oeXzA72COlHb
 G7oYWfI1GUjooqT0hrILKcriwCib77CtJgaz6JlBEUk3_eSAvJ7EUNBsI.rE6iUvBa6ueMEaSngM
 XZSFv4cx7.TVydpMC.qhseCT_6bxu0_.ErzrvoUaUFUaKWNcMEoOkWiFLxjTPbyQUkHryqnsrjI7
 Ko9ks.74Mw9prb_er6mSi5.bIyaAP8QFWpexaTs_GnLcwEbTjCKm6ejyRjLwXmv08en9yByWXoQF
 CVrdyaSjp4365wUibmtlOHdKlBZEau7KPjgtPkNicg6BNDgVccb8_47MMp5zNMksZRMoXIAFAVO0
 DVSnaw9y6..vQZCbx_zaPXOqeRBbTWWwlE6oenlBYf4bg.DiTsC1YEbvSTc8Aekh3yo6npbpSyw3
 5gJp47U6wFpqZJecQDL1xzDI2vDQhe1tDdPySqTlNXN63l5pyFXFH.ySWtuNL_SSNi0TJv8hd8Wi
 drDcNgOq7lv.pt6SXxmYhJg03AR7XUyDN3Lf6M9nlR_iFf7Krv3.q8OL.g.w3f9es0yR0C_nJXXr
 7OqaPdU6LDSCOTSP7pwzzeI2mM87e9qrSRT4RM_tZ_KTjO3SRbBgWrlPZf4ntJ8QuzsC2mpiRocK
 nNtNma0hlvm6ywgf234kj2aVfkSY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 4 Sep 2020 21:35:53 +0000
Received: by smtp417.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 00dceb58e3f3f0bf436a9997d98cfafc;
          Fri, 04 Sep 2020 21:35:48 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1eeef766-405f-3800-c0cf-3eb008f9673e@schaufler-ca.com>
Date:   Fri, 4 Sep 2020 14:35:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSh=r4w_3mZOUwmKN0UxCMxPNGKd=_vr_iGV06rvCNbSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16565 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/2020 1:08 PM, Paul Moore wrote:
> On Wed, Aug 26, 2020 at 11:07 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Change the data used in UDS SO_PEERSEC processing from a
>> secid to a more general struct lsmblob. Update the
>> security_socket_getpeersec_dgram() interface to use the
>> lsmblob. There is a small amount of scaffolding code
>> that will come out when the security_secid_to_secctx()
>> code is brought in line with the lsmblob.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
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
>> index f42fdddecd41..a86da0cb5ec1 100644
>> --- a/include/net/af_unix.h
>> +++ b/include/net/af_unix.h
>> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>>         kgid_t                  gid;
>>         struct scm_fp_list      *fp;            /* Passed files         */
>>  #ifdef CONFIG_SECURITY_NETWORK
>> -       u32                     secid;          /* Security ID          */
>> +       struct lsmblob          lsmblob;        /* Security LSM data    */
> As mentioned in a previous revision, I remain concerned that this is
> going to become a problem due to the size limit on unix_skb_parms.  I
> would need to redo the math to be certain, but if I recall correctly
> this would limit us to five LSMs assuming both that we don't need to
> grow the per-LSM size of lsmblob *and* the netdev folks don't decide
> to add more fields to the unix_skb_parms.
>
> I lost track of that earlier discussion so I'm not sure where it ended
> up, but if there is a viable alternative it might be a good idea to
> pursue it.

Stephen had concerns about the lifecycle management involved. He also
pointed out that I had taken a cowards way out when allocations failed.
That could result in unexpected behavior when an allocation failed.
Fixing that would have required a major re-write of the currently simple
UDS attribute code, which I suspect would be as hard a sell to netdev as
expanding the secid to a lsmblob. I also thought I'd gotten netdev on the
CC: for this patch, but it looks like I missed it.

I did start on the UDS attribute re-do, and discovered that I was going
to have to introduce new failure paths, and that it might not be possible
to maintain compatibility for all cases because of the new possibilities
of failure.

