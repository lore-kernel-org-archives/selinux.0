Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1A3C433EF
	for <selinux@archiver.kernel.org>; Wed, 16 Feb 2022 17:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiBPRIp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:08:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiBPRIo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Feb 2022 12:08:44 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5B22A7957
        for <selinux@vger.kernel.org>; Wed, 16 Feb 2022 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645031309; bh=jlNkuavda2CeuAjhnD/qjXWqQkLslgrOawTre93lmjc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iwoZb+fUa7K1ALxNsbzOuCmbgCuFKYR6+w4EJrYT01kHeNk/G/i+ZWlRSKjHeEu8/COJ0PXDGyvq9bc7yfqsxbDoTAeHAkW5Ye9K2NN1cVpCm8av0W8wopCctEVa9e3a6XoaeKA87ZlXmKET3y3481Zg2ZapP7fHi06PWrkssVFp4AUyG+LUfH46xwHmwCr2gCj1qHKpA+OHMQ11Hiikw9aiIbTq+2yb8KmSM8wJBJtMzJwG3DgWKKbaeWmucQ+4Wfih822Y4QrF5bs2kffoeC7LRzdRyI6ZP/4tkeKI9vfI6lLmJYnx50K8N2noQpnC5D9gqsbbtaUjCVuv/G0dkw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645031309; bh=403q+NbMS/zjAK3kdGot68ftMBri4JSMZP5hRpEr5vo=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fvFngSITIAe9Z6StqOXXaH5SbHnnNgrYKBjrgFWZ0Z2qRSx8SHByb2t+v6xWzGKYF/3l6UH16uTxmH5cEp17tN+ygjzun855L5qg5vHGup6gUU6AuZhQhKMuTZaINknUMoqSYOjV80n/aFPkIl/SpBvGm7HrQQOeP+4owvK1EGhfFm+/R4o/DGTZx4iuZkx2zDfZn+BSGTNE2R3sFCFFYptW0h3jtZGFHzNmaCdESl7HJ+flYBsVHW7/r2a2NZTcQy9vRLDBO1mMhH6uOCSYBeGmbiQu2QCDz+E8zfnoKhkm2Aelt+2rxBQRDcGu/+01dpZIVoC1zzu//FOAkszsYQ==
X-YMail-OSG: p46rcDMVM1n_KZ1bmMNtowiIC_8zS3or4ZNQyz6hTPo1CzdPaReOt3KAIPT4LUP
 3XTCeSYv08.efAe0M3MQ8L2PGnjIBwL_BcR7WJg9HJtpJFLNJkuT516pFOeXh1MeMOlGL.lQNRCF
 UHm9SGeQWmqc4eQEyGJHPF2y_quotVVhhHUZCgXMoqkpvE2lbawCvLSRuYyLBQiEQjOD63D6xWpS
 1cfc6hcFqZUR6QPM9esMZTEb0nxBhS3.oWNBin3PggM1KGGqvoB2VH6jobzVPAJkpcjs2RVahjUZ
 LTadw5c0A9ETOj4P2ZkrFu0SQdlI.jef9596WvRPo17S43.ByFcTuTPCs.kmL38rlJyR7YWOIgL2
 DfAHY7jQnCaIqTdaW5VxqsFUlt5nVL5NAjFucnRS3uNjcaPYBpKmBB15IRkoWU6WR.7FWuBTqSdy
 0vP943qG8Cdq.4FqeQthGDvOcwhSxD00LEn1LhFAK0U01P6Yp_him3D0a.0So.p0Yc.HvPFApme7
 L9IqDTw.K1B2roCCAMautAoOjnmntGnwl09LCdgizKXocOuDdwomodMezU6Q6vC2cBHaBpegv3zn
 oR5AevjXlh1vIRWk6A5m4EXyeZeqNbZa2gfC37LJ6I1aFJbHqOh9XFFaKa43UkByA8.kNU4ImIw9
 whPIn_oeEuqlY8YAcGS5c8qFKDGHkXizQZq3LiVAHIJ_5CDlHHWWinfVICa9QbJv4ZQrqC7haC3k
 o3IHbECboPES0S39mza_whZOUEMVNR1h2MGKR4qwmsjeMKoZGzNX8UpKerAjIMpNA5I7evXBOn.W
 hLyDRrwvi9zzFAlXmR3HQdfKb27zrJ0YuNQcCkyogTiWZSDXL5pWGPxe1v5ZaIF2Rw_pTLdYFEmd
 708xaSRVwkCH2UbHYDO3rTevNy.gv_mHcGwH98fPLYzwX4FznN5xBIDhSTtl6x9r_pQbV_9ZjNfl
 VcVHjAA6E.Xc9w_2AFWZwO6zLI4u5WH47zq1wV87FJn_R5hfmvuxdOc7z69YoqARIj0bK0t6s65F
 7pEen7okoQ52ulN_vtt4yv2DtnylPysoLryU9MyJqmpPuSJOgCg85BW9atvCI7xeIwWRgtiNvQb7
 YVcp2JTpxvDaeTVwe5FpgqCguYNEOuTaDQiKs0B0SirZprGS.mbnZDhfzWmYYi0eZGznkMYXDJhl
 XxTNHlC9j9WEK.kxPBkind.mjoTa.wtVBriktVxLNDeRNPOT3Me9tgUNV.9zhLQ0SGZXfoVm7AGh
 MrWJ4mcp17oxXxVSYIrdNIXuGyyrA0Z2Oh3fceqUXVHehliFCJsDiTMe4rG0sClzzRcvsL8HXtD6
 cj5inxJnbNYdgWJ5InWR7HPdNJVF5zWXaDN37EX8PFtg4RIBYBtvXwbbVqsbbB_UWsc2XTzZnolg
 cGHXX8sbTPwb8x.mUPDOpicWbYiZ8dmEU2zxmQ9N5RwCkc8G6bYgZljoa0YWczURWQs31L8AnW1y
 EkPMUOJXwUl1Ax7roPwAeah0r6tD1WHQJ8U5S3sI8Gf.9d_64Bq5QUxjeNyjkeFT7Ez89oYSpwwI
 MkmO_6q.zbAt_Z7XFK8NboCzW1hnxaqYK7EH8IG4_kdwXz2Udbg9QyqN3xSXOJKxeXZV1HWkwr5_
 UP8XQPRhoCdozevRpyBTEOp2F2dOK47_DbCPrZzCTfpNTCxKrJCIWMluYKQi45BR7x2osl8yhJYn
 yW6Xb1Y5rwrN7zaq8IAB3GfdkoIXgMY.ajEx.mMAvd2iglrr2EArq9q.FR7gpPQtOd71GuQXhcqc
 9i.3zSDNhLtL_tmaFcHJm0QbMed2jhWVdh7N6NpCnqo583shTq.rUlqbVLEJssttZamzSys6.KVT
 v5NEccVqveB4Gx.gvOQ6zjlbRTf8MucLPx333bPJCqVfBaU7FgrwbZK57A5y__WBlYK0G9tWKSb3
 6i.IcbUxZyxXwM5W_NO96x_7yUU.ro1mT4St3RFUW1mkZhkq7YzEE9w7Gh..9MTNPfGn4hf2wdZG
 jMCLvPYDUGgydVTFUpfaA_WZaWYBzXQIaMuRmC088gI4hco260W1qFbbde8g2jjgunQ.qVQc4N0M
 gjO3H9.8bB0EP9madA2lvRs5PGS.5l03bbel1qcCXB7D9oLNFig53UJhNfHB3qrJzUb0Jup1d1vo
 iTOHeUuc5CJAAZwH0v3XpxaN0dQh.RRPlfQp98jQY7ya8XPL645_xPYtXdNeKV_cBHYm9dqVD_8N
 h_JIUXtCKIaddJM9F_G7oH4TdYRl0NG.dhMuKM6MaiNMNRjhuYwWGCByxcfozwdQMh5HI
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Feb 2022 17:08:29 +0000
Received: by kubenode515.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 369de8b5cebd8c417eb416ec1e19c6ca;
          Wed, 16 Feb 2022 17:08:24 +0000 (UTC)
