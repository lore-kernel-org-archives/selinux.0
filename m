Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022826A8D1
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958100; cv=none; b=J7jrDzrpiGuyxvinV4PMu53Gvk9h+7EgN3pXPM7iq7RalU6V8xL+z6tNUhY5bpw0Q5xaLQELhMcKDeV0YFqJtgbnxaT/P5G1IWuZ/AW2z3kFbb6C9LEJXvGk4CE9cgR3G5n8l85O90r/niqy5Bo28IEFb+otCJmPJYq6aS6dd6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958100; c=relaxed/simple;
	bh=R+1ljclZqVUA+yfTMgNFSH8zOCue5ezEwW3z7O8eMH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z71PX5CpBFR5oMgSJ7hk0c10B9T0IqiGKnKWaC+QHSNd3DcP9i1jz7Qx7Lt3aULEeXbRUBvYgiMf7r3SLnMh2mjGw/JQe3DTwICU4MZ8LYvIe6AiRJJRC90PlHOX5ni4v6YYShj4RY3gxL/zISw3PZs2W+B0JIW0zn4wDxTpUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jh/LJ+lO; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jh/LJ+lO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710958090; bh=R+1ljclZqVUA+yfTMgNFSH8zOCue5ezEwW3z7O8eMH4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jh/LJ+lO7EKeQfBrP8bo53soD1+KQW57FD7kj3zVRWKWnW9EOMFuAIgiqPAJI0egZkTvkLOSXP9I+IeTvhbP7VfzvGiwmspwd39XUO6kFP5KUrNo4MC1CcaEXVK1jmw244/JeT77aCztayesjJiqMLlvCvUhmrBImnu2Ot+kAzMe/o15wSkJhyfbh21UOXu/fybbdLoQEqQ5M8tfEmKjX01/m4iewPO92YdT4UysMz6Owb5T0IdN9RTW/EvHAK6Xf0kp5S8G+/lvA2ew/89z6/FLHJPlI1O0FukymjGWgBIuDE5MJOvvmmnOJC85ln1ZUnc3cGiWHl9NahOGGboX4w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710958090; bh=92W1s3Bzc35mbmSBreeT3P0ILEaGruhGL7og73cANkZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=htmkDagG+tnRjQ+xv3vyENHqexzu17OgaT3AFdp41avtXkClaYWbJx5RcPlLBFfy+VFTyqKi5BhKOazaxVFrTTioebhjsoVmtwwLw4T75aPceJRu4Z6EOpDXvcL9TOt4+b0Ivtw324Y365AGs2JV0ZhlqgM/aVrLtEzU5FPLByZW7Mv9oRzoGWrnNhwgor9CVqBiQdT5am4WXKhaJH/k0qvl3k26uqSKAsychH5SCZrJfREyQtYrbsmwzbR8UnIwFAxPksPixgDtngjA+WH/0dOU6IlkMupcO8TcIv/mqMycHa4PamYGv0p4bk8mNZJGysEo8VRMxddPCr2t1i71nA==
