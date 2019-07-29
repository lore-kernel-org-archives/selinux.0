Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C029AC433FF
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 15:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8767F2067D
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 15:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aYRG0wZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfG2PEQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:04:16 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:34811
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387859AbfG2PEP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 11:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564412654; bh=pHPlMf+EkVZr0nc1butMWMvwj+NNzpBJQKhP1snLMck=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=aYRG0wZiO/zwel3yZ/mhwxrppx5pag8+6ECWks0whHfL7jqevHvla2p3BNX9JzMkZEHQfAmwg354VGA5s5Umqu7b6vfrOHgut7nGO5l0wjzFfDku/rSPy3PjlkqQZ+HN5hWGkVvJrG4LMt77ghVuNXzzSKpCmVbiDRHYlznkVZMH/dc0CO3n5OVMxCUbCfxSfAHO5K96zlJYMb7LFQ9DLCjlDuSuXQJ+SqbKkjXW4b09y59OpfZS8OiQy1CNVg1ZjLDNuWHHPgxPjy5tIuc/EHTjRp6j50Ru3hsd7pj1Tt1cDk3kjEdLy59C4RjgxX7TKf597XceXtsaI2O+x5jwCw==
X-YMail-OSG: SN8evh4VM1lnuLNGEc1oA1iQSu_1RwmH0rgtzpiXQa6.3Pw3glXVWp4AxX55pav
 hKFbbubxQ7WbN48qc4Quhmsr_Gx2__hvtYJqZUhV7Xml_yVXRNCoN6wfZF5RIvci6B1hOszhxd9R
 fDPEjqc44Z2DKEZlaIv_alU9vHjcRodafdT3UAmjwJeyA6q3tJDvAZoR_u7NhMemefJAY3KsvYZz
 rj5XbE1KyT4v03s09IYTods8hJ3RAj4Vc8Dfw4nQPP.XkzOAQnj8RMJ0LuhSuyfN3VI221c.WkKB
 sc6wFLnQ7PqbFG0RyLofbYmvFIAe9NxWHplR3BVR5XdcdrmuBWG4h9YpmiVbJnrZspU3yepbAHaK
 TZ8pxP4uxW9EVM46oIBjnMIP6cGs2bOohY2KSpvodcCQjnoKJsju.ZMVyFUNfeRp3GMWcX2M73AP
 LKGXY5kmoqZXqc44Kc2is8BfyWKTi9W_ymv7BMIEKVtjKmjzISFlLjpbnP6LrQM6fRn7UHpPzLDa
 poDZRapeDkNXjO.YpVpTsv76XD_pbbKQMUJ_I7b2zAnh5f.jbtQVp7LetMDRzSMg6.gu5379qw7i
 0EoovAm8AyuV1euC74Fi1T8YV2CrovubA8zhJ4ATvPMZzxLFo_YebMq_VaCXLbLaP2RrhtmYzuXV
 MueuMCbYqWDy3szyb61D2W5YXVC4AgLy7uAxZyLrm6z4MPl8e57qfZ3usGKnOtdW9TK1QWMyRLLx
 wXOdcs91j_Y1nPJzYaA0UaZPWl_O_7oTChN0u.XJYqIvCXbgO.iWzNJ5AyzZ_WiTbb6yAJQQoM8p
 a9pqatpQaTCtUdv9MudBY5oSnr4WBEymcPza0t_Uqdc76qx_Y1.k55nB8VWPC8PGGNfy.pmvvvHS
 NqvFksYNqITcl.RxsO24n1fuun4tSuHFkkySGMB6aqgXx6OIT3CMkLULU189cZ9XV1rR5JELr_89
 oe6zTP2HSsCaSXwjcxPSH3wmf8zEg.hwl0p4QtZ82XE0ApsRd98lUBbbMtX2nT0d1II.Pk_MvFUb
 KdiiTIPg4L8l1uN95sCkET6HuXOfn9OqzxjTv0L57HXh6m2fx.d5iOuOpDM8UYLQI6RjAGaX8GW8
 UpPA092OBdO_ZXWdUHmuOTBfF7XE4Z_NMi0Eq4rl44t6FxEco4kIsaTw.hyonwfV2Tiqp2vOnD0O
 hunWCBSOU5E.rvapE8JxUlJUK9seDwpLljP7CQek1zj9j410Gj3gLIb8HUs8mxJ6mKVVXi07DgXO
 F5luayA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Jul 2019 15:04:14 +0000
Received: by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 81dcdb2e5981bb0556cd8fd7b14ef721;
          Mon, 29 Jul 2019 15:04:12 +0000 (UTC)
Subject: Re: [PATCH 25/27] NET: Add SO_PEERCONTEXT for multiple LSMs
To:     Simon McVittie <smcv@collabora.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, casey@schaufler-ca.com
References: <20190726233923.2570-1-casey@schaufler-ca.com>
 <20190726233923.2570-26-casey@schaufler-ca.com>
 <20190729130033.GD2383@horizon>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <53d9e69b-c0f9-aadf-43d1-72167e9876cc@schaufler-ca.com>
Date:   Mon, 29 Jul 2019 08:04:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729130033.GD2383@horizon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/29/2019 6:00 AM, Simon McVittie wrote:
> On Fri, 26 Jul 2019 at 16:39:21 -0700, Casey Schaufler wrote:
>> A new option SO_PEERCONTEXT is added to report the
>> security "context" of multiple modules using a "compound" format
>>
>> 	lsm1\0value\0lsm2\0value\0
>> +		/*
>> +		 * A compound context, in the form lsm=3D'value'[,lsm=3D'value']...=

>> +		 */
> Presumably the commit message (and the implementation) means the commen=
t
> is out of date?

Yup. The curse of incremental development.


>> +			/*
>> +			 * Don't propogate trailing nul bytes.
>> +			 */
>> +			clen =3D strnlen(cp, clen) + 1;
>> +			tlen =3D llen + clen;
> ...
>> +			memcpy(tp + finallen + llen, cp, clen);
> This assumes that cp points to a '\0'-terminated string, with the '\0'
> either inside the span of memory cp[clen]..cp[clen-1], or at cp[clen]
> (which is just outside the range that is obviously safe to access).
> Is that assumption robust?

James Morris, the security subsystem maintainer, says:

	"Security labels are strings, so this is implied."

>  If an LSM that worked with length-counted
> ("Pascal") strings internally would be allowed to fill the buffer with
> nonzero bytes and not place a '\0' immediately after it, then it would
> be necessary to insert the NUL explicitly:

True enough. I could use an embedded length format:

	[<lsmname\0><valuesize-u16><value>]...

but as James is willing to assert that security labels are strings
I don't think we need to go that far.

>
>     clen =3D strnlen(cp, clen);
>     tlen =3D llen + clen + 1;
>     ...
>     memcpy(tp + finallen + llen, cp, clen);
>     tp[finallen + llen + clen] =3D '\0';
>
> Thanks,
>     smcv