Message-ID: <8e752954-d871-c67e-32b2-b1293753bf07@schaufler-ca.com>
Date:   Wed, 16 Feb 2022 09:08:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 0/1] SELinux-namespaces
Content-Language: en-US
To:     Igor Baranov <igor.baranov@huawei.com>, paul@paul-moore.com
Cc:     hw.likun@huawei.com, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, xiujianfeng@huawei.com,
        alexander.kozhevnikov@huawei.com, yusongping@huawei.com,
        artem.kuzin@huawei.com, Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhR3ZbcNM8awhJs9_NXmdUXHO4XoH8s2d3MjhMXwkgbh=Q@mail.gmail.com>
 <20220216125206.20975-1-igor.baranov@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220216125206.20975-1-igor.baranov@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19724 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/16/2022 4:52 AM, Igor Baranov wrote:
> Hi all!
> Our team at Huawei decided to revive the work on SELinux namespaces.
> We took https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
> as a basis with some patches from selinuxns-xattr.
> We reworked them significantly, fixing and adding functionality.
> As a result we managed to run a CentOS Docker container with SELinux in enforcing mode!
>
> We would like to start our discussion with the smallest, but most basic
> change: we gave each namespace a unique identifier.
> It is assigned to a namespace from the global counter
> that is incremented each time you create it.
>
> All the objects which in the original patchset kept a pointer to their
> namespace now store its identifier. It's needed only to determine whether
> an object belongs to our (in the current context) namespace or not.
> The aim of this change is to reduce the height of the Babel tower of pointers,
> because in the original patch there was such a mess and such bugs,
> that we decided to cut this Gordian knot, removing some pointers altogether.
>
> This is a very small part of our changes, but we see the point of discussing
> more when we come to this.
>
> Particularly because there are alternative approaches,
> such as Casey Schaufler's suggestion, which is mentioned
> in http://namei.org/presentations/selinux_namespacing_lca2018.pdf
> "How to deal with secids (32-bit IDs) which are passed to core kernel and
> cached there - Make them global" which seems quite promising for us too.

The promise of secids is that they are opaque identifiers and
thus only need to be meaningful to the policy engine.

> In the case of this approach, it is not necessary to store the namespace ID
> in objects, because it can be deduced from sid. But a detailed study of
> this area reveals some painful challenges. For example: fragmentation of
> the global sid space when loading/unloading different policies. And the
> depth of the rabbit hole is not obvious from current positions. This is a
> separate big topic.

The downside of secids is that eventually you do need to map them
to something meaningful to the policy engine. This is why I have always
(since 1986) objected to them. The SELinux implementation would be much
simpler without them. (I'm ignoring the networking implications for the
moment. :) ). Nonetheless, with separate AVC instances the mapping
should be (I've been told) straight forward.


>
> Igor Baranov (1):
>    Replace state pointer with namespace id
>
>   security/selinux/hooks.c            | 29 ++++++++++++++++++++++++-----
>   security/selinux/include/objsec.h   |  4 +++-
>   security/selinux/include/security.h |  2 ++
>   3 files changed, 29 insertions(+), 6 deletions(-)
>
