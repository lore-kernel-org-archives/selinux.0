Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30286219A81
	for <selinux@vger.kernel.org>; Wed, 20 Aug 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704257; cv=none; b=c1hymVvWzpEvB4AAq7/GSz5+8xFon5StZH6DuexwZqL8yhb87tFg17eh2GrL2nx0dSCbHqdr/FJa5N2PchOV06i1W/xJhenhwyV+A9y7nbglEYokNNK3g5fpzYZqiqJNT0SE/1V51HII82CSvCOyCyjJ0/PQEaXQW1r1bMgZzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704257; c=relaxed/simple;
	bh=IJ+xL/v+s1AVc3/VZ82rCjey1isOhaO+xMd+86pwobw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaYOa+fkN5aBGHXtnOYy6TxLCezzG7PU4vCy3LpkHs5oKG3AGQYWRB3XzgTVV5bwXHBNTkw+DesJxe8cVHjqFMRuOBs+Jwwbmj5Edygs6MAmdrxIhxockijc1BPtNkkvOe/xzjC3PmyL4rL7dX1qsX9sya+Va6JyKoCFsjQm5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VUjgqfNE; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VUjgqfNE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755704248; bh=F+0Uhh5O34cTWtgMq2AZSTcMlSs2e16X8Npqy/HMG98=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VUjgqfNEPufayU7GyRUwG2YQYlj6rPeE3/6HDUysOGFdBi7RA70OHvZ6lC9JeIEw4PxQgpBm2UCREYOdBXX7v+Lgq2YaSFvqZkF0BXiH/rVCNwfpTN1Ci5TtgP4n8AYHRqv+Mck+vrNIH6G2cTJ2WLvQraL0+OTG/eJ/yJ8y5r7D+zVOpneI7wtmiqSmQ7cAOOVMD1dFl0NtH5sVEq43j3N14jMLzQaOqTpfY32Sb2041F/yZdTlLkxhga9CEwXjv3EonvwjdvKzLGQxFQsEXI4O2La6N5b9df3I9HYI+8BUNQI7pmJckFTavFY/LxsPsSXwNDX773zsqeRg/cO/2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755704248; bh=eUpxy13KxXfxu46yz6t54LYAHSARQbs6n0b4+OAQ62f=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CGUwqhJjydn3NumkygpjWs4zLQgEsCJZ0Z3N0MXG2zhu6HIDc99DSE8/SsSYCW7/QOMQ+Devy1TUKBTlR3ESoYd4wdLLZte+6KAJzUR4vJ3YdsSXfAEx3bjBGGr0+6wAxnZJObn3pX41xh6DV6hsFCwT2Xjgbho7kIKh/eY+5mJdnSVT9FQiFRreAbRIbHuuecI+BxB9vA1P7t5hHe8XpwMBydw1aFcc4C9Hl9pgSYR4iEKl5e3kW4H903zeGMGrYpQjV4fntV9U1Ldyx9Sb5ALbArn7jrlyH7eirJFtueCHmNAvCoPiXYcsqIK+onesZdPelihqs2o7Wn2khBFu2g==
