Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D65C2BBCA
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E6EE233FA
	for <selinux@archiver.kernel.org>; Wed, 16 Dec 2020 16:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLPQcL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Dec 2020 11:32:11 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:38400
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgLPQcK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Dec 2020 11:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608136283; bh=zUOmpsLMPHpqP3XwESCmUsFWI+b0CpsoPbAMX2ouz+Y=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SD6OLd/K3V1UQ+4XPUAerl+ljEzy9TtIR8uCLzOdnMj3NYP4djfsdIzOuRCAEhw9w7FgPpxtlTopqv/1zlHrN1p7agaNYHEzXYgezkZRWLr/CQnrd8tIthKoovCIndy1JcwhbE4DwK4lTh8bN5PsJ7PYvC+kDKfXZL6vx75p7cbsatK5PbekwbbapRd+Uaer39OiPTcSDIBk4XCasmLx5FRXeRMDvAMFxnmf0GzJhzi4y9c6WY3Ckp/J7q6TySefUsUhQ4eoORf9Le+OW3SxTXC4sv1V5d/aARCaNYSBTEQbtJj0+9mu33gRG6px3jCwnnGu9RXfzMLxmfIXwNMqAQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608136283; bh=9vzMoicP2aYeGG64i4HMemhS1opicqcz4MHU3v/Xabl=; h=Subject:To:From:Date:From:Subject; b=mSb48me+apZENvNjEfKZ0aXh4I9AWCLTjePlN7cXIBvybfnNhPi46+48ytf6RCOnHAcbBwMhkUzqKxAyGvfJy8Gmq7wiO5WgCfUAGnVIeLiPwrW7ngztHDBErMaqSAviIq1ZCbf1UL1Jbsq1YLWQ+6LMLZkMunh1iw2Ubg2ZelEngcbfpM8vfUgGnP6MRPvb52JSVqKM4hLLpi3fULc68KE5ccoAQNUfWI7IyM1XI9AcJQiYRFc2mqip+5cAckBtTrO8DnP2878Y4jvUeVfwxSVMqefHocnCkQsn66lA79tNXN9M897O0ogqEh7iMQSIMkaq5T5hJfFFfNWvEtovTw==
X-YMail-OSG: J3CCqasVM1kpaQgNp8Il8OOKNEfbtdp1lg6IsLEO3Et_G8ZWY2jXNJdizlHvnWj
 EwV6St9WE6Fn1GcPQXDcnph4NHngDFzkPFObKUe8LTtM3cueWwKZ93fw3eKT84jKtFg0pD5.YLrW
 WyG5oeKF6zkY42C4xLJeLqkORvKPfJoKx0jmjbGxRsAirmzJ8IBfEiRp4wOtZThJAazzaWMjMW0j
 OnN5FKCRrQiyJvHFFqr.sjb9Eyj0GqjR6NP0.HTLS5a9lPoCBV1pDjq0lAcNEI5bjAm3hKtq9kp6
 uxxICWdpRgG39dRi_1dLdhWYIvzPBSb6EvnkXzBVxdGdpq67llxdXwyyDtDGreydXiQ.m9cOOBaK
 6y_qfuo6cEU1EItWymNxyNWpMsKOegV.TraMS9okQuPA6KEdNEpPVggKHY.KbBycaYxdhJK81ezG
 qhNSZOoMjTYYo0wlJ1eYEinXLZ.cqn76Rk3n0ooBidp4xtn69YyehJzisYrT8byvcRwNq75ANEA9
 B9HF3cp7YWXLa4X5m7.ev5A6hlWcq1uhGT022LPR44OAg5MTojEZaXgG.pz1WHW_sgDw5NEbVhW8
 EJgJkpe677uIIp9B7KNtMjlPAVUjyAQJrCsxAvVVWZs2IlMiw_ejEUR0_JxAZxIcvSV1ZNoGYXK4
 y3OMPFOcNZlsvFm46mtq1GZZ961NWXeP84XJrUcxh4.SZYPJjMqKJFHPNAzbXUQIOq8OrejjT4p_
 Pdlbf2NdYVGLK2iF8gp5FqkvxXZNqCad8AcjcsDnMNP_r3kW_YPBveDqFxDyBB7fsCEe6LQktVXM
 WqSxaFlwlT8dXZgbcNWg4DOWd3D33aa7gE1twIvY4_N.XJD_aC9t8J6gykwM0vIC7iCwlkoOvKlW
 ndv30cZNo8rkFP3wMQ.FlMtPUKvsUXj_BOtFYee2rdGcl5Hi_yj5kjLWDMLADOBtTFZa52G2ISvS
 j0O5xE6jzSzopfEhCPoXi1xXbwyFj3D7c6E7ZMKeDBeie1L5dAcyRrk.BPmZLD538wmnFXAIo9lJ
 fsROdki1zRmvj14yfvi9leiJQEJ9n7zhPZEPSwW4oYBvfr.AoO356HJmOy.Ad6urWc74BorwMvHa
 pXOFqXwbtUvZZ7LthXuiT_KlCR99mlqsgo41J33zhpFuzdxwRcf2YPjC5DSMBGePEO5xR3dO8wni
 ih2RrbXN5WgScG88gksHD930xNk2Fxs4IfJkTGiCsBEU3NyVFDDSpeETu4m2g6Gaap7QhpU03dX3
 r7BLqyy1rDMfvoxNFHjOw5lk58Qdwp4U9kHrnStWHzNcYGz4rMmaCsVKZvjALosyoLrvBbxrPPG9
 U67Au8hxWqc0beJ56r66rX6KnWyRUXkXrdKdFo0.YTqUgpB8O8xJz1czVPzF4JhaJCvpsPuYtqc7
 tXL7pa2Gxgm0rYQul8T9NkaNLfaVcB6PoLP8kiooDyWWO1dPlLzE_pOyfbQbSwIx3rhPP.9Odq13
 nLXA9ABi6lv.2yi7YiladjY6sRrjPpbyTQCXTJVaECSRIHRAEHx5LQCIVLcxK0BGlZYvGL4OziIt
 tkaW97tqvLpaXCVDird5azJ_90befZmjc4e7cx4ETPIkf6361x5NUEU3gX4LhwMT3fMVBEyOKEge
 KpimmSilwJUv1r29dbFZ1bu9UfaNYYQErJnwioSFPUzWBSYeSDmxwCEMuAzCAXUowQMJw0CASfUf
 uiUcy5gNnyqHRYMrgoQRIqdwMrt0mUQRXxZlfwZrm66ndpJAHE3HcT93VSxmNc.vxJPiUmq3u0r7
 3jwrgL6esnTroS7UGxpmqfAjmJu_PWTmJnZODzvflBijKhz9c3omvCZiGcxunZikhTK.S5txrlrd
 S9Nft3QsNUsd2ADx3R5oJW85mQHwFfRg.vO3ohC5F.MmxCbtJg0vF1o6m_YupmP.tXfM_ILqDqXR
 j8PIMcC9MG3_drCksK1KxWH1BaA0LGoDFJbDsgjZsM7knn8Y3qotXIQ8YOpewa9Mzfky9Xx2D7uB
 GL8AVpDr1UjDhEqAe2DfAgFID8GA2CSOdvv69MPEgN63VRJJv5F2B4iT8God0MfqIUmnCvR5B9jD
 s2pNvFmQ6GxerTDa7ooZhY0U5vkaUG.onjHNObETkVDlCYegljc2V52QuDYG5u.1rdYJvTWMek7Y
 VMo_3tJuCvsb.jfEThzzEaZQU2jjX5cmDE9xsY6MYpAAgeF9EmkTib8wAHqpxBUUQm9.Sm.5N95K
 q55akfkdDCPqa7y7ClKIJMKfObX5bX.odPPDd8kyoDr.szK0jzzIPA_JbkhIG5V78MRh9JhjH0lj
 zPUEn_TSFq.z_gZJBL92N.6wLeCMUn2ODuWxBrPEXTwj8OxiCLzL_7Xe.f1BqLrDgnfCEY3TeodD
 AqjeIeMbrwxOQe8gFSa_1r_aFviKzR0xMxwbVmGVfbyZJDPyrt.fxQ.Od.8HRh6c.0IHf4xjqbkr
 vGL1021TFx0R_iK8gK.jxwWGpTkFLswJCk2goDwRrn0_N36x_by_._z09RWHobBUUxSuxqt9tTPI
 1dVOF7OP3OicG1l6poSEpvEDkgdgNE.dlsqqVJzOBpbG_T.T_ftxjshB.L2twhAq1msiraEnHWv6
 VZOSVfhfZfrduFHWM_6RhyIDbIxBqhULh3qYHEdOB57keGtMgni9b3ZLta8mIfug5Mc0Eq6BqEMy
 UxQQrGYMq4SyeqDX2UAvFO9SQ2725zHuayL35sRm_hL_QOmriYmNJhyrCdieR.yB1CKMjtfac_HS
 leZQGOKOyWPVx_Ybdhc0qOADn1TYqxq6xfKlzQbth4i9ID5NCv78vK9MmcCt7jqFZFJQrTdi5YVj
 QkDRwdN5uFkp56oegPsBaPvWqv4K.ft.4yDdc5QbfhU6jjzjVVYA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Dec 2020 16:31:23 +0000
