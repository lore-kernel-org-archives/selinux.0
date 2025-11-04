Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8317333427
	for <selinux@vger.kernel.org>; Tue,  4 Nov 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278981; cv=none; b=AHsitoW4r0rcLalxBcYhfQOSEN0bxyc0jHyCXl6vovuxMFJ6nFV34GGZ1rCNv5rsndEyh5qrcBVaIE8EeNo5Ss7DeUmPXlwf6DspKkOXx9u0Kaue1XJ1St270z6meE2azWuGQy3LAD8ZDRDpf5Avzx4sbT5ZsMzA0+l1DEOevuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278981; c=relaxed/simple;
	bh=+vRx3ABJ4EajGVIFFGaixi+4TZ+VcU6yxjdyq28GRUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bA2CUbjCWN7dRsR6AHQ51B2HXB74R0q3BQdDd/gdtlUhG9pkzufsTX8r4fAwk0BpSMcwSiC0e/KYTUYIB4eFCrsF/FxGFWhgoVahlUT8O2Pnltg/HdHBrHqrN64ZYijylO8IZ5X6BvpQBrdcyTdu6dE5M+SppRFqXhysN1OxjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lKIwzYU0; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lKIwzYU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762278978; bh=th6F6yZ9ktqthCQv2MGa7/ckJ5CDORFCRwj664QG8rk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lKIwzYU0ZkpnICuSm/2BUZ2F5W47SIRk1pkyPmakyFLlnn5IS7Bzv+kwRLGpBJdoG1SdyLa9AtP0sD6TejmTziE1lZVwg6ans5lYgmbqCZldOnYiExzOlI8MVgMIcwBLoqcYr19kTA5+CVGBFTFrj/mHKqfI8RQu8K3e7mO4Zk2n3EegAqsvkNYMYWwFK60C93dfIhosYYobiaZRdARKyoA+DgOqyQ3M3we4b9tLJy46oatcpDI15eo5wjvipmsx6PXJCs/5jHGBB1Yw0D1wkyjGoqD7jjXAahLV0yTUE0hArGmsSoDMRDr/Ietw1+QUUqxtUoc5hYY2OlFSvvUZTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762278978; bh=l6HkUlc8oyx++Zw9RVj421kmwzleq7Ab+gA83ECcQ3H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IaUj4vZ7SCmPJwEHCbnEkEFugWSjciuRkX3I5JN+vnXrxQrpVPT8jJqxNynQvQRfZyDNIeXwiCF3nMVyXlzj3e/yz3MiuOYRFPymoLvXgmBihsc17cPTDolxpgCacsXxcudJAbT7vR1/m5jy8f6bAG6xah18ltOkQ+6F9uJ8Y837zawFasdxoiX6oo4vfLL0VlqLccP9YNpwROIEOjJBP1I+/VF1ukFYVLTevoMmkUurxa88JzGJlkloecStDrr3D2RjHjKsnLTZSwP0cxXQrSc3Sch78+AKfIn/2rXEr15MzUTsJy+Jg6ebbnc48kHcAhqX40aMfiUI5WW8qs045w==
