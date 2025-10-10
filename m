Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF572F7AD8
	for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108944; cv=none; b=cSaxYi8kiXSsq5jqmXtIyB2AuHyofKuuqppsTSVMGEU0CrDnRI5HQ/tx5tb0t6jpkpaKw+wFENyakqCx5y/daLv/fIhSW8hWFnWcNG+fVqdhAFd1dJHHrpryXOer9Vyab1dBNJxsbe/iJLoyrGlZQXMChOJFVi3Vt9XhrMhRvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108944; c=relaxed/simple;
	bh=HGsjbE6k1Cg7BWKlETqXdaWfp1ExPcd17cLqxSAQBWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1kEktqe2Qek+J/qky3951+VSwjVAjoQW4XeZw4WJQIREHbDRawcmiQdhunIUwLh7TwWGmMeGLSckyoFM8OkthJJqTYo+g9khQonOzq1IzQa1CKSWkn8F6JLMQ/zVVHSWmRQ6UmUsbYmI8aTsGGP1L2xG5/DOdUZqKh0TjboEZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NjDrQ4Oq; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NjDrQ4Oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760108941; bh=s5sHM8FWOIxntJ1+B14ZnieG9KTdiXXbLg0dtX9zCwg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NjDrQ4Oq67a7AMu/BGuI6WCi7mMFwgXhbbI1BGjYaNA7DEeebXULtQxxmQ4+7S2/wo0I6xXNsz9THdGEny/Fl2Cu4TxSA5Tjrvd54BNLutP7LdH+fcmzlXynpGAHCksHg7U/ip5rwxt7plV4CCv1ftuPBEUQOt6P6M547Sdu134MOmo5vYaddvkpOiMdTRolo9vOxeYQCLGQOnUM5dlzySHoin9bcyO6YODsqsOoTv4jzy3AVaVihGn6xQ2dIrg9tsfL6lvNT64KwlkAlNURfaceIlORDeDBLfGFluFy56BbUpYOiB5bwskeslkh8Yr0Rxq2En3/NQhI2PQVZ31ayw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1760108941; bh=USJTwe/uw7H6hWaOg/k7AgrN3VrUJGb1DO/eXMDzcoQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TjFjHGqOqu05f4pCz4WorNCoLUj5Rjv97dHdeQgC8LA/bY+vK3hR1o0h40qx/4GGI/qT5IXSzfXrXJJ9bcJA5iG6i5d8sTXzLTCHxa/UcO774vvXUZXrsx6FFFEwgvKLK3TuBcB0gmgpMKhS0ud2Hl15EgDgblLHXXO4iCioS8qSt0DoVRV4PAhwmND3HaqbKoRZ2Nlme+FlHT/IyHxdst8UJHKGvBSqfGW67EfhBvbtBsYM52BU/IIwL37vPKyQO2Zh2I1p/K3U8AUi/SU/X7k1Fxx1s0V45/QQCqiyG355ajPD0EZ/4tyxX9CvskEv2mLWIgW1qHg2CayB8e+ENQ==
