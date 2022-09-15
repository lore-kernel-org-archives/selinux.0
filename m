Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F7C6FA8A
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 15:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIOPul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIOPuk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 11:50:40 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com (sonic302-27.consmr.mail.ne1.yahoo.com [66.163.186.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFBA5A807
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663257038; bh=71YgQPkufQtgj1Hjl3JdpU1PFutij7n90ncMGUq5TiA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=QjzWchNkAXLDSk11Xats4BbvPF4DuVSth4Hc7Rk2qj994hcZ55UQ6ZUIrwYb0eveOGwKvhxuu3GG8CXPrKOstpO+knkj9Lt8DMZjXW71GudQ69QOi3RXYxf+nQa9CgfKa3AMFWJLNrT3pKwzV5GE2/QogdqqCwYxWkBDZgY4f+rXicb+vllK1ILINslp1EhvkXZPJi2s7I/CGybWy3m1g4rhz6HDi4RL3lZYUA7q/f6gdxpYOblfDqM/O3/Bz8p+Wu0vdOE5dChjg3HMk+AtFlAfZ/GrcTwgu+vOxlUr6KMcuSbAVkVbaQsAYK6XxEiLK+2nFKvmuIGvQWktOnIuKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663257038; bh=6yviBBNC32dDwrurkQcgYkgHWtjYEub2m1MRJY1PDOG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Rj3vRxCqNY3ThpenkJzts4vQqsHaCA8fQc6Qe1WoXHjTAiGSYNDfa4A6/lS3RJNMwstYZZYDbNkmbEXSVz1kCJRGRzqejmxWWS+hW7mnGKLTihGuNTjRdZ2v5sle4fSV0xeVv6qoMbltT4lauJkuerHvTeM6JiyW3oFcYQytwL7VA/5AIt5bk8KfXs+rJJjkg7mLQKJq248MX9lErCDEbK+Fv/iljooQeVLLU5CCtfTP1LD+9acDxgN3gx0wZdyBqOI1l4ygRdk2q6OfIKlXmB8XcIShCx9mo/UYbEX0v75WI9ufhksjgRQJLydwMuN7uLZ9/B3UXJbIf5aBsOY5gg==
X-YMail-OSG: mL1JSuUVM1kzJqenl8imonXmAhAcEfl9bbeXiKBGuB_07asbG3BImcvofhy5uA3
 rk_wvv7HGT61fnySwfa5ldCH.iQ4ISj06oeVB2BQ0hY0y_o8LdtHFDT211ntM1VVO3e9T9JumQoo
 NKwkoec_VkiN3A5wzZxv9lqCftQubLMQrE10Tf28UOxWKn6rphgA4Vg8dRL5obX3orIdK9q2qnp4
 wFUZZt5TY0RpnWtZjQYCyKID3d7at6cW7FIsmEVFpFYzDlwtxSvqKhTVUIAhq4PbAYBpls6L9Ni7
 6WeXJK67CSqe1n9nNAaoY_fRJUxcu_YCLurNqvb_gKZ3UeCBc1t9liHRjOvDKQd1X3m2Y7ivP906
 _EML2euKkAG7MipeCOVxc8r.eW2z_RglrbxF56Don7nreLh0jIQK2ptQ6yDSsBDZibdYYedO9lnF
 PhKppCdHjsKj91AZH0pS_VhhT2hJUClx.NmY6ALv499wXo3RGOiOJ7zSeRqoHUMVh5_ALPIEWwaR
 BaEst.KU58RSjown_l8OtQgeUvsC9fIuDvTBjLzCPI4zbjQh7jpguC84WQUdpUAh15qISjzxFvMr
 iaGHgoB6HNd0Bt8Tl9_cc.B120jaSQnHxdc7hyM0fD.BQuhXzWvFvzOzJovJ9SrcVR3tTGCwp3TK
 9zrZIyMw5Wr8bCBb2aThKiavIJdDdel0WKhAMx6..Zi4zb8zq5r5w_fU8kcQs.Ctvmhx3dURW6DW
 4_LsQZj00KQ8Y9kmuHZ.SIIWDynBo5DkFi49lcryRIODxyUbEb3thJXuETJcz6hiZ138tPamlHtR
 jS5VSgNbUPc8NJ7h1WdE2D.E9mZE7aQrxyNatvLLgncqLxWFAs6f5KUhiejtPsd2Y5etmly7Zlg_
 .Iab6fex2vndLoXEl6NHL_rwScRy7BZ.tj2sWztWCttriVpTx0r8H3qqCwv_cfsmC101e__ORh9h
 735eKTCVHQGMHgvE9C7iW6f0sUQ8.bKsn5CMJ_eIch7ay6PifiKk8v0KDYLAH79RapUwIo4oKBH7
 k_opFKJDECVFyV88vFygVOa2nN2H4Ufx3N08Vt7XccJamPNCNglSDBQsQSHoSoJdz7.hoET5bBOF
 wC7UoI3PqzvXY0jsxEk2VTwFbaidMz8tTIurC3koVQstZTwL6D9cy2esvA8cuA7aKUoBSqvZ0JN_
 yMTyo4MzQxH6Sdo1.3xcpvVHe72aqi9dDYz6CDVPL.TgayjVm_YWZCR.2P86VbRlWk.pUjtnWTuN
 wL3MY51WuMen8cut.DE7Hij0e4ClkG8PH6FKWRqAhrmzSb5WF0V.PAKtinMZj1JBcgl3eDbGH6WS
 UU6k4HjzjLB7wygjgRmvHe7Lc1OOHQoCe6bs7zYq6DUxqf_15fXBLiBfI5ciJiE9usNPNeqs0owG
 UCNK7hq9tcxLNrG18eQMWQHsW5B540assQm9x9WlcblCrRMtEPR5MkySUs4F2jSe3UMx.ynXYoq4
 Iyp8VVmL9puimjZ6.rnJHyvyvfqagESYG9FZG.o3swrveeRZWwUnbolG8da.I.jwXty0R91CNT4q
 aQfB0.5d4voPxnCnA6n24o2Uy0RpVbonhWmr74wdT4aitrhdOwus1Hb1kJpSwwcSNuE0NTe48Bb3
 5_ohl8yaSAvl36FV1Cm3DV6r3A5NxdV5QIHbrtSzCNf1MnMKigcGttJ6bo_WGcSedDfz9_4b0q4J
 .dhEnlyjyGL.ImqkZ5hMZktiXm0xjnvWoPZAgOWJKmLIQx7TMudDW.Us7VSMEHm5jdz5ZDxM5iVz
 1J5M4SsPNqzKs44WMnsPHU.1Ff_fk0aFyJkeAW3iAQLxhow7Oa3xXQOv3ZxUo8dT.Cf_gOmdD4h2
 X7eknlXJRsOFquII2J6_cfA9GtMeFb.loIXaoAa0NpNZzI2P5.OLD5OVKeulZr2Prbm3gywRvQoE
 _5hRmwlfGFsk7_iZRxl_EClFFBYzwO72HhcoDlNIFyLhnRuqDvXVF9ChE8a0H1w7mKhToxoi.P5V
 7CVaFPlIFE76WSFRF4gaTaqcRa9w31Z6AW1ZpNeerDOuwCTs7yuZk9hi2.WP1zcoQbfVKkTuPTFR
 ebRZ_3A5p6W00SWx9H1Brll7MELGYa_A1LECQUpv0h9_q9gqgoSXo1cVETK2GUO_kSJgPhkQx40f
 DEjVpKao_nb35pMg3CeM7GfOlHASl809atzJ0DnNw1WuwIpd4LX3Ta8lIujmtx4H.yPJ.VFw20PU
 VdUgyex0u0F43AGfBm.CSqoiMaKi4dispDAYqzuHY9JejS_7fI5or52A-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 Sep 2022 15:50:38 +0000
Received: by hermes--production-ne1-544744cc75-zkxbp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 408511d94d43d702f94fc6f08a7012d0;
          Thu, 15 Sep 2022 15:50:36 +0000 (UTC)
Message-ID: <c2a2ca9b-3fc1-c034-6cc2-4400838c3354@schaufler-ca.com>
Date:   Thu, 15 Sep 2022 08:50:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        John Johansen <john.johansen@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>, casey@schaufler-ca.com
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <791e13b5-bebd-12fc-53de-e9a86df23836@schaufler-ca.com>
 <8ac2731c-a1db-df7b-3690-dac2b371e431@I-love.SAKURA.ne.jp>
 <CAHC9VhQGnEcoYeGpwbbXbMrG1dOvJ=2ohd4zPYoqBJK9p1mSjQ@mail.gmail.com>
 <854c05ad-888e-b882-bb97-65f4ca289bc6@I-love.SAKURA.ne.jp>
 <CAHC9VhSDL+wuPGNB3axkksqVTjnxU8pS8Axz7skPk3zjBbRJXw@mail.gmail.com>
 <b6ccb6a2-b6b0-b6ad-9f19-8ff3180d04ba@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b6ccb6a2-b6b0-b6ad-9f19-8ff3180d04ba@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/15/2022 7:27 AM, Tetsuo Handa wrote:
> On 2022/09/14 22:56, Paul Moore wrote:
>> On Fri, Sep 9, 2022 at 7:33 AM Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>> Inclusion into upstream is far from the goal.
>> For better or worse, there is a long history of the upstream Linux
>> Kernel focusing only on in-tree kernel code, I see no reason why we
>> should change that now for LSMs.
> Because we can't afford accepting/maintaining whatever LSMs that are proposed.

We've done a reasonable job so far. Part of the process of getting a security
module upstream is demonstrating that it will (1) add value, (2) get used and
(3) continue to be maintained.  Several modules have been proposed that looked
like they would add value and get used, but that the author(s) had no means to
maintain.

> Do you think that we are going to accept/maintain whatever LSMs that are proposed
> if we get to the point to "The commitment I made to Paul some years ago now was
> that the stacking would eventually include making all combinations possible" ?
> I don't think so.

Neither do I. What I want to do is break down the existing technical barrier.
If Redhat wants to continue with their "SELinux only" position, that's their
call. If Ubuntu wants to take a more inclusive approach they should be able
to. That does not mean that every bizarre and/or unnatural security module
that's proposed should be included in the mainline.

> Although the upstream Linux Kernel focuses only on in-tree kernel code,
> CONFIG_MODULES=y is not limited for in-tree kernel code. It is used by e.g.
> device vendors to deliver their out-of-tree driver code.

I see this argument all the time. The response is "get your driver upstream".
Vendors/developers who whine "It's too hard" get no sympathy from me.

>  Then, I see no reason
> why we can't do the same for LSMs. We simply don't need to "provide efforts for
> fixing bugs in whatever LSMs"; we simply should "allow whatever LSMs to exist".
>
