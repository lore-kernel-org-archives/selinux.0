Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEACC31E5D
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 15:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466AF21897
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 15:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NP/P/M86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfFSPkF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:40:05 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:46465
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfFSPkF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 11:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560958804; bh=xiIYTuQ7Qz9rNn41FptP7tHAci2ojAkUnbNsColKIR8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NP/P/M86TY61VBE7HG6jgrkLgoznuBYXr0gbYeAL2w+P3Q63KmWKbF6/1lVzxO7FJla6iPM6eKxxYzGgoYKyDcSnfOQc5pB7DecH2oCAII8VF9TWHVb7ezvVvfuGDIPu5dyoKsrIK2XmM8lIMVE33k7njQ7N1KjY+wvLpOj34AfwpcVjPffmO1jty6Qz3oaSffydzwHlEEcfFpmjctVSxzF/HJKeJCqWlIxsZLJx9uRcBUJuMjttGm4cF7v5k0/+pTmJOp7q79gsDDQdLzIR36W3ORIwjwYTR2RviFTuCjkfVyR0PMLSYgcHwSI+0Su4+RrlvfLEf+kyc1PqT86lgw==
X-YMail-OSG: aOuJM2MVM1nfolLRDPUeC4Ccv25vMbOQjQzcwNSZpfo3Wk.7R0xCC6Qd1ebdJFJ
 unpAGsdhGPytB1NqoiC3Q6MSEuP.NFResxS_ETXaJjyl5G_8iTJfsT.23jn7GDW4O321ZgDjz8ic
 uITL1hs7nocoo4EQZp7zswCNNPRO10v7dK0OMzg3AcsETvS4y6a4quxsg3K59YFeAgtg9we66dsq
 BJ0h4mZ3MZUfQyERGDgF8.6kKPszBNiZKXq1Fq9wY7zKzYRR_KPPyc3q75uRSJ96lrGrKNLit9.e
 jfE991YXn5p5W4uw7juBPy0lV2_J4oxqa2CzMULydGrXRgyjHJikL33Wris3auVtlauB90SZAyXp
 8QolTantNMLznnFVbBvN64DZNhQ8FDF_GD8q.PrrZawRdaS06LXcLRk_smBEFboR0DizAH51DR.1
 AABZRYyAXT5VW8xO.vpz6BLTByDvDW.6HIGgmfeNXiwXj4AYRUxtF5vLb0VQ6FKLiZebCEPV8BRD
 5bJ1wuxMbXCxFT0nDFaTJZKD5eaOpqvee5fKA.APGs8KeuGWo_ZLYgN0lpndOjz4WPfewLYGvmtL
 LMY7SDlE5w5HgUc1ePdrSzZ2Wb8MAJPD_F.mX2dGqDG7CeiFfveMrBA6xrFw2aTHkEw7dY1bDikP
 ywL6pwjESmnk1R3nDDa7Lnzk8bNeTqX3rvbDBjbz_4SUxUSsxq5YIDZ3fEfCTQwqZRMnEvJNHC2j
 81f1i00s6jA2VfZohNSLQ5GczDshlp_V5voijAUQ6dsMpRQT5wA6pBE2fL4XgtqBeclmjB0yf7Em
 rsyKpAGrtuIIwSILs_xf71BEMgRo1._gj8pakSNlFey6PRLkeUgyBbbPklWEsrG6ZOBSfP_u_0XO
 teLUEtMOW4hl8z5M5PfKekGrkK8T_CChC1tP2XCVw6pauxaRVxu3S95KqKNec2C_ru6c47Qqc_XW
 65hsC_i9MgEzQYSXgRD89RBAJd7U0mq6HEEgaKNqbtOfMpqtpG8rR5Q6vNjT9G6rZXH7vzJilnq_
 EWrHdOiZB84iu5EwU13h_KnWS5aoP.C8iBzmgqk5FHFbJKdJ2aVVXZd.cijmQkr3o4fQXeTRuQzn
 8CtYlWGXrxW9gFJ6ZA3QgqF0MhW05FtAicGp9wEweUSfdERdcfdUCaEAVAKgPHWsHukVGu4nRcV_
 quFQpjpQ37Z14l5o2ikngo3qXE_gwxK6O8nOQAmjuQuVfs8.cP4E9CWj1Wgj.AFX.RrbF5lh2nSk
 0.Mnw54pREqydLvelLA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 19 Jun 2019 15:40:04 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1f6b2a6c5b7c5a3d08dfadcedaa6bdd5;
          Wed, 19 Jun 2019 15:39:59 +0000 (UTC)
Subject: Re: [PATCH v2 00/25] LSM: Module stacking for AppArmor
To:     Kees Cook <keescook@chromium.org>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <201906182133.EBF2C78D@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <967f2602-5cd4-f5f3-5936-08b02ad8f9d5@schaufler-ca.com>
Date:   Wed, 19 Jun 2019 08:39:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <201906182133.EBF2C78D@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/18/2019 9:34 PM, Kees Cook wrote:
> On Tue, Jun 18, 2019 at 04:05:26PM -0700, Casey Schaufler wrote:
>> Patches 0001-0003 complete the process of moving managment
>> of security blobs that might be shared from the individual
>> modules to the infrastructure.
> I think these are happy stand-alone patches and should just go into the
> common LSM tree for v5.3.

They don't have a user without the rest of the patchset,
but they do make the internals more consistent. James' call.

