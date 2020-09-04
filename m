Return-Path: <SRS0=VTMH=CN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF8C43461
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 23:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BD3206CB
	for <selinux@archiver.kernel.org>; Fri,  4 Sep 2020 23:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oBW+xGwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgIDX6w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Sep 2020 19:58:52 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:38367
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbgIDX6w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 4 Sep 2020 19:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599263930; bh=Bn+G+kKTLMlT91hsvkN4OBE9vtBjjhP53Hnpq34KXXg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=oBW+xGwuccE0OXVileGCK85MenySq4/BtMhuuAq8K1xJA+9/LyvxocnQ5Ox/Hp5kz0zkLqzr5YPeYjb23luPtSTIMd2JKw+H0ThxFIOroIYqhCo4tnKck+ggh6yiI0boRsFV67LEQhcsW0KRpJQ86D7xSS/YgWHwCI+11deAwlbS5cUZ6AEyc3s8UmY+Q9TdjBErDRZJbludgVK+QiGJyXk7BDDAQ/l+7WwPZDDmI7nT2q37JuOzDw1KayYOWCvgSmPWXN6prl65s47shJ040yWZPGX9ifaIXl76eRsHa+WQJofJ+u98r/wtxUi4dLQKbE/PJtEsZz45Ws3JM0hzRw==
X-YMail-OSG: NYqv0qYVM1kg4ANV6.jw0jnzHfac9YNHujC4RqUWyqEWfcY6B5dA3Y.JZxa_8P8
 hV1In0w3O0q.9wKSICpzmnLntEE73QvZfu_T.6agKAvPtuM63mmAVzc3n2ZvxTdfiOXgVXIvMK.B
 v54opuWIrSn9WrQL7.aG1Gq8Didd.hwBPt8iJHBLg_hqMg0HXsf9g.uIhoPM8seBNtLgZYQanoi5
 wzZyhnAj7iCSc_zpa8IWWQSupT0h2zhKnZxPvpJ9H6K9KNAhCGQFA_bnthDFe75krA1f.4eKys.N
 Z51ZN5X.qEZC11XbHzfMHiSczJFH6txprxAdZd6sHYCoSboOZ5ErUHwFcOEJ.pISHJ2QlVRA1a1Y
 HOfq8yVpE8vt2xAcZZ27biY4vXsemAqMady99Y4G.5t54GqziD9ovgbjwMWSadhfVurXpbzn4gxW
 QPT480qVctMhfqhqLvBhikrMgtVmXqo0mA.VDVVfwBZ67HyVef92ihT23NS_UkLx383LA.lK86pp
 uR.h0m4xJleaO3RrrzLHrnUbeEEW8zOwur9JqTqYzxqVKa5PgwAZ83zfLz.oENdSdKyLGH1th5.A
 g_j9WqaH5zR18wwor52LqdX.x_yg.munDULFWPCer2sDHxW_lxNV7iN0NyklvchgWHzTjBohfWJm
 dJahAO9diwxp_vcxUvdA9JtXNK3hfHr3MuwDRLnyru_w3fr4MThVQpv7AYT5jzcvJL_yCxmyvpkc
 DAZiN5hdstz2UbwmuJxs252D.C3Ti.S0BrgLcUteIWD30ok4I3S6xGsyqtQJOWA7VjCL2iBD8Dgl
 WoxCuNVYBY9N5irqfQ4zeOCOZY8wAjeoq0SzezmzA4bOlo1vT4DFyFP4iSo3_gehDKaSyKl4h8e4
 8MbeFrUq6WGk.FWPrD5b9PBsGn9.n6BuNlMszJ0NFVgjbnwwuDQu.DGjWLfiVzKe8I3M7zwQ8DTO
 6SUHCpuWg5FAXznpQMLD8sf_90EtjovXuWTGZfFktEMR03cxiuqLFSgrto54pz0e6p0mQRyzckNh
 dQ1jAnHt3grdn.GJhoaNBC3Kj2kLaJuVLiA8wM8D2Mm4v5h0iZVGchK_Cu4G75IZJLkEAN6mH3Ns
 QK5UIQkmqwoZGK09WIGQ36nIUg81HZ9q3A4cs9R5Arau4FgTlUaQg8lMxAOtqVDd1OqqmMI53JLX
 KuAcB_l2ate7uyAhTK67eS4EUW2HCYyHrm2zuttu7Z4Fm5v.QQFHiJG3iupYlvIsCIDalLZkF5.E
 6J.hjQYZaY.GeIGM4g82x3T9PzPe.S3BvoIg6aU0Qf.QTa.VBNSeroLiwAEyhVc8EXWtv9KfEOGG
 x2fFD0M3govOzM9cwya2kBivAq6F2SAPK9T7ZLy2onlSFFdBuGswQE1E5fOhaXN5XDGvYKG9fW0m
 RfLgTV_JJQeZURuL2Gkiyd1NUsIRnzb9IiklyFJc4H.NdSvQmX.eibQd4B775i0.vuMCqeiwbXLI
 gG6llpRRhcYoo6V7vUdlL89H2nuq5K8u_cmDVxrvh5fnwP210E8bVdW4r0ANUtFSJ3mlFFeVkgnd
 .zUw.3wWQCs3itaXWE92riW3QB2uRdXw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 4 Sep 2020 23:58:50 +0000