X-YMail-OSG: 3ziaTvAVM1mpfcaMokhq84FKVpBZUg8u9NEtemdnSBGzpYFiOd.tjtG0.hg.U6w
 eNPgLN2q0eHNqwFImdk7pEq7HZVi4FeJ4splyxi03MrjMX9JTjVCIeHaLmpbaFRSvvEXoQxAyIZ_
 6X0BIq1CySHP1SJhdm6cst5332TkNg7YVvOHk5ewAnF4tuvt.JKZUjJQfPj32az1FC2vVONJlRse
 94KSqmog_256XcPEQT7i8TmGuCp2qrxgCfq3xxvfpwFEfWykKdRSQ5UyxuomT_rUYTweY.2Iqc9Q
 YR4HYBFVQXNOoCaoSSztrzUjZk5ad4ckMeGdP2hoiT_wtPHnumCRnOVT1rRdsokew3Rjk3hYlcm2
 vuosDBJ0Xxc2wOLlu_mKIFsxgfQZRgxxNxv9QUQvUp_9z3BGunbKZAQlF11S5wh9ii2_gesZUnAL
 IqV_fsQ0FpKNsRArv9Et7vE2k_wTY4cPYZZAUUomdbiuZjk2A_W0u3uceg.o0Qenru9eobNjhk3B
 7gWX6HIXnHItG3_XJG3cB578iHhV26jr07tZXQgaFBTMDE13YDHPJ8.1tAdr2zMRJKLFDy0FNUFv
 JsItEYzAoSxTGslR6xSTvgCK_q1mwF_CIoR3XT44pEJG1VQNvYb.sdTnOSH7ciiZx1.4tHrgqMQc
 bWPPTfHssAULCdTY9laLDU8yVVfYiQN9W17Wd65ixo.adpCSIVupWyeLdx9m0j.AEkH4H8ATCAD_
 SPAx3mP6ZHPfbJga8Xz0i_WYl7m5xr6Tn6L0vlXLe4pCPKCckvHf_raWCEvdQSKlbuOEk3Q63.3s
 S5eQQZBnVgtAFTrNjdW.Szu0W.jMK0WdnDC886b8Fbj1OGW48o6k5YZMZzF3TY.rXMd.tuzz2bGv
 0dmly.UnBnKYrqaQMdm9KTziDFR6SkJWp5EujSWVhANUokLWBJDJzTh5S7wY4nwR_mSZbYv_n48C
 jxgGFwC5i.vgUMBLwBpUHJtoQP.2B9T5NL7vpDpyTT37Qvk66HK3EFO5UhDgsCWUbD0VtYC46QZb
 SZfQNSVCCLYPAX2ZMq9ME43mvz3Q.ohaaFVM_Idw_Mut4owyF15Xf.45w7rk9WUiU54U3cib59lN
 It72KpfpfhaD_JmOPXBVQqSfp1dNFwbprheWFPDR3ryaf22wSIs7KPz4fS3rHw_yO1tdMRr01DSY
 sXBY736HEF7impyDRmbi4QgJEQ2XyyBfw6JOlLBdbJJlAYkm4QYzZROoSn2hyzamuF5yDxEX8iBs
 2t2NXIl5UIHwQFhig_P0SuAmpJZ9yroHhYPMSD8eIwfdd9CxMsdAWvDIlV8CSbGFR.hkRPyQuaT0
 M1ok0vwWV3hFIyRkKd10.sZrybZ3sTh8KXJgpXuA5aMJ4azDrjxYAEEcgjzSVlb4FTwVngO87OQQ
 LjMZIZxRdar4SLG2pinyB1Oc5Hofq.a29zHg0A5KC3lQtRqor6kcLVPXTwaynMBFM2BawZCpuiVG
 9KE1WEc2KLjaKcVw4EgxvQSALfslDStbvEWn_ODjw.nOnJeaOq2QOWqzGYJpYhYfsPHcvOebi7As
 N4drSq0RuicmeN4j7Wm9qqIL8PwVuvkBwoR7ZOWhzlcHEFlvMW77BH64HG22Z7ePYVm.Y_8pTzZG
 kTp5ae.QvLM8zue3qB0kHfORqwgSjh6Y_RroPWzWKPEYbXBNRHJBAwj3_qwYvShuEZmH1W3BHC3e
 o7ku3mMpr526UqtFZrCagmTUSCqrZ5coUgEFeBJwKpvD1r_2XA_sPInvslD2.AxddiZ5fnl95RXa
 6zVqaEoMUEYfuiOrzNwIr.IZta_zSpRdjFYmFP9mMszcJa4PRXkL3IwQIJ2kEjQNiVc2eqeSn9Hm
 zofsWHr1t0zlqUieoxrK1OBBqf.LWmrDes2nAQHTHqC0.LYcMSGyI7dK3R2gQ7ASpyK7C_Qk11Xo
 mcY5QSa0YIt7PFZet1dYddFZW_dm732.J1hhMvX7E4ZT1eqgpysBWwEMa69xKHG_gz0z2NLz4zO8
 LTxdvl4qBKM4X5qhgygjJROYKs2SC4jQLMEyhBLrXNsSUckqdJS_Dr45hVaaQa.8ODciUjRbOvwj
 C9eo3Y3TALiiRlKBRNckRYt7tO55M0aF.wRPPMhek__VmoQMUr2N5smQfxhJZHNGrnDUAMk4U4W2
 RbtcnJBGP4i_E7Aah7DdYAks0jlBH._b0zxdO.d3Yv.Qb7Z9TiqmMeyN16tlj1yQT.Q_GPqEp_iP
 3IGBeuQzHi4V6Q9B9jvpB2WPJkpwMZ2ec5LQ990kv.psKlnB4BlfB.SaE5rYbzblnbHanGIBcyxu
 w2y_JnXGf4SNCzSFF
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 468ca47d-6dfd-4e15-b4d1-43d336e800bd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Oct 2025 15:09:01 +0000
Received: by hermes--production-gq1-66b66ffd5-cl26f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8888783bd8bb8c322748e1ff4bf26922;
          Fri, 10 Oct 2025 15:08:56 +0000 (UTC)
Message-ID: <ec89959d-c3a0-403d-bfb0-7405639eb0cf@schaufler-ca.com>
Date: Fri, 10 Oct 2025 08:08:54 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-3-casey@schaufler-ca.com>
 <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24562 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/9/2025 11:53 AM, Stephen Smalley wrote:
> On Wed, Oct 1, 2025 at 5:56 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Allow LSMs to request exclusive access to the netlabel facility.
>> Provide mechanism for LSMs to determine if they have access to
>> netlabel. Update the current users of netlabel, SELinux and Smack,
>> to use and respect the exclusive use of netlabel.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>> diff --git a/security/security.c b/security/security.c
>> index e59e3d403de6..9eca10844b56 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -289,6 +289,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>                 else
>>                         blob_sizes.lbs_secmark = true;
>>         }
>> +       if (needed->lbs_netlabel) {
>> +               if (blob_sizes.lbs_netlabel)
>> +                       needed->lbs_netlabel = false;
>> +               else
>> +                       blob_sizes.lbs_netlabel = true;
>> +
> Same principle here - if a LSM wants to use netlabel, it may want to
> guarantee that it truly has exclusive access to it no matter what the
> LSM order is.

And if SELinux and Smack both shout "I gotta have it!" who wins?
Does the system fail to boot? Do you assign it to the first requestor,
as this patch does explicitly?

If LSMs can't be equal in the eyes of the infrastructure, If one (e.g. SELinux)
always gets its way regardless of the end user intent, I have a problem with
the whole thing.