X-YMail-OSG: ah3BC7EVM1lTrsL2uHHnvdF.OIDsV6XmfES7VvXvrSObFz3Cq5AcwNaCvp_q2hf
 B5wCD2sn8r5BOLe_5_aGMrXpdqRs8xCKX3bssNJofRis_GWZTiF11jqJypf2Hn9KhHrBSqjiJPE9
 bVYu93wqdPoA9vEeZOO1O1zZY6KVuFbcIPsc4JeSCTFK8nKRz8Om..yvKjEiG94_ylajD5j1YtRu
 qh_ypoRgOH8jj_BXutAbFiat1X_RzK3UPS6hH7DBoBKwgb.0KOJwRl4u6Zd3uWChhE6Gc.q6tHGO
 jLp.88SQ5wwK.lHeA.nFc8vJwVU7m3A9OLdI.2LxxBlewof6iOgOogE.3L3pxeP4VL87noV1ZQkR
 VPhkqxnrC7ki5WUNMU11doX95W7oy.UehCldtyAeF1UYoDq.BIfVA80KwKLxpVz1YEjtMFcS_UtQ
 1mKXOZkdo9V_BwqV6xMwXlrHS3EMh66KIs12sgdRv5Of8UTXSCgcsTt907Vr0UbWFNauQItD2wV5
 ecSKIfAwjc9KUAARezFjkWxgBCYcz7hDWYu_vo6FkWNtmXogMlb8_vlLgkLBVyXwTxEobOX3ZqSD
 HaS6Enwi2GfWclriaai_PL1A5gmf8d0HMgalSXeLdJIlOKQaWancihntiE5T3HOiej9gRY1f5Vza
 4S2z8cDHTcoxfJUA9paajs5_Pc1EefoP_iwhEITp3O298ytXG22lxFyj9XcI085rQyMLPglVjKqg
 rka6c.oiV5YK5eeJdoMYYqyR99xN.DEYkcFVMPAzXNJd6VyBrS7k46mh51xABdJsqEaV3qPWh2gP
 aNcBNWmTXjunFZrnRemAea6t4udC7DeHPTXDFGoMtMKfcsygb5lA4vXPsCX2nEMbQxlCAa1WcZab
 uCyJsgCUEY6_HEwPHhEGpSB6Mp8yUaOycwaAZuHWk9Iw3ATjPbdZcJVuLAbJKsVpMKoqQljFLcq0
 xHRotadGPmTFgdSh_HHd5yY072UVmPNpcmoDoCQPdbZCD8HWvEsMi.fpeDYrBbtCYyBWnSyBVYMG
 6C7R.rxokxKmheSrpjZXuacsU_rk1oFe7km4mAyBp1ZQjsctuB4iNb8yET847z7pQYRMzHd3C6Dz
 G55k1kHKKDnnTaP59TPhjKb2N3qbsQxj.udBGtRr.U8X.pvVSDjE7XPle1W3hMTfU4zGumGvEgdY
 F90mpVSwgcfQqm.fpTo55ddtIGdGaiNgZ0qczaBnmnsSvDtaerDeNrdr2wY5b173Z16BuDzF1gdy
 RZUPzSGaElDpmMPaX9Eheqk.K0Jx3h9sMx7zc.UhwI.PDgJm0pyIV3BNeRluyQFhQ0AOuxS54QTJ
 ghl2IkHAZTT5L_hBolpCPhLsD_7AjGFJwOqc4uEfhKJflolGT1.0gQ7JneOxyAycWZoqHqMgXc_3
 F39hxJKOCsUQ8s9VHJyvTTpW8fpFl41SfRMQPqQJw3NrRYLD_SgotBo6B8NEB50QjE9qZZYRtGQT
 qslm9NWrEAP.SI5DQlN7KvmL6ZirwyNMhXDPelJH5gV8OSJvztDEEBXnCrunLsYLDyfOpgLRbgZw
 IHkF8RLIwtxxfBqu2MO2ekePJqv02LSYLSqgCbJOAaOrh7jkKPgIPRbUEl71aWIJwHDBUPge_tHy
 gzUPLzYIm2WBGM91BFIHA7Nunn8cq6FttQ_7uoCDp8_tzJFcefW1HaTkM0J_zJ4S6G3FTwiIgORi
 0_W01DD3bZ9Gq_KJPuTChj1nZEAowi9P9m8tp7xKZYs_WyPBlCbq3vcaKOARyZyubiHWbUSMdP6F
 1jtJVx380WM9Dk.RlTwf0oTrK271_X01u3YoFtBy_st_PFvWD76fkbxV3itXU4zHlTV9hE9vy5T7
 _LZ9SmDjUIxaQP2nNFc9dsZa9CkJdpIP.Quks9BfvPBsXGzKrtogbi16NxmNKzaB5llQA6ZAqhBj
 utUE0BmqqmB0lvXB5P0qJRFMgXwhCV_IvO8GKu3QcN3Ib5V6bY05xyg_hRuk_7PSvP144JWVaF80
 ONwIaoqRiUW8QBnDfbUko9RGlUxtnAW4d0aAleF8N05RcccXnoAvDD5JYh5ukl9YAN9xVuIIA5jP
 kQklhKCDgZwjc4ZOM8utm3i1h1wIoTtTsbGgStUJrRSZeTyBE58zqCXPtFcWrvyMU5sCUsTZtHMG
 yvvs6NdUBZGVR_n4fxOA3EtcC.ZFgA4CWbByFyAaxxmDBXunPNDSQGtN2K1o6czY5lNDGJKiOAmN
 7tb2Wg.9buzL6bK054eeBScqj.L_E3cF9T9CiyCGODbIu5PRRB06eq2il3XtTYKvwmV3CMiPDKx5
 DS8bKL_g5R0Zx5FxgdMVClB5je6z0ZXY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 0fbb50a8-a99f-4367-bc8d-f2eeae093282
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Nov 2025 17:56:18 +0000
Received: by hermes--production-gq1-86c5846576-72cgw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 09ccb174d06ff61091f56c6092cd5092;
          Tue, 04 Nov 2025 17:46:10 +0000 (UTC)