X-YMail-OSG: 3tpNQf8VM1lkz96wSSolvW3tU5Y4lnbbQ7ZnD0Yj4gmzWxdmLkK6pCCNXGfwBxu
 mI32sG4pPtBtGAqfUJ755iGq23KGqaR7mTg_hdh_TLDCdvb3sCUxxT5a4OzSE0lPeORn9.pZPNHG
 Z5dzBN9_tkZJSX4AX12P0gOC06lhmCO8wtkoLwMma8q070GMgNmbcDtUaqF4ZaTNHLn6zDlbnGue
 6.vNM7Rp1ut7sxZTbeqcJdLt4yRCxzXyeKZh2trev6J.xchIkRbGltUyxP25fzvu8MGpBfUF8NSI
 m28e9vyo2IpoO5304IeJyoHFnakx7sHRQrOlgPpMWg1gBsj1aVtpUwNVALXcgUvKsJD5hn9a8jZU
 KFpa5VKrvRDVFri4SqCCTKKqMO7SdCovwfkj7UwwXnZgD3wfw5b95KViqO1ppC6SUor23QnWI.eA
 WLKu5KAWeo3kX6LHI3aWVToPLHMFuP9fULHSQ6ywZoFH1UbUCyw6PbXFDfAmXqf0Ut9Y6oQZCiQx
 3oqSh_rYQ5dKXq1NQsETYbvzVzDS.veKe.N9.Z0ma4CYwrNblSaIx2Qhba0OH4hcxpQGSCdJ8DQj
 hTOgA2jSjiQekYiNNVa.VnzNyy8nvEqx1FbHncTCWKHZoUH_urcbtR3a3I9U4R7XgcumlujdYosF
 Go2C8LfRIBecnpMxzEIU4fVF_dKR1cgoqqAaxjrQnG_4uDXgqq3CnNR7mr2exEUBSM98oKqUyEv8
 pmot2S6xAkZ8aVUgRpKkpxAo6j7SJLR0w7kXhB_t9TiFttgc1llcdITFLoy_3j.bPgC9BOrZLn9U
 pTJtweGEvg6FDh56SZLtVEZrk9054peGsyxAQarGBGMzVpRYn5N6z0SM7TmRgWR8bOr2ME18vWoo
 09Rp_lhd7DYumOi5nvz.gZeA7fkk.YJrVoywF5UbMenKghZOlXhjo5TZ8.6atGzHg2zW_zfvRNd0
 7ue4l.1kfjckMpxzowluvy39muWPNKXJM83GNE9N1X9N2BevsyhG4SZO7YKQAYrz8ekYZXucxr4r
 RrfARrvATG9UvpwV.1t_vs6EtrLso7rrAorIZQ6vALtc.8K4xbb22GbtO2NJ.Pp0afTTtrSRZCkW
 iHQJI1UO7IkEeTZtPfhAv5Un9rQs5b_EJCuo2akD.PA5t_38U3RWujHvkdBwOywRf7aB8anE5ZRI
 Q6RXuj51YcDiohU1NpJPGAeLMVPOFETJ7TIa8qhNAKJSXHGhNiGJEwql1qdXr8YEQ4wz3aAGK7YU
 lANMfTBmU_DLEjnBkgWhSt.uXi_TwGFz6R7Q4ePc2LekgxXqR0dOPpG95MnDDHo5SjQJBh98UsvD
 lULuXdNy7Bo59uxaMfDPO26K2RZtvY5pdDSqSi3Ehumn53sFKz4dcB3GkfqEJfODDfvoy6ryF4tf
 4sggMEJIhUelR6Bp.jH03WR494l935fEIpw0ogvUPleYR0_Cq01o0qbP4OScv_xpAkYsoMelRCLA
 JZeRkbydYp.To6tqnp5EIuerPStPCNLUdkcLutuJlet7W5ppNpFp_T_xpRXOZRFaau5znFgUcCoo
 uE7uG_sl0Jvl25qQ9N2Ul1.v9X_c2rcP6OZcn8.SaabVllx50iQca0RZwLsB19bghepk0cW6WkkS
 RFDIHMm9EoNrC4H4YlxRwVusFVhuN4CUkpEQaYvw9QyUtW6jyu1gWQNb8f3nZ7nho8edgjsY.JY0
 fmHJfNUQYPCBVXH0x6f7QIemFPxk.ZlbyMun4uzDSRRhU1nHxizn9LdgPEK7NKjNlTGqvmJ2sodI
 iRfSvTRjSMf0UqOBogVbamLcTWRsr6a3t3m0Qls.six7ERW2MV3fkCHnjp2ENQT4OjskJYVp30h1
 6s5Ch5xRF3KYRG8Ty1jQIfDHBSd_Y35nC.3Sex26ayjwmMegq7op2zauHkWd0fLQ2obhe0QkQed2
 jq7VyUHNaC38povlXXBgC7fthdHqxoOkFIXVCf.u.GmQt2IVLw2tHMoDecB2u.P0L0bx4v4n5FLR
 NoNZTdTBgiXqTcNQRbf0g1AnI6MBSagxODGDMcdoBLyDdeWXLPP7HNAwvXwikJBHo7RVFVe9..z3
 Y_VWXPtAdngzfGzC26yVynIW0OYA814UDdkVLz.i_.yFTd8qDetPWW8TlD5rsGNpvHBycMiMKetK
 qnqK7KlWyd41cnnD22JHRXNoxgvYKvOeRfYWGjpWhynejnpdTqFPUeo2uayhBXwctJCJavUJRn0M
 FxpKDFqlgCHYJkhxxCRLxMMH4RgOrZ9UZ3cizO9FxiOVfnI42XAQ7AENu97jwdxqzaNIxhX0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8ac78891-9f5d-45a6-bf11-d35669833f67
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Mar 2024 18:08:10 +0000
Received: by hermes--production-gq1-5c57879fdf-27p5r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 27ff484b89392ef389f10179e7880f73;
          Wed, 20 Mar 2024 18:08:08 +0000 (UTC)
Message-ID: <29fcb989-bfc8-4afb-a6b0-4474f32ae996@schaufler-ca.com>
Date: Wed, 20 Mar 2024 11:08:06 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Where to look for system services modified for SELinux
Content-Language: en-US
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
References: <41f73ba5-7d43-4a19-a373-84f05c03d95b.ref@schaufler-ca.com>
 <41f73ba5-7d43-4a19-a373-84f05c03d95b@schaufler-ca.com>
 <CAEjxPJ7nCf1SYRb5cAg=wFOM5r8C-y9XNJAijfU3dVxyYuYQ+g@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ7nCf1SYRb5cAg=wFOM5r8C-y9XNJAijfU3dVxyYuYQ+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/20/2024 8:50 AM, Stephen Smalley wrote:
> On Tue, Mar 19, 2024 at 7:03 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> It would be very helpful if I could find documentation about, or even a
>> list of, system services that have been enhanced in support of SELinux.
>> I'm doing this as part of the LSM stacking effort, looking for things that
>> may require additional work for the multiple LSM environment. I already
>> know about systemd, dbus and the pam module.
> (re-send in plaintext mode, with some additional info appended at the end)
>
> There is an old list at
> https://github.com/SELinuxProject/selinux/wiki/Userspace-Packages
>
> But the only way to get an accurate up-to-date list is to use your
> favorite package manager and ask it for the list of all packages that
> depend on libselinux. That will be more than just services of course.
> Technically that might not get all of them since some could just be
> directly using the xattr system calls, the /proc/pid/attr interface,
> and/or the /sys/fs/selinux interface without using the libselinux
> wrappers.
>
> Some SELinux-aware services besides the ones you listed above and not
> in the original list on GitHub include nscd (part of glibc), sssd,
> Xorg, PostgreSQL, libvirtd, all the modern cron variants, and various
> container runtimes/daemons. The extent to which they use SELinux APIs
> varies though, from those that are merely getting/setting SELinux
> process or file contexts to full-fledged userspace object managers /
> policy enforcers.
>
> Then there is a completely different list for Android, but not sure
> you care about it.

Thank you, that's been a big help. Turns out Fedora 39 installs 93
packages with "selinux" in the title. Yoiks!

