Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA51B043C
	for <selinux@vger.kernel.org>; Thu, 27 Mar 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093693; cv=none; b=em+2EkPN1qCAtJxvquoA0u8VP5bFTQlkcWQUNjjc3L+cav1/Fde5HshIuzzRrklmteIP6t1oWmk70+zIKbiGsoeSxh/wY+iDM0PrA4EaezL6ufAMGYLqwuWVaqTlHkv+HcWStgzR/u7oBKlOv39eUztPrADXoXLv781018wS39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093693; c=relaxed/simple;
	bh=ERe0YYQQppbhCRnZs4v51rqVSyPLNE3D2fW1lrVn1Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOu4lKMCQwCzdPDomTU7Dn7c0CKYfsdPiMvw8B0ZKb+FmJY+5q9/AZZukBCde843VSjvxKaAKKEgJ5lQXvbOcMFl1mFIKQdVWHX3d5myQ6tGOoJcmTyy6B+xkww3bbDlG1zeV+VsjCZpcJyymByvAS42RjNv6GgUQ/ubq6rBasw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HSEJln9l; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HSEJln9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743093685; bh=ERe0YYQQppbhCRnZs4v51rqVSyPLNE3D2fW1lrVn1Uo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HSEJln9llrJi2viwDhjhtqGgabGFgDMkvZqH6UFUVPHqV6AEzLZnvGaykPDvYMTf4z68og77Te1sQ8ZMknCQCsQ9oj07JAOFedEw7BkszpxPvEHXxBKHg0fjyDbNz2ELJssNCmg8DrmCyrMmHOr5Bdu7cMT5Fm/yY/7amSTks+3xcshYKABB5pN+KPNrvfLB8kUodmUFIhYJBNCmioI8u6ckTcVTCxw1Etn19Da37xUUoKmx9UaMV+6J89BbkqM60ukS5/96C+UR5RTEgUIC25Ie8nqKSUPkjPr8Wv6FHy54OpK5lvJfE/YMSZaRrsR0qyawZDfBpV6z2WWDF4PuzQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1743093685; bh=/ks5cXxo1HWmhjKyu5wVa/iIPNyqYhrcNYj8pb85pgZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=e7VWfH4L29IRrQ+i3r8Hejrz1oN2IME420D2X3XOEICyDTIryC+P5LV3l0wKKnu5vu363OiBT7bCWjq0B9BYx8Us1SDjq3PUrbmYd/vdlPLi7T32d0yP+F+7Nz4gMa0HYBbaGk5Z/wWoYl4n9a5HS0WBuLVLdWh4qLmOfQwjr/Cz+XawTHN5xoZSum5wcfZh1kO+/gxvTDTStabmQXFij9ImROuTm44wTRbdQ+dyaEEF2vOXluwhf7/mI5Ota2pubT6xXzFneaaTxVUUvyCr/7dEmjnjpMiy9PmLOueQJ0hMOuItXDqOe3vBS1DAYclnjztr2WLzUGJ+yK8LR4/qyw==