Received: by smtp407.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7f663c88d39e1c3b2840a3750c77941c;
          Wed, 16 Dec 2020 16:31:18 +0000 (UTC)
Subject: Re: [PATCH] linux: handle MPTCP consistently with TCP
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-security-module@vger.kernel.org, mptcp@lists.01.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SELinux <selinux@vger.kernel.org>
References: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <27d6afd1-9a2e-e258-dd09-e943de06f480@schaufler-ca.com>
Date:   Wed, 16 Dec 2020 08:31:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <fde38edd69c998624c5eb5be072ca1fa556d312d.1608119587.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/2020 3:55 AM, Paolo Abeni wrote:
> The MPTCP protocol uses a specific protocol value, even if
> it's an extension to TCP. Additionally, MPTCP sockets
> could 'fall-back' to TCP at run-time, depending on peer MPTCP
> support and available resources.
>
> As a consequence of the specific protocol number, selinux
> applies the raw_socket class to MPTCP sockets.

Have you looked at the implications for Smack?

>
> Existing TCP application converted to MPTCP - or forced to
> use MPTCP socket with user-space hacks - will need an
> updated policy to run successfully.
>
> This change lets selinux attach the TCP socket class to
> MPTCP sockets, too, so that no policy changes are needed in
> the above scenario.
>
> Note that the MPTCP is setting, propagating and updating the
> security context on all the subflows and related request
> socket.
>
> Link: https://lore.kernel.org/linux-security-module/CAHC9VhTaK3xx0hEGByD2zxfF7fadyPP1kb-WeWH_YCyq9X-sRg@mail.gmail.com/T/#t
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6fa593006802..451bded67d9c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umode_t mode)
>  
>  static inline int default_protocol_stream(int protocol)
>  {
> -	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP);
> +	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP ||
> +		protocol == IPPROTO_MPTCP);
>  }
>  
>  static inline int default_protocol_dgram(int protocol)