Message-ID: <200ce2d0-6243-415b-954c-3078779dff2c@schaufler-ca.com>
Date: Tue, 4 Nov 2025 09:46:07 -0800
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] LSM: Infrastructure management of the mnt_opts
 security blob
To: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250925171208.5997-1-casey@schaufler-ca.com>
 <20250925171208.5997-3-casey@schaufler-ca.com>
 <CAEjxPJ4D7A4KDF9BfmRa9VvzcAHBkkrdKCvmGazuZUto5=qDuw@mail.gmail.com>
 <CAHC9VhSRGyMuTYxP0nDpXv_MwvNqVsrBXcak84AGHj7ycDtu3A@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSRGyMuTYxP0nDpXv_MwvNqVsrBXcak84AGHj7ycDtu3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/13/2025 1:55 PM, Paul Moore wrote:
> On Thu, Oct 9, 2025 at 2:38 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>> On Thu, Sep 25, 2025 at 1:12 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Move management of the mnt_opts->security blob out of the individual
>>> security modules and into the security infrastructure.  The modules
>>> tell the infrastructure how much space is required, and the space is
>>> allocated as required in the interfaces that use the blob.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 4bba9d119713..1ccf880e4894 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -656,19 +651,13 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>>         mutex_lock(&sbsec->lock);
>>>
>>>         if (!selinux_initialized()) {
>>> -               if (!opts) {
>>> -                       /* Defer initialization until selinux_complete_init,
>>> -                          after the initial policy is loaded and the security
>>> -                          server is ready to handle calls. */
>>> -                       if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
>>> -                               sbsec->flags |= SE_SBNATIVE;
>>> -                               *set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
>>> -                       }
>>> -                       goto out;
>>> +               /* Defer initialization until selinux_complete_init,
>>> +                  after the initial policy is loaded and the security
>>> +                  server is ready to handle calls. */
>>> +               if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
>>> +                       sbsec->flags |= SE_SBNATIVE;
>>> +                       *set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
>> This seemingly would produce a change in behavior for SELinux.

Except that it doesn't, at least from the tests I've been able to find.
If multiple LSMs use mount options you can't use the !opts test, because
there may be options for another LSM. Deferring initialization is harmless
when there are options, as it's all checked again later.

>> Previously we would only do this if there were no SELinux mount
>> options specified.
> What Stephen said.  I think this is good work that needs to be done
> (thank you for doing it!), but we have to preserve existing behaviors.
>