X-YMail-OSG: 55S29aYVM1mFzO6bwYKyspS3pl70O7aif7Og4n.Bb9Hjij_C44am73pMPqb.1yJ
 uT5vD34NAR7OiPJu.bubSBIA6YhZvUW_dnzdMW_yn2CNKOcopp0n_j_ahhek4XG48MsvIKWVcahO
 t2NAE2ONaQYpefCo7zVg_X9JJJTL6Z8UcVzpFlP8plG7DhQspaFgKxLkaf.NbbPgGaaKuUyeFA1e
 QLRABI_h0F_kcEhsU4oscrW9lI7RKEw_qttHtHugPXTuNugdwiGJPl8SCY.ma_aq_ERUcujm6qJN
 elem3HD14t7Q26N4jlZ0jD.AzZylIcBr.P9LfDXEXhanAD4sIaNVqaxU1sfeXujb5m61fLGtJFNU
 C0tmx78YSON.iDCpGu6QwhVKnq9bBaObbWSHNbOIDA.HA_s8eW29hwjqfqSiNtcPWQoy8Uljuu9k
 mvjukC7pXTSSIc118K8piJF57gnDMstIwhZFrn5wmfu0ceVbXS4vHHHgQRiygAq0qgdcBcljY6Gw
 sIiM.WKtUOGSfDmeQdlemyUKtPU5a7CUAaSUtG.Wq3jk7A5XtW3pWfEpwMtDU2Tw0ei8wn5c0H2i
 4Rbjo8.4wsxkzeh2bEsL_VttutIC1KxafwbxrSc1At0ZxAl0mhPHddhkobvRJMP4.0U21yQ3KImX
 OKK0QfbSa1BNsSYivWDyWCf3pXfckkyohCRX.DHnWBdA2tpk1aE7mjTEPBuCjGJWaNn176R.p1QJ
 hmriwy103GwMC3FuMbxlo1SREWMkw8QWUuY1uCXua_h5.SZu4rbsDSqTepnXI1YDSrBhGolqzo2K
 gl60rOzpa1THqSc4bDcua_6QrGC8kFwVmTikr80PvgwrZks5G0R2P_WhlffRgv.M7WsJB4hlnnvn
 K_bgh8EeRrreZmraGaynAz02MqMGNsUUqipjkIBCVLZw20H07Jzw7Lzt3j8Zd6sp1z.dH8T9qStY
 E7Pvy1ltc.uKjJTisUoGICqosMnzoB5MXYOEAOkmPFj_yoi2nuh00vUm_j0eVYjRn40mY101AMMp
 A94jDSGKgqW.dvL3ddX1ms490764ANugsrikT4TAFpRMAKMQNxhuCcPehFZ_jneZpdpHpMO.heTe
 XNmn5UMMWGN8ewJnplU6gx2_pmyv2eehEOppoj7A1OEfAQfwizo8C3pAv0_vGV8OVrE5dJC5PHXc
 L8navpn93LmYRVGoFyGVUtiCN_kDNBzA6K2W.P1_0XJff5DVKn9MnjJ29v1Wp3fUG8OWwc3iTggg
 1uqz8cm92mXNb_4Bh2ec996Gm8n46Fdtiiw3tkpfgYQNuEx9EUECISiDV5QDkAk29WbQTmA8nsv5
 JQiosfWiUHi7tbdLCHoeGnubpybCtZxfn8GZyeD4L5_CozQpCGJXlfTeypbS3CnewkKmydgyCN6C
 bYTaHUHz8VmbR9KerbX7sz70hg9yWlwbhZfTLinnJjw5TXLez4gS2mV8SOhNNtZengnZwoeClZZi
 lyQdjqDRm.zbuNQyC__PQ4xq_LZE_CEaR67qrZu50a4pMg9HkRhCHbkznGqU7gK43YsDwWwNX9my
 3_hprhweBqqQDvzgNkc2HhIQKU3_ysHh9Uz3NGBisyV_6sY1o3aM3855EIvIMx8.YeEPDk4Mmyv7
 7Kba49c88eOfhxo7lJV.NzA4YXONyH9svwl7o2rj59Q5aIloMmGQTrTE8j.ylVSAqONji0GV.v2O
 Se9s9WKVEGRxUtJD1Gjw5gwJVgEwBIw73cEUhsqFwwT4.5SDw.ouRgFyjm1tpeQfi2qZnfhN_ef.
 koakCum34NqEfl77nuy_9vYfq2CXkBMvsU.qljr7GGQyIrdg6GZAKwjCSzvvW3fDBD98OgN8jIyW
 3Vp9ZOrCHel1WS8nem88N2mbzZzIoUDBhdPS4w7BEHHR7RCcDde2JeV35_YEGnMbCRYUTaF18I_y
 uiAbubgOCbzOLvlFfoKtQu88M6aXiw6ukJcW.GNy.ID3nGFdJEwkSCe7sg1KIQOwx3.a.r7JJ34R
 HayBWml_krPaSCsTBPrACxuV1UyyK2_arykStHbTV8zEY39X59ExOBzMCHwCOsKsmFoJU4Mk7cle
 6DPsIyZbko5IjMIcwu0QS50uYu1VQ4VH7lhzZOK3jfpNV1QTrwlpSw0TTVr3rBZIfugl0uy45mSl
 JZF31BKzEeThSdSRsozS3OemqToW5Ybpwi.UKez.jFSfUmBB5AtxR.4O2P1fk__2r62yfZTVeqwo
 X4gOfKrZTCO6MlLnUbyyoyuTNzW9fX4rmjTcJnweFIhas3Z2lAUU727SdWTRiT8uGal9alkMdrSK
 jylv3EHIpcigwOkGUYbfye8OGvA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 48194f79-7568-4829-816f-26b8d6c6d76d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Mar 2025 16:41:25 +0000
Received: by hermes--production-gq1-5c477bf655-5s42x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f11c2ac843a44436a94966781ae7c982;
          Thu, 27 Mar 2025 16:41:21 +0000 (UTC)
Message-ID: <cfece0a5-fd0a-41d7-939d-5a2f524c9ced@schaufler-ca.com>
Date: Thu, 27 Mar 2025 09:41:19 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Jeffrey Vander Stoep <jeffv@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Paul Moore <paul@paul-moore.com>,
 "Cameron K. Williams" <ckwilliams.work@gmail.com>,
 "Kipp N. Davis" <kippndavis.work@gmx.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nick Kralevich <nnk@google.com>, Casey Schaufler <casey@schaufler-ca.com>
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com>
 <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23533 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/27/2025 1:59 AM, Jeffrey Vander Stoep wrote:
> On Thu, Mar 27, 2025 at 5:10 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, 26 Mar 2025 at 20:28, Thiébaud Weksteen <tweek@google.com> wrote:
>>> That is not quite right. If you look at commit 581dd6983034 [1], when
>>> a firmware is about to be loaded, the kernel credentials are used.
>> Ahh, that's good, at least there's no "random state" to check.
>>
>> But it does still mean that the security check is pointless - there
>> aren't any other credentials that would validly be used for firmware
>> loading, so what was the point of checking them again?
> The value here isn't so much about checking the source context
> "kernel", but rather about checking the target context and enforcing
> that firmware can only come from trusted filesystems. So even a
> compromised privileged process that sets firmware_class.path cannot
> cause the kernel to load firmware from an arbitrary source.
>
> These restrictions reduce our reliance on (1) individual component
> manufacturers (e.g. NFC chips) implementing signature verification
> correctly in their firmware loading procedure, or (2) the fallout for
> the Android ecosystem if a component manufacturer's private key leaks
> because even firmware signed with the leaked key will not be trusted
> if it doesn't come from the trusted filesystem signed by the Android
> device manufacturer. Leaked keys is a very real problem. Restrictions
> like those added here can significantly reduce the severity of such
> incidences.
>
> With this, we can write policies for Android devices that enforce that
> firmware only comes from trusted filesystems. For example:
>
> allow kernel vendor_file:system firmware_load;

Am I missing something, or isn't that what loadpin is for?