X-YMail-OSG: d4XnbQIVM1kli6Yv3Z7K_cPdvU3BMpKMc349_JxVaUXuXWTs4wyEyLc6PZscsSO
 PZnqSvcPxHEN9fkobvWNHIJT3A_i6t2ZRzoffjqIJj5PqD5ns4g0i.f.sM42296M0RAluxYKX1PB
 YP6tynhBwb3Z10qGHaxiRsq3A6LHwdEPaGMjZA2cL0TA5g5CphDGP10S03O3EDg2H8UkjdCcD.R3
 SnXiLpIneytJy9E6YO.ICdjTmo3PriHdTLVqZwrohUSw7h3i9FSJrdES2wwd7WFLB93cYyFl6xr.
 76sRwAO7QzJIIl5pOJT4Wp9nBou79rMVJce8tLb9nWFFlLiDV1FoMjr0FWUNdsrqGCmxQLsP3.tt
 8915x1CQoA5NNyZt_pZKebXZ3dpqAPHzLz4kHR9hMxYZ8rEf9zDp__KH0CItbCPk97THCdC9lM3_
 zpT8lbyL5VC1UrHQLVFgiFWEDN6VmCmZ0acDWwTjMMUVdTG2qIpFLRfZ1RL3qR0uDCjnYJkfp32T
 dKHVcpDelQc9.0hAITwx5fXCso8HIXE6KPcvwHXo0CsyAwUo.rSfk4vUxLjImZ_L8W_KJvBZiIni
 3Btly3jOCaoAuVFoIoDfYK0PLdN5GXDFPUcuQydmLHTRYgmflZyh1DxQHgwkuFFAvxuiYMwJPpt8
 VMFXynQpBpv8lPIWj4xgVlzCxNORXM8gjZCGL2ywxTiutiDrHkop1ADINXw92HHNL0DALuN2a2nU
 c8.NMyntwhc5LSnSkAcsBMt40oyy4V58lk8G3HjqlzcVrUcMDnjvVJ7QkyTkp3LpTqL9zLep93nH
 _y5M1gUbY6HFaAiyLMc3uXmOuCaiuBD.XqrldsgBJV5hXkA2Q35OViKQzMvLEs1rjpLnaskyTuv9
 BhWtoIf2DD7eq4fU77_77GL5w8bAXoPGT7t6N9vo8_TDDHfbEwR5CBNMk52AFS7Lq4JMqATBVCFu
 kCQPX5aVK3VNhbNePNzyWy9TBQVvl9VJZIu5i0TEzWLIIiSHWEl9Y3VHztEQFOpVtMjEt.h0Jcy1
 iWIkltv5AClzLGPXiAVzU3GT66oU1mX_YKUAzz34DW8rRcmcpBtQxroEErPzFzBQX5b8uxto2uYP
 MbjLpfv0SB79usiza5xpL2d8g8qieACil99LaVnZowqZ3Snam6AMtHTRxb4imhLc8tD67cGi9PsX
 YHVnnUEFh.dTDaIYGcZ70khxEBcfm1Rq31dzB_eLSQt6KKU_45dC2f8cfN3cYO8BpgwqLu_S6kyc
 kocnEKwGpS5N4cQ6Boyueh.0fh6YHKKq3bdDK2xrcxFSI0auOf4q990qOYLGboVDKfT3X9fukFS4
 ixgdu3a2gTacdv_DsCxjGinXrpxiu5ZlDMlQs1_xs2NiJgoEIsPa4l_4ZvQEuj4JIEh88RooPsj5
 tH2oNhJnLMDPQ31fnqrxJSlrMbltQqfxaEkfrypAAToGTryufVk45SLElSop9fZBKULfe51YKmKI
 8MGtgkQTq6aYQbiLPaRGMPhD8LvpkBtWmyB11WmL_cDzv2Mpz6cMjgxF2Ft0gqenKWuEiFmw4OEM
 Y0cqrweoO37sv3f1W8fWh9LFRsZhHWUlNx7BUNs1yR4M65Rk2HsTD1OdRoaCTYijEug7uUSVJZzG
 7zrRElmVMswlllYhWaaTDUfM1FIyQ_1KzMr04Fh2SJ7wfn3Hi5la6gfDkbqgFRadxDXIYEOfuUJ2
 qAXp9sVZiQc75q22mexlQcXUghZPRc1HLDxuGo0_CmU_rvDtRYjwRjjTlpV3hdG_SHN.XK9SxYG.
 ccLhmOq5zH4BPa0ggFmjZQtvczFBBBGKaoZ.krNgSKUZvzwTYYy4_LImT6z0yfHy85gAX77XrSUK
 qtnlHTEeXwDD1_zueW_Y_EPExj8QUh022E1f_7rpPDPQerSp9LVExxI79T7W2Bgid7ZUKhQ5k7i7
 _NC9UnuAnllB6rAj8gYNhc06LyWunLK0n5PHGjUrXaNPm4WD3L8e4rqIb9n.wn_WCMPZwGDPoFpC
 yFKU0wLahiETfcX6aqitMxXfSYE5ldLbN6267AOqrj4YsnCKqlIu_wUAERcT2ikYHg.G3AlOzdzG
 kX42clwFDgWCp._jIK166u2TANI6Na82w3_IT5I4k5u3c6vp3gGMSzo5myily68KJ.U7Br3SeEBW
 tYc0pr2hZsM5bQTnytBqM9ql7M_Kpcx8lfYRCGFPNEZJ0kpHgBlOBwQZgGzWn.URfVDP_JUj5ccR
 aRTmFTZFD_6mjGlwveFBIpLcRKKtg_IvdtA7FIKJy7yaRRJAgH6iVnAbjRdrQD9FsAHbmRlwzjEs
 1RK7BV6uY4UYBPVHslS4WQFk0
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7889c320-4574-487d-9ba4-c15c02b1728b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Aug 2025 15:37:28 +0000
Received: by hermes--production-gq1-74d64bb7d7-grhph (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52bd897ed762881905182e4340aa120d;
          Wed, 20 Aug 2025 15:37:23 +0000 (UTC)
Message-ID: <46b3bada-09da-45b9-8479-feb6d94f1221@schaufler-ca.com>
Date: Wed, 20 Aug 2025 08:37:21 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 John Johansen <john.johansen@canonical.com>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <20250820.ieNg1quoRouz@digikod.net>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250820.ieNg1quoRouz@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24338 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/20/2025 7:44 AM, Mickaël Salaün wrote:
> On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
>> On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>> I think we want to be able to unshare a specific security module
>>> namespace without unsharing the others, i.e. just SELinux or just
>>> AppArmor.
>>> Not sure if your suggestion above supports that already but wanted to note it.
>> The lsm_set_self_attr(2) approach allows for LSM specific unshare
>> operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
>> two LSMs have implemented support (AppArmor and SELinux), and
>> userspace can independently set the attribute as desired for each LSM.
>>
>>> Serge pointed out that we also will need an API to attach to an
>>> existing SELinux namespace, which I captured here:
>>> https://github.com/stephensmalley/selinuxns/issues/19
>>> This is handled for other Linux namespaces by opening a pseudo file
>>> under /proc/pid/ns and invoking setns(2), so not sure how we want to
>>> do it.
>> One option would be to have a the LSM framework return a LSM namespace
>> "handle" for a given LSM using lsm_get_self_attr(2) and then do a
>> setns(2)-esque operation using lsm_set_self_attr(2) with that
>> "handle".  We would need to figure out what would constitute a
>> "handle" but let's just mark that as TBD for now with this approach (I
>> think better options are available).
>>
>> Since we have an existing LSM namespace combination, with processes
>> running inside of it, it might be sufficient to simply support moving
>> into an existing LSM namespace set with setns(2) using only a pidfd
>> and a new CLONE_LSMNS flag (or similar, upstream might want this as
>> CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> Bike shedding but, I would prefer CLONE_NEWSEC or something without LSM
> because the goal is not to add a new LSM but a new "security" namespace.
> To fit with existing capabilities that could be reused by such security
> namespace (CAP_MAC_ADMIN), CLONE_NEWMAC is another option.  I know that
> LSM may not be enforce MAC, but I think "LSM" would be confusing for
> users.

I disagree. Using MAC in the name is bad because many LSMs don't do MAC.
Using SEC is even worse, because no two "users" define "security" the
same way, and most of what implements security in Linux is outside of
LSMs. Since this feature would be limited to use by LSMs, it makes sense
that LSM be in the name.