Received: by smtp423.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a395354623817bca1029a7e7161b6f91;
          Fri, 04 Sep 2020 23:58:46 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ef6a049a-c6b9-370b-c521-4594aa73e403@schaufler-ca.com>
Date:   Fri, 4 Sep 2020 16:58:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSf8RWUnRPYLR6LLzbn-cvNg8J0wnZGwTOAe=dOqkvd0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16565 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/2020 2:53 PM, Paul Moore wrote:
> On Fri, Sep 4, 2020 at 5:35 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/4/2020 1:08 PM, Paul Moore wrote:
>>> On Wed, Aug 26, 2020 at 11:07 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Change the data used in UDS SO_PEERSEC processing from a
>>>> secid to a more general struct lsmblob. Update the
>>>> security_socket_getpeersec_dgram() interface to use the
>>>> lsmblob. There is a small amount of scaffolding code
>>>> that will come out when the security_secid_to_secctx()
>>>> code is brought in line with the lsmblob.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  include/linux/security.h |  7 +++++--
>>>>  include/net/af_unix.h    |  2 +-
>>>>  include/net/scm.h        |  8 +++++---
>>>>  net/ipv4/ip_sockglue.c   |  8 +++++---
>>>>  net/unix/af_unix.c       |  6 +++---
>>>>  security/security.c      | 18 +++++++++++++++---
>>>>  6 files changed, 34 insertions(+), 15 deletions(-)
>>> ...
>>>
>>>> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
>>>> index f42fdddecd41..a86da0cb5ec1 100644
>>>> --- a/include/net/af_unix.h
>>>> +++ b/include/net/af_unix.h
>>>> @@ -36,7 +36,7 @@ struct unix_skb_parms {
>>>>         kgid_t                  gid;
>>>>         struct scm_fp_list      *fp;            /* Passed files         */
>>>>  #ifdef CONFIG_SECURITY_NETWORK
>>>> -       u32                     secid;          /* Security ID          */
>>>> +       struct lsmblob          lsmblob;        /* Security LSM data    */
>>> As mentioned in a previous revision, I remain concerned that this is
>>> going to become a problem due to the size limit on unix_skb_parms.  I
>>> would need to redo the math to be certain, but if I recall correctly
>>> this would limit us to five LSMs assuming both that we don't need to
>>> grow the per-LSM size of lsmblob *and* the netdev folks don't decide
>>> to add more fields to the unix_skb_parms.
>>>
>>> I lost track of that earlier discussion so I'm not sure where it ended
>>> up, but if there is a viable alternative it might be a good idea to
>>> pursue it.
>> Stephen had concerns about the lifecycle management involved. He also
>> pointed out that I had taken a cowards way out when allocations failed.
>> That could result in unexpected behavior when an allocation failed.
>> Fixing that would have required a major re-write of the currently simple
>> UDS attribute code, which I suspect would be as hard a sell to netdev as
>> expanding the secid to a lsmblob. I also thought I'd gotten netdev on the
>> CC: for this patch, but it looks like I missed it.
>>
>> I did start on the UDS attribute re-do, and discovered that I was going
>> to have to introduce new failure paths, and that it might not be possible
>> to maintain compatibility for all cases because of the new possibilities
>> of failure.
> ... and you're hoping to not be responsible for this code by the time
> this becomes a limiting issue? ;)

Well, maybe. More likely that full dementia will have set in by the
time I get the alternative done correctly. It's a _lot_ more complicated.
I'm carefully watching what the BPF people are doing with their
memory management schemes in the hope they will come up with something
useful. 

> I understand the concerns you mention, they are all valid as far as
> I'm concerned, but I think we are going to get burned by this code as
> it currently stands.

Yes, I can see that. We're getting burned by the non-extensibility
of secids. It will take someone smarter than me to figure out how to
fit N secids into 32bits without danger of either failure or memory
allocation.

